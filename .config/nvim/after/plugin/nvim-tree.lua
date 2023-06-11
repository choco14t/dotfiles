if vim.g.vscode then
  return
end

local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok then return end

nvim_tree.setup {}

local api = require("nvim-tree.api")

vim.keymap.set("n", "<C-h>", api.tree.toggle)

