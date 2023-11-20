if vim.g.vscode then
  return
end

local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok then return end

local api = require("nvim-tree.api")

nvim_tree.setup({
  on_attach = function (bufnr)
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.del("n", "s", { buffer = bufnr })
    vim.keymap.del("n", "<C-e>", { buffer = bufnr })
  end,
  view = {
    width = "20%",
  },
})

vim.keymap.set("n", "<C-h>", function()
  api.tree.toggle({ find_file = true })
end)

