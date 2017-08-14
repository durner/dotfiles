call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
Plug 'valloric/youcompleteme'               " autocompletion
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} " ycm generator
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'ctrlpvim/ctrlp.vim'                   " fuzzy file finder
Plug 'majutsushi/tagbar'                    " tagbar
Plug 'tpope/vim-fugitive'                   " git support
Plug 'vim-airline/vim-airline'              " fancy statusline
Plug 'godlygeek/csapprox'                   " approximate gvim plugin
Plug 'lervag/vimtex'                        " latex support
Plug 'scrooloose/syntastic'
Plug 'edkolev/promptline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'derekwyatt/vim-fswitch'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'jalvesaq/Nvim-R'

call plug#end()


"YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/config/.ycm_extra_conf.py"
set completeopt-=preview
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 0 "default 0
let g:ycm_auto_trigger = 0
map <F3> :YcmCompleter GoTo<CR>
imap <F3> <C-\><C-O>:YcmCompleter GoTo<CR>

"FSHere
map <F4> :FSHere<CR>
imap <F4> <C-\><C-O>:FSHere<CR>


"TAGBAR
"map <F8> :TagbarToggle<CR>
"imap <F8> <C-\><C-O>:TagbarToggle<CR>

"spellcheck
map <F8> :setlocal spell! spelllang=en_us<CR>
imap <F8> <C-\><C-O>:setlocal spell! spelllang=en_us<CR>


"NERDTREE
map <F7> :NERDTreeToggle<CR>
imap <F7> <C-\><C-O>:NERDTreeToggle<CR>
let NERDTreeStatusline="%{matchstr(getline('.'), '\s\zs\w\(.*\)')}"
let g:NERDTreeShowHidden = 0
let NERDTreeQuitOnOpen=1


"AIRLINE
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0             " Do not check for whitespaces
let g:airline#extensions#tagbar#enabled = 1                " Enable Tagbar integration
let g:airline_theme='light'
let g:airline_powerline_fonts = 1
set fillchars+=stl:\ ,stlnc:\

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cpp_remove_include_errors = 0
let g:syntastic_cpp_compiler_options='-std=c++11 -mavx2'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_enable_signs = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_config_file = '.syntastic'
let g:syntastic_quiet_messages={'level':'warnings'}
let g:syntastic_enable_highlighting = 0

function! ToggleHighlight()
  if g:syntastic_enable_highlighting == 1
    let g:syntastic_enable_highlighting = 0
  else
    let g:syntastic_enable_highlighting = 1
  endif
endfunction


"Autoformater
map <F12> mzgg=G`z<CR>
autocmd Filetype c,cpp map <F12> :%!clang-format -style=file<CR>
imap <F12> <C-\><C-O>mzgg=G`z<CR>
autocmd Filetype c,cpp imap <F12> <C-\><C-O> :%!clang-format -style=file<CR>

" F2 toggles paste mode one and off "
set pastetoggle=<F2>

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
vmap <C-v> c<ESC>"+p
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
" Automatic syntax highlight "
syntax on
set enc=utf-8 " Set UTF-8 encoding
set fenc=utf-8
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
set smarttab

" Make tabs 4 spaces wide "
set tabstop=2
set shiftwidth=2

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

" Highlight column 101 to help keep lines of code 100 characters or less "
set colorcolumn=121

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
"colorscheme molokai
colorscheme editplus
" set background=light
" Enable .vimrc files per project "
set exrc
set secure

"Easier Clipboard integration
set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

if has("gui_running")
    set guifont=DejaVuSansMonoforPowerline\ 12
    colorscheme editplus
endif

set mouse=a
