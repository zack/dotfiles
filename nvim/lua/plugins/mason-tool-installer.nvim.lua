return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    auto_update = true,
    ensure_installed = {
      "eslint-lsp",
      "lua-language-server",
      "prettierd",
      "prisma-language-server",
      "typescript-language-server",
    },
  },
}
