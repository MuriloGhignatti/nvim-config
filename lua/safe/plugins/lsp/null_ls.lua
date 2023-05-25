return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        keys = {
            { "<leader>f", function() vim.lsp.buf.format() end }
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {
                "clang_format",
                "google_java_format",
                "ktlint",
                "prettier",
                "eslint_d",
                "hadolint"
            },
            handlers = {}
        },
        config = function(_, opts)
            require("mason-null-ls").setup(opts)
            require("null-ls").setup()
        end,
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            "williamboman/mason.nvim"
        }
    }
}
