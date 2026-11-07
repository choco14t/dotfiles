local M = {}

local function source_action(kind)
  return function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { kind }, diagnostics = {} } })
  end
end

local function has_organize_imports(buffer)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buffer })) do
    local kinds =
      vim.list_extend({}, vim.tbl_get(client.server_capabilities, "codeActionProvider", "codeActionKinds") or {})
    for _, registration in ipairs(client.dynamic_capabilities:get("textDocument/codeAction", { bufnr = buffer }) or {}) do
      vim.list_extend(kinds, vim.tbl_get(registration, "registerOptions", "codeActionKinds") or {})
    end
    for _, kind in ipairs(kinds) do
      if kind == "source.organizeImports" or vim.startswith(kind, "source.organizeImports.") then
        return true
      end
    end
  end
  return false
end

local function setup_keymaps()
  local map = Snacks.keymap.set
  map(
    "n",
    "gd",
    Snacks.picker.lsp_definitions,
    { desc = "Goto Definition", lsp = { method = "textDocument/definition" } }
  )
  map("n", "gr", Snacks.picker.lsp_references, { desc = "References", nowait = true, lsp = {} })
  map("n", "gI", Snacks.picker.lsp_implementations, { desc = "Goto Implementation", lsp = {} })
  map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto T[y]pe Definition", lsp = {} })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", lsp = {} })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover", lsp = {} })
  map(
    "n",
    "gK",
    vim.lsp.buf.signature_help,
    { desc = "Signature Help", lsp = { method = "textDocument/signatureHelp" } }
  )
  map(
    "i",
    "<C-k>",
    vim.lsp.buf.signature_help,
    { desc = "Signature Help", lsp = { method = "textDocument/signatureHelp" } }
  )
  map(
    { "n", "x" },
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "Code Action", lsp = { method = "textDocument/codeAction" } }
  )
  map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", lsp = { method = "textDocument/rename" } })
  map(
    "n",
    "<leader>cA",
    source_action("source"),
    { desc = "Source Action", lsp = { method = "textDocument/codeAction" } }
  )
  map("n", "<leader>co", source_action("source.organizeImports"), {
    desc = "Organize Imports",
    lsp = { method = "textDocument/codeAction" },
    enabled = has_organize_imports,
  })
  map("n", "gD", function()
    local params = vim.lsp.util.make_position_params(0, "utf-16")
    require("trouble").open({
      mode = "lsp_command",
      params = { command = "typescript.goToSourceDefinition", arguments = { params.textDocument.uri, params.position } },
    })
  end, { desc = "Goto Source Definition", lsp = { name = "vtsls" } })
end

function M.setup(extra_tools)
  require("mason").setup()
  require("plugins.completion").setup()

  local capabilities = require("blink.cmp").get_lsp_capabilities({
    workspace = { fileOperations = { didRename = true, willRename = true } },
  })
  vim.lsp.config("*", { capabilities = capabilities })
  vim.lsp.inlay_hint.enable(false)
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
  })
  setup_keymaps()

  local typescript = {
    updateImportsOnFileMove = { enabled = "always" },
    suggest = { completeFunctionCalls = true },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = "literals" },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  }
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          codeLens = { enable = true },
          completion = { callSnippet = "Replace" },
          doc = { privateName = { "^_" } },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    },
    jsonls = {
      before_init = function(_, config)
        config.settings.json.schemas = config.settings.json.schemas or {}
        vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = { json = { format = { enable = true }, validate = { enable = true } } },
    },
    vtsls = {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          autoUseWorkspaceTsdk = true,
          experimental = { maxInlayHintLength = 30, completion = { enableServerSideFuzzyMatch = true } },
        },
        typescript = typescript,
        javascript = vim.deepcopy(typescript),
      },
    },
    eslint = { settings = { workingDirectories = { mode = "auto" }, format = true } },
    graphql = {},
    terraformls = {},
  }
  if vim.tbl_contains(extra_tools or {}, "gopls") then
    servers.gopls = {}
  end

  vim.g.rustaceanvim = {
    server = {
      on_attach = function(_, buffer)
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action", buffer = buffer })
      end,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
          checkOnSave = true,
          diagnostics = { enable = true },
          procMacro = { enable = true },
          files = {
            exclude = {
              ".direnv",
              ".git",
              ".jj",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
            watcher = "client",
          },
        },
      },
    },
  }

  for server, config in pairs(servers) do
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end

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
    "vtsls",
    "shfmt",
    "codelldb",
  }, extra_tools or {})
  local registry = require("mason-registry")
  registry:on("package:install:success", function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("FileType", { buffer = vim.api.nvim_get_current_buf() })
    end, 100)
  end)
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
