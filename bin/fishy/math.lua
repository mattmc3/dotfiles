#!/usr/bin/env lua

local posix = require "posix"

-- Memoization table for factorials
local factorials = {}

local custom_math = {}

-- Custom math functions
function custom_math.cosh(x)
	x = tonumber(x)
	if not x then error("math: cosh argument must be a number") end
	return (math.exp(x) + math.exp(-x)) / 2
end

function custom_math.log2(x)
	x = tonumber(x)
	if not x or x <= 0 then error("math: log2 argument must be a positive number") end
	return math.log(x, 2)
end

function custom_math.fac(n)
	n = tonumber(n)
	if not n or n < 0 or n ~= math.floor(n) then
		error("math: fac argument must be a non-negative integer")
	end
	if n == 0 then return 1 end
	if factorials[n] then return factorials[n] end
	local result = 1
	for i = 2, n do
		result = result * i
	end
	factorials[n] = result
	return result
end

-- Compute gcd for reducing fractions
function custom_math.gcd(a, b)
	while b ~= 0 do
		a, b = b, a % b
	end
	return a
end

-- Compute nCr using multiplicative formula with fraction reduction
function custom_math.ncr(n, r)
	n, r = tonumber(n), tonumber(r)
	if not n or not r or n < 0 or r < 0 or n ~= math.floor(n) or r ~= math.floor(r) or r > n then
		error("math: ncr arguments must be non-negative integers with r <= n")
	end
	if r > n - r then r = n - r end -- take advantage of symmetry
	local num, den = 1, 1
	for i = 1, r do
		num = num * (n - i + 1)
		den = den * i
		local g = custom_math.gcd(num, den)
		num = num // g
		den = den // g
	end
	return num
end

-- Compute nPr directly
function custom_math.npr(n, r)
	n, r = tonumber(n), tonumber(r)
	if not n or not r or n < 0 or r < 0 or n ~= math.floor(n) or r ~= math.floor(r) or r > n then
		error("math: npr arguments must be non-negative integers with r <= n")
	end
	local result = 1
	for i = 0, r - 1 do
		result = result * (n - i)
	end
	return result
end

function custom_math.round(x)
	x = tonumber(x)
	if not x then error("math: round argument must be a number") end
	if x >= 0 then
		return math.floor(x + 0.5)
	else
		return math.ceil(x - 0.5)
	end
end

function custom_math.eval_infix(args)
	for i, v in ipairs(args) do
		local vl = tostring(v):lower()
		if vl == "x" then
			args[i] = "*"
		elseif vl == "pi" then
			args[i] = "3.141593"
		elseif vl == "tau" then
			args[i] = "6.283185"
		elseif vl == "e" then
			args[i] = "2.718282"
		end
	end

	-- Join args into a string
	local expr = table.concat(args, " ")
	-- Only allow numbers, operators, parentheses, and spaces for safety
	if expr:match("[^%de%^%+%-%*/%%%.%(%)%sE]") then
		error("math: invalid characters in expression")
	end
	-- Evaluate using load
	local f, err = load("return " .. expr)
	if not f then error("math: invalid expression: " .. err) end
	return f()
end

local function math_command(args)
	local funcname = args[1]
	local fn = math[funcname] or custom_math[funcname]
	if type(fn) == "function" then
		-- Convert remaining args to numbers
		local params = {}
		for i = 2, #args do
			local n = tonumber(args[i])
			if not n then
				error("math: argument '" .. tostring(args[i]) .. "' is not a number")
			end
			params[#params+1] = n
		end
		return fn(table.unpack(params))
	else
		-- Try to evaluate as infix expression
		return custom_math.eval_infix(args)
	end
end

if debug.getinfo(1, "S").short_src == arg[0] then
	local ok, result = pcall(math_command, {...})
	if not ok then
		local err = result:match(":%s(.+)$") or result
		io.stderr:write(err, "\n")
		os.exit(1)
	end
	print(result)
end

return math_command
