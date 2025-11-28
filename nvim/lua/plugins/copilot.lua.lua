return {
  'zbirenbaum/copilot.lua', -- Github copilot lua fork
  dependencies = { "copilotlsp-nvim/copilot-lsp" }, -- (optional) for NES functionality
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        accept = true,
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        ["*"] = true,
      },
    })
    vim.keymap.set(
      "i",
      "<S-Tab>",
      function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
        end
      end, {
      silent = true,
    })
  end,
}
