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

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = { height = 0.5 },
    dialog = { height = 0.5 },
    msg = { height = 0.3, timeout = 5000 },
    pager = { height = 0.5 },
  },
})
