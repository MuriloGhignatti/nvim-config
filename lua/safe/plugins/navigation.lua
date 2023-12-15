return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release ;" ..
            " cmake --build build --config Release ;" ..
            " cmake --install build --prefix build",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc="Telescope find files"},
            { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc="Telescope find string"},
            { "<leader>fg", "<cmd>Telescope git_files<cr>", desc="Telescope find git files"},
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc="Telescope find buffers"},
            { "<leader>fbs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc="Telescope find string in current buffer"},
            -- LSP
            { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc="Telescope find lsp references"},
            { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc="Telescope find lsp definitions"},
            { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc="Telescope find lsp implementations"},
            { "<leader>fws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc="Telescope find lsp workspace symbols"},
            { "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", desc="Telescope find lsp document symbols"}
        },
        config = function()
            require("telescope").load_extension("fzf")
        end
    },
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<leader>gs", vim.cmd.Git, desc = "Open vim-fugitive" }
        }
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = true
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to harpoon" },
            { "<C-t>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Show harpoon quick menu" },
            { "<C-q>",     function() require("harpoon.ui").nav_file(1) end, desc = "Go to first harpoon file" },
            { "<C-w>",     function() require("harpoon.ui").nav_file(2) end, desc = "Go to second harpoon file"},
            { "<C-e>",     function() require("harpoon.ui").nav_file(3) end, desc = "Go to third harpoon file"},
            { "<C-r>",     function() require("harpoon.ui").nav_file(4) end, desc = "Go to fourth harpoon file"}
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false
    }
}
