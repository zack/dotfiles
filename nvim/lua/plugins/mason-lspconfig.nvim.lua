-- connect mason and lsp-config
return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  config = function()
    -- formatting for lua files is handled by null-ls (stylua); disable
    -- lua_ls's own formatter so it can't win the LSP client race on save
    vim.lsp.config("lua_ls", {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })
    require("mason-lspconfig").setup({
      -- stylua is installed via mason for its CLI (used by null-ls), not as
      -- an LSP server; make sure not to enable it as an LSP server.
      automatic_enable = { exclude = { "stylua" } },
    })
  end,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
