-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("BlexMono Nerd Font Propo")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 25

config.color_scheme = "Tokyo Night Moon"
-- and finally, return the configuration to wezterm
return config
