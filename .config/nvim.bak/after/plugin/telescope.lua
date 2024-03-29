if vim.g.vscode then
  return
end

local ok, builtin = pcall(require, "telescope.builtin")
if not ok then return end

vim.keymap.set("n", ";f", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", ";b", builtin.buffers)
vim.keymap.set("n", ";r", builtin.live_grep)
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

