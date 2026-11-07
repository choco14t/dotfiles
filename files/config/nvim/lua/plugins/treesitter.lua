local M = {}

function M.setup(extra_parsers)
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  if #vim.api.nvim_list_uis() > 0 then
    treesitter.install(vim.list_extend({ "graphql", "ruby" }, extra_parsers or {}))
  end
end

return M
