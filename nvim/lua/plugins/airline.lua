return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "catppuccin"
            },
            sections = { lualine_a = { { 'filename', path = 1 } } }
        })
    end
}
