local status, saga = pcall(require, "lspsaga")
if not status then return end

saga.setup {
  ui = {
    border = "rounded",
  },
}

local opts = { silent = true }
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gf", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<Cr>", opts)
vim.keymap.set("n", "rn", "<Cmd>Lspsaga rename<CR>", opts)
