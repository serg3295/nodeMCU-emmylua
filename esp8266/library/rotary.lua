--=== rotary ===

---@class rotary
---@field PRESS integer
---@field LONGPRESS integer
---@field RELEASE integer
---@field TURN integer
---@field CLICK integer
---@field DBLCLICK integer
---@field ALL integer
rotary = {}

---Initialize the nodemcu to talk to a rotary encoder switch.
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
---@param pina integer @This is a GPIO number (excluding 0) and connects to pin phase A on the rotary switch.
---@param pinb integer @This is a GPIO number (excluding 0) and connects to pin phase B on the rotary switch.
---@param pinpress? integer @(optional) This is a GPIO number (excluding 0) and connects to the press switch.
---@param longpress_time_ms? integer @(optional) The number of milliseconds (default 500) of press to be considered a long press.
---@param dblclick_time_ms? integer @"(optional) The number of milliseconds (default 500) between a release and a press for  \n the next release to be considered a double click."
---@return any @"Nothing. If the arguments are in error, or the operation cannot be completed, then an error is thrown.  \n For all API calls, if the channel number is out of range, then an error will be thrown."
function rotary.setup(channel, pina, pinb, pinpress, longpress_time_ms, dblclick_time_ms) end

---Sets a callback on specific events.
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
---@param eventtype integer @This defines the type of event being registered.
---|'rotary.PRESS' #= 1 The eventtype for the switch press.
---|'rotary.LONGPRESS' #= 2 The eventtype for a long press.
---|'rotary.RELEASE' #= 4 The eventtype for the switch release.
---|'rotary.TURN' #= 8 The eventtype for the switch rotation.
---|'rotary.CLICK' #= 16 The eventtype for a single click (after release)
---|'rotary.DBLCLICK' #= 32 The eventtype for a double click (after second release)
---|'rotary.ALL' #= 63 All event types.
---@param callback? function @(optional) This is a function that will be invoked when the specified event happens.
---@return any @If an invalid eventtype is supplied, then an error will be thrown.
function rotary.on(channel, eventtype, callback) end

---Gets the current position and press status of the switch
---@param channel integer @"The rotary module supports three switches.  \n The channel is either 0, 1 or 2."
---@return number pos @The current position of the switch.
---@return boolean press @A boolean indicating if the switch is currently pressed.
function rotary.getpos(channel) end

---Releases the resources associated with the rotary switch.
---@param channel integer @"The rotary module supports three switches.  \n The channel is either 0, 1 or 2."
function rotary.close(channel) end
