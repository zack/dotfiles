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
Plugin 'rking/ag.vim'
Plugin 'gmarik/vundle'
Plugin 'sjl/gundo.vim'
Plugin 'benmills/vimux'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'skalnik/vim-vroom'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-fireplace'
Plugin 'groenewege/vim-less'
Plugin 'airblade/vim-gitgutter'
Plugin 'whatyouhide/vim-gotham'
Plugin 'vim-scripts/rainbow-end'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-expand-region'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mustache/vim-mustache-handlebars'

" Ensure proper color settings for the terminal
"set t_Co=256
"let g:railscasts_termcolors = 256
"colorscheme railscasts
colorscheme gotham

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
set splitbelow
set cursorline
set ignorecase
set splitright
set cursorcolumn
set nocompatible
set nofoldenable
set relativenumber

" Because consistency
set backspace    =2
set foldlevel    =2
set foldmethod   =indent
set foldnestmax  =10
set grepprg      =grep\ -nH\ $*
set guifont      =Consolas/12/-1/5/25/0/0/0/1/0
set laststatus   =2
set lcs          =trail:·,tab:»·,eol:$,extends:»
set scrolloff    =5
set textwidth    =79
set undodir      =$HOME/.vim/undo
set undolevels   =1000
set undoreload   =10000
set viminfo      ='20,<1000,s10,h
set wildmode     =list:longest,full

" Lets
let &colorcolumn             ="80,100"
let java_highlight_all       =1
let java_highlight_functions ="style"
let java_allow_cpp_keywords  =1
let g:clipbrdDefaultReg      ='+'
let NERDTreeHijackNetrw      =1

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
hi ColorColumn ctermbg=52
hi CursorLine ctermbg=235
hi CursorColumn ctermbg=235

" Switch between rel and abs line numbers. Key mapping below
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Better leader key
let mapleader = "\<Space>"

" Keybindings

" Nobody uses you and you have no friends
map q: :q

" v to expand region
vmap v <Plug>(expand_region_expand)
" Ctrl-V to collapse region
vmap <C-v> <Plug>(expand_region_shrink)

" Menu navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
" Menu navigation
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" Select the whole line
nnoremap <Leader><Leader> V
" New tab
nnoremap tn :tabedit<CR>
" Close tab
nnoremap tx :tabclose<CR>
" Backspace to go to beginning of file
nnoremap <BS> gg
" Open CtrlP directly to buffers
nnoremap <C-b> :CtrlPBuffer<CR>
" Toggle rainbowparentheses
nnoremap <C-c> :RainbowParenthesesToggle<CR>
" Toggle rainbowend
nnoremap <C-d> :call ToggleRainbow()<CR>
" Show the full file name and path
nnoremap <C-f> :echo expand('%:p')<CR>
" Toggle absolute vs relative numbers
nnoremap <C-n> :call NumberToggle()<CR>
" Search and replace text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Previous tab
nnoremap <C-[> :tabp<CR>
" Next tab
nnoremap <C-]> :tabn<CR>
" Beginning of line
nnoremap <leader>h ^
" Set indent on file
nnoremap <leader>i mmgg=G`m<CR>
" Access CtrlP
nnoremap <Leader>o :CtrlP<CR>
" Toggle syntastic
nnoremap <leader>s :SyntasticToggleMode<CR>
" Toggle Gundo Tree
nnoremap <leader>u :GundoToggle<CR>
" Save a file
nnoremap <leader>w :w<CR>
" Unset 'last search' register on return
nnoremap <silent> <leader>\ :nohl<CR>

" Resize vim splits
nnoremap <leader>h :vertical resize +10<CR>
nnoremap <leader>H :vertical resize +1<CR>
nnoremap <leader>j :resize -10<CR>
nnoremap <leader>J :resize -1<CR>
nnoremap <leader>k :resize +10<CR>
nnoremap <leader>K :resize +1<CR>
nnoremap <leader>l :vertical resize -10<CR>
nnoremap <leader>L :vertical resize -1<CR>

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
let g:airline_theme='dark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

" Vim-Vroom settings
let g:vroom_use_vimux=1 " Use vimux, obviously

"Vim-Gitgutter settingsh
let g:gitgutter_map_keys = 0 " Don't map my keys!

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

" Use ag with ack.vim if available
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
