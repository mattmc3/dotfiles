-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- What's our shell?
shell = '/opt/homebrew/bin/fish'
config.default_prog = { shell }
config.set_environment_variables = {
	SHELL = shell,
}

-- Change the color scheme
config.color_scheme = 'Wombat'

config.macos_window_background_blur = 20
config.window_background_opacity = 0.9
-- config.background = {
-- 	{
-- 		source = {
-- 			Color = '#0f1019'
-- 		},
-- 		width = "100%",
-- 		height = "100%",
-- 		opacity = .9
-- 	},
-- }

config.colors = {
	-- foreground = '#8f92a0',
	background = '#0f1019',
	selection_fg = '#8f92a0',
	selection_bg = '#1f2131',
}


-- Font
config.font = wezterm.font 'MesloLGM Nerd Font Mono'
config.font_size = 14.0

-- Center on screen
wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().main
	local ratio = 0.7
	local width, height = screen.width * ratio, screen.height * ratio
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {
		position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
	})
	-- window:gui_window():maximize()
	window:gui_window():set_inner_size(width, height)
end)

-- and finally, return the configuration to wezterm
return config
