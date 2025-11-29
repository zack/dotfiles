return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = true },
  },
  keys = {
    { "<Leader>dn", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<Leader>hn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
  },
  config = function ()
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        local reg = vim.fn.reg_recording()
        Last_recorded_reg = reg ~= "" and reg or "?"
        require("snacks").notifier.notify("Recording started to: @" .. Last_recorded_reg, "info")
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        require("snacks").notifier.notify("Recording ended, stored in: @" .. Last_recorded_reg, "info")
      end,
    })
  end
}
