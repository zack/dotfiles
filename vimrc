" Turn all of this off for pathogen. Just to be safe.
filetype off
filetype plugin indent off

" Pathogen
execute pathogen#infect()

" Turn that back on
filetype plugin indent on
syntax enable

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'amdt/vim-niji'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'groenewege/vim-less'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/rainbow-end'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mustache/vim-mustache-handlebars'

" Ensure proper color settings for the terminal
set t_Co=256
let g:railscasts_termcolors = 256
colorscheme railscasts

" Special Syntax Highlighting
let g:niji_matching_filetypes = ['racket'] " Racket
autocmd BufNewFile,BufRead *.json set ft=javascript " JSON using JS rules

" Autotrim whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Tab options
autocmd FileType * set tabstop=2|set shiftwidth=2
autocmd FileType python set tabstop=4|set shiftwidth=4

" Do/end matching
runtime macros/matchit.vim

" Sets
set ai
set sm
set hidden
set nowrap
set number
set showcmd
set hlsearch
set nohidden
set smarttab
set undofile
set wildmenu
set expandtab
set incsearch
set smartcase
set autoindent
set cursorline
set ignorecase
set cursorcolumn
set nocompatible

" Because consistency
set lcs          =trail:·,tab:»·,eol:$,extends:»
set mouse        =a
set grepprg      =grep\ -nH\ $*
set guifont      =Consolas/12/-1/5/25/0/0/0/1/0
set viminfo      ='20,<1000,s10,h
set wildmode     =list:longest,full
set backspace    =2
set scrolloff    =5
set textwidth    =79
set laststatus   =2

" Lets
let &colorcolumn             =80
let java_highlight_all       =1
let java_highlight_functions ="style"
let java_allow_cpp_keywords  =1
let g:clipbrdDefaultReg      ='+'

" Syntastic settings
set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
let g:syntastic_check_on_wq              = 0
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_always_populate_loc_list = 1
source ~/.syntastic.conf

" Colors
hi clear SignColumn
hi matchParen ctermbg=4
hi CursorLine ctermbg=239
hi ColorColumn ctermbg=52
hi CursorColumn ctermbg=239

" Switch between rel and abs line numbers. Key mapping below
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" Normal mode, non-recursive key mappings
nnoremap gb :bn<CR>| " Next buffer
nnoremap Gb :bp<CR>| " Previous buffer
nnoremap <C-d> :call ToggleRainbow()<CR>| " Toggle rainbowend
nnoremap <Leader>i mmgg=G`m<CR>| " \i will set indent on the whole file
nnoremap <C-f> :echo expand('%F')<CR>| " Show the full file name and path
nnoremap <C-n> :call NumberToggle()<CR>| " Toggle absolute vs relative numbers
nnoremap <silent> <leader>c :nohl<CR>| " Unset 'last search' register on return

" Insert mode, non-recursive key mappings
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"| " Menu navigation
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"| " Menu navigation

" Visual mode, non-recursive key mappings
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>| " Search and replace text

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts=1
