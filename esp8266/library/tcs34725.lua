--=== tcs34725 ===

---@class tcs34725
tcs34725 = {}

---Initialization via this call is mandatory before values can be read.
---@return integer @"**0** if setup has failed (no sensor connected?),  \n **1** if sensor is TCS34725"
function tcs34725.setup() end

---Enables the sensor. Can be used to wake up after a disable.
---@param foo function @called when the sensor has finished initialising.
---@return nil
function tcs34725.enable(foo) end

---Disables the sensor.\
---Enables a low-power sleep mode.
---@return nil
function tcs34725.disable() end

---Reads the clear, red, green and blue\
---values from the sensor.
---@return integer clear @in uint16_t.
---@return integer red @in uint16_t.
---@return integer green @in uint16_t.
---@return integer blue @in uint16_t.
function tcs34725.raw() end

---Sets the gain of the sensor.\
---Must be called after the sensor is enabled.
---@param gain number @gain
---@return nil
function tcs34725.setGain(gain) end

---Sets the integration time of the sensor.\
---Must be called after the sensor is enabled.
---@param time number @time
---@return nil
function tcs34725.setIntegrationTime(time) end
