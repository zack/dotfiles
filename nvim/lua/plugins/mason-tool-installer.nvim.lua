-- installs tools specified in init.luau
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    auto_update = true,
    ensure_installed = {
      "eslint",
      "eslint-lsp",
      "eslint_d",
      "lua-language-server",
      "prettierd",
      "typescript-language-server",
    },
  },
}
