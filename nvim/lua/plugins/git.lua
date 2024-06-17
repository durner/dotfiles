return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        {
            "sindrets/diffview.nvim",
            cmd = { "DiffviewFileHistory" }
        }
    },
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({ current_line_blame = true })
    end
}
