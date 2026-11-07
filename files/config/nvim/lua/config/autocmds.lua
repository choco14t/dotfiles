vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("dotfiles_wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})
