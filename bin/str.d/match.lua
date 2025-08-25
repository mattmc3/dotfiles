#!/usr/bin/env lua

local rex = require("rex_pcre")
local posix = require("posix")

local function usage(exit_code)
  io.stderr:write("Usage: " .. arg[0] .. " [-a] [-e] [-i] [-h] PATTERN [STR...]\n")
  os.exit(exit_code or 0)
end

-- Parse options using a for loop
local all, entire, ignorecase = false, false, false
local pattern_idx = nil
for i = 1, #arg do
  local a = arg[i]
  if a == "-a" then all = true
  elseif a == "-e" then entire = true
  elseif a == "-i" then ignorecase = true
  elseif a == "-h" then usage(0)
  elseif a == "-r" then -- no-op, always regex
  elseif a:sub(1,1) == "-" then usage(2)
  else
    pattern_idx = i
    break
  end
end

if not pattern_idx then usage(2) end
local pattern = arg[pattern_idx]
local flags = ignorecase and "i" or ""

-- Gather input strings
local inputs = {}
if pattern_idx < #arg then
  for j = pattern_idx + 1, #arg do table.insert(inputs, arg[j]) end
else
  if posix.isatty(io.stdin) then usage(2) end
  for line in io.lines() do table.insert(inputs, line) end
end

for _, str in ipairs(inputs) do
  if entire then
    local count = 0
    for _ in rex.gmatch(str, pattern, flags) do count = count + 1 end
    if count > 0 then
      if all then
        for _ = 1, count do print(str) end
      else
        print(str)
      end
    end
  else
    local matches = {}
    for m in rex.gmatch(str, pattern, flags) do table.insert(matches, m) end
    if #matches > 0 then
      if all then
        for _, m in ipairs(matches) do print(m) end
      else
        print(matches[1])
      end
    end
  end
end
