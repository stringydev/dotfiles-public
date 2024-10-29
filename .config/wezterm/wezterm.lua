-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("PlemolJP Console NF")
config.font_size = 22

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.75
config.macos_window_background_blur = 30
config.color_scheme = "Solarized Dark - Patched"
config.colors = {
	background = "#131c20",
}
return config
