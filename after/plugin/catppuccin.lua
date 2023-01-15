local status, theme = pcall(require, 'catppuccin')
if (not status) then return end

theme.setup({
  flavour = 'mocha',
  compile = {
    enabled = true,
  },
  integrations = {
    cmp = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    telescope = true,
    nvimtree = {
      enabled = true,
    },
    bufferline = true,
    treesitter = true
  },
  transparent_background = true,
  styles = {
    comments = { 'italic' },
  }
})
