local keymap = vim.keymap

-- move tab
keymap.set("n", "L", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", { noremap = true })
keymap.set("n", "H", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>", { noremap = true })

-- split window
keymap.set("n", "ss", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", { noremap = true })
keymap.set("n", "sv", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>", { noremap = true })

-- move window
keymap.set("n", "sj", "<Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>", { noremap = true })
keymap.set("n", "sk", "<Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>", { noremap = true })
keymap.set("n", "sl", "<Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>", { noremap = true })
keymap.set("n", "sh", "<Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", { noremap = true })

