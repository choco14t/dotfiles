return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
    opts = {
      options = {
        transparent = true,
        dim_inactive = false,
      },
    },
  },
}
