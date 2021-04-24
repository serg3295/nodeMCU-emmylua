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
--#region beforeParser
local readFile, saveFile, lines
local dataOut, mdFile, allFunc, getDescr, getSyntax, getParams, getRet
local description, parameters, returns, syntax, content
local func

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
                  : gsub("##%s[%a]+\n", "")     -- remove lines like ## Constructor
                  : gsub("### ([%a]+)", "## %1" ) -- e.g. for tmr:...
                  : gsub("##%s%w-%s", "")       -- remove lines like ## Timer Object Methods
                  : gsub("## gpio.pulse\n", "") -- ambigous headers
                  : gsub("## node.LFS\n", "")
                  : gsub("## wifi.eventmon.reason", "")
                  : gsub("(##%s%w-[:%._].-)\n", "%1\n%1\n") -- duplicate headers
                  : gsub("##%s.-%(%)", "", 1)   -- and remove first header ##

  mdFile = mdFile .. "\n## EOF()" -- end of file

  -- print(mdFile)
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
--#endregion beforeParser

-- Get "Description"
---@param cont string
---@return string
function getDescr(cont)
  func = cont:match("## ([%w_:%.]+%(%)).-\n")
  if not func then
    func = cont:match("##%s?([%w_:%.]+).-\n")
    error("Probably missing parentheses in the function declaration. ## " .. func)
  end

  local buff = cont:match("##%s.-\n\n?(.-)\n?#####?[%w]+\n")
  if not buff then
    error("Description = nil in: " .. func)
  else
    local t = lines(buff)
    for k, v in pairs (t) do
      t[k] = string.gsub(v, "(.+)", "---%1")
    end
    buff = table.concat(t, "\n")
    buff = buff:gsub("\n\n\n?", "\n") -- remove blank lines
  end

  return buff
end

-- Get "Syntax"
---@param cont string
---@return string
function getSyntax(cont)
  -- local buff = cont:match("####Syntax\n?\n`(.-)`\n?\n####[%w]+\n")  -- TODO multiple functions -> @overload
  local buff = cont:match("####Syntax\n?\n`([^\n]-)`\n?\n")  -- one line only
  if not buff then
    error("#### Syntax section or '`' is missed in: " .. func)
  else
    buff = buff:gsub("[%[%]]", "")  -- TODO  add "?" in parameter's field
    buff = buff:gsub("({.+})", "tbl")
    buff = buff:gsub("^(.+%()(.+)%(.*(%))$", "%1%2%3")  -- remove nested "()"
    buff = buff:gsub("^([^%(]+%(.*)(function)(.*%))", "%1foo%3")
    buff = buff:gsub("(%.%.%.%s?)([%w]+)", "%1")  -- vararg
    buff = buff:gsub("^(.+=%s?)", "")
    buff = buff:gsub("^(.+)[/|](.+)", "%1_or_%2")   -- change / | -> _or_
    buff = "function " .. buff .. " end\n\n"
  end

  return buff
end

-- Get "Returns"
---@param cont string
---@return string
function getRet(cont)
  local buff, clObj, t

  buff = cont:match("####Returns\n\n?(.-)\n##")
  if not buff then
    error("#### Returns section is missed in: " .. func)
  else
    ---@type table <number, string>
    t = lines(buff)
    for k, v in pairs (t) do
      if k == 1 then
        -- try catch object :-\
        if v:match("[Oo]bject") then  -- 'oObject' word is given in line
          clObj = string.match(v, "`([%w_]+)`")
          dataOut = dataOut .. string.format("---@class %s\nlocal %s = {}\n\n", clObj, clObj)
        end

        t[k] =  v:match("^[%-%*]%s") and
                v:gsub ("^([%-%*]%s?.-)", "---@return any @>\n--- %1") or
                v:match("^`nil`") and
                v:gsub ("^`nil`", "---@return nil") or
                clObj and
                v:gsub ("^(.+)","---@return " .. clObj .. " @%1") or
               (v:match("`true`") and v:match("`false`")) and
                v:gsub ("^(.+)","---@return boolean @%1") or
                v:gsub ("^(.+)", "---@return any @%1")
      else
        t[k] = string.gsub(v, "(.+)", "--- %1")
      end
    end
    buff = table.concat(t, "\n")
    buff = buff:gsub("\n\n", "\n") -- remove blank lines
  end

  return buff
end

-- Get "Parameters"
---@param cont string
---@return string
function getParams(cont)

  ---one parameter parse
  ---@param t table
  ---@param k integer
  ---@param v string
  ---@return table
  local function parsePar(t, k, v)
    if (v:match("^[ \t]+[%-%*]")) then  -- 2-nd level of params
      t[k] =  string.gsub(v, "^(.-)", "--- %1")
        if k == #t then -- the last string is 2-nd level param
          t[k] = t[k] .. "\n"
        end
    else
      t[k] =  string.match(v, "^[%-%*]?[ \t]*`([%(%)%w%s_/,]+)`") and
              string.gsub(v, "^(.-)`([%(%)%w%s_/,]+)`[ :%.]?\r?\n?(.*)", "---@param %2 any @%3") or
              string.gsub(v, "^(.-)", "--- %1")

      -- remove "()" in parameter name - this is a "function" type
      t[k] =  string.gsub(t[k], "^%-%-%-@param (([%w_]+)%(.+%)) any", "---@param %2 function %1")
      -- change function -> foo. 'function' can't be a parameter's name
      t[k] =  string.gsub(t[k], "^%-%-%-@param function (.+)", "---@param foo %1")
      -- change \ or | -> _or_
      t[k] =  string.gsub(t[k], "^%-%-%-@param ([%w_]+)/([%w_]+) (.+)", "---@param %1_or_%2 %3")
      -- vararg
      t[k] =  string.gsub(t[k], "^%-%-%-[\t ]+%-[\t ]+(`%.%.%.[%w]+`)", "---@vararg any %1")

      if k == #t then -- the last string
        t[k] = t[k] .. "\n"
      end
    end

    return t[k]
  end

  local buff = cont:match("####Parameters\n(.-)\n\n?#####?%s?[%w]+\n")
  if not buff then
    error("#### Parameters or Returns section is missed in: " .. func)
  else
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
  end

  return buff
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

-- from http://lua-users.org/wiki/SplitJoin
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

local function main()
--[[ -- all files
  for i = 1, #arg do
    fileParse(arg[i])
  end
--]]

---[[ -- debug mode
  arg = "wifi.md"
  fileParse(arg)
--]]

end

main()
