call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'
Plug 'scrooloose/nerdtree'
"Plug 'ryanoasis/vim-devicons'
Plug '~/.repos/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'edkolev/promptline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'derekwyatt/vim-fswitch'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline-themes'
Plug 'jalvesaq/Nvim-R'
Plug 'rhysd/vim-clang-format'
"Plug 'airblade/vim-gitgutter'
Plug 'ntnn/vim-diction'
"Language Server
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
if has('nvim')
    Plug 'Shougo/deoplete.nvim', {
        \ 'do': ':UpdateRemotePlugins',
        \ }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

"nord-template colors
" Plug 'arcticicestudio/nord-vim'
"editplus
"Plug 'godlygeek/csapprox'
"candid
"Plug 'flrnprz/candid.vim'
" tender
Plug 'jacoborus/tender.vim'
call plug#end()
" Colorsheme
"augroup nord-overrides
"    autocmd!
"    autocmd ColorScheme nord highlight Comment ctermfg=13 guifg='#EBCB8B'
"augroup END
" Automatic syntax highlight "
syntax on
set termguicolors
"set background=dark
"colorscheme nord
"colorscheme editplus
"colorscheme candid
colorscheme tender
" Learn it the hard way
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Alternate map leader
let mapleader = ','
let g:mapleader = ','

set encoding=utf8
set enc=utf-8
"set termencoding=utf-8
"let g:cpp_class_scope_highlight = 1

" Reload files modified outside of Vim "
set autoread

" Stop vim from creating automatic backups "
set nobackup
set nowb
set directory=~/.vimtmp//

" Replace tabs with spaces "
set expandtab

" Make tabs 4 spaces wide "
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Auto Load Localvimrc
let g:localvimrc_ask = 0

" indent
set display=lastline
set autoindent
set smartindent

" wrap
set wrap
set linebreak
" only linebreak at some characters (reduced from default)
set breakat-=-

" wrap indention
set breakindent
set breakindentopt=shift:2

" Show line numbers "
set number

" Highlight all occurrences of a search "
set hlsearch

" search case insensitive if term is all lowercase "
set ignorecase
set smartcase
set colorcolumn=0

set nocompatible
set noequalalways
set showmatch
set wildmode=longest:full
set wildmenu
set hidden
set backspace=2
set backspace=indent,eol,start

" Enable .vimrc files per project "
set exrc
set secure

"Easier Clipboard integration
set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

if has('gui')
  set guioptions-=m  "menu bar
  "set guioptions-=T  "toolbar
  "set guioptions-=r  "scrollbar
  "set guioptions-=L  "scrollbar
  set belloff=all
  set guifont=FiraCodeRetina\ 13
endif

set mouse=a

" LanguageClient
let g:LanguageClient_serverCommands = {
    \   'python': ['pyls'],
    \   'cpp': [
    \       '~/.local/bin/ccls',
    \       '--log-file=/tmp/ccls.log',
    \       '--init={"cache": {"directory": "/tmp/ccls-cache"}}'
    \   ],
    \   'c': [
    \       '~/.local/bin/ccls',
    \       '--log-file=/tmp/ccls.log',
    \       '--init={"cache": {"directory": "/tmp/ccls-cache"}}'
    \   ]
    \ }
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <leader>ry :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>rk :call LanguageClient#textDocument_implementation()<CR>
nnoremap <leader>rj :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>rf :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>rF :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<CR>
nnoremap <leader>rp :call LanguageClient#textDocument_documentSymbol()<CR>
map <F3> :call LanguageClient#textDocument_definition()<CR>
imap <F3> <C-\><C-O>:call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>rn :call LanguageClient#textDocument_rename()<CR>
" bases
nnoremap <leader>rb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
" derived
nnoremap <leader>rh :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
" caller
nnoremap <leader>rv :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
" callee
nnoremap <leader>rc :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>

set completeopt-=preview

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#option({ 'ignore_case': v:true, 'ignore_sources': { 'cpp': ['buffer', 'around', 'tag', 'member']}})
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#manual_complete()
set signcolumn=yes

"FSHere
map <F4> :FSHere<CR>
imap <F4> <C-\><C-O>:FSHere<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"TAGBAR
map <F8> :TagbarToggle<CR>
imap <F8> <C-\><C-O>:TagbarToggle<CR>
let g:tagbar_indent = 1
"autocmd FileType c,cpp nested :TagbarOpen

"spellcheck
map <F2> :setlocal spell! spelllang=en_us<CR>
imap <F2> <C-\><C-O>:setlocal spell! spelllang=en_us<CR>
hi SpellBad ctermfg=red guifg=red

"AIRLINE
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='tender'
let g:airline_powerline_fonts = 1
set fillchars+=stl:\ ,stlnc:\

"NERDTREE
map <F7> :NERDTreeToggle<CR>
imap <F7> <C-\><C-O>:NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen= 1

"Autoformater
map <silent> <F12> mzgg=G`z<CR>
autocmd Filetype c,cpp map <silent> <F12> :ClangFormat<CR>
imap <silent> <F12> <C-\><C-O>mzgg=G`z<CR>
autocmd Filetype c,cpp imap <silent> <F12> <C-\><C-O>:ClangFormat<CR>

"Buffer & Windows Mgmt
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

"location list
nnoremap <leader>ln :lne<CR>
nnoremap <leader>lp :lp<CR>
nnoremap <leader>lc :lcl<CR>

" allows to stamp in visual mode
vnoremap p "_dP

" normal copy/paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> "_dP
imap <C-v> <C-r><C-o>+

" seach and delete results
map <silent> <F9> :noh<CR>
imap <silent> <F9> <C-\><C-O>:noh<CR>
vnoremap // y/<C-R>"<CR>

"GENERAL
inoremap jk <Esc>
nnoremap <leader>lb i//<ESC>75a-<ESC><CR>

"RTags
autocmd Filetype c,cpp silent! execute "!rc -w $(pwd) >/dev/null 2>&1" | redraw!

"Large File Handling
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

"fzf
nnoremap <C-P> :Files<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* Gitgrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
command! -bang -nargs=* Gitgrepi
  \ call fzf#vim#grep(
  \   'git grep -i --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }

let g:clang_format#detect_style_file = 1
