vim.g.mapleader = " "

vim.api.nvim_set_keymap('', ',', ':', { noremap = true })

-- quit insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- move window
vim.api.nvim_set_keymap('n', 'sj', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sk', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sl', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sh', '<C-w>h', { noremap = true, silent = true })

-- turn off highlight
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':noh<CR>', { noremap = true, silent = true })

-- split window
vim.api.nvim_set_keymap('n', 'ss', ':<C-u>sp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sv', ':<C-u>vs<CR>', { noremap = true, silent = true })

-- write file
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':wq<CR>', { noremap = true, silent = true })
