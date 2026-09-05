local function cancel_close(view)
  view:goto_main()
  view:close()
end

return {
  "folke/twilight.nvim",
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          focus = true,
          keys = { ["<cr>"] = "jump_close", ["<esc>"] = cancel_close },
          win = { type = "float", border = "rounded" },
        },
        symbols = {
          focus = true,
          keys = { ["<cr>"] = "jump_close", ["<esc>"] = cancel_close },
          win = { type = "float", border = "rounded" },
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        twilight = false,
      },
      window = { backdrop = 0.7 },
    },
    keys = {
      { mode = { "n" }, "<Leader>z", "<CMD>ZenMode<CR>", desc = "Toggle ZenMode" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        show_buffer_close_icons = false,
        auto_toggle_bufferline = false,
        indicator = {
          icon = "",
          style = "underline",
        },
      },
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme nightfox")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme dayfox")
      end,
    },
  },
}
