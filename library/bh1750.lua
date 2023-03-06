---@meta

--=== bh1750 ===

---@class bh1750
bh1750 = {}

---Initializes the module and sets up I²C with hardcoded\
---device address.
---@param sda number @SDA pin number.
---@param scl number @SCL pin number.
---@return nil
function bh1750.init(sda, scl) end

---Reads lux value from the sensor.
---@return number Lux @value.
function bh1750.read() end

---Function used to return last read\
---lux value.
---@return number @Last known lux value.
---@nodiscard
function bh1750.getlux() end
