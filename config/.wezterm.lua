-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"

config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 12

return config
