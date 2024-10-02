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
      { mode = { "n" }, "<Leader>t", desc = "Telekasten" },
      { mode = { "n" }, "<Leader>tt", "<Cmd>Telekasten<CR>", desc = "Command palette" },
      { mode = { "n" }, "<Leader>tp", "<Cmd>Telekasten panel<CR>", desc = "Open Panel" },
      { mode = { "n" }, "<Leader>tf", "<Cmd>Telekasten find_notes<CR>", desc = "Find Notes" },
      { mode = { "n" }, "<Leader>tg", "<Cmd>Telekasten search_notes<CR>", desc = "Search Notes" },
      { mode = { "n" }, "<Leader>td", "<Cmd>Telekasten goto_today<CR>", desc = "Today's Note" },
      { mode = { "n" }, "<Leader>tw", "<Cmd>Telekasten goto_thisweek<CR>", desc = "Weekly Note" },
      { mode = { "n" }, "<Leader>tz", "<Cmd>Telekasten follow_link<CR>", desc = "Follow Link" },
      { mode = { "n" }, "<Leader>tn", "<Cmd>Telekasten new_note<CR>", desc = "New Note" },
      { mode = { "n" }, "<Leader>tc", "<Cmd>Telekasten show_calendar<CR>", desc = "Show Calendar" },
      { mode = { "n" }, "<Leader>tb", "<Cmd>Telekasten show_backlinks<CR>", desc = "Show Backlinks" },
      { mode = { "n" }, "<Leader>tI", "<Cmd>Telekasten insert_img_link<CR>", desc = "Insert Image Link" },
      { mode = { "n" }, "<Leader>tv", "<Cmd>Telekasten switch_vault<CR>", desc = "Switch Vault" },
      { mode = { "i" }, "[[", "<Cmd>Telekasten insert_link<CR>", desc = "Insert Link" },
    },
  },
}
