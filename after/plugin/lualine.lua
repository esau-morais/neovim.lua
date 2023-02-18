local status, lualine = pcall(require, "lualine")
if not status then return end

lualine.setup {
  options = {
    theme = "catppuccin",
    component_separators = "|",
    section_separators = { right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", right_padding = 2 },
    },
    lualine_b = { "filename", "branch" },
    lualine_c = { "fileformat" },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
}
