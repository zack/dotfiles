set nocompatible

filetype off

" Get fzf up in here
set rtp+=~/.fzf

" FZF
let $FZF_DEFAULT_COMMAND="rg --files | rg -v '(jpg$|png$)'"

" For colors and stuff
set termguicolors

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'blueyed/smarty.vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'ervandew/supertab'
Plug 'ggandor/lightspeed.nvim'
Plug 'gmarik/vundle'
Plug 'groenewege/vim-less'
Plug 'herringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'knubie/vim-kitty-navigator'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'pangloss/vim-javascript'
Plug 'rbgrouleff/bclose.vim'
Plug 'rigellute/rigel'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-jp/syntax-vim-ex'
Plug 'yuezk/vim-js'

call plug#end()

syntax enable
filetype plugin indent on

" nvim colorizer
lua require'colorizer'.setup()

" Colorscheme from minpac plugin
colorscheme rigel

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.hbs      set filetype=html.handlebars syntax=mustache
  au BufNewFile,BufRead *.js       set filetype=javascript      syntax=javascript
  au BufNewFile,BufRead *.jsx      set filetype=javascriptreact syntax=javascriptreact
  au BufNewFile,BufRead *.mustache set filetype=html.mustache   syntax=mustache
  au BufNewFile,BufRead *.tpl      set filetype=html.handlebars syntax=mustache
  au BufNewFile,BufRead *.ts       set filetype=typescript      syntax=typescript
  au BufNewFile,BufRead *.tsx      set filetype=typescriptreact syntax=typescriptreact
augroup END
au FileType gitcommit 1

" disable syntax highlighting in files > 250K
au BufReadPost * if getfsize(bufname("%")) > 250*1024 | set syntax= ai | endif

" Autotrim whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Delete comment character when joining commented lines
set formatoptions+=j

" Tab options
autocmd FileType *               setlocal tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType cpp             setlocal tabstop=8|set shiftwidth=8|set expandtab
autocmd FileType elm             setlocal tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType html            setlocal tabstop=4|set shiftwidth=4|set expandtab|set fo-=t
autocmd FileType html.handlebars setlocal tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType javascript      setlocal tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType php             setlocal tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType python          setlocal tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType rust            setlocal tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType typescript      setlocal tabstop=2|set shiftwidth=2|set expandtab

" Do/end matching
runtime macros/matchit.vim

" Man pages
runtime ftplugin/man.vim

" Sets
set ai
set autoindent
" set cursorcolumn
set cursorline
set hidden
set hlsearch
set ignorecase
set incsearch
set list
set nobackup
set nohidden
set nowrap
set number
set sm
set smartcase
set smarttab
set splitbelow
set splitright
set swapfile
set undofile
set wildmenu
set writebackup

" patch required to honor double slash at end
if has("patch-8.1.0251")
  set backupdir ^=~/.vim/backup//
end

" Because consistency
set backspace    =2
set backupcopy   =auto
set directory   ^=~/.vim/swap//
set encoding     =utf8
set grepprg      =grep\ -nH\ $*
set guifont      =Consolas/12/-1/5/25/0/0/0/1/0
set laststatus   =2
set lcs          =trail:·,tab:»·,eol:$,extends:»
set scrolloff    =5
set sidescrolloff=1
set sidescroll   =1
set textwidth    =79
set undodir      =$HOME/.vim/undo
set undolevels   =1000
set undoreload   =10000
set viminfo      ='20,<1000,s10,h
set wildmode     =list:longest,full

" Lets
let &colorcolumn             ="80,100"
let g:clipbrdDefaultReg      ='+'
let mapleader = "\<Space>"

let g:netrw_liststyle = 3

" FZF
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" javascript flow syntax from rigel documentation
let g:javascript_plugin_flow = 1

" Ale flake-8
call ale#Set('python_flake8_options', '--config=$HOME/.config/flake8')

" Airline
"" Extensions
let g:airline_extensions = [ 'ale', 'branch' ]
""" Airline Section Overrides
""""" Don't show tagbar, filetype, or virtualenv
let g:airline_section_x = ''
""""" Don't show fileencoding or fileformat
let g:airline_section_y = ''
""""" [Current LineNumber]/[Total LineCount]:ColumnNumber
let g:airline_section_z = '%l/%L:%c'
"" Config
let g:airline_detect_paste       = 1
let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts    = 1
"" Theming
let g:rigel_airline = 1
let g:airline_theme = 'bubblegum'

" Rust
let g:rustfmt_autosave = 1

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

"Vim-Gitgutter settings
let g:gitgutter_map_keys = 0 " Don't map my keys!
let g:gitgutter_max_signs = 10000

" Colors
hi clear SignColumn
hi ColorColumn ctermbg=52
hi LineNr ctermbg=16
hi CursorLineNr cterm=bold ctermfg=15 ctermbg=16
hi GitGutterAdd ctermfg=48 ctermbg=16
hi GitGutterChange ctermfg=190 ctermbg=16
hi GitGutterChangeDelete ctermfg=172 ctermbg=16
hi GitGutterDelete ctermfg=196 ctermbg=16
hi Normal ctermbg=16
hi SignColumn ctermbg=16

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
    set norelativenumber
  endif
