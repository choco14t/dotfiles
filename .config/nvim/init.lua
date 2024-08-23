-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.fn.has("diff") == 1 then
  vim.cmd("colorscheme nightfox")
end
