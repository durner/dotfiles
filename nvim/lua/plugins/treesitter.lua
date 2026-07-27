return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "gitcommit", "json", "lua", "python", "cpp", "c"
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
