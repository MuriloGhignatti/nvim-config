return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
                config = true
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
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7.cmd",
				options = {
					detached = false,
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
		end,
	},
}
