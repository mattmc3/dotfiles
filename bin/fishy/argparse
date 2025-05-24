#!/usr/bin/env lua

-- Helper to check if a string is nil or empty
local function isempty(s)
	return s == nil or s == ""
end

local function argparse(args)
	-- Parse the spec
	local specs = {}
	local i = 1

	-- Collect specs until we hit '--'
	while args[i] and args[i] ~= "--" do
		local spec = args[i]
		local short, long, takes_value = nil, nil, false

		-- Check for '=' at the end (takes value)
		if spec:sub(-1) == '=' then
			takes_value = true
			spec = spec:sub(1, -2)
		end

		-- Split short/long
		local slash = spec:find('/')
		if slash then
			short = spec:sub(1, slash-1)
			long = spec:sub(slash+1)
		elseif #spec == 1 then
			short = spec
		else
			long = spec
		end

		-- Check for valid spec
		if isempty(short) and isempty(long) then
			error("argparse: An option spec must have at least a short or a long flag")
		end

		table.insert(specs, {short=short, long=long, takes_value=takes_value})
		i = i + 1
	end

	-- Check for '--' separator
	if args[i] ~= "--" then
		error("argparse: Missing -- separator")
	end

	-- Skip '--'
	i = i + 1

	-- Build lookup tables
	local short_map, long_map = {}, {}
	for _, s in ipairs(specs) do
		if s.short then short_map[s.short] = s end
		if s.long then long_map[s.long] = s end
	end

	-- Parse arguments
	local results = {}
	local positionals = {}
	while i <= #args do
		local arg = args[i]
		if arg:sub(1,2) == "--" then
			local name = arg:sub(3)
			local spec = long_map[name]
			if spec then
				local key = not isempty(spec.long) and spec.long or spec.short
				if spec.takes_value then
					i = i + 1
					results[key] = args[i]
				else
					results[key] = true
				end
			else
				table.insert(positionals, arg)
			end
		elseif arg:sub(1,1) == "-" and #arg > 1 then
			local name = arg:sub(2,2)
			local spec = short_map[name]
			if spec then
				local key = not isempty(spec.long) and spec.long or spec.short
				if spec.takes_value then
					i = i + 1
					results[key] = args[i]
				else
					results[key] = true
				end
			else
				table.insert(positionals, arg)
			end
		else
			table.insert(positionals, arg)
		end
		i = i + 1
	end

	-- Build result table
	local flags = {}
	for _, spec in ipairs(specs) do
		local key = not isempty(spec.long) and spec.long or spec.short
		local value = results[key]
		if value ~= nil then
			if spec.long then flags[spec.long] = value end
			if spec.short then flags[spec.short] = value end
		end
	end

	return {
		flags = flags,
		positionals = positionals,
		specs = specs,
	}
end

-- If run as a script
if debug.getinfo(1, "S").short_src == arg[0] then
	local ok, parsed = pcall(argparse, {...})

	if not ok then
		local err = parsed:match(":%s(.+)$") or parsed
		io.stderr:write(err, "\n")
		os.exit(1)
	end

	-- Unset flag vars
	-- for var in $(compgen -v _flag_); do unset "$var"; done
	-- for var in ${(k)parameters}; do
	-- 	[[ $var == _flag_* ]] && unset $var
	-- done

	-- Print flag variables as shell assignments
	for _, spec in ipairs(parsed.specs) do
		local key = not isempty(spec.long) and spec.long or spec.short
		local value = parsed.flags[key]
		if value ~= nil then
			if spec.long then
				io.write("_flag_", spec.long, "=")
				if type(value) == "boolean" then
					io.write(value and "1" or "0", "\n")
				else
					io.write(string.format("%q", tostring(value)), "\n")
				end
			end
			if spec.short then
				io.write("_flag_", spec.short, "=")
				if type(value) == "boolean" then
					io.write(value and "1" or "0", "\n")
				else
					io.write(string.format("%q", tostring(value)), "\n")
				end
			end
		end
	end

	-- Print positionals as a set -- statement
	io.write("set --")
	for _, v in ipairs(parsed.positionals) do
		io.write(" ", string.format("%q", tostring(v)))
	end
	io.write("\n")
end

return argparse
