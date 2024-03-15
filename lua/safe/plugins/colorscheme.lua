return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
	},
	config = function(opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa-dragon")
	end,
}
