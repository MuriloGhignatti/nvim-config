return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"nvim-neorg/neorg",
		dependencies = "vhyrro/luarocks.nvim",
		lazy = false,
		version = "*",
		opts = {
			load = {
				["core.defaults"] = {},
                ["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
	},
}
