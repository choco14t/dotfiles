return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      background_colour = "#000000",
      render = "compact",
      stages = "static",
      init = function()
        -- when noice is not enabled, install notify on VeryLazy
        if not Util.has("noice.nvim") then
          Util.on_very_lazy(function()
            vim.notify = require("notify")
          end)
        end
      end,
    },
  },
}
