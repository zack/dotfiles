--                             ###
--                              ###
--                               ##           #                            #
--                               ##          ##                           ##
--                               ##          ##                           ##
--    /###      /###     /###    ##        ######## /##   /##    ###    ########
--   / ###  /  / ###  / / ###  / ##       ######## / ### / ###  #### / ########
--  /   ###/  /   ###/ /   ###/  ##          ##   /   ###   ### /###/     ##
-- ##        ##    ## ##    ##   ##          ##  ##    ###   ##/  ##      ##
-- ##        ##    ## ##    ##   ##          ##  ########     /##         ##
-- ##        ##    ## ##    ##   ##          ##  #######     / ###        ##
-- ##        ##    ## ##    ##   ##          ##  ##         /   ###       ##
-- ###     / ##    ## ##    ##   ##          ##  ####    / /     ###      ##
--  ######/   ######   ######    ### /       ##   ######/ /       ### /   ##
--   #####     ####     ####      ##/         ##   ##### /         ##/     ##



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                 LAZY.NVIM                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Settings needed to make sure plugins work properly
vim.g.mapleader = " "       -- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.maplocalleader = "\\" -- loading lazy.nvim so that mappings are correct.
vim.o.termguicolors = true -- required for colorizer (and maybe other things)


-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                  PLUGINS                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝


require("lazy").setup({
  spec = {
    -- General Usability
    -- TODO: Maybe dedup supertab/coc.nvim
    { 'ervandew/supertab' }, -- improved (? )tab insert completion
    -- TODO: Change mappings so they don't conflict with surround
    -- { 'ggandor/leap.nvim' }, -- jumping around with 's'
    { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    { 'jremmen/vim-ripgrep' }, -- ripgrep
    { 'junegunn/vim-peekaboo' }, -- see contents of registers in a sidebar
    {
      'knubie/vim-kitty-navigator', -- use the same keys to move between kitty & vims
      build = 'cp ./*.py ~/.config/kitty/',
    },
    { 'ludovicchabant/vim-gutentags' }, -- tags support
    { 'mbbill/undotree' }, -- powerful branching undo trees
    { 'neoclide/coc.nvim', branch = "release", build = "npm i" }, -- more completion
    { 'norcalli/nvim-colorizer.lua' }, -- colorizer hexes and color names and stuff
    { 'rbgrouleff/bclose.vim' }, -- delete a buffer without closing the window
    { 'rigellute/rigel' }, -- colorscheme
    { 'scrooloose/nerdcommenter' }, -- powerful commenting tool
    { 'terryma/vim-expand-region' }, -- tap v to expand selections
    { 'tpope/vim-surround' }, -- easy surround bindings
    { 'tpope/vim-vinegar' }, -- improve netrw usability
    { 'unblevable/quick-scope' }, -- highlights characters for quick jumps


    -- Git
    { 'airblade/vim-gitgutter' }, -- git indicators on the left
    { 'tpope/vim-fugitive' }, -- :Git commands
    { 'tpope/vim-rhubarb' }, -- :GBrowse to open a file in GitHub

    -- CSVs
    { 'cameron-wags/rainbow_csv.nvim' }, -- CSV "cells" colored by column

    -- Linting & Fixing
    {  -- asynchronous linting engine
      'dense-analysis/ale',
      config = function()
        vim.g.ale_fix_on_save = 1

        vim.g.ale_linters = {
          lua = {'lua_language_server'},
          bash = { 'shellcheck' },
          javascript = { 'eslint', 'prettier' },
          javascriptreact = { 'eslint', 'prettier' },
          rs = { 'rls' },
          sh = { 'shellcheck' },
          typescript = { 'eslint', 'prettier', 'tsserver' },
          typescriptreact = { 'eslint', 'prettier', 'tsserver' },
          zsh = { 'shellcheck' }
        }

        vim.g.ale_fixers = {
          javascript = { 'eslint', 'prettier' },
          javascriptreact = { 'eslint', 'prettier' },
          typescript = { 'eslint', 'prettier' },
          typescriptreact = { 'eslint', 'prettier' }
        }
      end
    },

    -- Config Management
    { 'editorconfig/editorconfig-vim' }, -- support for .editorconfig files

    -- Languages & Frameworks
    ---- Typescript
    ---- TODO: Do we need both of these?
    { 'herringtonDarkholme/yats.vim' },
    { 'leafgarland/typescript-vim' },
    ---- Javascript
    { 'yuezk/vim-js' },
    ---- JSX
    { 'maxmellon/vim-jsx-pretty' },
    ---- Prisma
    { 'prisma/vim-prisma' },
  },

  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               PLUGIN SETUP                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- require('leap').create_default_mappings()
require('colorizer').setup()



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                              PLUGIN OPTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- vim-js
vim.g.javascript_plugin_flow = 1 -- enable syntax highlighting for flow

-- nerdcommenter
vim.g.NERDSpaceDelims = 1

-- gitgutter
vim.g.gitgutter_map_keys = 0 -- disable keymappings
vim.g.gitgutter_max_signs = 10000 -- show all the signs



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                  COLORS                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Sets the vim colorscheme
local colorscheme = "rigel"

-- 80th and 100th columns are red
vim.cmd("highlight ColorColumn guibg='#800000'")

-- GitGutter symbol colors
vim.cmd("highlight GitGutterAdd guifg='#00AA00'")
vim.cmd("highlight GitGutterChange guifg='#AAAA00'")
vim.cmd("highlight GitGutterChangeDelete guifg='#AA0000'")
vim.cmd("highlight GitGutterDelete guifg='#AA0000'")

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               AUTOCOMMANDS                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Autmatically enter insert mode for git commits
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- Disable syntax on files longer than 10,000 lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 100000 then
      vim.bo.syntax = 'off'
    end
  end,
})

-- Automatically trim whitespace on read & write
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Default tab behavior for files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  command = "setlocal tabstop=2|set shiftwidth=2|set expandtab"
})

