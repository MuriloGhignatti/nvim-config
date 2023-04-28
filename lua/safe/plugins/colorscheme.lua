return {
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
            vim.cmd([[TransparentEnable]])
        end,
        dependencies = {
            { "rktjmp/lush.nvim" },
            {
                "xiyaowong/transparent.nvim",
                opts = {
                    extra_groups = {
                        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
                        "NvimTreeNormal" -- NvimTree
                    }
                }
            },
        }
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufReadPre",
        config = true
    }
}
