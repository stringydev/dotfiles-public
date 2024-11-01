-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("PlemolJP Console NF")
config.font_size = 22

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.80
config.macos_window_background_blur = 30
config.color_scheme = "Tokyo Night"

config.initial_rows = 28
config.initial_cols = 90

config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.automatically_reload_config = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

return config
