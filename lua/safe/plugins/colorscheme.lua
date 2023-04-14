return {
    {
        -- Color scheme
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme rose-pine]])
        end
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufReadPre",
        config = true
    }
}
