return {
  {
    "choco14t/futaba",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.futaba_transparent = true
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = true,
        dim_inactive = false,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "futaba",
    },
  },
}
