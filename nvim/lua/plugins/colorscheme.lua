return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            -- flavour = "latte",
            flavour = "frappe",
            no_bold = false,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                barbar = true,
                dap = true,
                dap_ui = true,
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        CursorLineNr = { style = { "bold" } }
                    }
                end
            }
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
