local wk = require("which-key")
vim.keymap.set("", ",", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true, buffer = bufnr }
local dap = require "dap"

-- Auto Completion
wk.register({
    ["<leader>"] = {
        y = { vim.lsp.buf.hover, "Hover" },
        j = { "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", "Jump to definition" },
        k = { require('fzf-lua').lsp_implementations, "Jump to implementation" },
        r = { require('fzf-lua').lsp_references, "Jump to references" },
        n = { vim.lsp.buf.rename, "Rename" },
        p = { require('fzf-lua').lsp_code_actions, "Code actions" },
        c = { require('fzf-lua').lsp_incoming_calls, "Incoming calls hierarchy" },
        o = { require('fzf-lua').lsp_outgoing_calls, "Outgoing calls hierarchy" },
        t = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers" },
        f = { "<cmd>lua require('fzf-lua').files()<cr>", "Files" },
        g = {
            "<cmd>lua require('fzf-lua').live_grep({ cmd = 'git grep -i --line-number --column --color=always' })<cr>",
            "Git grep"
        },
        a = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        d = {
            name = "Debug menu",
            n = { require('dap').step_over, "Next" },
            i = { require('dap').step_into, "Step into" },
            f = { require('dap').step_out, "Finish" },
            c = { require('dap').continue, "Continue" },
            y = { require("dap.ui.widgets").hover, "Hover" },
            x = { require('dap').disconnect, "Terminate" },
            u = { require('dap').up, "Up" },
            d = { require('dap').down, "Down" },
            v = { "<cmd>lua require('fzf-lua').dap_variables()<cr>", "Variables" },
            s = { "<cmd>lua require('fzf-lua').dap_frames()<cr>", "Strack Trace" },
            t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
            b = { function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, "Set Breakpoint" },
        },
        m = {
            name = "CMake menu",
            g = { "<cmd>CMakeGenerate<cr>", "Generate" },
            r = { "<cmd>CMakeRun<cr>", "Run" },
            d = { "<cmd>CMakeDebug<cr>", "Debug" },
            b = { "<cmd>CMakeBuild<cr>", "Build" },
            t = { "<cmd>CMakeSelectBuildType<cr>", "Select Build Type" },
            e = { "<cmd>CMakeSelectBuildTarget<cr>", "Select Buld Target" },
            l = { "<cmd>CMakeSelectLaunchTarget<cr>", "Select Launch Target" },
            s = { function()
                vim.cmd([[CMakeStopRunner]])
                vim.cmd([[CMakeStopExecutor]])
            end, "Stop CMake" }
        },
        e = { vim.diagnostic.goto_next, "Next Diagnostic" },
        ["-"] = { "i//<Esc>75a-<ESC><cr>", "Insert separator" },
    },
    ["jk"] = { "<Esc>", "Go to normal", mode = { "i" } },
    ["<Esc>"] = { ":noh <CR>", "Disable highligting" },
    ["<C-LeftMouse>"] = { "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", "Jump to definition", mode = { "i", "n" } },
    ["<C-P>"] = { "<cmd>lua require('fzf-lua').files()<cr>", "Find Files", mode = { "i", "n" } },
    ["<C-h>"] = { "<C-w>h", "Window left", mode = { "i", "n" } },
    ["<C-l>"] = { "<C-w>l", "Window right", mode = { "i", "n" } },
    ["<C-j>"] = { "<C-w>j", "Window down", mode = { "i", "n" } },
    ["<C-k>"] = { "<C-w>k", "Window up", mode = { "i", "n" } },
    ["<F2>"] = { "<cmd>setlocal spell! spelllang=en_us<cr>", "Spell Check", mode = { "i", "n" } },
    ["<F3>"] = { "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", "Jump to definition", mode = { "i", "n" } },
    ["<F4>"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Header / Source", mode = { "i", "n" } },
    ["<F5>"] = { "<cmd>bp!<cr>", "Previous buffer", mode = { "i", "n" } },
    ["<F6>"] = { "<cmd>bn!<cr>", "Next buffer", mode = { "i", "n" } },
    ["<F7>"] = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree", mode = { "i", "n" } },
    ["<F8>"] = { require('dap').step_over, "Dap next", mode = { "i", "n" } },
    ["<F9>"] = { require('dap').step_into, "Dap step into", mode = { "i", "n" } },
    ["<F10>"] = { require('dap').step_out, "Dap step out", mode = { "i", "n" } },
    ["<F12>"] = { "<cmd>noh<cr>", "Disable highlighting", mode = { "i", "n" } },
    ["//"] = { 'y/<C-R>"<cr>', "Highlight underlying word", mode = { "v", "n" } }
}, { nowait = true })

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

" normal copy/paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> "_dP
imap <C-v> <C-r><C-o>+
]]
