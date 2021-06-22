--=== bmp085 ===

---@class bmp085
bmp085 = {}

---Initializes the module.
---@return nil
function bmp085.setup() end

---Samples the sensor and returns the temperature\
---in celsius as an integer multiplied with 10.
---@return integer T @temperature multiplied with 10 (integer)
function bmp085.temperature() end

---Samples the sensor and returns the pressure in pascal as an integer.
---@param oversampling_setting integer @that can be 0, 1, 2 or 3
---@return integer P @pressure in pascals
function bmp085.pressure(oversampling_setting) end

---Samples the sensor and returns the raw pressure in internal units.
---@param oversampling_setting integer @that can be 0, 1, 2 or 3
---@return integer P @raw pressure sampling value (integer)
function bmp085.pressure_raw(oversampling_setting) end
