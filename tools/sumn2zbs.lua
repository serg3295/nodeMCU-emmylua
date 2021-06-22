--#region Overview
-- The following script is used to convert NodeMCU API descriptions to ZeroBrane Studio format.
-- written by serg3295
-- ver. 0.1.0
--
-- The script uses some code from script to convert Corona API descriptions
-- by Paul Kulchenko. https://github.com/pkulchenko/ZeroBraneStudio
--
-- This script requires ZeroBrane Studio already installed to run.
-- To process:
-- 1. copy this script `sumn2zbs.lua` to `ZBS/api/lua` folder
-- 2. copy `esp8266` and `esp32` folders with module.lua files to `ZBS/api/lua` folder
--    Note.
--    'bme280_c_module.lua' is deprecated. You must delete this file from `esp8266` folder
--    before converting, otherwise, the conversion will fail with an error.
--    If you want to use bme280 C module instead of Lua module bme280.lua you could add code
--
--        ---@class bme280
--        bme280 = {}
--
--    in file 'bme280_c_module.lua' and delete file 'bme280.lua'. Then run the script.
-- 3. run as "../../bin/lua sumn2zbs.lua "srcDir" >outputFile.lua" from ZBS/api/lua folder
--    If no "srcDir" is given, script uses ./esp8266 directory
--      lua sumn2zbs.lua >nodemcu.lua
--    otherwise, the argument is directory's name and script uses ./"arg" directory
--      lua sumn2zbs.lua esp32 >nodemcu32.lua
-- 4. launch the IDE with setting -> api = {'nodemcu'} or api = {'nodemcu32'}
--    to confirm it's loading without issues
--#endregion Overview

package.path  = package.path .. ';../../lualibs/?/?.lua;../../lualibs/?.lua'
package.cpath = package.cpath .. ';../../bin/clibs/?.dll'

local mobdebug = require('mobdebug')
local lfs      = require('lfs')
local format, find, match = string.format, string.find, string.match
local DIR_SEP = '/'
local API     = {}
local files   = {}
local tAlias  = {}
local srcDir  = arg[1] and ("." .. DIR_SEP .. arg[1])  or ("." .. DIR_SEP .. "esp8266")

--#region Utility functions

--- Get file names from src directory
---@param path string
local getFilenames = function (path, tbl)
  for file in lfs.dir(path) do
    if lfs.attributes(path .. DIR_SEP .. file, "mode") == "file" then
        table.insert(tbl, file)
    end
  end
end

-- Load contents of the given file
---@param fname string file name
---@return      string @data from file
local readFile = function(fname)
  local file = io.open(fname, "r")
  if not file then error(format("Can't open file %s", fname)) end
  local data = file:read("*a")
  file:close()
  return data
end

-- from http://lua-users.org/wiki/SplitJoin \
---split string into lines
---@param str string
---@return    table
local function lines(str)
  local t = {}
  local function helper(line)
    table.insert(t, line)
    return ""
  end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

---Split string into paragraphs
---@param str string
---@return    table
local function getParagraph(str)
  local t = {}
  local function helper(line)
    table.insert(t, line)
    return ""
  end
  helper((str:gsub("(.-)\r?\n\r?\n", helper)))
  return t
end

---Check whether string starts with 'piece'
---@param s     string
---@param piece string
---@return      boolean
local function startswith(s, piece)
  return string.sub(s, 1, string.len(piece)) == piece
end

---Check if not sumneco's type
---@param r string
---@return  boolean
local function isUserType(r)
  return (r
    and r ~= 'string'
    and r ~= 'boolean'
    and r ~= 'number'
    and r ~= 'table'
    and r ~= 'integer'
    and r ~= 'function'
    and r ~= 'nil'
    and r ~= 'any')
end

---Check if parameter is alias type
---@param s string
---@return  string|nil @alias type or nil
local function alias(s)
  local at = nil
  for aName, aType in pairs(tAlias) do
    if s == aName then at = aType break end
  end
  return at
end

---remove redundant characters from description
---@param d string
---@return  string
local function cleanDescr(d)
  return d:sub(4)
          :gsub("\\$", "", 1)  -- remove trailing backslash
          :gsub("%*", "")
          :gsub("`", "'")
          :gsub("(%b[])%b()", function (h)  -- remove links
                return string.sub(h, 2, -2)
            end)
end

--#endregion Utility functions

if lfs.attributes(srcDir) then
  if lfs.attributes(srcDir).mode == "directory" then
    getFilenames (srcDir, files)
  end
else
  error(format("Cannot open directory, %s", srcDir))
end

