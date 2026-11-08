vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
local overrides = require("config.overrides")

vim.pack.add(require("config.pack"), { confirm = false })

require("plugins.colorscheme").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("plugins.snacks").setup()
require("plugins.editor").setup(overrides.gaito)
require("plugins.lsp").setup(overrides.tools)
require("plugins.formatting").setup()
require("plugins.treesitter").setup(overrides.parsers)
require("plugins.ui").setup()
require("plugins.incline").setup()
require("config.autocmds")
require("config.keymaps")

require("vim._core.ui2").enable()
