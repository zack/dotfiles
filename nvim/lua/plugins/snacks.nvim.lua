return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = true},
    indent = {
      enabled = true,
      animate = {
        enabled = false
      }
    },
    -- These two take over vim.ui.input and vim.ui.select for every plugin,
    -- which is the job dressing.nvim used to do.
    -- The input style pins itself to row 2 and a fixed width of 60. These match
    -- it to the select layout instead, which is 0.5/80/100 wide and centers a
    -- box 40% of the screen tall. A fraction won't line up, because a fraction
    -- positions the top edge and select's top edge sits well above centre --
    -- so this repeats select's own sizing math to land on the same row.
    input = {
      enabled = true,
      win = {
        max_width = 100,
        min_width = 80,
        row = function()
          local height = math.max(math.floor(vim.o.lines * 0.4) - 2, 2)
          return math.floor((vim.o.lines - height) / 2) - 1
        end,
        width = 0.5,
      },
    },
    picker = {
      exclude = { ".git", "node_modules", "vendor" },
      follow = true,
      hidden = true,
      ui_select = true,
      -- <C-s> and <C-v> are already split/vsplit by default. <C-x> isn't bound
      -- at all, and binding it here instead of on the buffers source keeps it
      -- the same key everywhere -- it warns instead of erroring on file items.
      win = {
        input = { keys = { ["<c-x>"] = { "bufdelete", mode = { "i", "n" } } } },
        list = { keys = { dd = "bufdelete" } },
      },
    },
  },
  keys = {
    { "<Leader>dn", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<Leader>hn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
  },
  -- config = function ()
    -- vim.api.nvim_create_autocmd("RecordingEnter", {
      -- callback = function()
        -- local reg = vim.fn.reg_recording()
        -- Last_recorded_reg = reg ~= "" and reg or "?"
        -- require("snacks").notifier.notify("Recording started to: @" .. Last_recorded_reg, "info")
      -- end,
    -- })

    -- vim.api.nvim_create_autocmd("RecordingLeave", {
      -- callback = function()
        -- require("snacks").notifier.notify("Recording ended, stored in: @" .. Last_recorded_reg, "info")
      -- end,
    -- })
  -- end
}
