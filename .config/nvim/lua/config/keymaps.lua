-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local keymap = vim.keymap
local options = { noremap = true, silent = true }

-- move window
keymap.set("n", "sj", "<C-w>j", options)
keymap.set("n", "sk", "<C-w>k", options)
keymap.set("n", "sl", "<C-w>l", options)
keymap.set("n", "sh", "<C-w>h", options)

-- turn off highlight
keymap.set("n", "<Esc><Esc>", ":noh<CR>", options)

-- split window
keymap.set("n", "ss", ":<C-u>sp<CR>", options)
keymap.set("n", "sv", ":<C-u>vs<CR>", options)

-- store jump record
keymap.set("n", "j", "v:count == 0 ? 'j' : 'm`' .. v:count .. 'j'", { expr = true, noremap = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'k' : 'm`' .. v:count .. 'k'", { expr = true, noremap = true, silent = true })

-- disabled
keymap.set("i", "<C-j>", "<Nop>", options)
keymap.set("n", "<C-j>", "<Nop>", options)
keymap.set("v", "<C-j>", "<Nop>", options)
keymap.set("i", "<C-;>", "<Nop>", options)
keymap.set("n", "<C-;>", "<Nop>", options)
keymap.set("v", "<C-;>", "<Nop>", options)

-- disable C-hjkl in terminal
vim.cmd([[
  tunmap <C-h>
  tunmap <C-j>
  tunmap <C-k>
  tunmap <C-l>
]])

-- add border to terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root(), border = "rounded" })
end
keymap.set("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
keymap.set("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
keymap.set("n", "<C-_>", lazyterm, { desc = "which_key_ignore" })

-- for buffers
local function del_all_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local deleted = false

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local neo_tree = string.match(buf_name, "neo%-tree filesystem")

    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) and not vim.bo[buf].modified and not neo_tree then
      vim.api.nvim_buf_delete(buf, { force = false })
      if not deleted then
        deleted = true
      end
    end
  end

  Util.notify("Delete all buffers without current buffer.", { level = 2 })
end
keymap.set("n", "<leader>ba", del_all_buffers, { noremap = true, silent = true, desc = "Delete Buffers" })
