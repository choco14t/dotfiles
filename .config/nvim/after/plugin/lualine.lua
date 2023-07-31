if vim.g.vscode then
  return
end

vim.cmd("colorscheme nordfox")
require("lualine").setup({
  sections = {
    lualine_c = {{"filename", path = 1}},
    lualine_x = {"encoding", "filetype"}
  }
})

