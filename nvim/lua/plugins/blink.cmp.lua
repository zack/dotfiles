-- from https://github.com/Saghen/blink.cmp/discussions/564#discussioncomment-13439030
function in_treesitter_capture(capture)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if vim.api.nvim_get_mode().mode == 'i' then
    col = col - 1
  end

  local buf = vim.api.nvim_get_current_buf()
  local get_captures_at_pos = require('vim.treesitter').get_captures_at_pos

  local captures_at_cursor = vim.tbl_map(function(x)
    return x.capture
  end, get_captures_at_pos(buf, row - 1, col))

  if vim.tbl_isempty(captures_at_cursor) then
    return false
  elseif type(capture) == 'string' and vim.tbl_contains(captures_at_cursor, capture) then
    return true
  elseif type(capture) == 'table' then
    for _, v in ipairs(capture) do
      if vim.tbl_contains(captures_at_cursor, v) then
        return true
      end
    end
  end
  return false
end

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
    completion = {
      menu = {
        auto_show = function()
          return not in_treesitter_capture("comment") and not require("luasnip").expand_or_jumpable()
        end
      }
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
