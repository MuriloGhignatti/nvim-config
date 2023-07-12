return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup{
            filetype = {
                c = {
                    require("formatter.filetypes.c")
                },
                cmake = {
                    require("formatter.filetypes.cmake")
                },
                cpp = {
                    require("formatter.filetypes.cpp")
                },
                h = cpp,
                java = {
                    require("formatter.filetypes.java")
                },
                js = {
                    require("formatter.filetypes.javascript")
                },
                json = {
                    require("formatter.filetypes.json")
                },

                kt = {
                    require("formatter.filetypes.kotlin")
                },
                kts = kt,
                lua = {
                    require("formatter.filetypes.lua")
                },
                md = {
                    require("formatter.filetypes.markdown")
                },
                python = {
                    require("formatter.filetypes.python")
                },
                sh = {
                    require("formatter.filetypes.sh")
                },
                ts = {
                    require("formatter.filetypes.typescript")
                },
                yml = {
                    require("formatter.filetypes.yaml")
                }
            }
        }
    end,
    keys = {
        { "<leader>f", "<cmd>Format<cr>", "Format buffer"},
        { "<leader>F", "<cmd>FormatWrite<cr>", "Write and Format buffer"}
    }
}
