local M = {}

function M.setup()
  require("nightfox").setup({
    options = { transparent = true, dim_inactive = false },
  })
  vim.cmd.colorscheme("futaba")
end

return M
