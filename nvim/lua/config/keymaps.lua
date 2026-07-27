local wk = require("which-key")
vim.keymap.set("", ",", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true }
local dap = require "dap"

-- fzf no git alternatives
local fzf = require("fzf-lua")

local function in_git_worktree()
    local result = vim.system(
        { "git", "rev-parse", "--is-inside-work-tree" },
        { text = true }
    ):wait()

    return result.code == 0 and vim.trim(result.stdout) == "true"
end

local function find_files()
    if in_git_worktree() then
        fzf.git_files({ resume = true })
    else
        fzf.files({ resume = true })
    end
end

local function grep_project()
    if in_git_worktree() then
        fzf.live_grep({
            cmd = "git grep -i --line-number --column --color=always",
            resume = true
        })
    else
        fzf.live_grep({ resume = true })
    end
end

-- Auto Completion
wk.add({
    nowait = true,
    {
        group = "Completion",
        desc = "Completion",
        { "<leader>y", vim.lsp.buf.hover,                                                   desc = "Hover", },
        { "<leader>j", "<cmd>lua require('fzf-lua').lsp_definitions({ jump1 = true })<cr>", desc = "Jump to definition" },
        { "<leader>k", fzf.lsp_implementations,                                             desc = "Jump to implementation" },
        { "<leader>r", fzf.lsp_references,                                                  desc = "Jump to references" },
        { "<leader>n", vim.lsp.buf.rename,                                                  desc = "Rename" },
        { "<leader>p", fzf.lsp_code_actions,                                                desc = "Code actions" },
        { "<leader>i", fzf.lsp_incoming_calls,                                              desc = "Incoming calls hierarchy" },
        { "<leader>o", fzf.lsp_outgoing_calls,                                              desc = "Outgoing calls hierarchy" },
        { "<leader>h", fzf.lsp_type_sub,                                                    desc = "Derived Types" },
        { "<leader>b", fzf.lsp_type_super,                                                  desc = "Base Types" },
        { "<leader>q", "<cmd>lua require('fzf-lua').buffers({ resume = true })<cr>",        desc = "Buffers" },
        { "<leader>c", fzf.git_bcommits,                                                    desc = "Commits of this file" },
        { "<leader>f", find_files,                                                          desc = "Files" },
        { "<leader>g", grep_project,                                                        desc = "Git grep" },
        {
            "<leader>a",
            function()
                local has_conform, conform = pcall(require, "conform")
                if has_conform then
                    conform.format({ async = true, lsp_format = "fallback" })
                    return
                end
                vim.lsp.buf.format()
            end,
            desc = "Format"
        },
        { "<leader>e", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        { "<leader>-", "i//<Esc>75a-<ESC><cr>",  desc = "Insert separator" },
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
        { "<leader>du", require('dap').up,                  desc = "Up" },
        { "<leader>dd", require('dap').down,                desc = "Down" },
        { "<leader>dp", require('dap').pause,               desc = "Pause" },
        { "<leader>dv", "<cmd>lua fzf.dap_variables()<cr>", desc = "Variables" },
        { "<leader>ds", "<cmd>lua fzf.dap_frames()<cr>",    desc = "Strack Trace" },
        { "<leader>dt", dap.toggle_breakpoint,              desc = "Toggle Breakpoint" },
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
        desc = "CodeCompanion menu",
        group = "CodeCompanion",
        { "<leader>wc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
        { "<leader>ww", "<cmd>CodeCompanion<cr>",     desc = "CodeCompanion",     mode = { "v", "i" } },
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
        { "jk",            "<Esc>",                                                             desc = "Go to normal",              mode = { "i" } },
        { "<Esc>",         ":noh <CR>",                                                         desc = "Disable highligting" },
        { "<C-LeftMouse>", "<cmd>lua require('fzf-lua').lsp_definitions({ jump1 = true })<cr>", desc = "Jump to definition",        mode = { "i", "n" } },
        { "<C-P>",         find_files,                                                          desc = "Find Files",                mode = { "i", "n" } },
        { "<C-h>",         "<C-w>h",                                                            desc = "Window left",               mode = { "i", "n" } },
        { "<C-l>",         "<C-w>l",                                                            desc = "Window right",              mode = { "i", "n" } },
        { "<C-j>",         "<C-w>j",                                                            desc = "Window down",               mode = { "i", "n" } },
        { "<C-k>",         "<C-w>k",                                                            desc = "Window up",                 mode = { "i", "n" } },
        { "<F2>",          "<cmd>setlocal spell! spelllang=en_us<cr>",                          desc = "Spell Check",               mode = { "i", "n" } },
        { "<F3>",          "<cmd>lua require('fzf-lua').lsp_definitions({ jump1 = true })<cr>", desc = "Jump to definition",        mode = { "i", "n" } },
        { "<F4>",          "<cmd>LspClangdSwitchSourceHeader<cr>",                              desc = "Switch Header / Source",    mode = { "i", "n" } },
        { "<F5>",          "<cmd>bp!<cr>",                                                      desc = "Previous buffer",           mode = { "i", "n" } },
        { "<F6>",          "<cmd>bn!<cr>",                                                      desc = "Next buffer",               mode = { "i", "n" } },
        { "<F7>",          "<cmd>NvimTreeToggle<cr>",                                           desc = "Toggle NvimTree",           mode = { "i", "n" } },
        { "<F8>",          require('dap').step_over,                                            desc = "Dap next",                  mode = { "i", "n" } },
        { "<F9>",          require('dap').step_into,                                            desc = "Dap step into",             mode = { "i", "n" } },
        { "<F10>",         require('dap').step_out,                                             desc = "Dap step out",              mode = { "i", "n" } },
        { "<F12>",         "<cmd>noh<cr>",                                                      desc = "Disable highlighting",      mode = { "i", "n" } },
        { "//",            'y/<C-R>"<cr>',                                                      desc = "Highlight underlying word", mode = { "v", "n" } }
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


-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

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
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> "_dP
imap <C-v> <C-r>+
]]