endfunc

" Keybindings

" Nobody uses you and you have no friends
map q: :q
" Replace any quotes with single quotes
map <leader>' cs"'<ESC>lcs`'<ESC>
" Replace any quotes with double quotes
map <leader>" cs'"<ESC>lcs`"<ESC>
" Replace any quotes with backtick quotes
map <leader>` cs'`<ESC>lcs"`<ESC>
" Ripgrep
map <leader>r :Rg<CR>
" Redraw
map <leader>R :redraw!<CR>
" Toggle line wrap
map <leader>w :set wrap!<CR>

" v to expand region
vmap v <Plug>(expand_region_expand)
" Ctrl-V to collapse region
vmap <C-v> <Plug>(expand_region_shrink)

" Menu navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
" Menu navigation
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" coc.vim remap <cr> to confirm completion
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" ALE jump to next error
nnoremap <silent> <leader>aj :ALENext<cr>
" ALE jump to previous error
nnoremap <silent> <leader>ak :ALEPrevious<cr>

" Go back to the most recently open file
nnoremap <leader><leader> <C-^>
" Show inferred typescript type
nnoremap <silent> K :call ShowDocumentation()<CR>
" New tab
nnoremap tn :tabedit<CR>
" Close tab
nnoremap tx :tabclose<CR>
" Backspace to go to beginning of file
nnoremap <BS> gg
" Open FZF
nnoremap <C-p> :GFiles<CR>
" Open FZF in buffers mode
nnoremap <C-b> :Buffers<CR>
" Open FZF in history mode
nnoremap <C-y> :History<CR>
" Open up fzf GFiles? (git status files)
nnoremap <C-g> :GFiles?<CR>
" Show the full file name and path
nnoremap <C-f> :Files<CR>
" Toggle absolute vs relative numbers
nnoremap <C-n> :call RelNumberToggle()<CR>
" Toggle all number display
nnoremap <leader>n :call AllNumberToggle()<CR>
" Toggle paste
nnoremap <leader>p :set invpaste<CR>
" Open FZF in git diff mode
vnoremap <leader>A :call fzf#vim#grep('ag --nogroup --color "<C-r>h"', 1)<CR>
" Search and replace highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Search and prepend highlighted text
vnoremap <C-e> "hy:%s/\(<C-r>h\)/\1/gc<left><left><left><left><left>
" Search and postpend highlighted text
vnoremap <C-t> "hy:%s/\(<C-r>h\)/\1/gc<left><left><left>
" Set indent on file
nnoremap <leader>i mmgg=G`m<CR>
" Sort
vnoremap <leader>s :sort<CR>
" Toggle Gundo Tree
nnoremap <leader>u :MundoToggle<CR>
" Save a file
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

" Start copy and paste to system clipboard using leader
vmap <leader>d "+d
nmap <leader>p "+p
vmap <leader>y "+y

" For coc.vim
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('T', 'in')
  endif
endfunction

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

" Use ag with ack.vim if available
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/node_modules,*.swp

" At the bottom because something above is breaking it
set showcmd

let g:ale_linters = {
\    'bash': ['shellcheck'],
\    'javascript': ['eslint', 'prettier'],
\    'javascriptreact': ['eslint', 'prettier'],
\    'php': ['phpcs'],
\    'python': ['flake8', 'mypy'],
\    'rs': ['rls'],
\    'sh': ['shellcheck'],
\    'typescript': ['eslint', 'prettier'],
\    'typescriptreact': ['eslint', 'prettier', 'tsserver'],
\    'zsh': ['shellcheck']
\}

let g:ale_fixers = {
\  'javascript': ['eslint', 'prettier'],
\  'javascriptreact': ['eslint', 'prettier'],
\  'typescript': ['eslint', 'prettier'],
\  'typescriptreact': ['eslint', 'prettier']
\}

let g:ale_python_mypy_options='--follow-imports=skip'

" Fix files when I save
let g:ale_fix_on_save = 1

" disable linting on minified stuff
let g:ale_pattern_options = {
\    '\.min\.js$': { 'ale_linters': [], 'ale_fixers': [] },
\    '\.min\.css$': { 'ale_linters': [], 'ale_fixers': [] }
\}

" let g:rg_command = '
  " \ rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always"
  " \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,tpl}"
  " \ -g "!{.git,node_modules,vendor}"
" '

" --column: Show column number
" --fixed-strings: Search term as a literal string
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --hidden: Search hidden files and folders
" --ignore-case: Case insensitive search
" --line-number: Show line number
command! -bang -nargs=* Rg call fzf#vim#grep('
  \rg --column
    \ --fixed-strings
    \ --follow
    \ --glob "!{.git,node_modules,vendor}/*" --color "always"
    \ --hidden
    \ --ignore-case
    \ --line-number
  \ '
  \.shellescape(<q-args>), 1, <bang>0)

" augroup vimrc
  " au BufReadPre * setlocal foldmethod=indent
  " au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

" try
  " source ~/dotfiles/stellar_dotfiles/vimrc
" endtry
