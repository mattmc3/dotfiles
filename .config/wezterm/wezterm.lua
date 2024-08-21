-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- region: Definitions
-- Define selectable backgrounds
local backgrounds = {}
backgrounds["Solid"] = {
	{
		source = {
			Color = '#0f1019',
		},
		width = "100%",
		height = "100%",
		opacity = .85,
	},
}
backgrounds["Nydra"] = {
	{
		source = {
			File = wezterm.config_dir .. '/backgrounds/botw_corrupted_nydra_rev.jpg',
		},
		repeat_x = 'NoRepeat',
		repeat_y = 'NoRepeat',
		opacity = 0.8,
		hsb = { brightness = 0.15 },
	},
	{
		source = {
			Color = '#0f1019',
			-- Color = '#ff0000'  -- red for testing
		},
		width = "100%",
		height = "100%",
		opacity = .5,
	},
}
wezterm.GLOBAL.backgrounds = backgrounds

-- Define selectable shells
local shells = {
	default = "/bin/zsh",
	bash = "/opt/homebrew/bin/bash",
	fish = "/opt/homebrew/bin/fish",
	zsh = "/opt/homebrew/bin/zsh",
}
wezterm.GLOBAL.shells = shells
-- }}}

-- This will hold the configuration.
local config = wezterm.config_builder()

-- What's our shell?
local shell = shells["fish"]
config.default_prog = { shell }
config.set_environment_variables = {
	SHELL = shell,
}

-- Change the color scheme
config.color_scheme = 'Tokyo Night'
config.colors = {
	--foreground = '#8f92a0',
	--background = '#0f1019',
	selection_fg = '#8f92a0',
	selection_bg = '#1f2131',
}

-- Background
config.macos_window_background_blur = 20
--config.window_background_opacity = 0.7
config.background = wezterm.GLOBAL.backgrounds["Solid"]

-- Font
config.font = wezterm.font 'MesloLGM Nerd Font Mono'
config.font_size = 14.0

-- Rows/Cols
config.initial_cols = 120
config.initial_rows = 30

-- Set the initial window start position
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or
		{position={x=400,y=300}}
	)
	window:gui_window():set_position(400,300)
end)

-- Open new windows with offset
-- https://github.com/wez/wezterm/issues/3173
wezterm.on("window-config-reloaded", function(window, pane)
  -- approximately identify this gui window, by using the associated mux id
  local id = tostring(window:window_id())

  -- maintain a mapping of windows that we have previously seen before in this event handler
  local seen = wezterm.GLOBAL.seen_windows or {}
	local next_window_x = wezterm.GLOBAL.next_window_x or 450
	local next_window_y = wezterm.GLOBAL.next_window_y or 350

	-- set a flag if we haven't seen this window before
  local is_new_window = not seen[id]

  -- and update the mapping
  seen[id] = true
  wezterm.GLOBAL.seen_windows = seen
	wezterm.GLOBAL.next_window_x = next_window_x + 50
	wezterm.GLOBAL.next_window_y = next_window_y + 50

  -- now act upon the flag
  if is_new_window then
    window:set_position(next_window_x, next_window_y)
  end
end)

-- Mimic iTerm2's floating window trick
config.keys = {
  {
    key = ']',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ToggleAlwaysOnTop,
  },
}

-- and finally, return the configuration to wezterm
return config
