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
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
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

-- Mason's bin dir is normally added to PATH by mason.nvim's setup(), but that
-- plugin is lazy-loaded on VeryLazy, which can fire after buffers (and their
-- format-on-save autocmds) are already set up. Prepend it eagerly so tools
-- like stylua are always resolvable, regardless of plugin load order.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- Settings needed to make sure plugins work properly
vim.g.mapleader = " " -- Make sure to setup `mapleader` and `maplocalleader` before
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
  install = { colorscheme = { "habamax" } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})

-- Automatically sync (install/clean/update) plugins once a day.
local lazy_sync_stamp = vim.fn.stdpath("data") .. "/lazy-sync-debounce"
local lazy_sync_debounce_hours = 24

local function lazy_sync_due()
  local f = io.open(lazy_sync_stamp)
  local last = f and tonumber(f:read())
  if f then
    f:close()
  end
  if last and (os.time() - last) < lazy_sync_debounce_hours * 3600 then
    return false
  end
  local w = assert(io.open(lazy_sync_stamp, "w"))
  w:write(os.time())
  w:close()
  return true
end

local lazy_sync_augroup = vim.api.nvim_create_augroup("LazySync", { clear = true })

-- sync runs clean + install + update
vim.api.nvim_create_autocmd("User", {
  group = lazy_sync_augroup,
  pattern = "LazySync",
  callback = function()
    for _, plugin in pairs(require("lazy.core.config").plugins) do
      if require("lazy.core.plugin").has_errors(plugin) then
        vim.notify(
          "lazy.nvim: automatic sync hit an error, run :Lazy for details",
          vim.log.levels.ERROR,
          { title = "lazy.nvim" }
        )
        return
      end
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = lazy_sync_augroup,
  callback = function()
    if lazy_sync_due() then
      vim.defer_fn(function()
        require("lazy").sync({ show = false })
      end, 2000)
    end
  end,
})

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                LSP SETUP                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

