if vim.g.vscode then
  return
end

vim.cmd("colorscheme nightfox")
require("lualine").setup({})

