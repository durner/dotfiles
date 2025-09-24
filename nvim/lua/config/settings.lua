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

-- Trim trailing whitespace and format only for LSP-managed buffers
autocmd("BufWritePre", {
    pattern = "*",
    callback = function(event)
        local bufnr = event.buf
        -- only run if there are active LSP clients for this buffer
        if next(vim.lsp.get_active_clients({ bufnr = bufnr })) == nil then
            return
        end

        -- Trim trailing whitespace safely (preserve view)
        vim.api.nvim_buf_call(bufnr, function()
            local view = vim.fn.winsaveview()
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.winrestview(view)
        end)

        -- Format via LSP (safe)
        pcall(function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end)
    end,
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
