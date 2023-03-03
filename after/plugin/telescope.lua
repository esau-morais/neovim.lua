local status, telescope = pcall(require, "telescope")
if not status then return end
local builtin = require "telescope.builtin"

local fb_actions = require("telescope").extensions.file_browser.actions

-- TODO: extract function to somewhere else
local function getVisualSelection()
  -- yank current visual selection into the 'v' register
  -- note that this makes no effort to preserve this register
  vim.cmd 'noau normal! "vy"'

  return vim.fn.getreg "v"
end

telescope.setup {
  defaults = {
    path_display = { "smart" },
    prompt_prefix = " ▲  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.6,
        preview_cutoff = 100,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
    },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    mappings = {
      -- your custom insert mode mappings
      ["i"] = {
        ["<C-w>"] = function() vim.cmd "normal vbd" end,
      },
      ["n"] = {
        -- your custom normal mode mappings
        ["N"] = fb_actions.create,
        ["h"] = fb_actions.goto_parent_dir,
        ["/"] = function() vim.cmd "startinsert" end,
      },
    },
  },
}

local keymap = vim.keymap.set

keymap("n", "sf", function() builtin.find_files() end)
keymap("n", "\\\\", function() builtin.buffers() end)
keymap("n", ";;", function() builtin.resume() end)
keymap("n", ";e", function() builtin.diagnostics() end)
keymap("n", "<leader>g", function() builtin.current_buffer_fuzzy_find() end)
keymap("v", "<leader>g", function()
  local text = getVisualSelection()
  builtin.current_buffer_fuzzy_find { default_text = text }
end)
keymap("n", "<leader>G", ":Telescope live_grep<cr>")
keymap("v", "<leader>G", function()
  local text = getVisualSelection()
  builtin.live_grep { default_text = text }
end)
