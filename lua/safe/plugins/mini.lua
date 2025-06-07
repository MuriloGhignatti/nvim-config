return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = "0.16.0",
		config = function()
			require("mini.icons").setup()

			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]parenthen
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Activate animations in case we are not using neovide
			if not vim.g.neovide then
				require("mini.animate").setup()
			end

			-- Automatically add pairs
			require("mini.pairs").setup()

			-- Picker similar to telescope
			require("mini.pick").setup()

			-- Code completion, substitutes nvim-cmp
			require("mini.completion").setup()
			local gen_loader = require("mini.snippets").gen_loader
			require("mini.snippets").setup({
				snippets = {
					gen_loader.from_lang(),
				},
			})

			require("mini.git").setup()
			require("mini.diff").setup()
			require("mini.statusline").setup()

			-- Comments
			--
			-- - gc to comment line or specific highlight
			-- - gcc to comment current line
			require("mini.comment").setup()
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
			commit = "572f566",
		},
	},
}
