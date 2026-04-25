require("event")
require("format")
require("status")

local wezterm = require("wezterm")

local default_prog = nil
local font_size = 13
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

local mouse_bindings = require("mousebinds")

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "nightfox"
	else
		return "dawnfox"
	end
end

return {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = scheme_for_appearance(get_appearance()),
	default_prog = default_prog,
	font = wezterm.font_with_fallback({
		{ family = "MonaspiceRn Nerd Font", weight = "Medium" },
		{ family = "PlemolJP Console NF", weight = "Bold" },
	}),
	font_size = font_size,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
	},
	launch_menu = launch_menu,
	mouse_bindings = mouse_bindings,
	scrollback_lines = 100000,
	show_new_tab_button_in_tab_bar = false,
	use_fancy_tab_bar = false,
	use_ime = true,
	window_background_opacity = 0.9,
	window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
	window_decorations = "RESIZE",
}
