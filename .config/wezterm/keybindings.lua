local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 1000 }) },
	{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 20 }) },

	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },

	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "w", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },

	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "]", mods = "LEADER", action = act.PasteFrom("PrimarySelection") },

	{ key = "l", mods = "ALT", action = act.ShowLauncher },
	{ key = "z", mods = "ALT", action = "ReloadConfiguration" },

	{ key = "u", mods = "CTRL | SHIFT", action = act.ScrollByLine(-30) },
	{ key = "d", mods = "CTRL | SHIFT", action = act.ScrollByLine(30) },

	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },

	{ key = "t", mods = "CMD", action = act.DisableDefaultAssignment },
	{ key = "w", mods = "CMD", action = act.DisableDefaultAssignment },

	{ key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
}

for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

local key_tables = {
	copy_mode = {
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
	},
}

return {
	keys = keys,
	key_tables = key_tables,
}
