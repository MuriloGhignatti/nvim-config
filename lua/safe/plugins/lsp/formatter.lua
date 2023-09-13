return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            sh = { "beautysh"},
            bash = { "beautysh"},
            c = { "clang_format" },
            cpp = { "clang_format" },
            java = { "clang_format" },
            lua = { "stylua" },
            go = { "gofumpt" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            markdown = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" }
        }
    },
    keys = {
        { "<leader>f", function()
            require("conform").format() end, desc = "Format current buffer"}
    }
}
