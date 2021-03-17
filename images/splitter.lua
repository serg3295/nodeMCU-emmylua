-- splitter
-- lua pattern "--%*%*%*%s([%w_%s%-]-)%s%*%*%*"

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

for _, v in ipairs(files) do

  local fInp = assert(io.open(v, "r"))
  local cont = fInp:read("a")

  cont = cont:gsub("%sTODO", ""):gsub("(%-%-%*%*%*%s.-%s%*%*%*)", "%1\n%1"):gsub("%-%-%*%*%*%s.-%s%*%*%*","",1)
  cont = cont .. "\n--*** EOF ***"

  for fileOut, fileName in string.gmatch(cont, "(%-%-%*%*%*%s([%w_%s%-]-)%s%*%*%*.-)%-%-%*%*%*%s[%w_%s%-]-%s%*%*%*", 1) do
     fileName = string.gsub(fileName, "%s", "_")
    -- print(fileName)
    -- local fo = assert(io.open(string.lower(fileName), "w"))
    local fo = assert(io.open(string.lower(fileName .. ".lua"), "w"))
    fo:write(fileOut)
    fo:close()
  end

  fInp:close()

end