for _, fileName in pairs(files) do
  local content          = readFile(srcDir .. DIR_SEP .. fileName)
  local base, cla1, cla2 = nil, nil, nil  ---@type string

  for i = 1, #tAlias do tAlias[i] = nil end
  -- classes find ( Limitation max 2 level -> base.class1.class2.* )
  for parClass in string.gmatch(content, "(%-%-%-@class.-%s=%s{})") do
    local t = lines(parClass)
    if find(t[#t], "local") then
      local bObj = match(t[#t], "^local%s([%w_]+)%s=")
      if bObj and not API[bObj] then
        API[bObj] = {type = "class", childs = {}}
      end
    else
      base, cla1, cla2 = match(t[#t], "([%w_]+)%.?([%w_]*)%.?([%w_]*)%.?.*=%s{}")
      if base and not API[base] then
        API[base] = {type = "lib", description = base .. ' module', childs = {}}
      end
      if cla1 ~= "" and not API[base].childs[cla1] then
        API[base].childs[cla1] = {type = "class", childs = {}}
      end
      if cla2 ~= "" and not API[base].childs[cla1].childs[cla2] then
        if  not API[base].childs[cla1] then
          API[base].childs[cla1] = {type = "class",  childs = {}}
        end
        API[base].childs[cla1].childs[cla2] = {type = "class", childs = {}}
      end
    end

    -- process inherits
    if find(t[1], "^%-%-%-@class%s[%w_]+%s:") then
      local cl, inh = match(t[1], "^%-%-%-@class%s([%w_]+)%s:%s([%w_]+)%f[%W]")
      API[cl].inherits = inh
    end
  end

  local paragraphs = getParagraph(content)
  for _, par in ipairs(paragraphs) do
    local descr     = ""
    local allParams = ""
    local allRets   = ""
    local child     = {type = "", description = "", args = "", returns = ""}

    local t = lines(par)
    for _, tstr in ipairs(t) do

      if startswith(tstr, "---@field") and find(t[#t], "[%w_]+ = {}") then
        local constant = match(tstr, "^%-%-%-@field ([%w_]+) %a")
        local item     = match(t[#t], "([%w_]+) = {}$")
        if item == base then
          API[base].childs[constant] = { type = "value" }
        elseif find(t[#t], "local") then
          API[item].childs[constant] = { type = "value" } -- item = object name -> bObj
        else
          API[base].childs[item].childs[constant] = { type = "value" }
        end

      elseif startswith(tstr, "function") then
        if find(tstr, "^function [%w_]-%..+%(") then
          child.type = "function"
      ---@type string
          local l1, l2, l3 = match(tstr, "^function%s[%w_]+%.([%w_]+)%.?([%w_]*)%.?([%w_]*)%(.*%)")
          if l2 == "" and l3 == "" then
            API[base].childs[l1] = child
          elseif l2 ~= "" and l3 == "" then
            API[base].childs[l1].childs[l2] = child
          elseif l3 ~= "" then
            API[base].childs[l1].childs[l2].childs[l3] = child
          end
        elseif find(tstr, "^function%s[%w_]-:.+%(") then
          child.type = "method"
          local bObj, funName = match(tstr, "^function%s([%w_]+):([%w_]+)%(")
          API[bObj].childs[funName] = child
        elseif find(tstr, "^function%s[%w_]+%(") then
          child.type = "function"
          local l0 = match(tstr, "^function%s([%w_]+)%(")
          API[l0] = child
        end

        if child.args    == "" then child.args    = "()" end
        if child.returns == "" then child.returns = "()" end

      elseif startswith(tstr, "---@return") then
        local ret = match(tstr, "@return%s([%w%|_]+)%f[%W]")
        if ret and ret ~= "" and isUserType(ret) and (not find(ret, "|")) then
          child.valuetype = ret
          child.returns   = '(' .. ret .. ')'
        else
          allRets       = allRets .. ret
          child.returns = '(' .. allRets .. ')'
          allRets       = allRets .. ", "
        end

      elseif find(tstr, "^%-%-%-[%w%s]") and child.args == "" and child.returns == "" then
        descr = descr .. cleanDescr(tstr)
        child.description = descr
        descr = descr .. "\n"

      elseif startswith(tstr, "---@param") then
        local param, paramType = match(tstr, "^%-%-%-@param%s([%w_?]+)%s([%w_]+)%f[%W]")
        if alias(paramType) then paramType = alias(paramType) end
        if isUserType(paramType) then paramType = "table" end
        allParams  = allParams .. param .. ": " .. paramType
        child.args = "(" .. allParams .. ")"
        allParams  = allParams .. ", "

      elseif startswith(tstr, "---@alias") then
        local aliasName, aliasType = match(tstr, "^%-%-%-@alias%s([%w_]+)%s([%w_]+)%f[%W]")
        tAlias[aliasName] = aliasType
      end
    end
  end
end

print("return " .. mobdebug.line(API, {indent = ' ', comment = false}) )
