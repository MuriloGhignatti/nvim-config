return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	commit = "5a70b1e",
	config = function()
		require("nvim-treesitter").install({ "bash", "c", "java", "lua", "markdown", "xml", "markdown_inline" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "<filetype>" },
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
