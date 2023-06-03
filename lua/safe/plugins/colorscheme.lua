return {
    { "rktjmp/lush.nvim" },
    {
        -- Color scheme
        "rose-pine/neovim",
        enabled = true,
        lazy = false,
        priority = 1000,
        dependencies = {
            "xiyaowong/transparent.nvim"
        },
        opts = {
            disable_background = true
        },
        config = function(opts)
            require("rose-pine").setup(opts)
            vim.cmd([[colorscheme rose-pine]])
        end
    },
    {
        "metalelf0/jellybeans-nvim",
        enabled = false,
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
