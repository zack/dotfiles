return {
  "olimorris/codecompanion.nvim",
  version="17.*",
  opts = {
    strategies = {
      chat = {
        name = "copilot",
        model = "claude-sonnet-4"
      },
      inline = {
        name = "copilot",
        model = "claude-sonnet-4"
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
