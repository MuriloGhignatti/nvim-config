return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {
            log_level = vim.log.levels.DEBUG
        },
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
            "mason-lspconfig.nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
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
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" }
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = 'symbol_text',  -- show only symbol annotations
                        maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    })
                }
            })
        end
    },
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
                "hadolint",
                "luacheck"
            },
            handlers = {}
        },
        config = function(_, opts)
            require("mason-null-ls").setup(opts)
            require("null-ls").setup()
        end,
        dependencies = {
            "null-ls.nvim",
            "mason.nvim"
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, opts_lazy)
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
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
            local jdtls = require("jdtls")
            local path = {}
            path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
            local jdtls_install = require('mason-registry')
                .get_package('jdtls')
                :get_install_path()

            path.java_agent = jdtls_install .. '/lombok.jar'
            path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

            if vim.fn.has('mac') == 1 then
                path.platform_config = jdtls_install .. '/config_mac'
            elseif vim.fn.has('unix') == 1 then
                path.jdk_bin = "/bin/java"
                path.jdk_homes = "~/.sdkman/candidates/java/"
                path.platform_config = jdtls_install .. '/config_linux'
            elseif vim.fn.has('win32') == 1 then
                path.jdk_bin = "\\bin\\java"
                path.jdk_homes = "C:\\Program Files\\Java\\"
                path.platform_config = jdtls_install .. '/config_win'
            end

            path.bundles = {}

            ---
            -- Include java-test bundle if present
            ---
            local java_test_path = require('mason-registry')
                .get_package('java-test')
                :get_install_path()

            local java_test_bundle = vim.split(
                vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
                '\n'
            )

            if java_test_bundle[1] ~= '' then
                vim.list_extend(path.bundles, java_test_bundle)
            end

            ---
            -- Include java-debug-adapter bundle if present
            ---
            local java_debug_path = require('mason-registry')
                .get_package('java-debug-adapter')
                :get_install_path()

            local java_debug_bundle = vim.split(
                vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
                '\n'
            )

            if java_debug_bundle[1] ~= '' then
                vim.list_extend(path.bundles, java_debug_bundle)
            end

            local jdk_17_path = vim.split(
                vim.fn.glob(path.jdk_homes .. '*17*'),
                '\n')

            if jdk_17_path[1] ~= "" then
                path.jdk_17_home = jdk_17_path[1]
            end

            local jdk_11_path = vim.split(
                vim.fn.glob(path.jdk_homes .. '*11*'),
                '\n')

            if jdk_11_path[1] ~= "" then
                path.jdk_11_home = jdk_11_path[1]
            end

            local jdk_8_path = vim.split(
                vim.fn.glob(path.jdk_homes .. '*1.8*'),
                '\n')

            if jdk_8_path[1] ~= "" then
                path.jdk_8_home = jdk_8_path[1]
            end

            path.runtimes = {
                {
                    name = "JavaSE-1.8",
                    path = path.jdk_8_home 
                },
                {
                    name = "JavaSE-11",
                    path = path.jdk_11_home 
                },
                {
                    name = "JavaSE-17",
                    path = path.jdk_17_home 
                }
            }
            local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
            local config = {
                cmd = {
                    path.jdk_17_home .. path.jdk_bin,

                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-javaagent:' .. path.java_agent,
                    '-Xms1g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens',
                    'java.base/java.util=ALL-UNNAMED',
                    '--add-opens',
                    'java.base/java.lang=ALL-UNNAMED',

                    '-jar',
                    path.launcher_jar,

                    '-configuration',
                    path.platform_config,

                    '-data',
                    data_dir,
                },
                root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
                settings = {
                    java = {
                        eclipse = {
                            downloadSources = true,
                        },
                        configuration = {
                            updateBuildConfiguration = 'interactive',
                            runtimes = path.runtimes,
                        },
                        maven = {
                            downloadSources = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                        -- inlayHints = {
                        --   parameterNames = {
                        --     enabled = 'all' -- literals, all, none
                        --   }
                        -- },
                        format = {
                            enabled = true,
                            -- settings = {
                            --   profile = 'asdf'
                            -- },
                        }
                    },
                    signatureHelp = {
                        enabled = true,
                    },
                    completion = {
                        favoriteStaticMembers = {
                            'org.hamcrest.MatcherAssert.assertThat',
                            'org.hamcrest.Matchers.*',
                            'org.hamcrest.CoreMatchers.*',
                            'org.junit.jupiter.api.Assertions.*',
                            'java.util.Objects.requireNonNull',
                            'java.util.Objects.requireNonNullElse',
                            'org.mockito.Mockito.*',
                        },
                    },
                    contentProvider = {
                        preferred = 'fernflower',
                    },
                    extendedClientCapabilities = jdtls.extendedClientCapabilities,
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        }
                    },
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        useBlocks = true,
                    },
                }
            }
            jdtls.start_or_attach(config)
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim"
        }
    }
}
