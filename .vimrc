 set sm
 set ai
 let java_highlight_all=1
 let java_highlight_functions="style"
 let java_allow_cpp_keywords=1

"Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

set nocompatible

set showcmd

filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

set autoindent

set expandtab
set smarttab

set shiftwidth=3
set softtabstop=3

set wildmenu
set wildmode=list:longest,full

set mouse=a

set backspace=2

set number

set ignorecase

set smartcase

set incsearch

set hlsearch

let g:clipbrdDefaultReg = '+'

set nohidden

highlight matchParen ctermbg=4

if has("gui_running")
   colorscheme inkpot
   "set guifont=Terminus\ 9
endif
filetype plugin indent on
syntax on

:set viminfo='20,<1000,s10,h

execute pathogen#infect()

