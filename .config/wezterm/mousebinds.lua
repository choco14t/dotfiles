local act = require("wezterm").action

return {
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.EmitEvent "show-title-bar"
  }
}
