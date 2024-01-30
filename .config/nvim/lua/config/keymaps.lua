-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local options = { noremap = true, silent = true }

-- move window
keymap.set("n", "sj", "<C-w>j", options)
keymap.set("n", "sk", "<C-w>k", options)
keymap.set("n", "sl", "<C-w>l", options)
keymap.set("n", "sh", "<C-w>h", options)

-- turn off highlight
keymap.set("n", "<Esc><Esc>", ":noh<CR>", options)

-- split window
keymap.set("n", "ss", ":<C-u>sp<CR>", options)
keymap.set("n", "sv", ":<C-u>vs<CR>", options)

-- store jump record
keymap.set("n", "j", "v:count == 0 ? 'j' : 'm`' .. v:count .. 'j'", { expr = true, noremap = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'k' : 'm`' .. v:count .. 'k'", { expr = true, noremap = true, silent = true })
