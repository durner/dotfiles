return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup({
            layouts = {
                {
                    elements = {
                        "watches",
                        "console",
                        "repl"
                    },
                    size = 0.2,
                    position = "bottom",
                },
            },
            controls = {
                enabled = true,
            }
        })

        local icons = require("config.icons")

        vim.fn.sign_define("DapBreakpoint",
            { text = icons.ui.TinyCircle, texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition",
            { text = icons.ui.CircleWithGap, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = icons.ui.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped",
            { text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected",
            { text = icons.diagnostics.Error, texthl = "Error", linehl = "", numhl = "" })

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
    end
}
