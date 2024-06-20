return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            -- flavour = "macchiato",
            flavour = "latte",
            no_bold = false,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                barbar = true,
                dap = {
                    enabled = true,
                    enable_ui = true,
                }
            }
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
