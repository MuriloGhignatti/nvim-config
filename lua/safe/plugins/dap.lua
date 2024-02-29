return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"neovim/nvim-lspconfig",
		{
			"rcarriga/nvim-dap-ui",
			config = true,
		},
	},
	keys = {
		{
			"<F7>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<F8>",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<F9>",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<Leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle Breakpoint",
		},
		{
			"<Leader>B",
			function()
				require("dap").set_breakpoint()
			end,
			desc = "Set Breakpoint",
		},
		{
			"<Leader>lp",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set Breakpoint with message",
		},
		{
			"<Leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "Repl open",
		},
		{
			"<Leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run last",
		},
		{
			mode = { "n", "v" },
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Hover DAP UI Widgets",
		},
		{
			mode = { "n", "v" },
			"<Leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			desc = "Preview DAP UI Widgets",
		},
		{
			"<Leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			desc = "Centered float frames",
		},
		{
			"<Leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "Centered float scopes",
		},
	},
	config = function()
		local dap = require("dap")
		local mason_registry = require("mason-registry")
		local python_dap_install = mason_registry.get_package("debugpy"):get_install_path()

		-- Adapters
		--
		-- Python
		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = python_dap_install .. "/venv/bin/python",
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		-- Configurations
		--
		-- Python
		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python3"
					end
				end,
			},
		}
	end,
}
