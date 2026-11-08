vim.g.snacks_animate = false
vim.g.futaba_transparent = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.opt.iskeyword:append("-")

vim.o.mouse = ""

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

-- hide statusline, mode and cursor position
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.cmdheight = 0
