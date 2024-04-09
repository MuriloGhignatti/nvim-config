return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
            require('kanagawa').setup({
                transparent = true
            })
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function(opts)
	-- 		require("rose-pine").setup({
	-- 			disable_background = true,
	-- 		})
	-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			-- your configuration comes here
	--
	-- 			-- or leave it empty to use the default settings
	-- 			style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	-- 			transparent = true, -- Enable this to disable setting the background color
	-- 			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	-- 			styles = {
	-- 				-- Style to be applied to different syntax groups
	-- 				-- Value is any valid attr-list value for `:help nvim_set_hl`
	-- 				comments = { italic = false },
	-- 				keywords = { italic = false },
	-- 				-- Background styles. Can be "dark", "transparent" or "normal"
	-- 				sidebars = "dark", -- style for sidebars, see below
	-- 				floats = "dark", -- style for floating windows
	-- 			},
	-- 		})
	-- 		vim.cmd("colorscheme tokyonight")
	-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- 	end,
	-- },
}
