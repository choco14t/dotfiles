local M = {}

local function cancel_close(view)
  view:goto_main()
  view:close()
end

function M.setup()
  require("twilight").setup()
  require("trouble").setup({
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
  })
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, twilight = false },
    window = { backdrop = 0.7 },
  })
  vim.keymap.set("n", "<leader>z", "<CMD>ZenMode<CR>", { desc = "Toggle ZenMode" })

  require("bufferline").setup({
    options = {
      close_command = function(buffer)
        Snacks.bufdelete(buffer)
      end,
      right_mouse_command = function(buffer)
        Snacks.bufdelete(buffer)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diagnostics)
        local errors = diagnostics.error and " " .. diagnostics.error .. " " or ""
        local warnings = diagnostics.warning and " " .. diagnostics.warning or ""
        return vim.trim(errors .. warnings)
      end,
      show_buffer_close_icons = false,
      auto_toggle_bufferline = false,
      indicator = { icon = "", style = "underline" },
    },
  })

  if #vim.api.nvim_list_uis() > 0 then
    require("auto-dark-mode").setup({
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme oracle")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme futaba")
      end,
    })
  end
end

return M
