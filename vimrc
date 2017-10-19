set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Plugin
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'chrisbra/csv.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-scala'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elmcast/elm-vim'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/rainbow-end'
Plugin 'w0rp/ale'
Plugin 'whatyouhide/vim-gotham'
Plugin 'zack/rainbow_parentheses.vim'

syntax enable

filetype plugin indent on

" Ensure proper color settings for the terminal
colorscheme gotham

" Special Syntax Highlighting
let g:niji_matching_filetypes = ['racket'] " Racket
autocmd BufNewFile,BufRead *.json set ft=javascript " JSON using JS rules

" Autotrim whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Delete comment character when joining commented lines
set formatoptions+=j

" Tab options
autocmd FileType * setlocal tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType cpp setlocal tabstop=8|set shiftwidth=8|set softtabstop=8|set noexpandtab
autocmd FileType elm setlocal tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab
autocmd FileType html setlocal tabstop=4|set shiftwidth=4|set expandtab|set fo-=t
autocmd FileType python setlocal tabstop=4|set shiftwidth=4|set expandtab

" Do/end matching
runtime macros/matchit.vim

" Man pages
runtime ftplugin/man.vim

" Sets
set ai
set autoindent
set cursorcolumn
set cursorline
set hidden
set hlsearch
set ignorecase
set incsearch
set list
set nohidden
set nowrap
set number
set sm
set smartcase
set smarttab
set splitbelow
set splitright
set undofile
set wildmenu

" Because consistency
set backspace    =2
set encoding     =utf8
set grepprg      =grep\ -nH\ $*
set guifont      =Consolas/12/-1/5/25/0/0/0/1/0
set laststatus   =2
set lcs          =trail:·,tab:»·,eol:$,extends:»
set scrolloff    =5
set sidescroll   =1
set textwidth    =79
set undodir      =$HOME/.vim/undo
set undolevels   =1000
set undoreload   =10000
set viminfo      ='20,<1000,s10,h
set wildmode     =list:longest,full

" Autocommands
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Lets
let &colorcolumn             ="80,100"
let g:clipbrdDefaultReg      ='+'
let mapleader = "\<Space>"

" Airline
let g:airline#extensions#branch#enabled   =1
let g:airline#extensions#hunks#enabled    =1
let g:airline_detect_paste                =1
let g:airline_left_sep                    =''
let g:airline_powerline_fonts             =1
let g:airline_right_sep                   =''
let g:airline_theme                       ='dark'

" CtrlP settings
let g:ctrlp_open_multiple_files = '1i'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](_build|deps)$',
      \ }

" Editorconfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Elm-Vim settings
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 1
au FileType elm nmap <leader>m <Plug>(elm-make)
au FileType elm nmap <leader>b <Plug>(elm-make-main)
au FileType elm nmap <leader>t <Plug>(elm-test)
au FileType elm nmap <leader>r <Plug>(elm-repl)
au FileType elm nmap <leader>e <Plug>(elm-error-detail)
au FileType elm nmap <leader>d <Plug>(elm-show-docs)
au FileType elm nmap <leader>w <Plug>(elm-browse-docs)

" NerdCommenter
let NERDSpaceDelims =1

set statusline+=%*
set statusline+=%#warningmsg#

"Vim-Gitgutter settingsh
let g:gitgutter_map_keys = 0 " Don't map my keys!
let g:gitgutter_max_signs = 10000

" Colors
hi clear SignColumn
hi ColorColumn ctermbg=52
hi CursorColumn ctermbg=235
hi CursorLine ctermbg=235
hi matchParen ctermbg=4

" Switch between rel and abs line numbers. Key mapping below
function! RelNumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

function! AllNumberToggle()
  if(&number == 1 || &relativenumber == 1)
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

" Keybindings

" Nobody uses you and you have no friends
map q: :q
" Replace double quotes with single quotes
map <leader>' cs"'<ESC>
" Replace single quotes with double quotes
map <leader>" cs'"<ESC>
" Redraw
map <leader>R :redraw!<CR>

" v to expand region
vmap v <Plug>(expand_region_expand)
" Ctrl-V to collapse region
vmap <C-v> <Plug>(expand_region_shrink)

" Menu navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
" Menu navigation
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" Select the whole line
nnoremap <leader><leader> V
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
nnoremap <C-n> :call RelNumberToggle()<CR>
" Toggle all number display
nnoremap <leader>n :call AllNumberToggle()<CR>
" Search and replace text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Search and prepend text
vnoremap <C-e> "hy:%s/\(<C-r>h\)/\1/gc<left><left><left><left><left>
" Search and postpend text
vnoremap <C-t> "hy:%s/\(<C-r>h\)/\1/gc<left><left><left>
" Set indent on file
nnoremap <leader>i mmgg=G`m<CR>
" Access CtrlP
nnoremap <leader>o :CtrlP<CR>
" Sort
vnoremap <leader>s :sort<CR>
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
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P
vmap <leader>y "+y

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

" At the bottom because something above is breaking it
set showcmd

let g:ale_linters = {
\   'javascript': ['eslint'],
\}
