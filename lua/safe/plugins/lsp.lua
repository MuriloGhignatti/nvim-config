return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {
            log_level = vim.log.levels.DEBUG
        },
        --        config = true
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "nvim-lspconfig",
            "LuaSnip",
            "mason-lspconfig.nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = {
                    {
                        "L3MON4D3/LuaSnip",
                        build = "make install_jsregexp"
                    }
                }
            }
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, opts_lazy)
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

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(opts_lazy)

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    if server_name ~= "jdtls" then
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                        on_attach = lsp_attach
                    })
                    end
                end,
            })
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local jdtls_installation_path = require("mason-registry").get_package("jdtls"):get_install_path()
            local config = {
                cmd = {
                    '/usr/lib/jvm/java-17-openjdk/bin/java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-Xmx1g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

                    '-jar', jdtls_installation_path .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

                    '-configuration', jdtls_installation_path .. '/config_linux',

                    '-data', jdtls_installation_path .. "/jdtls_workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                },
                root_dir = require('jdtls.setup').find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
            }
            require("jdtls").start_or_attach(config)
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim"
        }
    },
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {
                "clang_format",
                "google_java_format",
                "ktlint",
                "prettier",
                "semgrep",
                "eslint_d",
                "hadolint",
                "luacheck"
            },
            handlers = {}
        },
        config = function(_, opts)
            require("mason-null-ls").setup({
                opts
            })
            local null_ls = require("null-ls")
            null_ls.setup({
            })
        end,
        dependencies = {
            "mason.nvim",
            {
                "jose-elias-alvarez/null-ls.nvim",
                keys = {
                    { "<leader>f", function() vim.lsp.buf.format() end }
                },
            }
        },
        config = true
    }
}
