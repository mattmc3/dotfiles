#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:match("@(.*/)")
local argparse = dofile(script_dir .. "argparse")
local parsed = argparse({"h/help", "n/name=", "--", "-h", "--name", "foo", 'b"ar', "baz\"\nqux"})
-- print(parsed.flags.help)         -- true
-- print(parsed.flags.h)            -- true
-- print(parsed.flags.name)         -- "foo"
-- print(parsed.positionals[1])     -- "bar"

local cjson = require "cjson"
print(cjson.encode(parsed))

local count = dofile(script_dir .. "count")
local result = count({"foo", "bar", "baz"})
print(result)
local result = count()
print(result)
