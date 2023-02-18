local keymap = vim.keymap

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- new tab
keymap.set("n", "<C-t>", ":tabedit<Return>")

-- split window
keymap.set("n", "sh", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- toggle explore
keymap.set("n", "<A-e>", ":NvimTreeToggle<Return>")

-- markdown
keymap.set("n", "<C-m>", ":MarkdownPreview<Return>")

-- fix spelling
keymap.set("n", "<leader>f", "1z=")
