local M = {}

local function with_tree_sitter_cli(callback)
  if vim.fn.executable("tree-sitter") == 1 then
    return callback()
  end
  local registry = require("mason-registry")
  registry.refresh(vim.schedule_wrap(function(success)
    if not success then
      vim.notify("Could not refresh Mason registry for tree-sitter-cli", vim.log.levels.ERROR)
      return
    end
    if vim.fn.executable("tree-sitter") == 1 then
      return callback()
    end
    local ok, cli = pcall(registry.get_package, "tree-sitter-cli")
    if not ok then
      vim.notify(cli, vim.log.levels.ERROR)
      return
    end
    local function ready(installed)
      if installed and vim.fn.executable("tree-sitter") == 1 then
        callback()
      else
        vim.notify("Could not install tree-sitter-cli with Mason", vim.log.levels.ERROR)
      end
    end
    if cli:is_installing() then
      cli:once(
        "install:success",
        vim.schedule_wrap(function()
          ready(true)
        end)
      )
    else
      cli:install(nil, vim.schedule_wrap(ready))
    end
  end))
end

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
    if vim.treesitter.query.get(lang, "folds") then
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end
  end
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true }),
    desc = "Enable installed Treesitter highlighting, indentation and folding",
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
    local installed = treesitter.get_installed("parsers")
    parsers = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, parsers)
    if #parsers == 0 then
      return
    end
    with_tree_sitter_cli(function()
      treesitter.install(parsers):await(function()
        vim.schedule(function()
          attach(vim.api.nvim_get_current_buf())
        end)
      end)
    end)
  end
end

return M
