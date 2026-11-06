return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- main branch dropped the module system, so highlight.enable/indent
    -- config above did nothing -- wire up the Neovim-core hooks by hand
    -- per https://github.com/nvim-treesitter/nvim-treesitter#supported-features
    require("nvim-treesitter").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "bash", "javascript", "javascriptreact", "lua", "markdown", "prisma", "typescript", "typescriptreact", "vim" },
      callback = function()
        vim.treesitter.start()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
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
