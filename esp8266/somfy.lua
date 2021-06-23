--=== somfy ===

---@class somfy
---@field UP integer
---@field DOWN integer
---@field PROG integer
---@field STOP integer
somfy = {}

---Builds an frame defined by Somfy protocol and sends it to the RF transmitter.
---@param pin integer @GPIO pin the RF transmitter is connected to.
---@param remote_address number @"address of the remote control.  \n The device to be controlled is programmed with the addresses of the remote controls it should listen to."
---@param command integer|'somfy.SOMFY_UP'|'somfy.SOMFY_DOWN'|'somfy.SOMFY_PROG'|'somfy.SOMFY_STOP' @somfy command
---@param rolling_code number @The rolling code is increased every time a button is pressed.
---@param repeat_count integer @how many times the command is repeated
---@param callback function @"a function to be called after the command is transmitted.  \n Allows chaining commands to set the blinds to a defined position."
---@return nil
function somfy.sendcommand(pin, remote_address, command, rolling_code, repeat_count, callback) end

---Using RF receiver listens to Somfy commands and triggers a callback when command is identified.
---@param pin integer @GPIO pin the RF receiver is connected to.
---@param callback function|'function(address, command, rc, frame) end' @"`function(address, command, rc, frame)` a function called when a Somfy  \n command is identified. Use `nil` to stop listening."
--- - **address** - of the remote controller sending the command
--- - **command** - sent by the remote controller. A number between *0* and *0xf*.\
---Can be somfy.SOMFY_UP, somfy.SOMFY_DOWN, somfy.SOMFY_PROG, somfy.SOMFY_STOP.
--- - **rc** - rolling code
--- - **frame** - String of 10 characters with the full captured data frame.
---@return nil
function somfy.listen(pin, callback) end
