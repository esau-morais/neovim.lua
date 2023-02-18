local status, zm = pcall(require, "zen-mode")
if not status then return end

zm.setup()

vim.keymap.set("n", "zm", "<cmd>ZenMode<cr>", { silent = true })
