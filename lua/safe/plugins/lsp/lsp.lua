require("safe.shared")
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            local wk = require("which-key")

            wk.register({
                ["<space>e"] = { vim.diagnostic.open_float
                , "Open Diagnostic Window" },
                ["[d"] = { vim.diagnostic.goto_prev, "Goto prev" },
                ["]d"] = { vim.diagnostic.goto_next, "Goto next" },
                ["<space>q"] = { vim.diagnostic.setloclist },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = ev.buf }
                    wk.register({
                        ["gD"] = { vim.lsp.buf.declaration, opts },
                        ["gd"] = { vim.lsp.buf.definition, opts },
                        ["K"] = { vim.lsp.buf.hover, opts },
                        ["gi"] = { vim.lsp.buf.implementation, opts },
                        ["<C-k>"] = { vim.lsp.buf.signature_help, opts },
                        ["<space>wa"] = { vim.lsp.buf.add_workspace_folder, opts },
                        ["<space>wr"] = { vim.lsp.buf.remove_workspace_folder, opts },
                        ["<space>D"] = { vim.lsp.buf.type_definition, opts },
                        ["<space>rn"] = { vim.lsp.buf.rename, opts },
                        ["gr"] = { vim.lsp.buf.references, opts },
                        ["<space>ca"] = { vim.lsp.buf.code_action, { buffer = ev.buf, mode = { "n", "v" } } },
                        ["<space>wl"] = { function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, opts },
                        ["<space>f"] = { function()
                            vim.lsp.buf.format { async = true }
                        end, opts },
                    })
                end,
            })
        end
    },
    {
        "mfussenegger/nvim-dap"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lua",
            "windwp/nvim-autopairs",
            "onsails/lspkind.nvim",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = {
                    {
                        "L3MON4D3/LuaSnip",
                        dependencies = "rafamadriz/friendly-snippets",
                        build = GetMakeCmd() .. " install_jsregexp"
                    }
                }
            }
        },
        config = function()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, {"i","s","c",}),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "calc" },
                    { name = "nvim_lua" },
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
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_document_symbol' }
                }, {
                    { name = 'buffer' }
                })
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })
            cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
            )
        end
    }
}
