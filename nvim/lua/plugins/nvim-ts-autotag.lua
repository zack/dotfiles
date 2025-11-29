return {
  'windwp/nvim-ts-autotag',
  opts = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    })
  end,
}
