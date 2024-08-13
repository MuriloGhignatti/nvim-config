return {
	{
		"tigion/nvim-asciidoc-preview",
		cmd = { "AsciiDocPreview" },
		ft = { "asciidoc" },
		build = "cd server && npm install",
        config = true
	},
}
