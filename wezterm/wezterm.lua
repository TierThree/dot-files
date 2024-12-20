-- Setup useful variables for configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Change the theme to Gruvbox Dark
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Setup the leader key
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

-- Setup the keybinds in the format I like
config.keys = {
	-- All keybinds for managing splits
	-- Keybinds for splitting
	{
		key = "s",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	-- Keybinds for moving between splits (using vim keybinds for movement)
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
}

-- Return the modified config to wezterm
return config
