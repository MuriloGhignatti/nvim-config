return {
    {
        "williamboman/mason.nvim",
        config = true,
        build = ":MasonUpdate"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "cmake",
                "dockerls",
                "gradle_ls",
                "html",
                "cssls",
                "jsonls",
                "jdtls",
                "tsserver",
                "kotlin_language_server",
                "lua_ls",
                "pylsp",
                "sqlls",
                "yamlls",
                "lemminx"
            }
        },
        dependencies = {
            "williamboman/mason.nvim",
            "hrsh7th/nvim-cmp"
        },
        config = function(_, opts_lazy)
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(opts_lazy)

            mason_lspconfig.setup_handlers({
                function(server_name)
                    if server_name ~= "jdtls" then
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end
            end
            })
        end
    }
}
