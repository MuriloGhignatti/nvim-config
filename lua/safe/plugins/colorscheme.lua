return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
        version = "3.0.1",
		lazy = false,
		priority = 1000,
		config = function(opts)
			require("rose-pine").setup({
				disable_background = true,
			})
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			vim.cmd("colorscheme rose-pine")
		end,
	},
}
