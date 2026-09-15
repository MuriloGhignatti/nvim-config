return {
	{
		"iamcco/markdown-preview.nvim",
		version = "0.0.10",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"charlesnicholson/plantuml.nvim",
        commit = "acd1162"
	},
}
