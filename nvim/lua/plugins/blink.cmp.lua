return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' }, -- provide snippets for the snippet source
  version = '1.*', -- use a release tag to download pre-built binaries
  opts = {
    keymap = {
      preset = "enter",
      ["K"] = { "select_prev", "fallback" },
      ["J"] = { "select_next", "fallback" },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
    cmdline = { enabled = false },
  },
  opts_extend = { 'sources.default' }
}
