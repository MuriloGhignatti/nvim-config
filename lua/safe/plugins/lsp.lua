return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = true
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
                "pyright",
                "rust_analyzer",
                "sqlls",
                "yamlls"
            }
        },
        dependencies = {
            "williamboman/mason.nvim",
            {
                "neovim/nvim-lspconfig",
                dependencies = {
                    "ms-jpq/coq_nvim",
                    dependencies = {
                        "ms-jpq/coq.artifacts",
                        config = function ()
                            local lsp = require("lspconfig")
                            local coq = require("coq")

                            local lsp_attach = function (client, bufnr)
                                
                            end

                            require('mason-lspconfig').setup_handlers({
                                function(server_name)
                                    lsp[server_name]
                                    .setup(coq.lsp_ensure_capabilities(
                                    {
                                        on_attach = lsp_attach
                                    }
                                    ))
                                end,
                            })
                        end
                    }
                }
            }
        }
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            config = true
        },
        config = true
    }
}

