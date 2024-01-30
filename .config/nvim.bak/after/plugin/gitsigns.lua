if vim.g.vscode then
  return
end

local ok, gitsigns = pcall(require, "gitsigns")

if not ok then return end

gitsigns.setup({})

vim.keymap.set({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
vim.keymap.set("n", "<leader>lb", gitsigns.toggle_current_line_blame)

