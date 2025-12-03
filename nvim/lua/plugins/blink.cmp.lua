return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' }, -- provide snippets for the snippet source
  version = '1.*', -- use a release tag to download pre-built binaries
  opts = {
    keymap = {
      preset = "enter",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    sources = {
      -- find a way to disable this for comment writing...
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
    cmdline = { enabled = false },
  },
  opts_extend = { 'sources.default' }
}
