---@meta

--=== rotary ===

---@class rotary
---@field PRESS integer = 1 The eventtype for the switch press.
---@field LONGPRESS integer = 2 The eventtype for a long press.
---@field RELEASE integer = 4 The eventtype for the switch release.
---@field TURN integer = 8 The eventtype for the switch rotation.
---@field CLICK integer = 16 The eventtype for a single click (after release)
---@field DBLCLICK integer = 32 The eventtype for a double click (after second release)
---@field ALL integer = 63 All event types.
rotary = {}

---@class rotaryObj
local rotaryObj = {}

---Initialize the nodemcu to talk to a rotary encoder switch.
---@param pina integer @This is a GPIO number and connects to pin phase A on the rotary switch.
---@param pinb integer @This is a GPIO number and connects to pin phase B on the rotary switch.
---@param pinpress? integer @(optional) This is a GPIO number and connects to the press switch.
---@param longpress_time_ms? integer @(optional) The number of milliseconds (default 500) of press to be considered a long press.
---@param dblclick_time_ms? integer @(optional) The number of milliseconds (default 500) between a release and a press for the next release to be considered a double click.
---@return rotaryObj @A switch object that can be used for the operations below.
function rotary.setup(pina, pinb, pinpress, longpress_time_ms, dblclick_time_ms) end

---Sets a callback on specific events.
---@param eventtype integer @This defines the type of event being registered. This is the logical or of one or more of `PRESS`, `LONGPRESS`, `RELEASE`, `TURN`, `CLICK` or `DBLCLICK`.`ALL` can be used as shorthand for all event types.
---|`rotary.PRESS` #= 1 The eventtype for the switch press.
---|`rotary.LONGPRESS` #= 2 The eventtype for a long press.
---|`rotary.RELEASE` #= 4 The eventtype for the switch release.
---|`rotary.TURN` #= 8 The eventtype for the switch rotation.
---|`rotary.CLICK` #= 16 The eventtype for a single click (after release)
---|`rotary.DBLCLICK` #= 32 The eventtype for a double click (after second release)
---|`rotary.ALL` #= 63 All event types.
---@param callback? fun(eventtype: integer, position: integer, when: integer): nil @(optional) This is a function that will be invoked when the specified event happens.
---If the callback is None or omitted, then the registration is cancelled.\
---The callback will be invoked with three arguments when the event happens. The first argument is the eventtype, the second is the current position of the rotary switch, and the third is the time when the event happened.\
---The position is tracked and is represented as a signed 32-bit integer. Increasing values indicate clockwise motion. The time is the number of microseconds represented in a 32-bit integer. Note that this wraps every hour or so.
---@return nil
function rotaryObj:on(eventtype, callback) end

---Gets the current position and press status of the switch
---@return integer pos @The current position of the switch.
---@return boolean press @A boolean indicating if the switch is currently pressed.
function rotaryObj:getpos() end

---Releases the resources associated with the rotary switch.
function rotaryObj:close() end
