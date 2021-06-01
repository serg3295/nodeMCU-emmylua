--#region Header
--------------------------------------------------------------------------------
-- A script to generate NodeMCU API autocomplete files in EmmyLua format
-- ver. 0.1.2
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
--
-- Limitations
--  - only handles two levels of class hierarchy (as in node.egc.*)
--------------------------------------------------------------------------------
--#endregion Header

--#region beforeParser

local readFile, saveFile, lines, detab, rmSpaces, makeBold
local getDescr, getSyntax, getParams, getRet, getConst
local addLineBr, escapeMagic, insClassField
local funcName, dataOut
local format = string.format

---@type table <number, string>
local optparam = {}  -- optional parameter names
---@type table<string, string>
local tconst   = {}  -- constants
---@type table<string, string>
local tclass   = {}  -- classes

local function fileParse(argf)

  --- remove ## headers that are not function descriptions
  ---@param str string
  ---@return string
  local function rmHeaders(str)
    local headers2ndlvl = {
    "## gpio%.pulse\n",
    "## node%.LFS\n",
    "## wifi%.eventmon%.reason\n",
    "## spi%.slave%(%)\n",
    "## node%.readvdd33%(%)"
  }

  for _, header2 in pairs(headers2ndlvl) do
    str = str:gsub(header2, "")
  end

  return str
  end

  local fn       = string.sub(argf, 1, -4)
  if type(fn)   ~= "string" then error("Wrong argument") end
  local fileName = fn .. ".md"
  local fout     = fn .. ".lua"
  local mdFile = readFile(fileName)

  -- file preprocessing
  mdFile = mdFile : gsub("###%s*Example", "####Example")
                  : gsub("###%s*See", "####See")
                  : gsub("\n#[ \t]*(%a)", "\n####%1") -- ignore # header
                  : gsub("\n### ([%a]+)", "## %1" )   -- e.g. for tmr:...
                  : gsub("(%b[])%b()",  function (h)  -- remove links
                                          return string.sub(h, 2, -2)
                                        end)
  mdFile = rmHeaders(mdFile) -- remove ambigous headers
  mdFile = mdFile : gsub("(##%s%w-[:%._].-)\n", "%1\n%1\n")   -- duplicate headers
                  : gsub("##%s%w-[:%._].-\n", "", 1)    -- and remove the first header ##
  mdFile = mdFile .. "\n## eof.EOF()\n"   -- end of file

  for i = 1, #tclass do tclass[i] = nil end
  getConst(fn, mdFile)
  dataOut = ""

  local allFunc = {}
  -- split on blocks
  for oneFunc in string.gmatch(mdFile, "(##%s%w-[:%._].-\n.-)##%s%w-[:%._].-\n") do
    oneFunc = oneFunc .. "####end\n" -- end marker
    table.insert(allFunc, oneFunc)
  end

  for i = 1, #allFunc do
    local content     = allFunc[i]

    local description = getDescr(content)
    local syntax, sx2 = getSyntax(content)
    local parameters  = getParams(content)
    local returns     = getRet(content)

    dataOut = dataOut .. description .. parameters .. returns .. syntax

    if sx2 then  -- object model
      dataOut = dataOut .. description .. parameters .. returns .. sx2
    end

  end

  dataOut = insClassField(fn, dataOut)
  saveFile(fout, dataOut)

end
--#endregion beforeParser

-- Get constants
---@param fn string file name
---@param cont string entire file
function getConst(fn, cont)
  for i = 1, #tconst do tconst[i] = nil end
  for prefix, cnst_or_class, cnst in string.gmatch(cont, "`(%a[%w_]+)%.([%w_]+)%.?([%w_]*)`") do
    if prefix == fn then
      if cnst == "" then
        tconst[cnst_or_class] = prefix
      else
        tconst[cnst] = cnst_or_class
      end
    end
  end
end

