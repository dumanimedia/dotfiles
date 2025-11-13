local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 11
config.line_height = 1.2
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- config.color_scheme = "OneDark Pro"

config.colors = {
	cursor_bg = "#f1fa8c",
	cursor_border = "#f1fa8c",
}
-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- key bindings
config.keys = {
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "h", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

return config
