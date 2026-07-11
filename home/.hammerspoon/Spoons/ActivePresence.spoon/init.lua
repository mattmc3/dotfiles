-- ~/.hammerspoon/Spoons/ActivePresence.spoon/init.lua

local obj = {}
obj.__index = obj

obj.name = "ActivePresence"
obj.version = "1.0"
obj.author = "Matt"
obj.license = "MIT"

obj.startHour = 9
obj.endHour = 17
obj.wiggleInterval = 60 * 4
obj.idleThreshold = 120

obj._lastWiggle = nil
obj._timer = nil
obj._active = false

function obj:isWorkHours()
  local t = os.date("*t")
  if t.wday < 2 or t.wday > 6 then return false end
  if t.hour < self.startHour or t.hour >= self.endHour then return false end
  return true
end

function obj:isPreventingIdle()
  local output = hs.execute("pmset -g assertions 2>/dev/null")
  local count = output:match("PreventUserIdleSystemSleep%s+(%d+)")
  return tonumber(count) and tonumber(count) > 0
end

function obj:simulateActivity()
  local shouldBeActive = self:isWorkHours() and self:isPreventingIdle()

  if shouldBeActive ~= self._active then
    self._active = shouldBeActive
    if self._active then
      hs.printf("[ActivePresence] Now active — will simulate activity every %ds", self.wiggleInterval)
    else
      hs.printf("[ActivePresence] Now inactive — paused")
    end
  end

  if not shouldBeActive then return end
  if hs.host.idleTime() < self.idleThreshold then return end

  local idleTime = hs.host.idleTime()

  -- Mouse wiggle: 1px right then back
  local pos = hs.mouse.absolutePosition()
  hs.mouse.absolutePosition({ x = pos.x + 1, y = pos.y })
  hs.timer.doAfter(0.1, function()
    hs.mouse.absolutePosition(pos)
  end)

  -- Keypress: F15 (no visible effect, registers as HID activity)
  hs.eventtap.event.newKeyEvent(hs.keycodes.map["f15"], true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map["f15"], false):post()

  self._lastWiggle = os.date("%H:%M:%S")
  hs.printf("[ActivePresence] Simulated activity at %s (idle for %.0fs)", self._lastWiggle, idleTime)
end

function obj:start()
  self._timer = hs.timer.doEvery(self.wiggleInterval, function()
    self:simulateActivity()
  end)
  hs.printf("[ActivePresence] Started (M-F %d:00-%d:00, every %ds, idle threshold %ds)",
    self.startHour, self.endHour, self.wiggleInterval, self.idleThreshold)
  return self
end

function obj:stop()
  if self._timer then
    self._timer:stop()
    self._timer = nil
  end
  self._active = false
  hs.printf("[ActivePresence] Stopped")
  return self
end

function obj:status()
  local wouldWiggle = self:isWorkHours() and self:isPreventingIdle()
  local nextCheck = self._timer and os.date("%H:%M:%S", math.floor(os.time() + self._timer:nextTrigger())) or "n/a"
  hs.printf("[ActivePresence] timer=%s wiggle=%s workHours=%s preventingIdle=%s lastWiggle=%s nextCheck=%s",
    self._timer and "running" or "stopped",
    wouldWiggle and "ready" or "idle",
    self:isWorkHours() and "yes" or "no",
    self:isPreventingIdle() and "yes" or "no",
    self._lastWiggle or "never",
    nextCheck)
end

return obj

