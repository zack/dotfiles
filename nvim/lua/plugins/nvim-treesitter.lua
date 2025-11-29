return {
  -- don't forget to `:TSInstall vim regex lua bash mardkwon markdown_inline jsx tsx typescript javascript`
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate'
}
