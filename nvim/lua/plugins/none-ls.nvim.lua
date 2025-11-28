return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function ()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.stylua,
        require("none-ls.diagnostics.eslint_d"),
      },
    })

    local format_autogrp = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
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
  end
}
