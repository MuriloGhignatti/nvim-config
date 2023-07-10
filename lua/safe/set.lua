-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
local keymap = vim.keymap   -- Setting custom keymaps

function SetOSSpecific()
    if string.find(vim.loop.os_uname().sysname, "Windows") then
        opt.undodir = os.getenv("LOCALAPPDATA") .. "/nvim/undodir"
        opt.shell = "powershell.exe"
    else
        opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
    end
end

-----------------------------------------------------------
-- General
-----------------------------------------------------------

SetOSSpecific()

opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
opt.undofile = true
opt.relativenumber = true
g.mapleader = " "   -- Defines leader as "SPACE"

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Custom Keymaps (Not related to plugins)
-----------------------------------------------------------
keymap.set("n", "<leader>pv", vim.cmd.Ex)
