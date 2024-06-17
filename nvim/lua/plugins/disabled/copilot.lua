return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({ suggestion = { enable = true }, panel = { enable = false } })
    end
    dependencies = {
        {
            "zbirenbaum/copilot-cmp",
            config = function()
                require("copilot_cmp").setup()
            end
        }
    }
}
