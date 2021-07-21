--=== i2c ===

---@class i2c
---@field TRANSMITTER integer
---@field RECEIVER integer
---@field SLOW integer
---@field FAST integer
---@field FASTPLUS integer
i2c = {}

---Setup I²C address and read/write mode for the next transfer.
---@param id integer @bus number
---@param device_addr number @7-bit device address.
---@param direction integer|'i2c.TRANSMITTER'|'i2c.RECEIVER' @transmitter | receiver
---@return boolean @`true` if ack received, `false` if no ack received.
function i2c.address(id, device_addr, direction) end

---Read data for variable number of bytes.
---@param id integer @bus number
---@param len number @number of data bytes
---@return string @string of received data
function i2c.read(id, len) end

---Initialize the I²C bus with the selected bus number, pins and speed.
---@param id integer @0~9, bus number
---@param pinSDA integer @1~12, IO index
---@param pinSCL integer @0~12, IO index
---@param speed integer|'i2c.SLOW'|'i2c.FAST'|'i2c.FASTPLUS' @slow | fast | fastplus
---@return integer @speed the selected speed, 0 if bus initialization error.
function i2c.setup(id, pinSDA, pinSCL, speed) end

---Send an I²C start condition.
---@param id integer @bus number
---@return nil
function i2c.start(id) end

---Send an I²C stop condition.
---@param id integer @bus number
---@return nil
function i2c.stop(id) end

---Write data to I²C bus. Data items can be multiple numbers, strings or lua tables.
---@param id integer @bus number
---@param data1 string|table|number @data can be numbers, string or Lua table.
---@return number @number of bytes written
function i2c.write(id, data1, ...) end
