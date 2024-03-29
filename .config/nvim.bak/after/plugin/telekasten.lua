if vim.g.vscode then
  return
end

local ok, telekasten = pcall(require, "telekasten")

if not ok then return end

telekasten.setup({
  home = vim.fn.expand(os.getenv("ZETTELKASTEN_DIR") or "~/zettelkasten"),
  tempaltes = vim.fn.expand("~/zettelkasten/templates"),
  template_new_daily = vim.fn.expand("~/zettelkasten/templates/daily.md"),
  template_new_weekly = vim.fn.expand("~/zettelkasten/templates/weekly.md"),
  dailies = vim.fn.expand("~/zettelkasten/daily"),
  weeklies = vim.fn.expand("~/zettelkasten/weekly"),
  auto_set_filetype = false,
})

-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

-- Most used functions
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

-- Call insert link automatically when we start typing a link
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

