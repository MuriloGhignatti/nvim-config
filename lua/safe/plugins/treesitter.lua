return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "lua", "vim", "java", "kotlin", "javascript",
            "typescript", "cpp", "cmake", "git_rebase", "gitcommit",
            "gitignore", "html", "json5", "latex", "make", "markdown",
            "markdown_inline", "python", "regex", "sql", "yaml"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true
    },
}
