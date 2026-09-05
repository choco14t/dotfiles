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
    "nvim-lualine/lualine.nvim",
    config = function(_, opts)
      local icons = LazyVim.config.icons
      local options = vim.tbl_deep_extend("force", opts, {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = LazyVim.config.icons.diagnostics.Error,
                warn = LazyVim.config.icons.diagnostics.Warn,
                info = LazyVim.config.icons.diagnostics.Info,
                hint = LazyVim.config.icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {},
          lualine_z = {},
        },
      })

      require("lualine").setup(options)
    end,
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
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local palette = require("nightfox.palette").load("nightfox")

      require("hlchunk").setup({})
      require("hlchunk.mods.chunk")({
        style = {
          { fg = palette.cyan.bright },
          { fg = palette.red.bright },
        },
        line_num = { enable = true },
        duration = 0,
        delay = 0,
      }):enable()
      require("hlchunk.mods.indent")({}):enable()
    end,
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
