return {
    {
        "rose-pine/neovim",
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
    {
        "xiyaowong/transparent.nvim",
        event = "VeryLazy",
        opts = {
            extra_groups = {
                "NormalFloat",
            }
        }
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufAdd",
        config = true
    }
}
