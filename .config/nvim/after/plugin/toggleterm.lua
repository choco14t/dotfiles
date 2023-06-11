if vim.g.vscode then
  return
end

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new({ cmd = "gitui", hidden = true, direction = "float", count = 9 })

function Gitui_toggle()
  gitui:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>lua Gitui_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

