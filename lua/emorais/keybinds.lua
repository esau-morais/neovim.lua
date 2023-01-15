local keymap = vim.keymap

-- select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- new tab
keymap.set('n', '<C-t>', ':tabedit<Return>')

-- split window
keymap.set('n', 'sh', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- toggle explorer
keymap.set('n', '<A-e>', ':NvimTreeToggle<Return>')

-- markdown
keymap.set('n', '<C-m>', ':MarkdownPreview<Return>')
