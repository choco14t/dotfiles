local ok = pcall(require, "bufdelete")

if not ok then return end

-- delete buffer
vim.keymap.set("n", "<C-x>", "<Cmd>Bdelete<CR>", { noremap = true, silent = true })

