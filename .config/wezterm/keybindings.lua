local wezterm = require("wezterm")
local act = wezterm.action

return {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  { key = "z", mods = "ALT", action = "ReloadConfiguration" },

  { key = "=", mods = "CTRL", action = "ResetFontSize" },
  { key = "+", mods = "CTRL", action = "IncreaseFontSize" },
  { key = "-", mods = "CTRL", action = "DecreaseFontSize" },

  { key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
  { key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
}

