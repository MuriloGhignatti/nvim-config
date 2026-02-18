vim.filetype.add({
	extension = {
		ivy = "ivy",
		ant = "ant",
	},
})

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h16"
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_fullscreen = true
end
