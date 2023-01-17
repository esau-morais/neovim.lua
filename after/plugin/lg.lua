local status, lg = pcall(require, 'lazy-git')
if (not status) then return end

lg.setup({})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
