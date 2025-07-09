return {
    'meeehdi-dev/bropilot.nvim',
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "j-hui/fidget.nvim",
    },
    opts = {
        auto_suggest = true,
        model = "starcoder2:3b",
        prompt = {
            prefix = "<fim_prefix>",
            suffix = "<fim_suffix>",
            middle = "<fim_middle>",
        },
        tokens_to_clear = { "<|endoftext|>" },
        debounce = 500,
        keymap = {
            accept_line = "<C-Space>",
        },
        model_params = {
            ctx = 32768,
            temperature = 0.2,
            top_p = 0.95,
        }
    },
    config = function(_, opts)
        require("bropilot").setup(opts)
    end,
}
