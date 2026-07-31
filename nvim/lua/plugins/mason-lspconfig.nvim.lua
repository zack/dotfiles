-- connect mason and lsp-config
return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
