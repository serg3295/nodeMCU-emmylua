---@meta

--=== ds18b20 ===

---@class ds18b20
---@field K string @Kelvin
---@field C string @Celsius
---@field F string @Fahrenheit
---@field sens table @A table with sensors present on the bus. It includes its address (8 bytes) and information whether the sensor is parasite-powered (9-th byte, 0 or 1).
---@field temp table @A table with readout values (also passed as a parameter to callback function). It is addressed by sensor addresses.
ds18b20 = {}

---Enables debug output of the module.
---@return nil
function ds18b20:enable_debug() end

---Scans the bus for DS18B20 sensors (optional), starts a readout (conversion) for all sensors and calls a callback function\
---when all temperatures are available.
---@param callback function @"that receives all results when all conversions finish. The callback function has one parameter -  \n an array addressed by sensor addresses and a value of the temperature (string for integer version)."
---@param pin integer @pin of the one-wire bus. If nil, GPIO0 (3) is used.
---@param unit string @"unit can be Celsius ("C" or `ds18b20.C`), Kelvin ("K" or `ds18b20.K`) or Fahrenheit ("F" or `ds18b20.F`).  \n If not specified (`nil`) latest used unit is used."
---@param force_search number @"if not `nil` a bus search for devices is performed before readout. If `nil` the existing list of sensors  \n in memory is used. If the bus has not been searched yet the search performed as well."
---@param save_search number @"if not `nil` found sensors are saved to the file `ds18b20_save.lc`. When `read_temp` is called, list of sensors  \n in memory is empty and file `ds18b20_save.lc` is present then sensor addresses are loaded from file - useful when running from  \n batteries & deepsleep - immediate readout is performed (no bus scan)."
---@return nil
function ds18b20:read_temp(callback, pin, unit, force_search, save_search) end
