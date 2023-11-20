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
        "kepano/flexoki-neovim",
        dependencies = {
            "xiyaowong/transparent.nvim"
        },
        config = function()
            vim.cmd('TransparentEnable')
            vim.cmd('colorscheme flexoki-dark')
        end
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufAdd",
        config = true
    }
}
