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
---@diagnostic disable-next-line: undefined-field
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
    -- imports plugins from lua/plugins directory
    { import = "plugins" },
  },

  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habamax' } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                LSP SETUP                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

vim.diagnostic.config({ virtual_text = true }) -- show LSP diagnostic messages

-- Lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- This tells the language server that 'vim' is a valid global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
})

-- Typescript and Javascript
vim.lsp.config('ts_ls', {
  settings = {
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayVariableTypeHints = true, -- Display type hints for variables
      }
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayVariableTypeHints = true,
      }
    }
  },
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                  COLORS                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Sets the vim colorscheme
vim.cmd [[colorscheme rigel]]

-- 80th and 100th columns are red
vim.cmd("highlight ColorColumn guibg='#800000'")

-- Disable highlights for Avante panes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion*",
  callback = function()
    vim.wo.colorcolumn = ""
  end,
})

-- GitGutter symbol colors
vim.cmd("highlight GitGutterAdd guifg='#00AA00'")
vim.cmd("highlight GitGutterChange guifg='#AAAA00'")
vim.cmd("highlight GitGutterChangeDelete guifg='#AA0000'")
vim.cmd("highlight GitGutterDelete guifg='#AA0000'")

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                 COMMANDS                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Highlight yanks
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               AUTOCOMMANDS                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝


-- Disable syntax on files longer than 10,000 lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 100000 then
      vim.bo.syntax = 'off'
    end
  end,
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
-- vim.o.cursorcolumn = true -- highlight the cursor's column
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
function AnyNumberToggle()
  if vim.o.relativenumber or vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
  else
    vim.o.number = true
    vim.o.relativenumber = false
  end
end

local function vim_grep()
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
    rg_opts = "--column --fixed-strings --follow --glob \"!{.git, node_modules, vendor}/*\" --color \"always\" --hidden --ignore-case --line-number"
  })
end

vim.api.nvim_create_user_command('Rg', function()
  vim_grep()
end, { bang = true, nargs = '*' })

-- Show errors and warnings in a floating window after a few seconds
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = false })
  end,
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               KEY MAPPINGS                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Plugins
---- Lazy.nvim
vim.api.nvim_set_keymap("n", "<Leader>z", ":Lazy<CR>", {})
---- TODO: Did Rg use to do something else?
vim.api.nvim_set_keymap("n", "<Leader>r", ":Rg<CR>", {}) -- search word under cursor
---- vim-expand
vim.api.nvim_set_keymap("x", "v", "<Plug>(expand_region_expand)", {})
vim.api.nvim_set_keymap("x", "<C-v>", "<Plug>(expand_region_shrink)", {})
---- FZF
vim.api.nvim_set_keymap("n", "<C-p>", ":FzfLua git_files<CR>", {})
vim.api.nvim_set_keymap("n", "<C-b>", ":FzfLua buffers<CR>", {})
vim.api.nvim_set_keymap("n", "<C-y>", ":FzfLua oldfiles<CR>", {})
vim.api.nvim_set_keymap("n", "<C-g>", ":FzfLua git_status<CR>", {})
vim.api.nvim_set_keymap("n", "<C-f>", ":FzfLua files<CR>", {})
---- Undotree
vim.api.nvim_set_keymap("n", "<Leader>u", ":UndotreeToggle<CR>", {})
--- CodeCompanion
      vim.api.nvim_set_keymap("n", "<Leader>A", ":CodeCompanionChat<CR>", {})
vim.api.nvim_set_keymap("v", "A", ":CodeCompanion #{buffer} ", {})
vim.api.nvim_set_keymap("v", "C", ":CodeCompanionChat Add<CR>", {})

-- Neovim stuff
---- Insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true; silent = true }) -- quick quit
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true; silent = true }) -- quick quit
vim.keymap.set("i", "<Esc>", function() -- not allowed to use Esc to exit insert mode
  require("snacks").notifier.notify("Use jk", "error")
end, { noremap = true, silent = true })
---- Normal mode
vim.api.nvim_set_keymap("n", "L", "$", {}) -- a sane keybind for going to the end of the line
vim.api.nvim_set_keymap("n", "H", "^", {}) -- a sane keybind for going to the first printable char
vim.api.nvim_set_keymap("n", "<C-[>", "<C-t>", {}) -- jump backward in the tagstack
vim.api.nvim_set_keymap("n", "<C-n>", ":set relativenumber!<CR>", { silent = true }) -- toggle relativeumber
vim.api.nvim_set_keymap("n", "<Leader>'", "cr\"'<ESC>lcr`'<ESC>", { silent = true }) -- change quotes to '
vim.api.nvim_set_keymap("n", "<Leader>H", ":vertical resize +1<CR>", {}) -- resize vertical 1
vim.api.nvim_set_keymap("n", "<Leader>J", ":resize -1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>K", ":resize +1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>L", ":vertical resize -1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>\"", "cr'\"<ESC>lcr`\"<ESC>", { silent = true }) -- change quotes to "
vim.api.nvim_set_keymap("n", "<Leader>\\", ":nohl<CR>", {}) -- clear highlighting
vim.api.nvim_set_keymap("n", "<Leader>`", "cr\"`<ESC>lcr'`<ESC>", { silent = true }) -- change quotes to `
vim.api.nvim_set_keymap("n", "<Leader>aa", ":lua vim.diagnostic.open_float() <CR>", {});
vim.api.nvim_set_keymap("n", "<Leader>aj", ":lua vim.diagnostic.goto_next() <CR>", {});
vim.api.nvim_set_keymap("n", "<Leader>ak", ":lua vim.diagnostic.goto_prev() <CR>", {});
vim.api.nvim_set_keymap("n", "<Leader>b", ":GBrowse<CR>", {}) -- open file in GitHub
vim.api.nvim_set_keymap("n", "<Leader>h", ":vertical resize +10<CR>", {}) -- resize vertical 10
vim.api.nvim_set_keymap("n", "<Leader>i", "mmgg=G`m<CR>", {}) -- indent the who file
vim.api.nvim_set_keymap("n", "<Leader>j", ":resize -10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>k", ":resize +10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>l", ":vertical resize -10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>n", ":lua AnyNumberToggle()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>q", ":Bd<CR>", {}) -- kill a buffer without affecting windows
vim.api.nvim_set_keymap("n", "<Leader>w", ":set wrap!<CR>", {}) -- toggle line wrap
vim.api.nvim_set_keymap("n", "q:", ":q", {}) -- fix accidentally hitting these in the wrong order
---- Visual mode
vim.api.nvim_set_keymap("x", "'", 'c\'<C-r>"\'<Esc>', { noremap = true, silent = true }) -- wrap selection in single quotes
vim.api.nvim_set_keymap("x", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", { noremap = true }) -- sort the visual selection
vim.api.nvim_set_keymap("x", "<Leader>s", ":sort<CR>", {}) -- sort the visual selection
vim.api.nvim_set_keymap("x", "\"", 'c"<C-r>""<Esc>', { noremap = true, silent = true }) -- wrap selection in double quotes
vim.api.nvim_set_keymap("x", "p", "P", {}) -- 'put' without overwriting register
