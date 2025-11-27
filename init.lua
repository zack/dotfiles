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
    -- General Usability
    { "alexghergh/nvim-tmux-navigation", config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end},
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      outs = {},
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      },
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        notifier = { enabled = true },
      },
      keys = {
        { "<leader>dn", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>hn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
      },
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = { -- 100% suggested config
        views = {
          cmdline_popup = {
            position = {
              row = 20,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 23,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
        lsp = {
          progress = { enabled = false }, -- disable lsp progress messages
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
      }
    },
    { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    { 'jremmen/vim-ripgrep' }, -- ripgrep
    {
      'knubie/vim-kitty-navigator', -- use the same keys to move between kitty & vims
      build = 'cp ./*.py ~/.config/kitty/',
    },
    { 'kylechui/nvim-surround' }, -- easy surround bindings
    { 'mbbill/undotree' }, -- branching undo trees
    { 'moll/vim-bbye' }, -- delete buffers without closing windows
    { 'norcalli/nvim-colorizer.lua' }, -- colorizer hexes and color names and stuff
    {
      -- don't forget to `:TSInstall vim regex lua bash mardkwon markdown_inline`
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      lazy = false,
      build = ':TSUpdate'
    },
    {
      'nvimtools/none-ls.nvim',
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
      },
    },
    { 'rbgrouleff/bclose.vim' }, -- delete a buffer without closing the window
    { 'rigellute/rigel' }, -- colorscheme
    { 'scrooloose/nerdcommenter' }, -- commenting tool
    { 'terryma/vim-expand-region' }, -- tap v to expand selections
    { 'thirtythreeforty/lessspace.vim' }, -- trim whitespace for edited lines only
    { 'tpope/vim-vinegar' }, -- improve netrw usability
    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' }, -- provide snippets for the snippet source
      version = '1.*', -- use a release tag to download pre-built binaries
      opts = {
        keymap = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          codecompanion = { "codecompanion" },
        },
        cmdline = { enabled = false },
      },
      opts_extend = { 'sources.default' }
    },
    {
      'zbirenbaum/copilot.lua', -- Github copilot lua fork
      dependencies = { "copilotlsp-nvim/copilot-lsp" }, -- (optional) for NES functionality
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            accept = true,
          },
          panel = {
            enabled = false,
          },
          filetypes = {
            ["*"] = true,
          },
        })
        vim.keymap.set(
          "i",
          "<S-Tab>",
          function()
            if require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
            end
          end, {
          silent = true,
        })
      end,
    },
    {
      "olimorris/codecompanion.nvim",
      version="17.*",
      opts = {
        strategies = {
          chat = {
            name = "copilot",
            model = "claude-sonnet-4"
          },
          inline = {
            name = "copilot",
            model = "claude-sonnet-4"
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    { -- markdown in the CodeCompanion chat buffer, also other markdown files
      "OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      },
    },
    { -- Better diff view in the CodeCompanion chat buffer
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },

    -- Git
    { 'airblade/vim-gitgutter' }, -- git indicators on the left
    { 'tpope/vim-fugitive' }, -- :Git commands
    { 'tpope/vim-rhubarb' }, -- :GBrowse to open a file in GitHub

    -- CSVs
    { 'cameron-wags/rainbow_csv.nvim' }, -- CSV "cells" colored by column

    -- Languages Servers and Linters
    { 'neovim/nvim-lspconfig' }, -- Collection of configurations for built-in LSP client
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'mason-org/mason.nvim' }, -- for managing LSPs, linters, etc.
    { -- connect mason and lsp-config
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' }, -- install tools from init.lua

    ---- Typescript
    { 'dmmulroy/ts-error-translator.nvim' },
    { 'leafgarland/typescript-vim' },

    ---- Javascript
    { 'yuezk/vim-js' },

    ---- JSX
    { 'maxmellon/vim-jsx-pretty' },

    ---- Prisma
    { 'prisma/vim-prisma' },
  },

  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habamax' } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})



-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                               PLUGIN SETUP                                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

require('colorizer').setup()

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "eslint",
    "eslint-lsp",
    "eslint_d",
    "lua-language-server",
    "prettierd",
    "typescript-language-server",
  },
})

require("fzf-lua").setup{
  actions = {
    files = vim.tbl_extend("force", require("fzf-lua").defaults.actions.files, {
      ["enter"] = require("fzf-lua").actions.file_edit,
      ["ctrl-x"] = require("fzf-lua").actions.file_vsplit,
    }),
  },
}

require("nvim-surround").setup{
  keymaps = {
    insert = "<C-g>r",
    insert_line = "<C-g>R",
    normal = "yr",
    normal_cur = "yrr",
    normal_line = "yR",
    normal_cur_line = "yRR",
    visual = "R",
    visual_line = "gR",
    delete = "dr",
    change = "cr",
    change_line = "cR",
  },
}

require("ts-error-translator").setup({
  -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
  auto_attach = true,

  -- LSP server names to translate diagnostics for (default shown below)
  servers = {
    "ts_ls",
  },
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.stylua,
    require("none-ls.diagnostics.eslint_d"),
  },
})

local format_autogrp = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      -- Format on save
      vim.api.nvim_clear_autocmds({ group = format_autogrp, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_autogrp,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})


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
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
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
vim.api.nvim_set_keymap("v", "v", "<Plug>(expand_region_expand)", {})
vim.api.nvim_set_keymap("v", "<C-v>", "<Plug>(expand_region_shrink)", {})
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
vim.api.nvim_set_keymap("i", "<Esc>", "<C-o>:echoerr \"Use jk\"<CR>", { noremap = true, silent = true }) -- No more esc
---- Normal mode
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
vim.api.nvim_set_keymap("v", "<Leader>s", ":sort<CR>", {}) -- sort the visual selection
vim.api.nvim_set_keymap("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", { noremap = true }) -- sort the visual selection
vim.api.nvim_set_keymap("v", "p", "P", {}) -- 'put' without overwriting register
