local wk = require("which-key")
vim.keymap.set("", ",", "<Nop>", {silent = true})
local opts = {noremap = true, silent = true, buffer = bufnr}
local dap = require 'dap'

-- Auto Completion
wk.register({
    ["<leader>"] = {
        y = {vim.lsp.buf.hover, "Hover"},
        j = {require('fzf-lua').lsp_definitions, "Jump to definition"},
        k = {require('fzf-lua').lsp_implementations, "Jump to implementation"},
        r = {require('fzf-lua').lsp_references, "Jump to references"},
        n = {vim.lsp.buf.rename, "Rename"},
        p = {require('fzf-lua').lsp_code_actions, "Code actions"},
        b = {"<cmd>CclsBaseHierarchy<cr>", "Base hierarchy"},
        h = {"<cmd>CclsDerivedHierarchy<cr>", "Derived hierarchy"},
        c = {"<cmd>CclsIncomingCallsHierarchy<cr>", "Incoming calls hierarchy"},
        e = {"<cmd>CclsOutgoingCallsHierarchy<cr>", "Outgoing calls hierarchy"},
        t = {"<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers"},
        f = {"<cmd>lua require('fzf-lua').files()<cr>", "Files"},
        g = {
            "<cmd>lua require('fzf-lua').live_grep({ cmd = 'git grep -i --line-number --column --color=always' })<cr>",
            "Git grep"
        },
        a = {"<cmd>lua vim.lsp.buf.format()<cr>", "Format"},
        v = {dap.toggle_breakpoint, "Toggle Breakpoint"},
        V = {
            function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, "Set Breakpoint"
        },
        ["-"] = {"i//<Esc>75a-<ESC><cr>", "Insert separator"},
    },
    ["jk"] = {"<Esc>", "Go to normal", mode = {"i"}},
    ["<Esc>"] = {":noh <CR>", "Disable highligting"},
    ["<C-LeftMouse>"] = {vim.lsp.buf.definition, "Jump to definition", mode = {"i", "n"}},
    ["<C-P>"] = {"<cmd>lua require('fzf-lua').files()<cr>", "Find Files", mode = {"i", "n"}},
    ["<C-h>"] = {"<C-w>h", "Window left", mode = {"i", "n"}},
    ["<C-l>"] = {"<C-w>l", "Window right", mode = {"i", "n"}},
    ["<C-j>"] = {"<C-w>j", "Window down", mode = {"i", "n"}},
    ["<C-k>"] = {"<C-w>k", "Window up", mode = {"i", "n"}},
    ["<F2>"] = {"<cmd>setlocal spell! spelllang=en_us<cr>", "Spell Check", mode = {"i", "n"}},
    ["<F3>"] = {vim.lsp.buf.definition, "Jump to definition", mode = {"i", "n"}},
    ["<F4>"] = {"<cmd>FSHere<cr>", "Switch Header / Source", mode = {"i", "n"}},
    ["<F5>"] = {"<cmd>bp!<cr>", "Previous buffer", mode = {"i", "n"}},
    ["<F6>"] = {"<cmd>bn!<cr>", "Next buffer", mode = {"i", "n"}},
    ["<F7>"] = {"<cmd>NvimTreeToggle<cr>", "Toggle NvimTree", mode = {"i", "n"}},
    ["<F8>"] = {dap.continue, "Dap continue", mode = {"i", "n"}},
    ["<F9>"] = {dap.step_over, "Dap next"},
    ["<F10>"] = {dap.step_into, "Dap step into"},
    ["<F12>"] = {"<cmd>noh<cr>", "Disable highlighting", mode = {"i", "n"}},
    ["//"] = {'y/<C-R>"<cr>', "Highlight underlying word", mode = {"v", "n"}}
}, {nowait = true})

vim.cmd [[
" R
function! s:customNvimRMappings()
   nmap <buffer> <Leader>pr <Plug>RStart
   imap <buffer> <Leader>pr <Plug>RStart
   vmap <buffer> <Leader>pr <Plug>RStart
endfunction
augroup myNvimR
   au!
   autocmd filetype r call s:customNvimRMappings()
augroup end

" allows to stamp in visual mode
vnoremap p "_dP

" normal copy/paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> "_dP
imap <C-v> <C-r><C-o>+
]]
