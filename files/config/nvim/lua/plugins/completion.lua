local M = {}

function M.setup()
  local interactive = #vim.api.nvim_list_uis() > 0
  require("blink.cmp").setup({
    snippets = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { draw = { treesitter = { "lsp" } } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<Right>"] = false,
        ["<Left>"] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },
    fuzzy = {
      -- The headless check must never enter Blink's binary downloader.
      implementation = interactive and "prefer_rust_with_warning" or "lua",
      prebuilt_binaries = { download = interactive },
    },
  })
end

return M
