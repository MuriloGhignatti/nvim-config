return {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = {"python", "cpp", "java"},
    dependencies = {
        "mfussenegger/nvim-jdtls",
        "williamboman/mason.nvim"
    },
    config = function()
        local sonar_language_server_path = require("mason-registry")
            .get_package("sonarlint-language-server")
            :get_install_path() 
        local analyzers_path = sonar_language_server_path .. "/extension/analyzers"
        require("sonarlint").setup({
            server = {
                cmd = {
                    sonar_language_server_path .. "/sonarlint-language-server.cmd",
                    "-stdio",
                    "-analyzers",
                    vim.fn.expand(analyzers_path .. "/sonarpython.jar"),
                    vim.fn.expand(analyzers_path .. "/sonarcfamily.jar"),
                    vim.fn.expand(analyzers_path .. "/sonarjava.jar"),

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
