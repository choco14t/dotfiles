local wezterm = require("wezterm")

local function BaseName(s)
	return string.gsub(s, "(.*[/\\](.*))", "%2")
end

wezterm.on("format-window-title", function(tab)
	return BaseName(tab.active_pane.foreground_process_name)
end)

local SYMBOL_COLOR = { "#63cdcf", "#a4a4a4" }
local FONT_COLOR = { "#cdcecf", "#aeafb0" }
local BACK_COLOR = "#192330"
local HOVER_COLOR = "#29394f"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.is_active and 1 or 2

	local bg = hover and HOVER_COLOR or BACK_COLOR
	local zoomed = tab.active_pane.is_zoomed and " *" or ""
	local tab_title = tab.tab_title

	return {
		{ Foreground = { Color = SYMBOL_COLOR[index] } },
		{ Background = { Color = bg } },
		{ Text = zoomed },
		{
			Text = (tab_title ~= "" and (" " .. tab_title .. " "))
				or (" " .. BaseName(tab.active_pane.foreground_process_name) .. " "),
		},

		{ Foreground = { Color = FONT_COLOR[index] } },
		{ Background = { Color = bg } },
	}
end)
