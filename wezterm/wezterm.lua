-- Setup useful variables for configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- NOTE: Any 'global'-like variables go up here

-- Local variable for create_keybinds
local map = {}

-- NOTE: All function declarations go here

-- Function for setting up keybinds
local function create_keybinds(key, mods, action)
	table.insert(map, { key = key, mods = mods, action = action })
	return map
end

-- NOTE: Setup any appearance values

-- Set the theme to Gruvbox Dark
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Setup the tab configs
config.use_fancy_tab_bar = false

-- NOTE: Setup all keybind related details here

-- Setup the leader key
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

-- Keybinds for managing splits (using neovim split keybinds for ease of memory)
create_keybinds("s", "LEADER", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
create_keybinds("v", "LEADER", act.SplitVertical({ domain = "CurrentPaneDomain" }))
create_keybinds("x", "LEADER", act.CloseCurrentPane({ confirm = true }))

-- Keybinds for moving between splits (using vim keybinds for movement)
create_keybinds("h", "LEADER", act.ActivatePaneDirection("Left"))
create_keybinds("l", "LEADER", act.ActivatePaneDirection("Right"))
create_keybinds("k", "LEADER", act.ActivatePaneDirection("Up"))
create_keybinds("j", "LEADER", act.ActivatePaneDirection("Down"))

-- Assign the converted keybinds from map -> config.keys
config.keys = map

-- Return the modified config to wezterm
return config
