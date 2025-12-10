return {
  -- don't forget to `:TSInstall the following:
  -- bash
  -- javascript
  -- jsx
  -- lua
  -- markdown
  -- markdown_inline
  -- prisma
  -- regex
  -- tsx
  -- typescript
  -- vim
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    }
  end
}

