return {
    {
        "rktjmp/lush.nvim"
    },
    {
        -- Color scheme
        "rose-pine/neovim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme rose-pine]])
        end
    },
    {
        "metalelf0/jellybeans-nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme jellybeans-nvim]])
        end
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufReadPre",
        config = true
    }
}
