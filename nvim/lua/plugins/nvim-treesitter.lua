return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    })

    local ensure_installed = {
      "bash",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "prisma",
      "regex",
      "tsx",
      "typescript",
      "vim",
    }

    -- install() reinstalls unconditionally, so filter to what's missing
    local installed = require("nvim-treesitter").get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ensure_installed)

    if #missing > 0 then
      require("nvim-treesitter").install(missing)
    end
  end,
}
