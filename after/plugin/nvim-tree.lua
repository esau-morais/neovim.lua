local status, tree = pcall(require, "nvim-tree")
if not status then return end

tree.setup {
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    custom = { "^.git$", "^node_modules$" },
  },
  git = {
    enable = false,
  },
  log = {
    enable = true,
    types = {
      diagnostics = true,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}
