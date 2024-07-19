return {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = "^0.0.0",
    config = function()
        require("barbar").setup({
            insert_at_end = true
        })
    end
}
