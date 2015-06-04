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

" Plugin
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-fireplace'
Plugin 'groenewege/vim-less'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/rainbow-end'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-expand-region'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mustache/vim-mustache-handlebars'

" Bundle
Bundle 'scrooloose/nerdtree'

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
set grepprg      =grep\ -nH\ $*
set guifont      =Consolas/12/-1/5/25/0/0/0/1/0
set viminfo      ='20,<1000,s10,h
set wildmode     =list:longest,full
set backspace    =2
set scrolloff    =5
set textwidth    =79
set laststatus   =2

" Lets
let &colorcolumn             ="80,100"
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
let g:syntastic_mode_map                 = { 'mode': 'passive' }
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

" Better leader key
let mapleader = "\<Space>"

" Keybindings
map q: :q| " Nobody uses you and you have no friends

nmap <Leader><Leader> V

vmap v <Plug>(expand_region_expand)| " v to expand region
vmap <C-v> <Plug>(expand_region_shrink)| " Ctrl-V to collapse region

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"| " Menu navigation
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"| " Menu navigation

nnoremap tn :tabedit<CR>| " New tab
nnoremap tx :tabclose<CR>| " Close tab
nnoremap <BS> gg| " Backspace to go to beginning of file
nnoremap <CR> G| " Use <Enter> instead of G
nnoremap <C-b> :CtrlPBuffer<CR>| " Open CtrlP directly to buffers
nnoremap <C-c> :RainbowParenthesesToggle<CR>| " Toggle rainbowparentheses
nnoremap <C-d> :call ToggleRainbow()<CR>| " Toggle rainbowend
nnoremap <C-f> :echo expand('%:p')<CR>| " Show the full file name and path
nnoremap <C-n> :call NumberToggle()<CR>| " Toggle absolute vs relative numbers
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>| " Search and replace text
nnoremap <C-[> :tabp<CR>| " Previous tab
nnoremap <C-]> :tabn<CR>| " Next tab
nnoremap <leader>hh ^|" Beginning of line
nnoremap <leader>i mmgg=G`m<CR>| " Set indent on file
nnoremap <leader>j :%!python -m json.tool<CR>| " Format JSON
nnoremap <leader>l $|" End of line
nnoremap <leader>n :NERDTree<CR>| "Open NERDTree
nnoremap <Leader>o :CtrlP<CR>| " Access CtrlP
nnoremap <leader>` ggg?G``
nnoremap <leader>s :SyntasticToggleMode<CR>| " Toggle syntastic
nnoremap <leader>w :w<CR>| " Save a file
nnoremap <silent> <leader>c :nohl<CR>| " Unset 'last search' register on return

" Start copy and paste to system clipboard using p and y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Start putting doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Airline settings
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

" CtrlP settings
let g:ctrlp_open_multiple_files = '1i'
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
