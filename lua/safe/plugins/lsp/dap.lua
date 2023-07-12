return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7.cmd",
                options = {
                    detached = false
                }
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true
                }
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    }
}
