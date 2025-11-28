-- Better typescript errors
return {
  'dmmulroy/ts-error-translator.nvim',
  opts = {
    -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
    auto_attach = true,
    -- LSP server names to translate diagnostics for (default shown below)
    servers = {
      "ts_ls",
    },
  },
}
