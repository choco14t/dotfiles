local ok, bufferline = pcall(require, "bufferline")

if not ok then return end

bufferline.setup({
  options = {
    mode = "buffers",
    show_buffer_close_icons = false,
    show_close_icon = false,
    modified_icon = "●",
    color_icons = true,
    diagnostics = "nvim_lsp"
  },
})

vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", {})

vim.keymap.set("n", "<Leader>1", function()
  bufferline.go_to_buffer(1, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>2", function()
  bufferline.go_to_buffer(2, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>3", function()
  bufferline.go_to_buffer(3, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>4", function()
  bufferline.go_to_buffer(4, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>5", function()
  bufferline.go_to_buffer(5, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>6", function()
  bufferline.go_to_buffer(6, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>7", function()
  bufferline.go_to_buffer(7, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>8", function()
  bufferline.go_to_buffer(8, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>9", function()
  bufferline.go_to_buffer(9, true)
end, { noremap = true, silent = true })

