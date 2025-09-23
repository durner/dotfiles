return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        -- Define default servers to install
        require("mason-lspconfig").setup({
            ensure_installed = { "bashls", "pyright", "texlab", "grammarly", "lua_ls" }
        })
        -- Setup dap
        require('mason-nvim-dap').setup({
            ensure_installed = { "python", "codelldb" },
            handlers = {}
        })
        -- Enable all mason language servers
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                vim.lsp.enable(server_name)
            end
        })
        -- Enable clangd
        vim.lsp.enable('clangd')
        -- Diagnostics: new API (no vim.fn.sign_define)
        local icons = require("config.icons")
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
                    [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
                },
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "single",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
