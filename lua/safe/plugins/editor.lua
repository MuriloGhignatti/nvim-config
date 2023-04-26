return {
    "lambdalisue/suda.vim",
    {
        "folke/drop.nvim",
        event = "VimEnter",
        config = true
    },
    {
        "m4xshen/autoclose.nvim",
        config = true
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    }
}
