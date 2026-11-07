local M = {}

function M.setup(opts)
  require("gaito").setup(vim.tbl_deep_extend("force", {
    enabled = true,
    mask_char = "*",
    patterns = { ".env*" },
  }, opts or {}))
end

return M
