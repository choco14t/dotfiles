local M = {}

local function autoformat_enabled(buffer)
  local enabled = vim.b[buffer].autoformat
  if enabled ~= nil then
    return enabled
  end
  return vim.g.autoformat ~= false
end

local function format(buffer)
  local mode = vim.api.nvim_get_mode().mode
  local method = (mode == "v" or mode == "V") and "textDocument/rangeFormatting" or "textDocument/formatting"
  local eslint, primary
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buffer, method = method })) do
    if client.name == "eslint" then
      eslint = eslint or client.id
    else
      primary = primary or client.id
    end
  end

  local conform = require("conform")
  if eslint then
    conform.format({ bufnr = buffer, formatters = {}, lsp_format = "prefer", id = eslint })
  end
  conform.format({
    bufnr = buffer,
    filter = function(client)
      return client.id == primary
    end,
  })
end

function M.setup()
  local prettier = { "prettier" }
  require("conform").setup({
    default_format_opts = { timeout_ms = 3000, lsp_format = "fallback", quiet = false },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      json = prettier,
      jsonc = prettier,
      json5 = prettier,
      graphql = prettier,
      markdown = prettier,
      ["markdown.mdx"] = prettier,
      html = prettier,
      css = prettier,
      svelte = prettier,
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("dotfiles_format", { clear = true }),
    desc = "Format with ESLint before the primary formatter",
    callback = function(event)
      if vim.bo[event.buf].buftype == "" and autoformat_enabled(event.buf) then
        format(event.buf)
      end
    end,
  })
  vim.keymap.set({ "n", "x" }, "<leader>cf", function()
    format(vim.api.nvim_get_current_buf())
  end, { desc = "Format selection or buffer", silent = true })
  vim.keymap.set("n", "<leader>uf", function()
    vim.g.autoformat = not autoformat_enabled(vim.api.nvim_get_current_buf())
    vim.b.autoformat = nil
    vim.notify("Auto Format (Global): " .. (vim.g.autoformat and "enabled" or "disabled"))
  end, { desc = "Toggle Auto Format (Global)", silent = true })
  vim.keymap.set("n", "<leader>uF", function()
    vim.b.autoformat = not autoformat_enabled(vim.api.nvim_get_current_buf())
    vim.notify("Auto Format (Buffer): " .. (vim.b.autoformat and "enabled" or "disabled"))
  end, { desc = "Toggle Auto Format (Buffer)", silent = true })
end

return M
