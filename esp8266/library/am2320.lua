---@meta

--=== am2320 ===

---@class am2320
am2320 = {}

---Samples the sensor and returns the relative humidity in % and\
---temperature in celsius, as an integer multiplied with 10.
---@return integer RH @relative humidity percentage multiplied with 10
---@return integer T @temperature in celcius multiplied with 10
---@nodiscard
function am2320.read() end

---Initializes the module.
---@return number model @16 bits number of model
---@return number version @8 bits version number
---@return number serial @32 bits serial number
---@nodiscard
function am2320.setup() end
