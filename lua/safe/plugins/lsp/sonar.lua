return {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = {"python", "cpp", "java"},
    dependencies = {
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local mason_path = os.getenv("MASON")
        local mason_bin_path = mason_path .. "\\bin"
        require("sonarlint").setup({
            server = {
                cmd = {
                    mason_bin_path .. "\\sonarlint-language-server.cmd",
                    "-stdio",
                    "-analyzers",
                    vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarpython.jar"),
                    vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarcfamily.jar"),
                    vim.fn.expand(mason_path .. "/share/sonarlint-analyzers/sonarjava.jar"),

                }
            },
            filetypes = {
                "python",
                "cpp",
                "java"
            }
        })
    end
}
