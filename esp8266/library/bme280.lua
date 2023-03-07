---@meta

--=== bme280 ===

---@class bme280
bme280 = {}

---@class sobj
local sobj = {}

---Creates bme280sensor object and initializes the module. Initialization is mandatory before reading values.\
---Note that there has to be a delay between some tens to hundreds of milliseconds between calling `setup()` and reading measurements.
---@param id number @I2C bus number
---@param address? number @(optional) BME280 sensor address. **1** for BME280_I2C_ADDRESS1 = 0x76, **2** for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@param cold_start? number @(optional) If **0** then the BME280 chip is not initialised.
---@return sobj @BME280 Sensor Object (`nil` if initialization has failed)
---@nodiscard
function bme280.setup(
	id,
	address,
	temp_oss,
	press_oss,
	humi_oss,
	power_mode,
	inactive_duration,
	IIR_filter,
	cold_start
)
end

---Re-initializes the sensor.
---@param id number @I2C bus number
---@param address? number @(optional) BME280 sensor address. **1** for BME280_I2C_ADDRESS1 = 0x76, **2** for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@param cold_start? number @(optional) If **0** then the BME280 chip is not initialised.
---@return sobj @BME280 Sensor Object (`nil` if initialization has failed)
---@nodiscard
function sobj:setup(
	id,
	address,
	temp_oss,
	press_oss,
	humi_oss,
	power_mode,
	inactive_duration,
	IIR_filter,
	cold_start
)
end

---For given air pressure (called QFE in aviation) and sea level air pressure\
---returns the altitude in meters, i.e. altimeter function.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
---@nodiscard
function sobj:altitude(P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param H number @relative humidity in percent (100 means 100%)
---@param T number @temperate in celsius
---@return number dewpoint @dew point in celsisus
---@nodiscard
function sobj:dewpoint(H, T) end

---For given altitude converts the air pressure to sea level\
---air pressure (QNH).
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
---@nodiscard
function sobj:qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure,\
---the air relative humidity and see level pressure when `altitude` is specified.
---@param altitude? number @"(optional) altitude in meters of measurement point.  \n If provided also the air pressure converted to sea level air pressure is returned."
---@return number T @temperature in celsius
---@return number P @air pressure in hectopascals
---@return number H @relative humidity in percent
---@return number QNH @"(optional) QNH air pressure in hectopascals  \n (when `altitude` is specified)"
--- Returns `nil` if the readout is not successful.
---@nodiscard
function sobj:read(altitude) end

---Starts readout (turns the sensor into forced mode). After the readout the sensor turns to sleep mode.\
---Callback function is called with readout results.
---@param callback? function @(optional) if provided it will be invoked after given delay. Callback parameters are:
--- - T - temperature in celsius (number)
--- - P - air pressure in hectopascals (number)
--- - H - relative humidity in percent (number)
---@param delay? number @"(optional) sets sensor to forced mode and calls the callback (if provided)  \n after given number of milliseconds. For **0** the default delay is set to 113ms."
---@param altitude number @in meters of measurement point (QNH is returned when specified)
---@return nil
function sobj:startreadout(callback, delay, altitude) end
