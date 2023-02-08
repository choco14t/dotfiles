local wezterm = require("wezterm")

local default_prog = nil
local font_size = 16
local launch_menu = {}

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

if is_windows then
  default_prog = { "wsl.exe", "~", "-d", "Ubuntu-22.04" }
  font_size = 11

  table.insert(launch_menu, {
    label = "New Tab PowerShell",
    args = { "powershell.exe", "-NoLogo" },
  })
end

local keys = require("keybindings")
local colors = is_windows and
  wezterm.color.load_scheme("colors/nightfox.toml") or
  wezterm.color.load_scheme(os.getenv("HOME") .. "/.config/wezterm/colors/nightfox.toml")

return {
  adjust_window_size_when_changing_font_size = false,

  color_scheme = "nightfox",
  colors = colors,

  default_prog = default_prog,

  font = wezterm.font("Cica"),
  font_size = font_size,

  hide_tab_bar_if_only_one_tab = true,

  keys = keys,

  launch_menu = launch_menu,

  tab_bar_at_bottom = false,

  use_fancy_tab_bar = true,
  use_ime = true,

  window_background_opacity = 0.9,
  window_frame = {
    inactive_titlebar_bg = "#71839b",
    active_titlebar_bg = "#212e3f",
  },
  window_decorations = "RESIZE",
  window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
}

