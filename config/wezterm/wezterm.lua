local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'OneHalfDark'
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 11

return config
