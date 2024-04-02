return {
	-- {
	-- "rebelot/kanagawa.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	vim.cmd("colorscheme kanagawa-dragon")
	-- end,
	-- }
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function(opts)
			require("rose-pine").setup({
				disable_background = true,
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
