return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local format_autogrp = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    null_ls.setup({
      sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettierd,
        -- stylua defaults to tabs at width 4; everything else here is 2-space
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
      },
      on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
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
  end,
}
