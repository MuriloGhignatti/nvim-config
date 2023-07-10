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
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup()
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    { "rcarriga/nvim-notify",    config = true },
    { "stevearc/dressing.nvim",  config = true },
    { "lewis6991/gitsigns.nvim", config = true },
    { "akinsho/toggleterm.nvim", config = true, cmd = "ToggleTerm" },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            space_char_blankline = " ",
            show_current_context_start = true,
            buftype_exclude = { "terminal" },
            filetype_exclude = { "dashboard", "NvimTree", "packer", "mason" },
            show_current_context = true,
            context_patterns = {
                "class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object",
                "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element",
                "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement",
                "operation_type"
            }
        }
    }
}
