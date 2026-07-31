return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  opts = {
    auto_update = true,
    ensure_installed = {
      "eslint-lsp",
      "lua-language-server",
      "prettierd",
      "prisma-language-server",
      "stylua",
      "typescript-language-server",
    },
  },
}
