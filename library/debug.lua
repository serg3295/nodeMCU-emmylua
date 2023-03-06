---@meta

--=== debug ===

---@class debug
debug = {}

---Returns a sorted array of the strings returned from\
---the `lua_getstrings` function.
---@param type string|"RAM"|"ROM"
---@return table
---@nodiscard
function debug.getstrings(type) end
