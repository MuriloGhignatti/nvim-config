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
            "mason.nvim",
            "neovim/nvim-lspconfig"
        }
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "nvim-lspconfig",
            "LuaSnip",
            "mason-lspconfig.nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
        config = function()
            require("cmp").setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" }
                }
            })
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                        on_attach = lsp_attach
                    })
                end
            })
        end
    },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            "nvim-cmp"
        }
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "mason.nvim",
            {
                "jose-elias-alvarez/null-ls.nvim",
                keys = {
                    { "<leader>f", function() vim.lsp.buf.format() end }
                },
                config = true
            }
        },
        config = true
    }
}
