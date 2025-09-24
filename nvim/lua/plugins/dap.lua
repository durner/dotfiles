return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    keys = { "<F8>", "<F9>", "<F10>", "<leader>dc", "<leader>dt" },
    config = function()
        -- Setup mason-nvim-dap (keep here since you intended mason config)
        require('mason-nvim-dap').setup({
            ensure_installed = { "python", "codelldb" },
            handlers = {}
        })

        -- require dap modules after lazy load
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
            { text = icons.kind.Event, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" })
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
