local ok, builtin = pcall(require, "telescope.builtin")
if not ok then return end

vim.keymap.set("n", ";f", function() builtin.find_files({ hidden = true }) end)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", ";b", builtin.buffers)
vim.keymap.set("n", ";r", builtin.live_grep)
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

