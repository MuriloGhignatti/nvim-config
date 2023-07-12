return {
    { "lambdalisue/suda.vim" },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>x", "<cmd>TroubleToggle<cr>" }
        }
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1
                    },
                }
            }
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "rcarriga/nvim-notify",
        config = true
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            local rainbow_delimiters = require 'rainbow-delimiters'
            
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter"
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup{
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc="Gitsigns next hunk"})

                    map('n', '[c', function()
                      if vim.wo.diff then return '[c' end
                      vim.schedule(function() gs.prev_hunk() end)
                      return '<Ignore>'
                    end, {expr=true, desc="Gitsigns prev hunk"})
                
                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, { desc = "Gitsigns stage hunk" })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = "Gitsigns reset hunk" })
                    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Gitsigns stage hunk" })
                    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Gitsigns reset hunk" })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk"})
                    map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = "Gitsigns preview hunk" })
                    map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle blame line" })
                    map('n', '<leader>hd', gs.diffthis, { desc = "Show diff" })
                    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Show diff against '~'" })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsigns Toggle deleted" })
                
                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select hunk" })
                end
            }
        end
    },
    { "stevearc/dressing.nvim",  config = true },
    { "akinsho/toggleterm.nvim", config = true, cmd = "ToggleTerm" }
}
