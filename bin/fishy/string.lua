#!/usr/bin/env lua

local cmd = nil
local quiet = false
local args = {}
local parsing_flags = true

-- Parse arguments
local i = 1
while i <= #arg do
	local a = arg[i]
	if parsing_flags then
		if a == "--" then
			parsing_flags = false
		elseif a == "-q" or a == "--quiet" then
			quiet = true
		elseif not cmd then
			cmd = a
		else
			table.insert(args, a)
		end
	else
		table.insert(args, a)
	end
	i = i + 1
end

if not cmd then
	io.stderr:write("Usage: str <upper|lower> [-q|--quiet] [--] [strings...]\n")
	os.exit(1)
end

local function transform(line)
	if cmd == "upper" then
		return string.upper(line)
	elseif cmd == "lower" then
		return string.lower(line)
	else
		io.stderr:write("Unknown command: " .. tostring(cmd) .. "\n")
		os.exit(1)
	end
end

local did_transform = false

if #args > 0 then
	for _, original in ipairs(args) do
		local transformed = transform(original)
		if not quiet then
			print(transformed)
		end
		if transformed ~= original then
			did_transform = true
		end
	end
else
	for line in io.lines() do
		local transformed = transform(line)
		if not quiet then
			print(transformed)
		end
		if transformed ~= line then
			did_transform = true
		end
	end
end

if did_transform then
	os.exit(0)
else
	os.exit(1)
end
