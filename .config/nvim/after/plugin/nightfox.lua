if vim.g.vscode then
  return
end

local ok, nightfox = pcall(require, "nightfox")
if not ok then
	print("nightfox not loaded")
	return
end

nightfox.setup({
	options = {
		transparent = false,
		dim_inactive = true,
	},
})

local compile_path = vim.fn.stdpath("cache") .. "/nightfox"
if vim.fn.isdirectory(compile_path) == 0 then
	nightfox.compile()
end

vim.cmd.colorscheme("nordfox")

