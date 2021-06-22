--=== wifi_monitor ===

---@class monitor
wifi.monitor = {}

---wifi.packet object. This object provides access to the raw packet data and also many methods to extract data from the packet in a simple way.
---@class packet
local packet = {}

---This registers a callback function to be called whenever a management frame is received.
---@param filter_parameters? number @"(optional) This is a byte offset (1 based) into the underlying data  \n structure, a value to match against, and an optional mask to use for matching."
---@param mgmt_frame_callback function @"is a function which is invoked with a single argument which is  \n a *wifi.packet* object which has many methods and attributes."
function wifi.monitor.start(filter_parameters, mgmt_frame_callback) end

---This disables the monitor mode\
---and returns to normal operation.
function wifi.monitor.stop() end

---This sets the channel number to monitor.
---@param channel number @sets the channel number in the range 1 to 15.
function wifi.monitor.channel(channel) end

---This is like the string.byte method, except that\
---it gives access to the bytes of the radio header.
---@param n number @"the byte number (1 based)  \n to get from the radio header portion of the packet"
---@return integer @"0-255 as the value of the byte nothing  \n if the offset is not within the radio header."
function packet:radio_byte(n) end

---This is like the string.byte method, except that\
---it gives access to the bytes of the received frame.
---@param n number @"the byte number (1 based)  \n to get from the received frame."
---@return integer @"0-255 as the value of the byte nothing  \n if the offset is not within the received frame."
function packet:frame_byte(n) end

---This is like the string.sub method, except that it gives access to \
---the bytes of the radio header.
---@param start any @"Same rules as for string.sub except that it  \n operates on the radio header."
---@param end_sub any
---@return string @A string according to the `string.sub` rules.
function packet:radio_sub(start, end_sub) end

---This is like the string.sub method, except that it gives access to\
---the bytes of the received frame.
---@param start any @"Same rules as for string.sub except that it  \n operates on the received frame."
---@param end_sub any
---@return string @A string according to the `string.sub` rules.
function packet:frame_sub(start, end_sub) end

---This is like the string.sub method, except that it gives access to the bytes of the radio header.\
---It also converts them into hex efficiently.
---@param start any @Same rules as for string.sub except that it operates on the radio header
---@param end_sub any
---@param seperator? string @is an optional sting which is placed between the individual hex pairs returned.
---@return string @A string according to the `string.sub` rules, converted into hex with possible inserted spacers.
function packet:radio_subhex(start, end_sub, seperator) end

---This is like the string.sub method, except that it gives access to the bytes of the received frame.
---@param start any @Same rules as for string.sub except that it operates on the received frame.
---@param end_sub any
---@param seperator? string @is an optional sting which is placed between the individual hex pairs returned.
---@return string @A string according to the `string.sub` rules, converted into hex with possible inserted spacers.
function packet:frame_subhex(start, end_sub, seperator) end

---This returns a table of the information elements\
---from the management frame. The table keys values\
---are the information element numbers (0 - 255).
---@return table @A table with all the information elements in it.
function packet:ie_table() end
