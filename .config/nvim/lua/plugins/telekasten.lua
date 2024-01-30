require("choco14t.private")
require("choco14t.helpers")

local baseVault = {
  personal = {
    home = vim.fn.expand("~/zettelkasten"),
    tempaltes = vim.fn.expand("~/zettelkasten/templates"),
    template_new_daily = vim.fn.expand("~/zettelkasten/templates/daily.md"),
    template_new_weekly = vim.fn.expand("~/zettelkasten/templates/weekly.md"),
    dailies = vim.fn.expand("~/zettelkasten/daily"),
    weeklies = vim.fn.expand("~/zettelkasten/weekly"),
  },
}
local workingVaults = TelekastenVaults or {}

return {
  {
    "renerocksai/telekasten.nvim",
    opts = {
      home = vim.fn.expand(os.getenv("ZETTELKASTEN_DIR") or "~/zettelkasten"),
      tempaltes = vim.fn.expand("~/zettelkasten/templates"),
      template_new_daily = vim.fn.expand("~/zettelkasten/templates/daily.md"),
      template_new_weekly = vim.fn.expand("~/zettelkasten/templates/weekly.md"),
      dailies = vim.fn.expand("~/zettelkasten/daily"),
      weeklies = vim.fn.expand("~/zettelkasten/weekly"),
      auto_set_filetype = false,
      vaults = MergeTables(baseVault, workingVaults),
    },
    keys = {
      { mode = { "n" }, "<Leader>z", "<Cmd>Telekasten panel<CR>" },
      { mode = { "n" }, "<Leader>zf", "<Cmd>Telekasten find_notes<CR>" },
      { mode = { "n" }, "<Leader>zg", "<Cmd>Telekasten search_notes<CR>" },
      { mode = { "n" }, "<Leader>zd", "<Cmd>Telekasten goto_today<CR>" },
      { mode = { "n" }, "<Leader>zw", "<Cmd>Telekasten goto_thisweek<CR>" },
      { mode = { "n" }, "<Leader>zz", "<Cmd>Telekasten follow_link<CR>" },
      { mode = { "n" }, "<Leader>zn", "<Cmd>Telekasten new_note<CR>" },
      { mode = { "n" }, "<Leader>zc", "<Cmd>Telekasten show_calendar<CR>" },
      { mode = { "n" }, "<Leader>zb", "<Cmd>Telekasten show_backlinks<CR>" },
      { mode = { "n" }, "<Leader>zI", "<Cmd>Telekasten insert_img_link<CR>" },
      { mode = { "i" }, "[[", "<Cmd>Telekasten insert_link<CR>" },
    },
  },
}
