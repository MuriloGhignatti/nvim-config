local function getJdtlsJavaHomes()
	local sdkman_path = vim.fn.expand("$HOME/.sdkman/candidates/java")
	if vim.fn.isdirectory(sdkman_path) == 1 then
		return sdkman_path
	elseif vim.fn.executable("archlinux-java") then
		return vim.fn.expand("/usr/lib/jvm")
	end
end

local function setupJDTLSBundles()
	local mason_path = vim.fn.stdpath("data") .. "/mason"
	local bundles = {
		vim.fn.glob(
			mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
			true
		),
	}

	local java_test_bundles =
		vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension" .. "/server/*.jar", true), "\n")
	local excluded = {
		"com.microsoft.java.test.runner-jar-with-dependencies.jar",
		"jacocoagent.jar",
	}
	for _, java_test_jar in ipairs(java_test_bundles) do
		local fname = vim.fn.fnamemodify(java_test_jar, ":t")
		if not vim.tbl_contains(excluded, fname) then
			table.insert(bundles, java_test_jar)
		end
	end
	return bundles
end

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		commit = "93a9ff9",
		opts = {
			ensure_installed = {
				-- Servers
				"lua_ls",
				"jdtls",
				"clangd",
				"cssls",
				"neocmake",
				"dockerls",
				"gradle-language-server",
				"jsonls",
				"kotlin-language-server",
				"lemminx",
				"pylsp",
				"sqlls",
				"ts_ls",
				"yamlls",

				-- Formatters
				"beautysh",
				"black",
				"clang-format",
				{
					"gofumpt",
					condition = function()
						return vim.fn.executable("go") == 1
					end,
				},
				"prettierd",
				"stylua",
				"xmlformatter",

				-- Debug
				"debugpy",
			},
		},
		dependencies = {
			{
				"mason-org/mason-lspconfig.nvim",
				version = "2.1.0",
				opts = {
					automatic_enable = true,
				},
			},
			{ "mason-org/mason.nvim", version = "2.0.0", opts = {} },
			{
				"jay-babu/mason-nvim-dap.nvim",
				version = "2.5.1",
				opts = {},
			},
			{
				"mfussenegger/nvim-jdtls",
				commit = "38d265e",
				config = function()
					print(vim.fn.glob(getJdtlsJavaHomes() .. "/*11*", true))
					vim.lsp.config("lua_ls", {
						settings = {
							Lua = {
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
							},
						},
					})
					vim.lsp.config("jdtls", {
						settings = {
							java = {
								configuration = {
									runtimes = {
										{
											name = "JavaSE-21",
											path = vim.fn.glob(getJdtlsJavaHomes() .. "/*21*", true),
											default = true,
										},
									},
								},
							},
						},
						init_options = {
							bundles = setupJDTLSBundles(),
						},
					})
				end,
				dependencies = {
					"neovim/nvim-lspconfig",
				},
			},
			{
				"neovim/nvim-lspconfig",
				version = "2.2.0",
				config = function()
					vim.lsp.config("clangd", {
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
					})
				end,
			},
		},
	},
	-- Useful status updates for LSP.
	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	{
		"j-hui/fidget.nvim",
		version = "1.5.0",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		version = "3.7.1",
		cmd = "Trouble",
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
		},
	},
}
