-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- color scheme
vim.cmd.syntax("enable")
vim.o.t_Co = 256
vim.o.background = "dark"

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if vim.fn.exists("+termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.o.number = true
vim.o.relativenumber = false

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

