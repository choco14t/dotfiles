local function copy_path(picker)
  local item = picker:current()
  if not item then
    return
  end

  local filepath = item.file
  local modify = vim.fn.fnamemodify
  local filename = modify(filepath, ":t")
  local results = {
    filepath,
    modify(filepath, ":."),
    modify(filepath, ":~"),
    filename,
    modify(filename, ":r"),
    modify(filename, ":e"),
  }

  vim.ui.select({
    "1. Absolute path: " .. results[1],
    "2. Path relative to CWD: " .. results[2],
    "3. Path relative to HOME: " .. results[3],
    "4. Filename: " .. results[4],
    "5. Filename without extension: " .. results[5],
    "6. Extension of the filename: " .. results[6],
  }, { prompt = "Choose to copy to clipboard:" }, function(_, index)
    if index then
      local result = results[index]
      vim.fn.setreg("*", result)
      vim.notify("Copied: " .. result)
    else
      vim.notify("Cancelled")
    end
  end)
end

local function git_root_terminal()
  Snacks.terminal.focus(nil, { cwd = LazyVim.root.git() })
end

local function git_root_files()
  LazyVim.pick.open("files", { cwd = LazyVim.root.git() })
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { win = { border = "rounded" } },
      notifier = { enabled = true, style = "compact", top_down = false },
      picker = {
        sources = {
          explorer = {
            actions = { copy_path = copy_path },
            layout = { layout = { position = "right" } },
            win = { list = { keys = { s = function() end, Y = "copy_path" } } },
          },
          files = {
            hidden = true,
            layout = { fullscreen = true },
          },
        },
        win = {
          input = {
            keys = {
              ["<a-f>"] = false,
              ["<a-h>"] = false,
              ["<a-g>"] = { "toggle_follow", mode = { "i", "n" } },
              ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<a-f>"] = false,
              ["<a-h>"] = false,
              ["<a-g>"] = "toggle_follow",
              ["<a-.>"] = "toggle_hidden",
            },
          },
        },
      },
      terminal = { win = { border = "rounded", position = "float" } },
    },
    keys = {
      { "<c-/>", git_root_terminal, mode = { "n", "t" }, desc = "Terminal (Git Root)" },
      { "<c-_>", git_root_terminal, mode = { "n", "t" }, desc = "which_key_ignore" },
      { "<leader><space>", git_root_files, desc = "Find Files (Git Root)" },
      { "<leader>ff", git_root_files, desc = "Find Files (Git Root)" },
      {
        "<leader>fe",
        function()
          Snacks.explorer({ cwd = LazyVim.root.git() })
        end,
        desc = "Explorer Snacks (Git Root)",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },
}
