---@meta

--=== sjson ===

---@class sjson
---@field NULL userdata
sjson = {}

---@class encoder
local encoder = {}

---@class decoder
local decoder = {}

---This creates an encoder object that can convert a Lua object\
---into a JSON encoded string.
---@param tbl table @data to encode
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table.\
---The default is 20.
--- - **null** - the string value to treat as null.
---@return encoder @A `sjson.encoder` object.
---@nodiscard
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer @"an optional value for the number of  \n bytes to return. The default is 1024."
---@return string|nil @"A string of up to `size` bytes, or `nil` if  \n the encoding is complete and all data has been returned."
---@nodiscard
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table @data to encode
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table.\
---The default is 20.
--- - **null** - the string value to treat as null.
---@return string @JSON string
---@nodiscard
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** - the string value to treat as null.
--- - **metatable** - a table to use as the metatable for all the new tables in the returned object.
---@return decoder @A `sjson.decoder` object
---@nodiscard
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string @the next piece of JSON encoded data
---@return any|nil obj @"The constructed Lua object or `nil`  \n if the decode is not yet complete."
---@nodiscard
function decoder:write(str) end

---This gets the decoded Lua object, or raises\
---an error if the decode is not yet complete.
---@nodiscard
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string @JSON string to decode
---@param opts? table @n optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table.\
---The default is 20.
--- - **null** - the string value to treat as null.
--- - **metatable** - a table to use as the metatable\
---for all the new tables in the returned object.
---@return table @Lua table representation of the JSON data
---@nodiscard
function sjson.decode(str, opts) end
