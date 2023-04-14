return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "lua", "vim", "help", "java", "kotlin", "javascript", "typescript", "cpp", "cmake",
            "html", "css" },
            sync_install = false,
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true
    },
    {
        "HiPhish/nvim-ts-rainbow2",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function() 
            require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                    -- list of languages you want to disable the plugin for
                    disable = { 'jsx', 'cpp' },
                    -- Which query to use for finding delimiters
                    query = 'rainbow-parens',
                    -- Highlight the entire buffer all at once
                    strategy = require('ts-rainbow').strategy.global,
                }
            }
        end,
    },
    {
        "m-demare/hlargs.nvim",
        config = true
    }
}

