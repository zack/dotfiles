filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle plugins
Plugin 'gmarik/vundle'
Plugin 'amdt/vim-niji'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'groenewege/vim-less'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/rainbow-end'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mustache/vim-mustache-handlebars'

" amdt/vim-niji customization
let g:niji_matching_filetypes = ['racket']

" Pathogen
execute pathogen#infect()

set t_Co=256
syntax enable
let g:railscasts_termcolors=256
colorscheme railscasts

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"JSON Highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

" Set tab options for all filetypes
autocmd FileType * set tabstop=2|set shiftwidth=2
autocmd FileType python set tabstop=4|set shiftwidth=4

filetype plugin indent on

" For do/end matching
runtime macros/matchit.vim

set sm
set ai
set paste
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
set cursorline
set cursorcolumn
set nocompatible
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%#error#%m%*%r%y%=%c,%l/%L\ %P
set runtimepath^=~/.vim/bundle/ctrlp.vim

set mouse=a
set backspace=2
set grepprg=grep\ -nH\ $*
set wildmode=list:longest,full
set guifont=Consolas/12/-1/5/25/0/0/0/1/0
set scrolloff=5 " Keep five lines below/above cursor

let &colorcolumn=80
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1
let g:clipbrdDefaultReg = '+'

highlight ColorColumn ctermbg=52
highlight CursorLine ctermbg=239
highlight CursorColumn ctermbg=239
highlight matchParen ctermbg=4
highlight clear SignColumn

:set viminfo='20,<1000,s10,h

" \i to indent whole file
map <Leader>i mmgg=G`m<CR>

" Switch between rel and abs line numbers with <C-n>
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" For NumberToggle
nnoremap <C-n> :call NumberToggle()<CR>

" For Rainbow-End
nnoremap <C-d> :call ToggleRainbow()<CR>

" Show full filename
nnoremap <C-f> :echo expand('%F')<CR>

" This unsets the 'last search pattern' register by hitting return
nnoremap <silent> <leader>c :nohl<CR>

" Use j and k to navigate menus
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" Because capslock is stupid, let's make ctrl+^ fake the capslock function
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Kill the fake software capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0

" Search and replace highlighted (visual block) text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
