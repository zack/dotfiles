-- git indicators on the left
-- replaces vim-gitgutter, which is legacy Vimscript; gitsigns is the
-- actively maintained, Lua-native standard the ecosystem converged on
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
}
