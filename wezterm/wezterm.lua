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

-- Setup the retro style tabs
config.use_fancy_tab_bar = false

-- Setup renaming the tab action, for later use in a keybinding
local action = act.PromptInputLine({
	description = "Enter a new name for the tab",
	action = wezterm.action_callback(function(window, pane, line)
		if line then
			window:active_tab():set_title(line)
		end
	end),
})

-- Basic tab color setup
-- TODO: Make this look a little cleaner later on
config.colors = {
	tab_bar = {
		background = "#282828",

		active_tab = {
			bg_color = "#fbf1c7",
			fg_color = "#333333",
			italic = true,
		},

		inactive_tab = {
			bg_color = "#665c54",
			fg_color = "#333333",
		},
	},
}

-- NOTE: Setup all keybind related details here

-- Setup the leader key
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

-- Keybinds for managing splits (using neovim split keybinds for ease of memory)
create_keybinds("v", "LEADER", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
create_keybinds("s", "LEADER", act.SplitVertical({ domain = "CurrentPaneDomain" }))
create_keybinds("x", "LEADER", act.CloseCurrentPane({ confirm = true }))

-- Keybinds for moving between splits (using vim keybinds for movement)
create_keybinds("h", "LEADER", act.ActivatePaneDirection("Left"))
create_keybinds("l", "LEADER", act.ActivatePaneDirection("Right"))
create_keybinds("k", "LEADER", act.ActivatePaneDirection("Up"))
create_keybinds("j", "LEADER", act.ActivatePaneDirection("Down"))

-- Keybinds for tab management
create_keybinds("t", "LEADER", act.SpawnTab("CurrentPaneDomain"))
create_keybinds("c", "LEADER", act.CloseCurrentTab({ confirm = true }))
create_keybinds("r", "LEADER", action)

-- Assign the converted keybinds from map -> config.keys
config.keys = map

-- Return the modified config to wezterm
return config
