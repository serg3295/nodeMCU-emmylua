--#region Header
--------------------------------------------------------------------------------
-- A script to generate NodeMCU API autocomplete files in EmmyLua format
-- ver. 0.1.1
-- Written by serg3295
-- This script converts nodeMCU module.md file to module.lua in emmyLua format
-- Expected structure is following:
--
-- ## functionName()
--
-- Description
--
-- #### Syntax
-- `declare.function:name(params)`
--
-- #### Parameters
-- none | None | nil | `nil` "^[`Nn][on][ni][el][`\n]*"  ¯\_(ツ)_/¯
-- -|* `text1` comment 1
--    -|* `text2` comment 2
-- text
--
-- #### Returns
-- `nil`
-- -|* `text1` comment 1
--    -|* `text2` comment 2
-- text
-- If word "O|object" is given in line, the first `word` will be treated as obj type.
-- e.g. `tObj` Timer Object -> @class tObj; local tobj = {}
-- "A `filter` object." in bloom module
-- #### Returns
-- `UDPSOCKET` Object
-- [net.udpsocket sub module](#netudpsocket-module)
-- etc.
--------------------------------------------------------------------------------
--#endregion Header

--#region beforeParser

local readFile, saveFile, lines, detab, rmSpaces, rmHeaders, makeBold
local dataOut, mdFile, allFunc, getDescr, getSyntax, getParams, getRet
local addLineBr
local description, parameters, returns, syntax, content
local funcName
local format = string.format

---@type table <number, string>
local optparam = {}  -- optional parameter names

local function fileParse(arg)
  local fn       = string.sub(arg, 1, -4)
  if type(fn)   ~= "string" then error("Wrong argument") end
  local fileName = fn .. ".md"
  local fout     = fn .. ".lua"
  mdFile = readFile(fileName)

  -- file preprocessing
  mdFile = mdFile : gsub("###%s*Example", "####Example")
                  : gsub("###%s*See", "####See")
                  : gsub("####%s*Return", "####Return")
                  : gsub("####%s?(.-)", "####%1")
                  : gsub("\n#[ \t]*(%a)", "\n####%1") -- set # header as a border ####text
                  : gsub("##%s[%a]+\n", "")     -- remove lines like ## Constructor
                  : gsub("### ([%a]+)", "## %1" ) -- e.g. for tmr:...
                  : gsub("##%s%w-%s", "")       -- remove lines like ## Timer Object Methods
                  : gsub("(%b[])%b()",  function (h)  -- handle links
                                          return string.sub(h, 2, -2)
                                        end)
  mdFile = rmHeaders(mdFile) -- remove ambigous headers
  mdFile = mdFile : gsub("(##%s%w-[:%._].-)\n", "%1\n%1\n") -- duplicate headers
                  : gsub("##%s.-%(%)", "", 1)  -- and remove first header ##
  mdFile = mdFile .. "\n## EOF()" -- end of file

  dataOut = "--=== ".. string.upper(fn) .. " ===\n" .. fn .." = {}\n\n"   -- make title

  allFunc = {}
  -- split on blocks
  for oneFunc in string.gmatch(mdFile, "(##%s.-)##%s") do
    oneFunc = oneFunc .. "####end\n" -- end marker
    table.insert(allFunc, oneFunc)
  end

  for i = 1, #allFunc do
    content = allFunc[i]

    description = getDescr(content)
    syntax      = getSyntax(content)
    parameters  = getParams(content)
    returns     = getRet(content)

    dataOut = dataOut .. description .. parameters .. returns .. syntax

  end

  saveFile(fout, dataOut)

end

---remove ## headers that are not function descriptions
---@param str string
---@return string
function rmHeaders(str)

  local headers2ndlvl = {
    "## `resource.lua` file\n",
    "## `make_resource.lua` script\n",
    "## gpio.pulse\n",
    "## node.LFS\n",
    "## wifi.eventmon.reason\n",
  }

  for _, header2 in pairs(headers2ndlvl) do
    str = str:gsub(header2, "")
  end

  return str
end
--#endregion beforeParser

-- Get "Description"
---@param cont string
---@return string
function getDescr(cont)
  funcName = cont:match("## ([%w_:%.]+%(%)).-\n")
  if not funcName then
    funcName = cont:match("##%s?([%w_:%.]+).-\n")
    error("Probably missing parentheses in the function declaration. ## " .. funcName)
  end

  local buff = cont:match("##%s.-\n\n?(.-)\n?#####?[%w]+\n")
  if not buff then
     error("Description = nil in: " .. funcName)
  end

  buff = addLineBr(buff, true)
  local t = lines(buff)
  for k, v in pairs (t) do
    t[k] = makeBold(v)
    t[k] = string.gsub(t[k], "(.+)", "--- %1")
  end
  buff = table.concat(t, "\n")
  buff = buff:gsub("\n\n\n?", "\n") -- remove blank lines

  return buff
end

-- Get "Syntax"
---@param cont string
---@return string
function getSyntax(cont)

  --- Fill 'optparam' table with optional parameter names
  ---@param str string Syntax
  local function getOptParam(str)
    for i = 1, #optparam do optparam[i] = nil end
    local allop = string.match(str, "(%[.+%])") or ""
    if allop then
      allop = string.gsub(allop, ",", "%[")
      for op in string.gmatch(allop, "[%[%s]+([%w_]+)%s*[%[%]]") do
        optparam[#optparam+1] = op
      end
    end
  end

  -- local buff = cont:match("####Syntax\n?\n`(.-)`\n?\n####[%w]+\n")  -- TODO multiple functions -> @overload
  local buff = cont:match("####Syntax\n?\n`([^\n]-)`\n?\n")  -- one line only
  if not buff then
    error("#### Syntax section or '`' is missed in: " .. funcName)
  end
  getOptParam(buff)

  buff = buff:gsub("[%[%]]", "")
  buff = buff:gsub("({.+})", "tbl")
  buff = buff:gsub("^(.+%()(.+)%(.*(%))$", "%1%2%3")  -- remove nested "()"
  buff = buff:gsub("^([^%(]+%(.*)(function)(.*%))", "%1foo%3")
  buff = buff:gsub("(%.%.%.%s?)([%w]+)", "%1")  -- vararg
  buff = buff:gsub("^(.+=%s?)", "")
  buff = buff:gsub("^(.+)[/|](.+)", "%1_or_%2")   -- change / | -> _or_
  buff = "function " .. buff .. " end\n\n"

  return buff
end

-- Get "Returns"
---@param cont string
---@return string
function getRet(cont)
  local buff, clObj, t

  buff = cont:match("####Returns\n\n?(.-)\n##")
  if not buff then
    error("#### Returns section is missed in: " .. funcName)
  end

  buff = addLineBr(buff)
  ---@type table <number, string>
  t = lines(buff)
  for k, v in pairs (t) do
    v = detab(v)
    v = rmSpaces(v)

    if k == 1 then
      -- try catch object :-\
      if v:find("[Oo]bject") then  -- 'oObject' word is given in line
        clObj = string.match(v, "`([%w_]+)`") or "Object"
        dataOut = dataOut .. string.format("---@class %s\nlocal %s = {}\n\n", clObj, clObj)
      end

      if v:match("^[%-%*]%s`") then
        t[k] = v:gsub ("^[%-%*]%s?`(.-)`%s?(.-)", "---@return any %1 @%2")

      elseif v:match("^[%-%*]%s") then
        t[k] = v:gsub ("^(.-)", "---@return any @\n--- %1")

      else
        t[k] =  v:match("^`nil`") and
                v:gsub ("^`nil`", "---@return nil") or
                clObj and
                v:gsub ("^(.+)","---@return " .. clObj .. " @%1") or
              (v:match("`true`") and v:match("`false`")) and
                v:gsub ("^(.+)","---@return boolean @%1") or
                v:gsub ("^(.+)", "---@return any @%1")
      end

    else
      t[k] =  v:match("^[%-%*]%s`") and
              v:gsub ("^[%-%*]%s?`(.-)`%s?(.-)", "---@return any %1 @%2") or
              v:gsub("(.+)", "--- %1")
      t[k] = makeBold(t[k])
    end

  end

  buff = table.concat(t, "\n")
  buff = buff:gsub("\n\n", "\n") -- remove blank lines
  return buff
end

-- Get "Parameters"
---@param cont string
---@return string
function getParams(cont)

  --- Add '?' and @(optional) if parameter is optional
  ---@param str string
  ---@return string
  local function subOptParam(str)
    for _, opName in ipairs(optparam) do
      if string.find(str, "%-%-%-@param%s" .. opName) then
        str = str : gsub("%-%-%-@param%s" .. (opName), "%1?")
                  : gsub("(%-%-%-@param%s.+@)", "%1(optional) ")
      end
    end
    return str
  end

  ---one parameter parse
  ---@param t table
  ---@param k integer
  ---@param v string
  ---@return table
  local function parsePar(t, k, v)

    v = detab(v)
    if (v:find("^%s+[%-%*]")) then  -- indent ==> not 1-st level param
      t[k] = rmSpaces(v)
      t[k] = makeBold(t[k])
      t[k] = string.gsub(t[k], "^(.-)", "---%1")

      if k == #t then
        t[k] = t[k] .. "\n"
      end

    -- 1-st level parameter
    else
      t[k] =  string.match(v, "^[%-%*]?%s*`([%(%)%[%]%w%s_/,%.]+)`") and
              string.gsub(v, "^(.-)`([%(%)%[%]%w%s_/,%.]+)`[ :%.]?\r?\n?(.*)", "---@param %2 any @%3") or
              string.gsub(v, "^(.-)", "--- %1")

      -- remove "()" in parameter name - this is a "function" type
      t[k] =  string.gsub(t[k], "^%-%-%-@param (([%w_]+)%(.*%)) any @", "---@param %2 function @%1 ")
      -- change function -> foo. 'function' is a reserved word
      t[k] =  string.gsub(t[k], "^%-%-%-@param function (.+)", "---@param foo %1 ")

      -- change \ or | -> _or_
      t[k] =  string.gsub(t[k], "^%-%-%-@param ([%w_]+)/([%w_]+) (.+)", "---@param %1_or_%2 %3")

      -- vararg
      t[k] =  string.gsub(t[k], "^%-%-%-@param%s%.%.%.[%w%s_]+.+@([%w]*)", "---@vararg any @%1")
      t[k] =  string.gsub(t[k], "^%-%-%-@param%s[%w%s_]+%.%.%..+@([%w]*)", "---@vararg any @%1")

      -- optional parameters
      t[k] = subOptParam(t[k])

      if k == #t then -- the last string
        t[k] = t[k] .. "\n"
      end

    end

    return t[k]
  end

  local buff = cont:match("####Parameters\n(.-)\n\n?#####?%s?[%w]+\n")
  if not buff then
    error("#### Parameters or Returns section is missed in: " .. funcName)
  end
  buff = addLineBr(buff)

  local t = lines(buff)

  for k, v in pairs (t) do
    if k == 1 then
      t[k] =  string.match(v, "^[`Nn][on][ni][el][`\n]*") and "" or parsePar(t, k, v)
    else
      t[k] = parsePar(t, k, v)
    end
  end
  buff = table.concat(t, "\n")
  buff = buff:gsub("\n\n", "\n") -- remove blank lines

  return buff
end

--#region Utility functions

---Add line breaks - 'backslash'
---@param blk string
---@param isDescr boolean for exclude 1-st entry
---@return string
addLineBr = function (blk, isDescr)
  local isLine1 = true
  blk = string.gsub(blk, "\r*\n+([^%-%s%d\t])", function (s)
        if isDescr then
          return format("\\\n%s", s)
        else
          if isLine1 then
            isLine1 = false
            return format("\n%s", s)
          else
            return format("\\\n%s", s)
          end
        end
      end)
  return blk
end

---Remove redundant spaces in indented lines
---@param str string
---@return string
rmSpaces = function (str)
  str = str :gsub("....", "%0\1")
            :gsub("    \1", "  ")
            :gsub("\1", "")
  return str
end

---Replace the first `text` with bold **text** to improve\
---text readability in IntelliJ IDEA
---@param str string
---@return string
makeBold = function (str)
  str = string.gsub(str, "%-%s+`(.-)`", "- **%1**", 1)
  return str
end

-- Load contents of the given file
---@param  fname string file name
---@return string @data from file
readFile = function(fname)
  local file = io.open(fname, "r")
  if not file then error("Can't open file") end
  local data = file:read("*a")
  file:close()
  return data
end

-- Save contents to the given file
---@param fname string file name
---@param data  string data for save
---@return nil
saveFile = function(fname, data)
  local file = io.open(fname, "w")
  file:write(data)
  file:close()
end

-- from http://lua-users.org/wiki/SplitJoin \
---split string into lines
---@param str string
---@return table
function lines(str)
  local t = {}
  local function helper(line)
    table.insert(t, line)
    return ""
  end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

---from https://github.com/mpeterv/markdown/ \
--- Converts tabs to spaces
---@param text string
---@return string
function detab(text)
  local tab_width = 4
  local function rep(match)
     local spaces = -match:len()
     while spaces<1 do spaces = spaces + tab_width end
     return match .. string.rep(" ", spaces)
  end
  text = text:gsub("([^\n]-)\t", rep)
  return text
end

--#endregion Utility functions

local function main()
--[[ -- all files
  for i = 1, #arg do
    fileParse(arg[i])
  end
--]]

---[[ -- debug mode
  arg = "file_lfs.md"
  fileParse(arg)
--]]

end

main()
