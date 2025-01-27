-- Set my core preferences up top
local myshell = "zsh"

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

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

-- What's our shell?
config.default_prog = { shells[myshell] }
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
config.background = wezterm.GLOBAL.backgrounds["Nydra"]

-- Cursor
config.default_cursor_style = 'SteadyBar'

-- Font
--config.font = wezterm.font 'Monaspace Argon'
--config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font 'MesloLGM Nerd Font Mono'
--config.font = wezterm.font 'Hack Nerd Font'
--config.font = wezterm.font 'FiraCode Nerd Font'
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

-- Add a Powerline status
-- https://gist.github.com/alexpls/83d7af23426c8928402d6d79e72f9401
local function segments_for_right_status(window)
  local result = {
    tostring(window:active_pane():get_user_vars().TERM_CURRENT_SHELL),
    wezterm.hostname(),
    wezterm.strftime('%a %b %-d %H:%M'),
  }
  local wksp = window:active_workspace()
  if wksp ~= "default" then
     table.insert(result, 1, wksp)
  end
  local curprog = tostring(window:active_pane():get_user_vars().WEZTERM_PROG)
  if curprog ~= "" then
     table.insert(result, 1, curprog)
  end
  return result
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg, bg
  gradient_from = gradient_to:lighten(0.4)

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

-- and finally, return the configuration to wezterm
return config
