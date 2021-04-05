--
-- Script converts a file from the sumneko format to the IDEA format
--
-- removes the char '?' which denotes an optional parameter from --@param name? type
-- converts
--  @alias name type
--- | 'par1' #comment 1
--- |>'par2' #comment 2
-- to @alias name 'par1'|'par2'
-- comments and char '>' (it denotes default value) will be lost
--

local lines

local files = {
  "nodemcu_emmy1_32.lua",
  "nodemcu_emmy2_32.lua",
}
--[[
local files = {
  "nodemcu_emmy1.lua",
  "nodemcu_emmy2.lua",
  "nodemcu_emmy3.lua",
  "nodemcu_emmy4.lua",
}
]]

local function main()
  for _, fileName in ipairs(files) do

    local fInp    = assert(io.open(fileName, "r"))
    local content = fInp:read("*a")  ---@type string
    fInp:close()

    content = content:gsub("(%-%-%-@param%s[%w_]+)%?", "%1"): -- delete '?'
                      gsub("(alias%s[%w_]+%s[%a]+\n.-)(%-%-%-[^|])", function (alias, tail)
                          ---@type table<integer, string>
                          local tbl = lines(alias)
                          for k, v in ipairs(tbl) do
                            tbl[k]  = v:gsub("(alias%s[%w_]+%s)[%a]+\n*", "%1"):
                                        gsub("^%-%-%-|[%s>]?('.+')%s?#?.*\n*", "%1|")
                          end
                          local   result = table.concat(tbl)
                                  result = result:sub(1, -2)  -- delete the last '|'
                          return  result .. '\n\n' .. tail
                        end):
                      gsub("(%-%-%-@alias%s[%w_]+%s)[%a]+|", "%1")  -- delete type of alias

    local fo  = assert(io.open(("i_" .. fileName), "w"))
    fo:write(content)
    fo:close()
  end
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

main()
