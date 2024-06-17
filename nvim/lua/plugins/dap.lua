return {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text'
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
        require("nvim-dap-virtual-text").setup()
    end
}
