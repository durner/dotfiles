return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
        "rcarriga/nvim-notify",
        {
            "MunifTanjim/nui.nvim",
            lazy = true
        }
    },
    config = function()
        require("noice").setup({
            cmdline = {
                view = "cmdline",
            },
            messages = {
                enabled = false
            },
            notify = {
                enabled = false
            }
        })
    end
}
