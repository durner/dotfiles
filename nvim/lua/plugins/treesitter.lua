return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "gitcommit", "json", "lua", "python", "latex", "cpp", "c"
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