-- Tab behavior for files needing 4-space tabs
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "elm", "html", "php", "rust" },
  command = "setlocal tabstop=4|set shiftwidth=4"
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               LOCAL OPTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- vim.opt
vim.opt.wildignore = { -- ignore these files when expanding
  "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.idea/*", "*/.DS_Store", "*/vendor", "*/node_modules", "*.swp"
}

-- vim.o
vim.o.cursorcolumn = true -- highlight the cursor's column
vim.o.cursorline = true -- highlight the cursor's line
vim.o.ignorecase = true -- searches case-insensitive by default
vim.o.lcs = "trail:·,tab:»·,eol:$,extends:»,nbsp:+" -- setlist chars
vim.o.list = true -- display special characters
vim.o.number = true -- show line numbers
vim.o.scrolloff = 5 -- lines to keep in view at top/bottom of window
vim.o.sidescrolloff = 3 -- characters to keep in view on left/right of window
vim.o.sm = true -- briefly flash to matching bracket when typing
vim.o.smartcase = true -- search becomes case-sensitive when capitals
vim.o.splitbelow = true -- horizontal splits default to below
vim.o.splitright = true -- vertical splits default to the right
vim.o.undofile = true -- enables undofile for persistent history
vim.o.undolevels = 1000 -- number of lines to keep in undofile
vim.o.undoreload = 1000 -- number of undo lines to retain when a file is reloaded
vim.o.wildmenu = true -- enable wild menu for command completion
vim.o.wildmode = "longest:full,full" -- wildmenu config
vim.o.viminfo = "'20,<1000,s10,h" -- searches, commands, etc. to persist between sessions
vim.o.wrap = false -- disable line wrapping by default
vim.o.colorcolumn = "80,100" -- highlight 80th and 100th columns
vim.o.clipboard = "unnamed" -- yank to the system clipboard




-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                              GLOBAL OPTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

vim.g.csv_no_conceal = true -- Always show commas (etc.) in csv files
vim.g.netrw_liststyle = 3 -- config for :Explore etc.



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                 FUNCTIONS                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Toggle numbers on and off no matter the type
function anyNumberToggle()
  if vim.o.relativenumber or vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
  else
    vim.o.number = true
    vim.o.relativenumber = false
  end
end

