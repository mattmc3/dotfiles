-- https://forum.colemak.com/topic/2020-for-mac-users-colemak-dh-curl-tarmak-anglewide-and-extend/
-- https://github.com/braydenm/hyper-hacks/blob/master/hammerspoon/init.lua
-- # http://homeowmorphism.com/2017/05/27/Remap-CapsLock-Backspace-Sierra
-- # https://developer.apple.com/library/archive/technotes/tn2450/_index.html

-- macOS map caps (0x39):
-- * to delete (0x2A)
-- * to F18 (0x6D)
-- * to right opt (0xE6)
-- hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}'

local hotkey = require "hs.hotkey"
local window = require "hs.window"
local spaces = require "hs.spaces"

-- A global variable for the Hyper Mode
hypermode = hs.hotkey.modal.new({}, "F17")

local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

-- Cursor movement modifiers for line, word, selecting, etc.
modifiers = {
  {''},
  {'cmd'},
  {'ctrl'},
  {'alt'},
  {'shift'},
  {'cmd','shift'},
  {'ctrl','shift'},
  {'alt','shift'},
}

-- Keypresses associated with each direction. I use colemak. Change to ijkl for qwerty.
movements = {
  { 'u', 'UP'},
  { 'n', 'LEFT'},
  { 'e', 'DOWN'},
  { 'i', 'RIGHT'},
  { 'l', 'HOME'},
  { 'y', 'END'},
  { 'j', 'PAGEUP'},
  { 'h', 'PAGEDOWN'},
  { 'o', 'DELETE'},
  { ';', 'FORWARDDELETE'},

}
for j,jmod in ipairs(modifiers) do
  for i,bnd in ipairs(movements) do
    i = function()
      -- hs.eventtap.keyStroke(jmod,bnd[2])
      fastKeyStroke(jmod,bnd[2])
      hypermode.triggered = true
    end
    hypermode:bind(jmod, bnd[1], i, nil, i)
  end
end

hyperMaps = {
  { 'a', function() hs.hid.capslock.toggle() end },
  { 'k', function() hs.eventtap.leftClick(hs.mouse.absolutePosition()) end },
  { 'm', function() hs.eventtap.rightClick(hs.mouse.absolutePosition()) end },
  { ',', function() hs.eventtap.middleClick(hs.mouse.absolutePosition()) end },
  { 'SPACE', function() hs.eventtap.keyStroke({}, 'RETURN') end },
  { 1, function() hs.eventtap.keyStroke({}, 'F1') end },
  { 2, function() hs.eventtap.keyStroke({}, 'F2') end },
  { 3, function() hs.eventtap.keyStroke({}, 'F3') end },
  { 4, function() hs.eventtap.keyStroke({}, 'F4') end },
  { 5, function() hs.eventtap.keyStroke({}, 'F5') end },
}

for _, hypMap in pairs(hyperMaps) do
  local hypKey = hypMap[1]
  hypfun = function()
    print("Hyper: " .. hypKey)
    hypMap[2]()
    hypermode.triggered = true
  end
  hypermode:bind({}, hypKey, hypfun, nil, nil)
end

-- HYPER+=: Open Google in the default browser
equalsfun = function()
  launch = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open https://google.com')"
  hs.osascript.javascript(launch)
  hypermode.triggered = true
end
hypermode:bind('', '=', nil, equalsfun, nil, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  hypermode.triggered = false
  hypermode:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  hypermode:exit()
  if not hypermode.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
shf18 = hs.hotkey.bind({'shift'}, 'F18', pressedF18, releasedF18)
altf18 = hs.hotkey.bind({'alt'}, 'F18', pressedF18, releasedF18)
altshf18 = hs.hotkey.bind({'shift', 'alt'}, 'F18', pressedF18, releasedF18)
cmdshf18 = hs.hotkey.bind({'cmd', 'shift'}, 'F18', pressedF18, releasedF18)
cmdaltshf18 = hs.hotkey.bind({'cmd', 'alt', 'shift'}, 'F18', pressedF18, releasedF18)

-- Reload config when any lua file in config directory changes
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
        doReload = true
    end
  end
  if doReload then
    hs.reload()
    print('reloaded')
  end
end
local myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()

-- Open WezTerm from anywhere
-- https://gist.github.com/pythoninthegrass/f141261a0dd28a4549780e1eb0e9c0f3
-- https://github.com/wez/wezterm/issues/1751
hs.hotkey.bind({"cmd"}, "`", function()
  local wez = hs.application.find("WezTerm", true)
  if not wez then
    hs.application.launchOrFocus("WezTerm")
  else
    if wez:isFrontmost() then
      wez:hide()
    else
      local wezWindow = wez:mainWindow()
      local curScreen = hs.window.focusedWindow():screen()
      wezWindow:moveToScreen(curScreen)
      wez:activate()
    end
  end
end)
