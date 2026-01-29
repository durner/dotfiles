return {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "nord"
            },
            sections = { lualine_a = { { 'filename', path = 1 } } }
        })
    end
}
