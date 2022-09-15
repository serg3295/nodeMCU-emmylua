---@meta

--=== bme680 ===

---@class bme680
bme680 = {}

---For given air pressure and sea level air pressure returns\
---the altitude in meters as an integer multiplied with 100.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
---@nodiscard
function bme680.altitude(P, QNH) end

---For given temperature and relative humidity returns\
---the dew point in Celsius as an integer multiplied with 100.
---@param H number @relative humidity in percent multiplied by 1000.
---@param T number @temperate in Celsius multiplied by 100.
---@return number dewpoint @dew point in Celsius
---@nodiscard
function bme680.dewpoint(H, T) end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number @measured pressure
---@param altitude number @altitude in meters of measurement point
---@return number P @sea level pressure
---@nodiscard
function bme680.qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure,\
---the air relative humidity
---@param altitude? number @(optional) altitude in meters of measurement point.
---@return number T @temperature in Celsius as an integer multiplied with 100
---@return number P @air pressure in hectopascals multiplied by 100
---@return number H @relative humidity in percent multiplied by 1000
---@return number G @gas resistance
---@return number QNH @air pressure in hectopascals multiplied by 100 converted to sea level
---Any of these variables is `nil` if the readout of given measure was not successful.
---@nodiscard
function bme680.read(altitude) end

---Starts readout (turns the sensor into forced mode).
---@param delay number @"sets sensor to forced mode and calls the callback (if provided)  \n after given number of milliseconds."
---@param callback function @"if provided it will be invoked after given delay.  \n The sensor reading should be finalized by then so."
---@return nil
function bme680.startreadout(delay, callback) end

---Initializes module. Initialization is mandatory before read values.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 2x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 1x.
---@param heater_temp? number @(optional) heater temp
---@param heater_duration? number @(optional) heater duration
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 31.
---@param cold_start? number @(optional) If 0 then the bme680 chip is not initialised.
---@return nil @`nil` if initialization has failed (no sensor connected?)
function bme680.setup(temp_oss, press_oss, humi_oss, heater_temp, heater_duration, IIR_filter, cold_start) end
