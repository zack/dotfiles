-- git indicators on the left
return {
  'airblade/vim-gitgutter',
  init = function ()
    vim.g.gitgutter_map_keys = 0 -- disable keymappings
    vim.g.gitgutter_max_signs = 10000 -- show all the signs
  end
}
