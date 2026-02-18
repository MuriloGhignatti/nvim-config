return {
	{
		"nvim-neorg/neorg",
        version = "9.3.0",
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
