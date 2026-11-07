local M = {}
local Snacks = require("snacks")

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

local function git_root()
  return vim.fs.root(0, ".git") or vim.fn.getcwd()
end

local function git_root_terminal()
  Snacks.terminal.focus(nil, { cwd = git_root() })
end

local function git_root_files()
  Snacks.picker.files({ cwd = git_root() })
end

function M.setup()
  Snacks.setup({
    explorer = {},
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
  })

  vim.keymap.set({ "n", "t" }, "<C-/>", git_root_terminal, { desc = "Terminal (Git Root)" })
  vim.keymap.set({ "n", "t" }, "<C-_>", git_root_terminal, { desc = "which_key_ignore" })
  vim.keymap.set("n", "<leader><space>", git_root_files, { desc = "Find Files (Git Root)" })
  vim.keymap.set("n", "<leader>ff", git_root_files, { desc = "Find Files (Git Root)" })
  vim.keymap.set("n", "<leader>fe", function()
    Snacks.explorer({ cwd = git_root() })
  end, { desc = "Explorer Snacks (Git Root)" })
  vim.keymap.set("n", "<leader>fE", function()
    Snacks.explorer({ cwd = vim.fn.getcwd() })
  end, { desc = "Explorer Snacks (cwd)" })
  vim.keymap.set("n", "<leader>e", "<leader>fe", { remap = true, desc = "Explorer Snacks (Git Root)" })
  vim.keymap.set("n", "<leader>E", "<leader>fE", { remap = true, desc = "Explorer Snacks (cwd)" })
  vim.keymap.set("n", "<leader>un", function()
    Snacks.notifier.hide()
  end, { desc = "Dismiss All Notifications" })
end

return M
