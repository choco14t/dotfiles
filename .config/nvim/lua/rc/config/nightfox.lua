local nightfox = require('nightfox')

nightfox.setup({
	options = {
		transparent = false,
		dim_inactive = true, -- Non focused panes set to alternative background
	},
})

vim.cmd([[ colorscheme nightfox ]])

local compile_path = vim.fn.stdpath('cache') .. '/nightfox'
if vim.fn.isdirectory(compile_path) == 0 then
	nightfox.compile()
end
