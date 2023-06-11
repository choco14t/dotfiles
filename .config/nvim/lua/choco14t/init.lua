require("choco14t.keymap")
require("choco14t.option")

if vim.g.vscode then
  return
end

require("choco14t.command")
require("choco14t.lazy")

local augroup = vim.api.nvim_create_augroup
local Choco14tGroup = augroup("Choco14t", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

autocmd({"BufWritePre"}, {
  group = Choco14tGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

