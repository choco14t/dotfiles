local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", ",", ":", { noremap = true })

-- quit insert mode
keymap.set("i", "jj", "<Esc>", { noremap = true })

-- delete buffer
keymap.set("n", "<C-x>", "<Cmd>bdelete<CR>", { noremap = true, silent = true })

-- move window
keymap.set("n", "sj", "<C-w>j", { noremap = true })
keymap.set("n", "sk", "<C-w>k", { noremap = true })
keymap.set("n", "sl", "<C-w>l", { noremap = true })
keymap.set("n", "sh", "<C-w>h", { noremap = true })

-- turn off highlight
keymap.set("n", "<Esc><Esc>", ":noh<CR>", { noremap = true, silent = true })

-- split window
keymap.set("n", "ss", ":<C-u>sp<CR>", { noremap = true, silent = true })
keymap.set("n", "sv", ":<C-u>vs<CR>", { noremap = true, silent = true })

-- write file
keymap.set("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>q", ":wq<CR>", { noremap = true, silent = true })

-- terminal settings
keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
keymap.set("t", "<C-\\>", "<Esc>", { noremap = true, silent = true })

-- new tab
keymap.set("n", "te", ":tabedit<CR>")

-- resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

