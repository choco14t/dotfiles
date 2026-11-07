local M = {}

function M.setup(extra_parsers)
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})

  local function attach(buffer)
    local lang = vim.treesitter.language.get_lang(vim.bo[buffer].filetype)
    if not lang or not vim.list_contains(treesitter.get_installed("parsers"), lang) then
      return
    end
    if vim.treesitter.query.get(lang, "highlights") then
      pcall(vim.treesitter.start, buffer, lang)
    end
    if vim.treesitter.query.get(lang, "indents") then
      vim.bo[buffer].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true }),
    desc = "Enable installed Treesitter highlighting and indentation",
    callback = function(event)
      attach(event.buf)
    end,
  })

  if #vim.api.nvim_list_uis() > 0 then
    local parsers = vim.list_extend({
      "css",
      "graphql",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "regex",
      "ron",
      "ruby",
      "rust",
      "tsx",
      "typescript",
    }, extra_parsers or {})
    treesitter.install(parsers):await(function()
      vim.schedule(function()
        attach(vim.api.nvim_get_current_buf())
      end)
    end)
  end
end

return M
