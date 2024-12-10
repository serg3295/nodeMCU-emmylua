---@meta

--=== console ===

---@class console
console = {
	INTERACTIVE = 1, -- automatically pass console data to the Lua VM for execution.
	NONINTERACTIVE = 0, -- disables the automatic passing of console data to the Lua VM. The data only goes to the registered "data" callback, if any.
}

---Used to register or deregister a callback function to handle console events.
---@param method @ One of `"data"` | `"error"`
---|"data" #for bytes received on the console
---|"error" #if an error condition is encountered on the console
---@param number_or_end_char? integer|string @(optional) Only for event `data`.
---  - if pass in a number *n*, the callback will called when *n* chars are received.
---  - if *n*=0, will receive every char in buffer.
---  - if pass in a one char string "c", the callback will called when "c" is encounterd, or max *n*=255 received.
---@param callback? @(optional) callback function.
---|`function(data) end`
---|`function(err) end`
---To unregister the callback, specify `nil` as the function.
---@return nil
function console.on(method, number_or_end_char, callback) end

---Controls the interactivity of the console.
---@param mode @One of
---|>`console.INTERACTIVE` #automatically pass console data to the Lua VM for execution. This is the default mode.
---|`console.NONINTERACTIVE` #disables the automatic passing of console data to the Lua VM. The data only goes to the registered "data" callback, if any.
---@return nil
function console.mode(mode) end

---Provides ability to write raw, unformatted data to the console.
---@param str_or_num string|number Either
---@param ... string|number
--- - A string to write to the console. May contain binary data.
--- - A number representing the character code to write the console.
---
---Multiple parameters may be given, and they will be written in sequence.
---@return nil
function console.write(str_or_num, ...) end
