return {
    { "lambdalisue/suda.vim" },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>x", "<cmd>TroubleToggle<cr>" }
        }
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1
                    },
                    "lsp_progress"
                }
            }
        },
        dependencies = {
            "arkav/lualine-lsp-progress",
            "nvim-tree/nvim-web-devicons"
        }
    },
    { "stevearc/dressing.nvim",  config = true },
    { "akinsho/toggleterm.nvim", config = true, cmd = "ToggleTerm" },
}