vim.diagnostic.config({ virtual_text = true }) -- show LSP diagnostic messages

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        -- This tells the language server that 'vim' is a valid global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- Typescript and Javascript
vim.lsp.config("ts_ls", {
  settings = {
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true, -- Display type hints for variables
      },
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                  COLORS                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Sets the vim colorscheme
vim.cmd([[colorscheme rigel]])

-- 80th and 100th columns are red
vim.cmd("highlight ColorColumn guibg='#800000'")

-- Gitsigns symbol colors
vim.cmd("highlight GitSignsAdd guifg='#00AA00'")
vim.cmd("highlight GitSignsChange guifg='#AAAA00'")
vim.cmd("highlight GitSignsChangedelete guifg='#AA0000'")
vim.cmd("highlight GitSignsDelete guifg='#AA0000'")

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                 COMMANDS                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Highlight yanks
vim.cmd([[au TextYankPost * silent! lua vim.hl.on_yank()]])

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               AUTOCOMMANDS                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- clear = true so re-sourcing this file doesn't stack duplicate autocmds
local init_augroup = vim.api.nvim_create_augroup("Init", { clear = true })

-- Disable syntax on files longer than 10,000 lines
vim.api.nvim_create_autocmd("FileType", {
  group = init_augroup,
  pattern = { "*" },
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 10000 then
      vim.bo.syntax = "off"
    end
  end,
})

-- Default tab behavior for files
vim.api.nvim_create_autocmd("FileType", {
  group = init_augroup,
  pattern = { "*" },
  command = "setlocal tabstop=2|set shiftwidth=2|set expandtab",
})

-- Tab behavior for files needing 4-space tabs
vim.api.nvim_create_autocmd("FileType", {
  group = init_augroup,
  pattern = { "elm", "html", "php", "rust" },
  command = "setlocal tabstop=4|set shiftwidth=4",
})

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               LOCAL OPTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- vim.opt
vim.opt.wildignore = { -- ignore these files when expanding
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*",
  "*/.idea/*",
  "*/.DS_Store",
  "*/vendor",
  "*/node_modules",
  "*.swp",
}
-- vim.o
vim.o.cursorline = true -- highlight the cursor's line
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#555555", blend = 0 })
vim.o.ignorecase = true -- searches case-insensitive by default
vim.o.lcs = "trail:·,tab:»·,eol:$,extends:»,nbsp:+" -- setlist chars
vim.o.list = true -- display special characters
vim.o.number = true -- show line numbers
vim.o.relativenumber = true -- show relative line numbers
vim.o.scrolloff = 5 -- lines to keep in view at top/bottom of window
vim.o.sidescrolloff = 3 -- characters to keep in view on left/right of window
vim.o.sm = true -- briefly flash to matching bracket when typing
vim.o.smartcase = true -- search becomes case-sensitive when capitals
vim.o.splitbelow = true -- horizontal splits default to below
vim.o.splitright = true -- vertical splits default to the right
vim.o.timeoutlen = 300 -- how long to wait on a mapping that's a prefix of another
vim.o.undofile = true -- enables undofile for persistent history
vim.o.undolevels = 1000 -- number of lines to keep in undofile
vim.o.undoreload = 1000 -- number of undo lines to retain when a file is reloaded
vim.o.wildmenu = true -- enable wild menu for command completion
vim.o.wildmode = "longest:full,full" -- wildmenu config
vim.o.viminfo = "'20,<1000,s10,h" -- searches, commands, etc. to persist between sessions
vim.o.wrap = false -- disable line wrapping by default
vim.o.colorcolumn = "80,100" -- highlight 80th and 100th columns
vim.o.clipboard = "unnamedplus" -- yank to the system clipboard

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                              GLOBAL OPTIONS                               ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

vim.g.csv_no_conceal = true -- Always show commas (etc.) in csv files
vim.g.netrw_liststyle = 3 -- config for :Explore etc.

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                                 FUNCTIONS                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

-- Toggle numbers on and off no matter the type
local function AnyNumberToggle()
  if vim.o.relativenumber or vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
  else
    vim.o.number = true
    vim.o.relativenumber = false
  end
end

-- Show errors and warnings in a floating window after a few seconds
vim.api.nvim_create_autocmd("CursorHold", {
  group = init_augroup,
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
---- vim-expand
vim.api.nvim_set_keymap("x", "v", "<Plug>(expand_region_expand)", {})
vim.api.nvim_set_keymap("x", "<C-v>", "<Plug>(expand_region_shrink)", {})
---- Undotree
vim.api.nvim_set_keymap("n", "<Leader>u", ":UndotreeToggle<CR>", {})
---- Markview
vim.api.nvim_set_keymap("n", "<Leader>m", ":Markview<CR>", {}) -- toggles the markview mode

-- Neovim stuff
---- Insert mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true }) -- quick quit
---- Command-line mode
vim.keymap.set("c", "jk", function() -- close the : command line, but not / ? =
  return vim.fn.getcmdtype() == ":" and "<C-c>" or "jk"
end, { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-H>", "<C-W>", { noremap = true }) -- delete last word
vim.keymap.set("i", "<Esc>", function() -- not allowed to use Esc to exit insert mode
  require("snacks").notifier.notify("Use jk", "error")
end, { noremap = true, silent = true })
---- Normal mode
vim.api.nvim_set_keymap("n", "<C-[>", "<C-t>", { noremap = true }) -- jump backward in the tagstack
vim.api.nvim_set_keymap("n", "<C-n>", ":set relativenumber!<CR>", { silent = true }) -- toggle relativeumber
vim.api.nvim_set_keymap("n", "<Leader>'", "cs\"'<ESC>lcs`'<ESC>", { silent = true }) -- change quotes to '
vim.api.nvim_set_keymap("n", "<Leader>H", ":vertical resize +1<CR>", {}) -- resize vertical 1
vim.api.nvim_set_keymap("n", "<Leader>J", ":resize -1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>K", ":resize +1<CR>", {}) -- resize horizontal 1
vim.api.nvim_set_keymap("n", "<Leader>L", ":vertical resize -1<CR>", {}) -- resize vertical 1
vim.api.nvim_set_keymap("n", '<Leader>"', 'cs\'"<ESC>lcs`"<ESC>', { silent = true }) -- change quotes to "
vim.api.nvim_set_keymap("n", "<Leader>\\", ":nohl<CR>", {}) -- clear highlighting
vim.api.nvim_set_keymap("n", "<Leader>`", "cs\"`<ESC>lcs'`<ESC>", { silent = true }) -- change quotes to `
vim.api.nvim_set_keymap("n", "<Leader>aa", ":lua vim.diagnostic.open_float() <CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>aj", ":lua vim.diagnostic.jump({ count = 1, float = true }) <CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>ak", ":lua vim.diagnostic.jump({ count = -1, float = true }) <CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>b", ":GBrowse<CR>", {}) -- open file in GitHub
vim.api.nvim_set_keymap("n", "<Leader>h", ":vertical resize +10<CR>", {}) -- resize vertical 10
vim.api.nvim_set_keymap("n", "<Leader>i", "mmgg=G`m<CR>", {}) -- indent the who file
vim.api.nvim_set_keymap("n", "<Leader>j", ":resize -10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>k", ":resize +10<CR>", {}) -- resize horizontal 10
vim.api.nvim_set_keymap("n", "<Leader>l", ":vertical resize -10<CR>", {}) -- resize vertical 10
vim.keymap.set("n", "<Leader>n", AnyNumberToggle, { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>q", ":Bd<CR>", {}) -- kill a buffer without affecting windows
vim.api.nvim_set_keymap("n", "<Leader>w", ":set wrap!<CR>", {}) -- toggle line wrap
vim.api.nvim_set_keymap("n", "H", "^", {}) -- a sane keybind for going to the first printable char
vim.api.nvim_set_keymap("n", "L", "$", {}) -- a sane keybind for going to the end of the line
vim.api.nvim_set_keymap("n", "q:", ":q", {}) -- fix accidentally hitting these in the wrong order
---- Visual mode
vim.api.nvim_set_keymap("x", "'", "c'<C-r>\"'<Esc>", { noremap = true, silent = true }) -- wrap selection in single quotes
vim.api.nvim_set_keymap("x", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true }) -- find and select the visual selection
vim.api.nvim_set_keymap("x", "<Leader>s", ":sort<CR>", {}) -- sort the visual selection
vim.api.nvim_set_keymap("x", "J", ":m+1<CR>V", {}) -- Move the line down one line
vim.api.nvim_set_keymap("x", "K", ":m-2<CR>V", {}) -- Move the line up one line
vim.api.nvim_set_keymap("x", '"', 'c"<C-r>""<Esc>', { noremap = true, silent = true }) -- wrap selection in double quotes
vim.api.nvim_set_keymap("x", "p", "P", {}) -- 'put' without overwriting register