-- Make text: -@class \n -@field const any \n [parent.]classname = {}
---@param cont string
---@param fn string file name
---@return string   @final file
function insClassField(fn, cont)
  local buff = format("--=== %s ===\n\n", fn)
  buff = buff .. format("---@class %s\n", fn)
  for c, cla in pairs(tconst) do
    if cla == fn then
      buff = buff .. format("---@field %s integer\n", c)
    end
  end
  buff = buff .. fn .. " = {}\n\n"

  for className, parent in pairs(tclass) do
    buff = buff .. format("---@class %s\n", className)
    for c, cla in pairs(tconst) do
      if cla == className then
        buff = buff .. format("---@field %s integer\n", c)
      end
    end
    buff = buff .. format("%s.%s = {}\n\n", parent, className)
  end

  return buff .. cont
end

-- Get "Description"
---@param cont string
---@return string
function getDescr(cont)
  funcName = cont:match("## ([%w_:%.]+%(.-%)).-\n")
  if not funcName then
    funcName = cont:match("##%s?([%w_:%.]+).-\n")
    error(format("\nProbably missing parentheses in the function declaration. ## %s\n", funcName))
  end

  local buff = cont:match("##%s.-\n\n?(.-)\n?#####?%s?[%w]+\n")
  if not buff then
     error(format("\nDescription = nil in: %s\n", funcName))
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
      allop = string.gsub(allop, "%b()", function (args)
                    return  args:gsub( ",", "\1")
                                :gsub("%[", "\2")
                                :gsub("%]", "\3")
                                :gsub("%(", "\4")
                                :gsub("%)", "\5")
                                :gsub("%.", "\6")
                    end)
      allop = string.gsub(allop, ",", "[")
      for op in string.gmatch(allop, "[%[%s]+([%s%w_\1\2\3\4\5\6]+)[%[%]]") do
        optparam[#optparam + 1]  = op :gsub("\1", ",")
                                      :gsub("\2", "[")
                                      :gsub("\3", "]")
                                      :gsub("\4", "(")
                                      :gsub("\5", ")")
                                      :gsub("\6", ".")
                                      :gsub("%s+$", "", 1)
      end
    end
  end

  local buff = cont:match("####%s?Syntax\n?\n(.-)\n?\n####%s?[%w]+\n")
  if not buff then
    error(format("\n#### Syntax section is missed in: %s\n", funcName))
  end

  buff =  buff:find("^```lua\r?\n") and
          buff:match("^```lua\r?\n(.-)\r?\n```") or
          cont:match("####%s?Syntax\n?\n`([^\n]-)`\n?\n")
  if not buff then
    error(format("\n#### Syntax is invalid or '`' is missed in function: %s\n", funcName))
  end

  local firstFunc = buff:match("(.+%))")
  getOptParam(buff)

  buff = buff:gsub("%s?[%[%]]", "")
             :gsub("({.+})", "tbl")
             :gsub("function%(.-%)", function(s)
                s = s:gsub("[%(%.%s,]", "_"):gsub("%)", ""):gsub("__", "_"):gsub("_-$", "")
                if not s:find("function_") then s = s:gsub("function", "func", 1) end
                return s
              end)
             :gsub("^(.-%()(.-)%(.*(%))$", "%1%2%3")  -- remove nested "()"
             :gsub("(%.%.%.%s?)([%w]+)", "%1")  -- vararg
             :gsub("^(.+=%s?)", "")
             :gsub("^(.+)[/|](.+)", "%1_or_%2")   -- change / | -> _or_

  -- multiple functions
  local secondBuff = nil
  local secondFunc = cont:match("####%s?Syntax\n?\n`[^\n]-`\n\n?`([^\n]-)`\n?\n")

  if secondFunc then
    firstFunc   = escapeMagic(firstFunc)
    secondFunc  = escapeMagic(secondFunc)
    local sub1, f1 = string.match(firstFunc, "(.+%.)(.+%))")
    local sub2, f2 = string.match(secondFunc, "(.+:)(.+%))")
    if f1 == f2 then
      secondBuff = "function " .. buff:gsub(sub1, sub2) .. " end\n\n"
    end
  end

  local parent, cl = string.match(buff, "([%w_]+)%.([%w_]+)%.[%w_]")  -- is class?
  if cl then tclass[cl] = parent end  -- fill classes table

  buff = "function " .. buff .. " end\n\n"
  return buff, secondBuff
end

-- Get "Returns"
---@param cont string
---@return string
function getRet(cont)
  local buff, clObj, t

  buff = cont:match("####%s?Returns\n\n?(.-)\n##")
  if not buff then
    buff = "Warning! 'Returns' section was missed in source file\n"
    print(format("\nWarning! #### Returns section is missed in: %s\n", funcName))
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
        dataOut = dataOut .. format("---@class %s\nlocal %s = {}\n\n", clObj, clObj)
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
      opName = escapeMagic(opName)
      if string.find(str, "%-%-%-@param%s" .. opName) then
        str = str : gsub("(%-%-%-@param%s.+@)", "%1(optional) ")
                  : gsub("%-%-%-@param%s" .. (opName), "%1?")
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

    else   -- 1-st level parameter
      t[k] =  string.match(v, "^[%-%*]?%s?`([%(%)%[%]%w%s_/,%.]+)`") and
              string.gsub(v, "^(.-)`([%(%)%[%]%w%s_/,%.]+)`[ :%.]?\r?\n?(.*)", "---@param %2 any @%3") or
              string.gsub(v, "^(.-)", "--- %1")

      t[k] = subOptParam(t[k])  -- optional parameters

      if t[k]:find("^.+[%(%)].+any @") then  --this is a "function" type
        local opFunc = t[k]:match("^%-%-%-@param (.-)%?? any @")
        local oFwoBr = opFunc:gsub("[%[%]]", "")  -- remove brackets []

        t[k] = t[k]:gsub("^.-%(optional%)", "%0 `" .. opFunc .. "`", 1)
        t[k] = t[k]:gsub("^(.-) any @", "%1 function|'" .. oFwoBr .. " end' @")

        t[k] = t[k]:gsub("function%(.-%)", function(s)
                        s = s:gsub("[%(%.%s,]", "_"):gsub("[%)%]%[]", ""):gsub("__", "_"):gsub("_-$", "")
                        if not s:find("function_") then s = s:gsub("function", "func", 1) end
                        return s
                    end, 1)
        t[k] = t[k]:gsub("(%-%-%-@param%s[%w_]-)%s-%(.-%)", "%1")
      end

      -- remove double "optional"
      t[k] = t[k]:gsub("^(.+%(optional%))%s[oO]ptional", "%1", 1)

      -- set 'function' type if parameter's name is 'callback'
      if t[k]:match("%-%-%-@param callback") then
        t[k] = t[k]:gsub("%sany%s@", " function @")
      end

      -- change \ or | -> _or_
      t[k] =  string.gsub(t[k], "^%-%-%-@param ([%w_]+)/([%w_]+) (.+)", "---@param %1_or_%2 %3")

      -- vararg
      t[k] =  string.gsub(t[k], "^%-%-%-@param%s%.%.%.[%w%s_]+.+@([%w]*)", "---@vararg any @%1")
      t[k] =  string.gsub(t[k], "^%-%-%-@param%s[%w%s_]+%.%.%..+@([%w]*)", "---@vararg any @%1")

      if k == #t then -- last string
        t[k] = t[k] .. "\n"
      end

    end

    return t[k]
  end


  local buff = cont:match("####%s?Parameters\n(.-)\n\n?#####?%s?[%w]+\n")
  if not buff then
    error(format("\n#### Parameters or Returns section is missed in: %s\n", funcName))
  end

  buff = addLineBr(buff)
  local t = lines(buff)

  for k, v in pairs (t) do
    if k == 1 then
      t[k] = string.match(v, "^[`Nn][on][ni][el][`\n]*") and "" or parsePar(t, k, v)
    else
      t[k] = parsePar(t, k, v)
    end
  end

  buff = table.concat(t, "\n")
  buff = buff:gsub("\n\n", "\n") -- remove blank lines
  return buff
end

--#region Utility functions

--- Escape magic characters
---@param str string
---@return string
escapeMagic = function (str)
  return string.gsub(str, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
end

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
  local argf = arg[1] or "func.md"
  fileParse(argf)
--]]

end

main()
