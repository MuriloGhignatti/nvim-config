return {
	{
		"nvim-neorg/neorg",
        version = "9.6.4",
        ft = "norg",
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
