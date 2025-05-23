#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:match("@(.*/)")
-- local argparse = dofile(script_dir .. "argparse")
-- local parsed = argparse({"h/help", "n/name=", "--", "-h", "--name", "foo", 'b"ar', "baz\"\nqux"})
-- -- print(parsed.flags.help)         -- true
-- -- print(parsed.flags.h)            -- true
-- -- print(parsed.flags.name)         -- "foo"
-- -- print(parsed.positionals[1])     -- "bar"

-- local cjson = require "cjson"
-- print(cjson.encode(parsed))

-- local count = dofile(script_dir .. "count")
-- local result = count({"foo", "bar", "baz"})
-- print(result)
-- local result = count()
-- print(result)

local assert = {
	passed = 0,
	failed = 0
}

function assert.equals(actual, expected, desc)
	if actual ~= expected then
		print("FAIL: " .. desc .. " (expected: " .. tostring(expected) .. ", got: " .. tostring(actual) .. ")")
		assert.failed = assert.failed + 1
		return false
	else
		print("PASS: " .. desc)
		assert.passed = assert.passed + 1
		return true
	end
end

function assert.error(fn, desc)
	local ok, err = pcall(fn)
	if ok then
		print("FAIL: " .. desc .. " (expected error, got success)")
		assert.failed = assert.failed + 1
		return false
	else
		print("PASS: " .. desc)
		assert.passed = assert.passed + 1
		return true
	end
end

function assert.command_output(cmd, expected, desc)
    local handle = io.popen(cmd)
    local output = handle:read("*a")
    handle:close()
    -- Remove trailing newline for comparison
    output = output:gsub("%s+$", "")
    if output ~= expected then
        print("FAIL: " .. desc .. " (expected: " .. tostring(expected) .. ", got: " .. tostring(output) .. ")")
        assert.failed = assert.failed + 1
        return false
    else
        print("PASS: " .. desc)
        assert.passed = assert.passed + 1
        return true
    end
end

function assert.print_results()
	print(string.format("\nResults: %d passed, %d failed", assert.passed, assert.failed))
end

-- Tests for contains
local contains = dofile(script_dir .. "contains")
assert.equals(contains({"foo", "bar", "baz", "foo"}), true, "contains: finds value")
assert.equals(contains({"foo", "bar", "baz"}), false, "contains: does not find value")
assert.equals(contains({"-i", "foo", "bar", "baz", "foo"}), 3, "contains: index flag finds correct index")
assert.equals(contains({"-i", "foo", "bar", "baz"}), false, "contains: index flag returns false if not found")
assert.error(function() contains({}) end, "contains: errors on missing key")

-- Tests for count
local count = dofile(script_dir .. "count")
assert.equals(count({"foo", "bar", "baz"}), 3, "count: counts three arguments")
assert.equals(count({}), 0, "count: counts zero arguments")
assert.equals(count(nil), 0, "count: handles nil as zero arguments")
assert.command_output("printf '%s\n' foo bar | " .. script_dir .. "count", "2", "count: counts stdin lines")
assert.command_output("printf '%s\n' x y z | " .. script_dir .. "count a b c", "6", "count: counts args and stdin lines")

-- Print test results
assert.print_results()
