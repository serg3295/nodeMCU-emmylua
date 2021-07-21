---@meta

--=== bme280_c_module ===

---For given air pressure and sea level air pressure returns the altitude\
---in meters as an integer multiplied with 100, i.e. altimeter function.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
function bme280.altitude(P, QNH) end

---Reads the sensor and returns the air pressure in hectopascals as an integer multiplied with 1000\
---or nil when readout is not successful. Current temperature is needed to calculate the air pressure\
---so temperature reading is performed prior reading pressure data.\
---Second returned variable is therefore current air temperature.
---@return number P @air pressure in hectopascals multiplied by 1000
---@return number T @temperature in celsius as an integer multiplied with 100
function bme280.baro() end

---For given temperature and relative humidity returns the dew point\
---in celsius as an integer multiplied with 100.
---@param H number @relative humidity in percent multiplied by 1000.
---@param T number @temperate in celsius multiplied by 100.
---@return number dewpoint @dew point in celsisus
function bme280.dewpoint(H, T) end

---Reads the sensor and returns the air relative humidity in percents as an integer multiplied with 100 or\
---`nil` when readout is not successful. Current temperature is needed to calculate the relative humidity\
---so temperature reading is performed prior reading pressure data.\
---Second returned variable is therefore current temperature.
---@return number H @last relative humidity reading in % times 1000
---@return number T @temperature in celsius as an integer multiplied with 100
function bme280.humi() end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
function bme280.qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity and
---@param altitude? number @"(optional) altitude in meters of measurement point.  \n If provided also the air pressure converted to sea level air pressure is returned."
---@return number T @temperature in celsius as an integer multiplied with 100
---@return number P @air pressure in hectopascals multiplied by 1000
---@return number H @relative humidity in percent multiplied by 1000
---@return number QNH @air pressure in hectopascals multiplied by 1000 converted to sea level
function bme280.read(altitude) end

---Starts readout (turns the sensor into forced mode).\
---After the readout the sensor turns to sleep mode.
---@param delay number @"sets sensor to forced mode and calls the callback (if provided)  \n after given number of milliseconds."
---@param callback function @"if provided it will be invoked after given delay.  \n The sensor reading should be finalized by then so."
---@return nil
function bme280.startreadout(delay, callback) end

---@deprecated
---Warning, deprecated API! bme280. It will be removed soon. Use bme280math and bme280 Lua module instead.\
---Initializes the module. Initialization is mandatory before reading values.
---@param temp_oss? number @(optional) Controls oversampling of temperature data.
---@param press_oss? number @(optional) Controls oversampling of pressure data.
---@param humi_oss? number @(optional) Controls oversampling of humidity data.
---@param power_mode? number @(optional) Controls the sensor mode of the device.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter.
---@return integer|nil @`nil` if initialization has failed (no sensor connected?), **2** if sensor is BME280, **1** if sensor is BMP280
function bme280.setup(temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---Reads the sensor and returns the temperature in celsius\
---as an integer multiplied with 100.
---@return integer T @"temperature in celsius as an integer multiplied with 100  \n or nil when readout is not successful"
---@return integer t_fine @"temperature measure used in pressure and  \n humidity compensation formulas (generally no need to use this value)"
function bme280.temp() end
