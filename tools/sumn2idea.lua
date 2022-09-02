--
-- Script converts a file from the sumneko format to the IDEA format
-- The Unlicense
--
-- Script:
-- 1. removes the char '?' which denotes an optional parameter from --@param name? type
-- 2. change @param ... Type -> @vararg Type
-- 3. converts
--      @alias name type
--      | 'par1' #comment 1
--      |>'par2' #comment 2
--    to @alias name 'par1'|'par2'
--    a comments and char '>' (it denotes default value) will be lost
-- 4. removes '\' at the end of lines
--
-- Usage:
-- | sumn2idea.lua  # script
-- |
-- |___esp32
-- |       |___library
-- |                 | *.lua  # files for esp32
-- |
-- |___esp8266
--         |___library
--                   | *.lua  # files for esp8266
--
-- If no argument is given, script uses ./esp8266/library directory
-- # lua sumn2idea.lua
--
-- otherwise the argument is directory's name
-- # lua sumn2idea.lua esp32
-- the script will add '/library' itself

local lfs    = require("lfs")
local format = string.format

local lines, readFile, saveFile, getFilenames
local files = {}

local srcDir = arg[1] and ("./"   .. arg[1] .. "/library")  or "./esp8266/library"
local outDir = arg[1] and ("./i_" .. arg[1])  or "./i_esp8266"

local function main()

  if lfs.attributes(srcDir) then
    if lfs.attributes(srcDir).mode == "directory" then
      getFilenames (srcDir, files)
    end
  else
    error(format("Cannot open directory, %s", srcDir))
  end

  -- Create output directory
  if not lfs.attributes(outDir) then
    if not lfs.mkdir(outDir) then
      error(format("Cannot create dir %s", outDir))
    end
  end

  for _, fileName in ipairs(files) do

    local content = readFile(srcDir .. '/' .. fileName)
    content = content : gsub("(%-%-%-@param%s[%w_]+)%?", "%1") -- delete '?'
                      : gsub("(%-%-%-@)param%s%.%.%.","%1vararg")  -- change @param ... -> @vararg
                      : gsub("(%-%-%-@param%s[%w_]+%s[%w_]+%s?|)(.-[@\n])", function (start, values)  -- changes |`text`|`text2` -> |'text'|'text2' in line @param
                            return start .. values:gsub("`", "'")
                          end)
                      : gsub("(%-%-%-|[%s>]?)`(.-)`([%s#\n]?)", "%1'%2'%3")  -- changes ` -> ' in a line that starts with ---|
                      : gsub("(alias%s[%w_]+%s[%a]+\n.-)(%-%-%-[^|])", function (alias, tail)
                            local tbl = lines(alias)  ---@type string[]
                            for k, v in ipairs(tbl) do
                              tbl[k]  = v:gsub("(alias%s[%w_]+%s)[%a]+\n*", "%1"):
                                          gsub("^%-%-%-|[%s>]?('.+')%s?#?.*\n*", "%1|")
                            end
                            local   result = table.concat(tbl)
                                    result = result:sub(1, -2)  -- delete the last '|'
                            return  result .. '\n\n' .. tail
                          end)
                      : gsub("(%-%-%-@alias%s[%w_]+%s)[%a]+|", "%1")  -- delete type of alias
                      : gsub("(%-%-%-.-)%\\r?\n", "%1\n")             -- delete trailing '\'
                      : gsub("(%-%-%-@.-@)\"(.-)\"", function (h, s)  -- delete \n in @"line1 \n line2"
                            return h .. s:gsub("%s%s\\n%s", " ")
                          end)
                      : gsub("%-%-%-@version%s.-%-", "-")
    content = content:sub(11) -- delete ---@meta

    saveFile(outDir .. "/" .. fileName, content)
  end

  print(format("\n\tThe files were successfully written to the directory %s.\n", outDir))
end

--#region Utility functions

--- Get file names from src directory
---@param path string
getFilenames = function (path, tbl)
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      table.insert(tbl, file)
    end
  end
end

-- Load contents of the given file
---@param  fname string file name
---@return string @data from file
readFile = function(fname)
  local file = io.open(fname, "r")
  if not file then error(format("Can't open file %s", fname)) end
  local data = file:read("*a")
  file:close()
  return data
end

-- Save contents to the given file
---@param fname string file name
---@param data  string data for save
---@return nil
saveFile = function(fname, data)
  local file = assert(io.open(fname, "w"))
  file:write(data)
  file:close()
end

-- from http://lua-users.org/wiki/SplitJoin \
---Split string into lines
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

--#endregion Utility functions

main()
