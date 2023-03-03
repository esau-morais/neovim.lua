local status, lualine = pcall(require, "lualine")
if not status then return end

lualine.setup {
  options = {
    theme = "auto",
    component_separators = "|",
    section_separators = { right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", right_padding = 2 },
    },
    lualine_b = { "branch" },
    lualine_c = {
      { "filename", path = 3 },
    },
    lualine_x = { "diagnostics" },
    lualine_y = {},
    lualine_z = { "filetype" },
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
