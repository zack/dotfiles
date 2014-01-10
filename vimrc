execute pathogen#infect()

set t_Co=256
syntax enable
let g:railscasts_termcolors=256
colorscheme railscasts

"Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"Set tab options for all filetypes
autocmd FileType * set tabstop=2|set shiftwidth=2

filetype on
filetype plugin on
filetype plugin indent on

set sm
set ai
set number
set showcmd
set smarttab
set wildmenu
set hlsearch
set nohidden
set incsearch
set expandtab
set smartcase
set incsearch
set ignorecase
set autoindent
set nocompatible

set mouse=a
set backspace=2
set grepprg=grep\ -nH\ $*
set wildmode=list:longest,full
set guifont=Consolas/12/-1/5/25/0/0/0/1/0

let &colorcolumn=81
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1
let g:clipbrdDefaultReg = '+'

highlight ColorColumn ctermbg=235
highlight matchParen ctermbg=4

:set viminfo='20,<1000,s10,h

map <Leader>i mmgg=G`m<CR>