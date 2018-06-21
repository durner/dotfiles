call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
Plug 'valloric/youcompleteme'               " autocompletion
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} " ycm generator
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'                   " fuzzy file finder
Plug 'majutsushi/tagbar'                    " tagbar
Plug 'tpope/vim-fugitive'                   " git support
Plug 'vim-airline/vim-airline'              " fancy statusline
"Plug 'godlygeek/csapprox'                   " approximate gvim plugin (only for editplus)
Plug 'lervag/vimtex'                        " latex support
Plug 'edkolev/promptline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'derekwyatt/vim-fswitch'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'jalvesaq/Nvim-R'

"colors
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Automatic syntax highlight "
syntax on
set encoding=utf8
set enc=utf-8 " Set UTF-8 encoding
set termencoding=utf-8
let g:cpp_class_scope_highlight = 1

" Reload files modified outside of Vim "
set autoread

" Stop vim from creating automatic backups "
set noswapfile
set nobackup
set nowb

" Replace tabs with spaces "
set expandtab

" Make tabs 2 spaces wide "
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Auto Load Localvimrc
let g:localvimrc_ask = 0

set display=lastline
set linebreak
set autoindent
set smartindent

" Show line numbers "
set number

" Highlight all occurrences of a search "
set hlsearch

" search case insensitive if term is all lowercase "
set ignorecase
set smartcase

" Highlight column 121 to help keep lines of code 121 characters or less "
set colorcolumn=0
autocmd Filetype java,python,c,cpp set colorcolumn=121

set nocompatible  " Disable vi compatibility (emulation of old bugs)
set noequalalways " Do not maintain window-size ratio (when having multiple window splits I don't find it desirable)
set showmatch " highlight matching braces
set wildmode=longest:full " Use intelligent file completion like in the bash
set wildmenu
set hidden " Allow changing buffers without saving them
" set cul " Highlight the current line
set backspace=2 " Backspace tweaks
set backspace=indent,eol,start
set t_Co=256

" Colorsheme
augroup nord-overrides
  autocmd!
  autocmd ColorScheme nord highlight Comment ctermfg=13 guifg='#EBCB8B'
augroup END
colorscheme nord
"colorscheme editplus
"colorscheme summerfruit256
hi CursorLine cterm=none
hi CursorLine gui=none
" set background=light

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
  set guioptions-=T  "toolbar
  set guioptions-=r  "scrollbar
  set guioptions-=L  "scrollbar
  set guifont=DejaVuSansMonoNerdFont\ 12
endif

set mouse=a

"YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_global_ycm_extra_conf = "~/.vim/config/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_auto_trigger = 0
let g:ycm_autoclose_preview_window_after_insertion=1
map <F3> :YcmCompleter GoTo<CR>
imap <F3> <C-\><C-O>:YcmCompleter GoTo<CR>

"FSHere
map <F4> :FSHere<CR>
imap <F4> <C-\><C-O>:FSHere<CR>


"TAGBAR
map <F8> :TagbarToggle<CR>
imap <F8> <C-\><C-O>:TagbarToggle<CR>
let g:tagbar_indent = 1
autocmd FileType c,cpp nested :TagbarOpen
"autocmd BufEnter * nested :call tagbar#autoopen(0)

"spellcheck
map <F2> :setlocal spell! spelllang=en_us<CR>
imap <F2> <C-\><C-O>:setlocal spell! spelllang=en_us<CR>
hi SpellBad ctermfg=red guifg=red


"AIRLINE
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
set fillchars+=stl:\ ,stlnc:\

"NERDTREE
map <F7> :NERDTreeToggle<CR>
imap <F7> <C-\><C-O>:NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen= 1

"Autoformater
map <silent> <F12> mzgg=G`z<CR>
autocmd Filetype c,cpp map <silent> <F12> :%!clang-format-5.0 -style=file<CR>
imap <silent> <F12> <C-\><C-O>mzgg=G`z<CR>
autocmd Filetype c,cpp imap <silent> <F12> <C-\><C-O>:%!clang-format-5.0 -style=file<CR>

" F2 toggles paste mode one and off "
" set pastetoggle=<F2>

"Buffer & Windows Mgmt
map <silent> <A-Up> :wincmd v<CR>
map <silent> <A-Down> :wincmd w<CR>
map <silent> <A-Left> :bp!<CR>
map <silent> <A-Right> :bn!<CR>
map <silent> <F5> :bp!<CR>
map <silent> <F6> :bn!<CR>
imap <silent> <A-Up> <C-\><C-O>:wincmd v<CR>
imap <silent> <A-Down> <C-\><C-O>:wincmd w<CR>
imap <silent> <A-Left> <C-\><C-O>:bp!<CR>
imap <silent> <A-Right> <C-\><C-O>:bn!<CR>
imap <silent> <F5> <C-\><C-O>:bp!<CR>
imap <silent> <F6> <C-\><C-O>:bn!<CR>

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

"CTags
"set tags=./tags;/
"set tags+=./TAGS;/
"imap <silent> <F4> <C-\><C-O>g<C-]>
"vmap <silent> <F4> g<C-]>
"map <silent> <F4> g<C-]>

"GENERAL
inoremap jk <Esc>
