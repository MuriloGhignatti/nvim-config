vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject View" })

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h14" -- text below applies for VimScript
    vim.g.neovide_transparency = 0.8
    vim.g.neovide_fullscreen = true
end
