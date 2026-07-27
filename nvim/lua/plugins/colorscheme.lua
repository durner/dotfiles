return {
    {
        "gbprod/nord.nvim",
        lazy = false,
        config = function()
            require("nord").setup({})
            vim.cmd.colorscheme("nord")
        end
    },
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     config = function()
    --         require('nordic').load({
    --             reduced_blue = false,
    --             cursorline = {
    --                 theme = 'light',
    --                 blend = 0.3,
    --             },
    --             on_highlight = function(hl, palette)
    --                 hl.Search = { bg = palette.blue0, fg = palette.bg, underline = false }
    --                 hl.IncSearch = { bg = palette.blue2, fg = palette.bg, bold = true }
    --                 hl.CurSearch = { bg = palette.blue1, fg = palette.bg, bold = true }
    --                 hl.Visual = { bg = palette.gray4, fg = palette.fg }
    --                 hl.VisualNOS = { bg = palette.gray4, fg = palette.fg }
    --             end,
    --         })
    --     end
    -- },
    --{
    --    "catppuccin/nvim",
    --    config = function()
    --        require("catppuccin").setup({
    --            flavour = "latte",
    --            -- flavour = "frappe",
    --            no_bold = false,
    --            integrations = {
    --                cmp = true,
    --                gitsigns = true,
    --                nvimtree = true,
    --                treesitter = true,
    --                barbar = true,
    --                dap = true,
    --                dap_ui = true,
    --            },
    --            highlight_overrides = {
    --                all = function(colors)
    --                    return {
    --                        CursorLineNr = { style = { "bold" } }
    --                    }
    --                end
    --            }
    --        })
    --        vim.cmd.colorscheme "catppuccin"
    --    end
    --}
}
