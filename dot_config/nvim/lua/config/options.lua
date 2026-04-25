-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"
vim.o.mousescroll = "ver:3,hor:6"

vim.o.wrap = true

-- clipboard
-- + reg: Ctrl-v nnamedplus
-- * reg: middle click unnamed
if vim.fn.has("clipboard") == 1 then
  vim.o.clipboard = "unnamedplus,unnamed"
end

-- indent
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0

-- search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true

-- swap file
vim.o.swapfile = false
vim.o.directory = "~/.vim/tmp"

-- spell
vim.o.spell = false
