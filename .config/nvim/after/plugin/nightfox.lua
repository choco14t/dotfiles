local ok, nightfox = pcall(require, "nightfox")
if not ok then
	print("nightfox not loaded")
	return
end

nightfox.setup({
	options = {
		transparent = true,
		dim_inactive = true,
	},
})

local compile_path = vim.fn.stdpath("cache") .. "/nightfox"
if vim.fn.isdirectory(compile_path) == 0 then
	nightfox.compile()
end

function ApplyColor(color)
	color = color or "nightfox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ApplyColor()

