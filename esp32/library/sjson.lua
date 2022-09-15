---@meta

--=== sjson ===

---@class sjson
---@field NULL userdata
sjson = {}

---@class encoder
local encoder = {}

---@class decoder
local decoder = {}

---@class SjsonCfg1
---@field depth integer
---@field null string

---@class SjsonCfg2
---@field depth integer
---@field null string
---@field metatable table

---This creates an encoder object that can convert a Lua object\
---into a JSON encoded string.
---@param tbl table @data to encode
---@param opts? SjsonCfg1 @an optional table of options. The possible entries are:
--- - **depth** the maximum encoding depth needed to encode the table.\
---The default is 20.
--- - **null** the string value to treat as null.
---@return encoder @A sjson.encoder object.
---@nodiscard
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer @"an optional value for the number of bytes to return.  \n The default is 1024."
---@return string|nil @"A `string` of up to size bytes, or `nil` if the encoding  \n is complete and all data has been returned."
---@nodiscard
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table @data to encode
---@param opts? SjsonCfg1 @an optional table of options. The possible entries are:
--- - **depth** the maximum encoding depth needed to encode the table.\
---The default is 20 which should be enough for nearly all situations.
--- - **null** the string value to treat as null.
---@return string @JSON string
---@nodiscard
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.\
---A metatable can be specified for all the newly created Lua tables. This allows you to handle\
---each value as it is inserted into each table (by implementing the __newindex method).
---@param opts? SjsonCfg2 @an optional table of options. The possible entries are:
--- - **depth** the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** the string value to treat as null.
--- - **metatable** a table to use as the metatable for all the new tables in the returned object.
---@return decoder @A `sjson.decoder` object
---@nodiscard
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string @the next piece of JSON encoded data
---@return any|nil @The constructed Lua object or `nil` if the decode is not yet complete.
---If a parse error occurrs during this decode, then an error is thrown\
---and the parse is aborted. The object cannot be used again.
---@nodiscard
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error\
---if the decode is not yet complete. This can be called\
---multiple times and will return the same object each time.\
---If the decode is not complete, then an error is thrown.
---@nodiscard
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string @JSON string to decode
---@param opts? SjsonCfg2 @an optional table of options. The possible entries are:
--- - **depth** the maximum encoding depth needed to encode the table.\
---The default is 20.
--- - **null** the string value to treat as null.
--- - **metatable** a table to use as the metatable\
---for all the new tables in the returned object.
---@return table @Lua table representation of the JSON data.
---If the string is not valid JSON, then an error is thrown.
---@nodiscard
function sjson.decode(str, opts) end
