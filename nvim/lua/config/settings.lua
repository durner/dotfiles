local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"
capabilities.offset_encoding = "utf-8"
capabilities.clang = {}
capabilities.clang.offsetEncoding = "utf-8"
capabilities.clang.offset_encoding = "utf-8"

require "lspconfig".clangd.setup {
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
            or require("lspconfig.util").root_pattern(
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja"
            )(fname)
            or require("lspconfig.util").find_git_ancestor(fname)
    end,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true
    }
}

local autocmd = vim.api.nvim_create_autocmd

-- Show diagnostics under the cursor when holding position
autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

-- Remove whitespace on save
autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e"
})

-- Auto format on save
autocmd("BufWritePre", {
    pattern = "",
    command = ":silent lua vim.lsp.buf.format()"
})

-- Don't auto comment new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o"
})

vim.cmd [[
" Spell Checking
hi SpellBad ctermfg=red guifg=red

"Large File Handling
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

"Close dap hover window with q
autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
]]
