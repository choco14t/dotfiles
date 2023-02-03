local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", ",", ":")
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- quit insert mode
keymap.set("i", "jj", "<Esc>")

-- move window
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "sh", "<C-w>h")

-- turn off highlight
keymap.set("n", "<Esc><Esc>", ":noh<CR>")

-- split window
keymap.set("n", "ss", ":<C-u>sp<CR>")
keymap.set("n", "sv", ":<C-u>vs<CR>")

-- write file
keymap.set("n", "<Leader>w", ":w<CR>")
keymap.set("n", "<Leader>q", ":wq<CR>")

