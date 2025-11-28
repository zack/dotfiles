return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = true },
  },
  keys = {
    { "<leader>dn", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>hn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
  },
}
