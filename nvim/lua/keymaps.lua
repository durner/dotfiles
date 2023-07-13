vim.keymap.set("", ",", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Auto Completion
vim.keymap.set("n", "<leader>y", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>j", require('fzf-lua').lsp_definitions, opts)
vim.keymap.set("n", "<leader>k", require('fzf-lua').lsp_implementations, opts)
vim.keymap.set("n", "<leader>r", require('fzf-lua').lsp_references, opts)
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>p", require('fzf-lua').lsp_code_actions, opts)
vim.keymap.set("n", "<F3>", vim.lsp.buf.definition, opts)
vim.keymap.set("i", "<F3>", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, opts)
vim.keymap.set("i", "<C-LeftMouse>", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<leader>b", ":CclsBaseHierarchy<cr>", opts)
vim.keymap.set("n", "<leader>h", ":CclsDerivedHierarchy<cr>", opts)
vim.keymap.set("n", "<leader>c", ":CclsIncomingCallsHierarchy<cr>", opts)
vim.keymap.set("n", "<leader>e", ":CclsOutgoingCallsHierarchy<cr>", opts)

vim.keymap.set("n", "<C-P>", "<cmd>lua require('fzf-lua').files()<cr>", opts)
vim.keymap.set("n", "<leader>t", "<cmd>lua require('fzf-lua').buffers()<cr>", opts)
vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<cr>", opts)
vim.keymap.set("n", "<leader>g", "<cmd>:lua require('fzf-lua').live_grep({ cmd = 'git grep -i --line-number --column --color=always' })<cr>", opts)
vim.keymap.set('n', '<leader>a', "<cmd>Neoformat<cr> <bar> <cmd>lua require('whitespace-nvim').trim()<cr>", opts)


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

" Buffer & Windows Mgmt
map <silent> <A-Left> :bp!<CR>
map <silent> <A-Right> :bn!<CR>
map <silent> <F5> :bp!<CR>
map <silent> <F6> :bn!<CR>
imap <silent> <A-Left> <C-\><C-O>:bp!<CR>
imap <silent> <A-Right> <C-\><C-O>:bn!<CR>
imap <silent> <F5> <C-\><C-O>:bp!<CR>
imap <silent> <F6> <C-\><C-O>:bn!<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" FSHere
map <F4> :FSHere<CR>
imap <F4> <C-\><C-O>:FSHere<CR>

" Spellcheck
map <F2> :setlocal spell! spelllang=en_us<CR>
imap <F2> <C-\><C-O>:setlocal spell! spelllang=en_us<CR>
hi SpellBad ctermfg=red guifg=red

" Tree
map <F7> :NvimTreeToggle<CR>
imap <F7> <C-\><C-O>:NvimTreeToggle<CR>

" allows to stamp in visual mode
vnoremap p "_dP

" normal copy/paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> "_dP
imap <C-v> <C-r><C-o>+

" seach and delete results
map <silent> <F9> :noh<CR>
map <silent> <leader>x :noh<CR>
imap <silent> <F9> <C-\><C-O>:noh<CR>
vnoremap // y/<C-R>"<CR>

" general
inoremap jk <Esc>
nnoremap <leader>- i//<ESC>75a-<ESC><CR>
]]
