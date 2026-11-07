local M = {}

function M.setup(extra_tools)
  require("mason").setup()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  local tools = vim.list_extend({
    "eslint-lsp",
    "graphql-language-service-cli",
    "json-lsp",
    "lua-language-server",
    "prettier",
    "rust-analyzer",
    "stylua",
    "terraform-ls",
    "typescript-language-server",
    "vtsls",
    "shfmt",
    "codelldb",
  }, extra_tools or {})
  local registry = require("mason-registry")
  registry.refresh(function()
    for _, tool in ipairs(tools) do
      local package = registry.get_package(tool)
      if not package:is_installed() then
        package:install()
      end
    end
  end)
end

return M
