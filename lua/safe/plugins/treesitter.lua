return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	commit = "2bd9b9b",
	config = function()
		local ts = require("nvim-treesitter")
		ts.install({ "bash", "c", "java", "lua", "markdown", "xml", "markdown_inline" })

		vim.treesitter.language.register("xml", { "ivy", "ant" })

		local ts_filetypes = vim.iter(ts.get_installed())
			:map(function(lang)
				return vim.treesitter.language.get_filetypes(lang)
			end)
			:flatten()
			:totable()

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Setup treesitter for a buffer",
			pattern = ts_filetypes,
			group = vim.api.nvim_create_augroup("ts_setup", { clear = true }),
			callback = function(e)
				vim.treesitter.start(e.buf)
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
