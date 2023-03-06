---@meta

--=== rfswitch ===

---@class rfswitch
rfswitch = {}

---Transmit data using the radio module.
---@param protocol_id integer @positive integer value, from 1-6
---@param pulse_length integer @length of one pulse in microseconds, usually from 100 to 650
---@param repeat_val integer @repeat value, usually from 1 to 5. This is a synchronous task.
---@param pin integer @I/O index of pin, example 6 is for GPIO12
---@param value integer @positive integer value, this is the primary data which will be sent
---@param length integer @bit length of value, if value length is 3 bytes, then length is 24
---@return nil
function rfswitch.send(protocol_id, pulse_length, repeat_val, pin, value, length) end
