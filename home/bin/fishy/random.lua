#!/usr/bin/env lua

local posix = require "posix"

local function random(args)
	local min, max

	if #args == 0 then
		min, max = 0, 32767
	elseif #args == 1 then
		min, max = 0, tonumber(args[1])
	elseif #args == 2 then
		min, max = tonumber(args[1]), tonumber(args[2])
	else
		error({errmsg = "random: Too many arguments", errcode = 1})
	end

	if not min or not max then
		error({errmsg = "random: Arguments must be numbers", errcode = 1})
	end

	if min > max then
		min, max = max, min
	end

	local val = math.random(min, max)
	return val
end

-- Run command if run as a script
if debug.getinfo(1, "S").short_src == arg[0] then
	local pid = posix.getpid("pid")
	local ppid = posix.getpid("ppid")
	local seed = os.time() + tonumber(tostring(os.clock()):reverse())
	print(string.format("ppid: %s", ppid))
	print(string.format("pid: %s", pid))
	print(string.format("seed: %s", seed))
	math.randomseed(seed + pid)

	local ok, result = pcall(random, {...})
	if not ok then
		io.stderr:write(result.errmsg .. "\n")
		os.exit(2)
	else
		print(result)
	end
end

return random
