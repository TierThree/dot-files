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

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- NOTE: Setup any appearance values

-- Set the theme to Gruvbox Dark
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Setup the retro style tabs
config.use_fancy_tab_bar = false

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
