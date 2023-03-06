---@meta

--=== bme280_math ===

---@class bme280_math
bme280_math = {}

---For given air pressure and sea level air pressure returns the altitude in meters
---@param self? userdata|table @"(optional) self userdata or table structure so that the function can be  \n directly called as object method, parameter is ignored in the calculation"
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
---@nodiscard
function bme280_math.altitude(self, P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param self? userdata|table @"(optional) self userdata or table structure so that the function can be  \n directly called as object method, parameter is ignored in the calculation"
---@param H number @relative humidity in percent (100 means 100%)
---@param T number @temperate in celsius
---@return number dewpoint @dew point in celsisus
---@nodiscard
function bme280_math.dewpoint(self, H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param self? userdata|table @"(optional) self userdata or table structure so that the function can be  \n directly called as object method, parameter is ignored in the calculation"
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
---@nodiscard
function bme280_math.qfe2qnh(self, P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity and\
---see level air pressure when **altitude** is specified.
---@param bme280sensor userdata @BME280 sensor user data returned by `bme280_math.setup()`
---@param registers string @string of 8 bytes (chars) registers read from BME280_REGISTER_PRESS
---@param altitude? number @"(optional) in meters of measurement point. If provided also the air pressure  \n converted to sea level air pressure is returned."
---@return number T @temperature in celsius
---@return number P @air pressure in hectopascals
---@return number H @relative humidity in percent
---@return number QNH @(optional) air pressure in hectopascals. Returns `nil` if the conversion is not successful.
---@nodiscard
function bme280_math.read(bme280sensor, registers, altitude) end

---Initializes the module. Initialization is mandatory before reading values.
---@param registers string @String of configuration registers read from the BME280 sensor. It consists of 6 bytes (chars) of BME280_REGISTER_DIG_T, 18 bytes (chars) BME280_REGISTER_DIG_P and optional (not present for BMP280 sensor) 8 bytes (chars) of BME280_REGISTER_DIG_H1 (1 byte) and BME280_REGISTER_DIG_H2 (7 bytes)
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@return userdata|nil @bme280sensor user data (`nil` if initialization has failed)
---@return table @config 3 (2 for BME280) field table with configuration parameters to be written to registers
--- - BME280_REGISTER_CONFIG,
--- - BME280_REGISTER_CONTROL_HUM,
--- - BME280_REGISTER_CONTROL consecutively
function bme280_math.setup(registers, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end
