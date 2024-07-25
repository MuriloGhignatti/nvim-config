return {
	{ -- Autoformat
		"stevearc/conform.nvim",
        cmd = "ConformInfo",
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				sh = { "beautysh" },
				bash = { "beautysh" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "clang_format" },
				lua = { "stylua" },
				go = { "gofumpt" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				markdown = { "prettierd" },
				xml = { "xmlformat" },
				json = { "prettierd" },
				python = { "black" },
				yaml = { "prettierd" },
			},
			formatters = {
				xmlformat = {
					prepend_args = { "--blanks", "--indent", "4" },
				},
				clang_format = {
					prepend_args = { "--style={IndentWidth: 4}" },
				},
			},
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format()
				end,
				desc = "[F]ormat current buffer",
			},
		},
	},
}
