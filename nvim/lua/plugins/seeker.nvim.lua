local function seek(mode, picker_opts)
  return function()
    require("seeker.picker").seek({ mode = mode, picker_opts = picker_opts })
  end
end

-- Seeker only builds three things: a file picker, a grep picker, and a
-- grep-word picker. Everything below is that file picker with the finder
-- swapped out, which is what gets us <C-e> on all of them. The cost is that
-- whatever the real snacks source would have set has to be restated here.
local buffer_opts = {
  current = true,
  finder = "buffers",
  format = "buffer",
  sort_lastused = true,
  unloaded = true,
}

local recent_opts = { finder = "recent_files", format = "file" }
local status_opts = { finder = "git_status", format = "git_status" }

return {
  "2kabhishek/seeker.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "Seeker" },
  keys = {
    { "<C-b>", seek("files", buffer_opts), desc = "Seek Buffers" },
    { "<C-f>", seek("files"), desc = "Seek Files" },
    { "<C-g>", seek("files", status_opts), desc = "Seek Git Status" },
    { "<C-p>", seek("git_files"), desc = "Seek Git Files" },
    { "<C-y>", seek("files", recent_opts), desc = "Seek Recent Files" },
    { "<leader>/", ":Seeker grep<CR>", desc = "Seek Grep" },
    { "<leader>G", ":Seeker grep_word<CR>", desc = "Seek Grep Word" },
  },
  opts = {},
}
