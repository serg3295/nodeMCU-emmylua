---@meta

--=== wiegand ===

---@class wiegand
wiegand = {}

---@class wiegandobj
local wiegandobj = {}

---Creates a dynamic wiegand object that receives a callback when data is received.
---@param pinD0 number @This is a GPIO number (excluding 0) and connects to the D0 data line
---@param pinD1 number @This is a GPIO number (excluding 0) and connects to the D1 data line
---@param callback function @This is a function that will invoked when a full card or keypress is read.
---@return wiegandobj wiegandObject @"If the arguments are in error, or the operation cannot be completed,  \n then an error is thrown."
---@nodiscard
function wiegand.create(pinD0, pinD1, callback) end

---Releases the resources\
---associated with the card reader.
---@return nil
function wiegandobj:close() end
