return {
	{
		"nvim-neorg/neorg",
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
