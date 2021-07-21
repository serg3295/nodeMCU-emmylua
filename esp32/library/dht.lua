--=== dht ===

---@class dht
dht = {}

---Read DHT11 humidity temperature combo sensor.
---@param pin integer @IO index
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal (always 0)
---@return number humi_dec @humidity decimal (always 0)
function dht.read11(pin) end

---Read DHT21/22/33/43 and AM2301/2302/2303\
---humidity temperature combo sensors.
---@param pin integer @IO index
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal (always 0)
---@return number humi_dec @humidity decimal (always 0)
function dht.read2x(pin) end
