local telescope = require('telescope')
local actions = require('telescope.actions')

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
      'vendor',
      '.git',
      '.next',
    },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
    path_display = { 'truncate' }
  }
}

vim.api.nvim_set_keymap(
  'n',
  ';f',
  "<Cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  ';r',
  "<Cmd>lua require('telescope.builtin').live_grep()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '\\\\', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';;', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
