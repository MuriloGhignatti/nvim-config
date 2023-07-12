return {
    "mhartington/formatter.nvim",
    opts = {
        filetype = {
            ["*"] = {
                require("formatter.filetypes.any")
            }
        }
    }
}
