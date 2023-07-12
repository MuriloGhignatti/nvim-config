require("safe.shared")
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/which-key.nvim",
        },
        config = function()
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Open float diagnostic" })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto prev" })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next"})
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Set loc list"})

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = ev.buf }
                    local function getOpts(customDesc)
                       return { buffer = ev.buf, desc = customDesc }
                    end
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, getOpts("Goto declaration"))
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, getOpts("Goto definition"))
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, getOpts("Hover"))
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, getOpts("Goto implementation"))
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, getOpts("Signature help"))
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, getOpts("Add workspace folder"))
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, getOpts("Remove workspace folder"))
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, getOpts("List workspace folders"))
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, getOpts("Type definition"))
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, getOpts("Rename"))
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, getOpts("Code action"))
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, getOpts("Goto references"))
                end, })
            end
        },
        {
            "mrded/nvim-lsp-notify",
            config = true
        },
        {
            "mfussenegger/nvim-dap"
        },
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
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
                {
                    "windwp/nvim-autopairs",
                    event = "InsertEnter",
                    config = true
                },
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

                local has_words_before = function()
                    unpack = unpack or table.unpack
                    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                end

                local cmp_autopairs = require('nvim-autopairs.completion.cmp')
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                cmp.setup({
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            elseif has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
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
