--
-- Script for converting a file from the sumneko format to the IDEA format
--
-- removes the char '?' which denotes an optional parameter from --@param name? type
-- TODO: convert
---| 'par1' #comment 1
---|>'par2' #comment 2
-- to @param name type|'par1'|'par2'
-- comments and char '>' (default value) will be lost

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

for _, fileName in ipairs(files) do

  local fInp    = assert(io.open(fileName, "r"))
  local content = fInp:read("*a")
  fInp:close()

  content   = content:gsub("(%-%-%-@param%s[%w_]+)%?", "%1") -- removes '?'

  local fo  = assert(io.open(("i_" .. fileName), "w"))
  fo:write(content)
  fo:close()

end
