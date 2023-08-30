return {
    {
        "xiyaowong/transparent.nvim",
        opts = {
            extra_groups = {
                "NormalFloat",
            }
        }
    },
    {
        "rose-pine/neovim",
        dependencies = {
            "xiyaowong/transparent.nvim"
        },
        config = function()
            vim.cmd('TransparentEnable')
            vim.cmd('colorscheme rose-pine')
        end
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufAdd",
        config = true
    }
}
