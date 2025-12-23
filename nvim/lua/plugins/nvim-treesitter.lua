return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    }

    -- Can't get this to stop installing every time I open neovim
    -- require('nvim-treesitter').install {
      -- 'bash',
      -- 'javascript',
      -- 'jsx',
      -- 'lua',
      -- 'markdown',
      -- 'markdown_inline',
      -- 'prisma',
      -- 'regex',
      -- 'tsx',
      -- 'typescript',
      -- 'vim',
    -- }
  end
}

