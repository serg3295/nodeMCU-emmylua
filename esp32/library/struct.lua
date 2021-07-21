---@meta

--=== struct ===

---@class struct
struct = {}

---Returns a string containing the values `d1, d2`, etc. packed\
---according to the format string `fmt`.
---@param fmt string @The format string
---@param d1 any @The first data item to be packed
---@param d2 any @The second data item to be packed etc.
---@return string @The packed string.
function struct.pack(fmt, d1, d2, ...) end

---Returns the values packed in string s according to the format string `fmt`.\
---An optional i marks where in s to start reading (default is 1). After the read\
---values, this function also returns the index in `s` where it stopped reading,\
---which is also where you should start to read the rest of the string.
---@param fmt string @The format string
---@param s string @The string holding the data to be unpacked
---@param offset? integer @(optional) The position to start in the string (default is 1)
---@return any @All the unpacked data.
function struct.unpack(fmt, s, offset) end

---Returns the size of a string formatted according to the format string `fmt`.\
---The format string should contain neither the option `s` nor the option `c0`.
---@param fmt string @The format string
---@return integer @"The size of the string that would be output in a pack operation  \n with this format string."
function struct.size(fmt) end
