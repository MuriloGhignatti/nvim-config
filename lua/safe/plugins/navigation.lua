return {
    {
        -- Telescope configuration
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end
            }
        },
        keys = {
            { "<leader>pf", "<cmd>Telescope find_files<cr>" },
            { "<C-p>",      "<cmd>Telescope git_files<cr>" },
            { "<leader>ps", function()
                require("telescope.builtin").grep_string(
                { search = vim.fn.input("Grep > ") }
                )
            end },
            { "<leader>fb", "<cmd>Telescope buffers<cr>" },
            { "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>" }
        }
    },
    {
        -- Fugitive for git_files
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<leader>gs", vim.cmd.Git }
        }
    },
    {
        -- Search for nvim commands
        "sudormrfbin/cheatsheet.nvim",
        config = true,
        cmd = "Cheatsheet",
        keys = {
            { "<leader>?", "<cmd>Cheatsheet<cr>" }
        }
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end },
            { "<C-t>",     function() require("harpoon.ui").toggle_quick_menu() end },
            { "<C-q>",     function() require("harpoon.ui").nav_file(1) end },
            { "<C-w>",     function() require("harpoon.ui").nav_file(2) end },
            { "<C-e>",     function() require("harpoon.ui").nav_file(3) end },
            { "<C-r>",     function() require("harpoon.ui").nav_file(4) end }
        }
    }
}
