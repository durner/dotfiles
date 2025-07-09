return {
    "olimorris/codecompanion.nvim",
    opts = {
        strategies = {
            chat = { adapter = "copilot" },
            inline = { adapter = "copilot" },
        },

        slash_commands = {
            ["buffer"] = {
                callback = "strategies.chat.slash_commands.buffer",
                description = "Insert open buffers",
                opts = {
                    contains_code = true,
                    provider = "fzf_lua",
                },
            },
            ["file"] = {
                callback = "strategies.chat.slash_commands.file",
                description = "Insert a file",
                opts = {
                    contains_code = true,
                    max_lines = 1000,
                    provider = "fzf_lua",
                },
            },
            ["files"] = {
                callback = "strategies.chat.slash_commands.files",
                description = "Insert multiple files",
                opts = {
                    contains_code = true,
                    max_lines = 1000,
                    provider = "fzf_lua",
                },
            },
            ["help"] = {
                callback = "strategies.chat.slash_commands.help",
                description = "Insert content from help tags",
                opts = {
                    contains_code = false,
                    provider = "fzf_lua",
                },
            },
            ["now"] = {
                callback = "strategies.chat.slash_commands.now",
                description = "Insert the current date and time",
                opts = {
                    contains_code = false,
                },
            },
            ["symbols"] = {
                callback = "strategies.chat.slash_commands.symbols",
                description = "Insert symbols for a selected file",
                opts = {
                    contains_code = true,
                    provider = "fzf_lua",
                },
            },
            ["terminal"] = {
                callback = "strategies.chat.slash_commands.terminal",
                description = "Insert terminal output",
                opts = {
                    contains_code = false,
                },
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
            ft = { "markdown", "codecompanion" }
        },
        {
            "echasnovski/mini.diff",
            config = function()
                local diff = require("mini.diff")
                diff.setup({
                    source = diff.gen_source.none(),
                })
            end,
        },
    },
}
