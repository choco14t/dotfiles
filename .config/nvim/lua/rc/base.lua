if vim.fn.has('unix') == 1 then
	vim.env.LANG = 'en_US.UTF-8'
else
	vim.env.LANG = 'en'
end

vim.o.encoding = 'utf8'

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_pythonx_provider = 0
vim.g.loaded_ruby_provider = 0
