return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		commit = "93a9ff9",
		opts = {
			ensure_installed = {
				-- Servers
				"lua_ls",
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
					automatic_enable = {
						exclude = {
							"jdtls",
						},
					},
				},
			},
			{ "mason-org/mason.nvim", version = "2.0.0", opts = {} },
			{
				"jay-babu/mason-nvim-dap.nvim",
				version = "2.5.1",
				opts = {},
			},
			{
				"neovim/nvim-lspconfig",
				version = "2.2.0",
				config = function()
					vim.lsp.config("clangd", {
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
					})
					vim.lsp.config("jdtls", {
						settings = {
							java = {
								configuration = {
									runtimes = {
										{
											name = "JavaSE-21",
											path = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.2-open"),
											default = false,
										},
										{
											name = "JavaSE-11",
											path = vim.fn.expand("$HOME/.sdkman/candidates/java/11.0.28-librca"),
											default = true,
										},
									},
								},
							},
						},
					})
					vim.lsp.enable("jdtls")
				end,
				dependencies = {
					{
						"nvim-java/nvim-java",
						version = "3.0.0",
						opts = {
							java_debug_adapter = {
								enable = true,
								version = "0.58.2",
							},
						},
					},
				},
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
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
