#!/usr/bin/env lua

local posix = require "posix"

local function contains(args)
	local index_flag = false
	local needle
	local start = 1

	-- Check for -i or --index flag
	if args[1] == "-i" or args[1] == "--index" then
		index_flag = true
		needle = args[2]
		start = 3
	else
		needle = args[1]
		start = 2
	end

	if not needle then
		error({errmsg = "contains: Key not specified", errcode = 2})
	end

	for i = start, #args do
		if args[i] == needle then
			if index_flag then
				return i - (index_flag and (start - 1) or 1)
			else
				return true
			end
		end
	end
	return false
end

-- Run command if run as a script
if debug.getinfo(1, "S").short_src == arg[0] then
	local ok, result = pcall(contains, {...})
	if not ok then
		io.stderr:write(result.errmsg .. "\n")
		os.exit(result.errcode)
	elseif type(result) == "number" then
		print(result)
	elseif not result then
		os.exit(1)
	end
end

return contains