local function vim_grep(args, bang)
  local query = '""'
  if args ~= nil then
    query = vim.fn.shellescape(args)
  end

  --column: Show column number
  --fixed-strings: Search term as a literal string
  --follow: Follow symlinks
  --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  --hidden: Search hidden files and folders
  --ignore-case: Case insensitive search
  --line-number: Show line number
  require('fzf-lua').grep({
    search = '',
    fzf_opts = {
      ["--preview-window"] = "right:50%"
    },
    rg_opts = "\
      --column\
      --fixed-strings\
      --follow\
      --glob\
      ---\"!{.git, node_modules, vendor}/*\"\
      --color \"always\"\
      --hidden\
      --ignore-case\
      --line-number\
    "
  })
end

vim.api.nvim_create_user_command('Rg', function(c)
  vim_grep(c.args, c.bang)
end, { bang = true, nargs = '*' })



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               KEY MAPPINGS                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Plugins
---- TODO: Did Rg used to do something else?
vim.api.nvim_set_keymap("n", "<Leader>r", ":Rg<CR>", {}) -- search word under cursor
---- vim-expand
vim.api.nvim_set_keymap("v", "v", "<Plug>(expand_region_expand)", {})
vim.api.nvim_set_keymap("v", "<C-v>", "<Plug>(expand_region_shrink)", {})
---- Ale
vim.api.nvim_set_keymap("n", "<Leader>aj", ":ALENext<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>ak", ":ALEPrevious<CR>", {})
---- FZF
vim.api.nvim_set_keymap("n", "<C-p>", ":FzfLua git_files<CR>", {})
vim.api.nvim_set_keymap("n", "<C-b>", ":FzfLua buffers<CR>", {})
vim.api.nvim_set_keymap("n", "<C-y>", ":FzfLua oldfiles<CR>", {})
vim.api.nvim_set_keymap("n", "<C-g>", ":FzfLua git_status<CR>", {})
vim.api.nvim_set_keymap("n", "<C-f>", ":FzfLua files<CR>", {})
---- Undotree
vim.api.nvim_set_keymap("n", "<Leader>u", ":UndotreeToggle<CR>", {})

-- Neovim stuff
---- Normal mode
vim.api.nvim_set_keymap("n", "q:", ":q", {}) -- fix accidentally hitting these in the wrong order
vim.api.nvim_set_keymap("n", "<Leader>R", ":Rg", {}) -- redraw the screen
vim.api.nvim_set_keymap("n", "<Leader>w", ":set wrap!<CR>", {}) -- toggle line wrap
vim.api.nvim_set_keymap("n", "<C-n>", ":set relativenumber!<CR>", { silent = true }) -- toggle relativeumber
vim.api.nvim_set_keymap("n", "<Leader>i", "mmgg=G`m<CR>", {}) -- indent the who file
vim.api.nvim_set_keymap("n", "<Leader>\\", ":nohl<CR>", {}) -- clear highlighting
vim.api.nvim_set_keymap("n", "<Leader>h", ":vertical resize +10<CR>", {}) -- resize vertical 10
vim.api.nvim_set_keymap("n", "<Leader>H", ":vertical resize +1<CR>", {}) -- resize vertical 1
vim.api.nvim_set_keymap("n", "<Leader>j", ":resize -10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>J", ":resize -1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>k", ":resize +10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>K", ":resize +1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>l", ":vertical resize -10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>L", ":vertical resize -1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>'", "cs\"'<ESC>lcs`'<ESC>", { silent = true }) -- change quotes to '
vim.api.nvim_set_keymap("n", "<Leader>\"", "cs'\"<ESC>lcs`\"<ESC>", { silent = true }) -- change quotes to "
vim.api.nvim_set_keymap("n", "<Leader>`", "cs\"`<ESC>lcs'`<ESC>", { silent = true }) -- change quotes to `
vim.api.nvim_set_keymap("n", "<Leader>n", ":lua anyNumberToggle()<CR>", { silent = true })
---- Visual mode
vim.api.nvim_set_keymap("v", "<Leader>s", ":sort<CR>", {}) -- sort the visual selection
vim.api.nvim_set_keymap("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", { noremap = true }) -- sort the visual selection
vim.api.nvim_set_keymap("v", "p", "P", {}) -- 'put' without overwriting register
