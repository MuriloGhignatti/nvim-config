return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndotree Toggle" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function(opts)
			require("lualine").setup(opts)
		end,
		opts = {
			sections = {
				lualine_c = {
					{
						"filename",
						path = 0,
					},
				},
				lualine_x = {
					"encoding",
					"fileformat",
					{
						"filetype",
						colored = true,
						icon_only = true,
					},
				},
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]rouble" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"fei6409/log-highlight.nvim",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		config = true,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"lambdalisue/suda.vim",
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<leader>o", "<CMD>Oil<CR>", desc = "[O]il navigation" },
			{ "<leader>pv", "<CMD>Oil<CR>", desc = "[P]roject [V]iew" },
		},
	},
}
