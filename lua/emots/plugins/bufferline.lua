local status, bar = pcall(require, "bufferline")
if not status then
  return
end

bar.setup({
  options = {
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
  },
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
