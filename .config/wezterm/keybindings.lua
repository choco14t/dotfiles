local wezterm = require("wezterm")
local act = wezterm.action

return {
  { key = 'l', mods = 'ALT', action = act.ShowLauncher },
  { key = "z", mods = "ALT", action = "ReloadConfiguration" },

  { key = "=", mods = "CTRL", action = "ResetFontSize" },
  { key = "+", mods = "CTRL", action = "IncreaseFontSize" },
  { key = "-", mods = "CTRL", action = "DecreaseFontSize" },

  { key = "t", mods = "CMD", action = act.DisableDefaultAssignment },
  { key = "w", mods = "CMD", action = act.DisableDefaultAssignment },

  { key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
  { key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
}

