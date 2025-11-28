return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    require("fzf-lua").setup{
      actions = {
        files = vim.tbl_extend("force", require("fzf-lua").defaults.actions.files, {
          ["enter"] = require("fzf-lua").actions.file_edit,
          ["ctrl-x"] = require("fzf-lua").actions.file_vsplit,
        }),
      },
    }
  end
}
