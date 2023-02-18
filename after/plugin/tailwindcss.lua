local status, tw = pcall(require, "tailwindcss-colors")
if not status then return end

tw.setup {
  module = "tailwindcss-colors",
}
