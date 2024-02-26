return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
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
		},
	},
}
