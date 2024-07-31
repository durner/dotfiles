local wk = require("which-key")
vim.keymap.set("", ",", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true, buffer = bufnr }
local dap = require "dap"

-- Auto Completion
wk.add({
    nowait = true,
    {
        group = "Completion",
        desc = "Completion",
        { "<leader>y", vim.lsp.buf.hover,                                                                   desc = "Hover", },
        { "<leader>j", "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", desc = "Jump to definition" },
        { "<leader>k", require('fzf-lua').lsp_implementations,                                              desc = "Jump to implementation" },
        { "<leader>r", require('fzf-lua').lsp_references,                                                   desc = "Jump to references" },
        { "<leader>n", vim.lsp.buf.rename,                                                                  desc = "Rename" },
        { "<leader>p", require('fzf-lua').lsp_code_actions,                                                 desc = "Code actions" },
        { "<leader>i", require('fzf-lua').lsp_incoming_calls,                                               desc = "Incoming calls hierarchy" },
        { "<leader>o", require('fzf-lua').lsp_outgoing_calls,                                               desc = "Outgoing calls hierarchy" },
        { "<leader>q", "<cmd>lua require('fzf-lua').buffers()<cr>",                                         desc = "Buffers" },
        { "<leader>f", "<cmd>lua require('fzf-lua').files()<cr>",                                           desc = "Files" },
        {
            "<leader>g",
            "<cmd>lua require('fzf-lua').live_grep({ cmd = 'git grep -i --line-number --column --color=always' })<cr>",
            desc = "Git grep"
        },
        { "<leader>a", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
        { "<leader>e", vim.diagnostic.goto_next,            desc = "Next Diagnostic" },
        { "<leader>-", "i//<Esc>75a-<ESC><cr>",             desc = "Insert separator" },

    },
    {
        desc = "Debug menu",
        group = "Debug menu",
        { "<leader>dn", require('dap').step_over,        desc = "Next" },
        { "<leader>di", require('dap').step_into,        desc = "Step into" },
        { "<leader>df", require('dap').step_out,         desc = "Finish" },
        { "<leader>dc", require('dap').continue,         desc = "Continue" },
        { "<leader>dy", require("dap.ui.widgets").hover, desc = "Hover" },
        {
            "<leader>dx",
            function()
                require('dap').disconnect()
                require("dapui").close()
            end,
            desc = "Terminate"
        },
        { "<leader>du", require('dap').up,                                 desc = "Up" },
        { "<leader>dd", require('dap').down,                               desc = "Down" },
        { "<leader>dp", require('dap').pause,                              desc = "Pause" },
        { "<leader>dv", "<cmd>lua require('fzf-lua').dap_variables()<cr>", desc = "Variables" },
        { "<leader>ds", "<cmd>lua require('fzf-lua').dap_frames()<cr>",    desc = "Strack Trace" },
        { "<leader>dt", dap.toggle_breakpoint,                             desc = "Toggle Breakpoint" },
        {
            "<leader>db",
            function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = "Set Breakpoint"
        },
    },
    {
        desc = "CMake menu",
        group = "CMake menu",
        { "<leader>mg", "<cmd>CMakeGenerate<cr>",           desc = "Generate" },
        { "<leader>mr", "<cmd>CMakeRun<cr>",                desc = "Run" },
        { "<leader>md", "<cmd>CMakeDebug<cr>",              desc = "Debug" },
        { "<leader>mb", "<cmd>CMakeBuild<cr>",              desc = "Build" },
        { "<leader>mt", "<cmd>CMakeSelectBuildType<cr>",    desc = "Select Build Type" },
        { "<leader>me", "<cmd>CMakeSelectBuildTarget<cr>",  desc = "Select Buld Target" },
        { "<leader>ml", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "Select Launch Target" },
        {
            "<leader>ms",
            function()
                vim.cmd([[CMakeStopRunner]])
                vim.cmd([[CMakeStopExecutor]])
            end,
            desc = "Stop CMake"
        }
    },
    {
        desc = "ToggleTerm menu",
        group = "ToggleTerm",
        { "<leader>tt", "<cmd>ToggleTerm<cr>",                 desc = "Regular Term" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Term" },
    },
    {
        group = "General",
        desc = "General",
        { "jk",            "<Esc>",                                                                             desc = "Go to normal",              mode = { "i" } },
        { "<Esc>",         ":noh <CR>",                                                                         desc = "Disable highligting" },
        { "<C-LeftMouse>", "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", desc = "Jump to definition",        mode = { "i", "n" } },
        { "<C-P>",         "<cmd>lua require('fzf-lua').git_files()<cr>",                                       desc = "Find Files",                mode = { "i", "n" } },
        { "<C-h>",         "<C-w>h",                                                                            desc = "Window left",               mode = { "i", "n" } },
        { "<C-l>",         "<C-w>l",                                                                            desc = "Window right",              mode = { "i", "n" } },
        { "<C-j>",         "<C-w>j",                                                                            desc = "Window down",               mode = { "i", "n" } },
        { "<C-k>",         "<C-w>k",                                                                            desc = "Window up",                 mode = { "i", "n" } },
        { "<F2>",          "<cmd>setlocal spell! spelllang=en_us<cr>",                                          desc = "Spell Check",               mode = { "i", "n" } },
        { "<F3>",          "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>", desc = "Jump to definition",        mode = { "i", "n" } },
        { "<F4>",          "<cmd>ClangdSwitchSourceHeader<cr>",                                                 desc = "Switch Header / Source",    mode = { "i", "n" } },
        { "<F5>",          "<cmd>bp!<cr>",                                                                      desc = "Previous buffer",           mode = { "i", "n" } },
        { "<F6>",          "<cmd>bn!<cr>",                                                                      desc = "Next buffer",               mode = { "i", "n" } },
        { "<F7>",          "<cmd>NvimTreeToggle<cr>",                                                           desc = "Toggle NvimTree",           mode = { "i", "n" } },
        { "<F8>",          require('dap').step_over,                                                            desc = "Dap next",                  mode = { "i", "n" } },
        { "<F9>",          require('dap').step_into,                                                            desc = "Dap step into",             mode = { "i", "n" } },
        { "<F10>",         require('dap').step_out,                                                             desc = "Dap step out",              mode = { "i", "n" } },
        { "<F12>",         "<cmd>noh<cr>",                                                                      desc = "Disable highlighting",      mode = { "i", "n" } },
        { "//",            'y/<C-R>"<cr>',                                                                      desc = "Highlight underlying word", mode = { "v", "n" } }
    }
})

-- Terminal mode keymaps


function _G.set_terminal_keymaps()
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<cr>]], opts)
    vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<cr>]], opts)
    vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<cr>]], opts)
    vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<cr>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

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
