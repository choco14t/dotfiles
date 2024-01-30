vim.api.nvim_create_user_command(
  "Terminals",
  "split | wincmd j | resize 20 | terminal",
  { force = true }
)

