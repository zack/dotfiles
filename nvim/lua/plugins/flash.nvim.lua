-- Jump to any location
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  outs = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
