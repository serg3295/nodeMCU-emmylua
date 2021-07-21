---@meta

--=== dht ===

---@class dht
dht = {}

---Read all kinds of DHT sensors, including DHT11, 21,\
---DHT22, 33, 44 humidity temperature combo sensor.\
---Returns correct readout except for DHT12 and negative\
---temperatures by DHT11. Use `dht.read12()` and\
---`dht.read11()` instead. It is to use model specific\
---read function anyway.
---@param pin number @pin number of DHT sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.read(pin) end

---Read DHT11 humidity temperature combo sensor.
---@param pin number @pin number of DHT11 sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.read11(pin) end

---Read DHT12 humidity temperature combo sensor.
---@param pin number @pin number of DHT12 sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.read12(pin) end

---Read all kinds of DHT sensors, except DHT11 and DHT12.\
---Differs from `dht.read()` only by waiting only sufficient 1 ms\
---for sensor wake-up while `dht.read()` waits universal 18 ms.
---@param pin number @pin number of DHT11 sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.readxx(pin) end
