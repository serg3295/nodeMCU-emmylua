---@meta

--=== tsl2561 ===

---@class tsl2561
---@field TSL2561_OK integer
---@field TSL2561_ERROR_I2CINIT integer
---@field TSL2561_ERROR_I2CBUSY integer
---@field TSL2561_ERROR_NOINIT integer
---@field TSL2561_ERROR_LAST integer
---@field ADDRESS_GND integer
---@field ADDRESS_FLOAT integer
---@field ADDRESS_VDD integer
---@field PACKAGE_CS integer
---@field PACKAGE_T_FN_CL integer
---@field INTEGRATIONTIME_13MS integer
---@field INTEGRATIONTIME_101MS integer
---@field INTEGRATIONTIME_402MS integer
---@field GAIN_1X integer
---@field GAIN_16X integer
tsl2561 = {}

---Reads sensor values from the device and returns calculated lux value.
---@return number lux @the calculated illuminance in lux (lx)
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.getlux() end

---Reads the device's 2 sensors and returns their values.
---@return number ch0 @value of the broad spectrum sensor
---@return number ch1 @value of the IR sensor
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.getrawchannels() end

---Initializes the device on pins sdapin & sclpin.
---@param sdapin number @pin number of the device's I²C sda connection
---@param sclpin number @pin number of the device's I²C scl connection
---@param address? number @optional address of the device on the I²C bus
---|'tsl2561.ADDRESS_GND'
---|>'tsl2561.ADDRESS_FLOAT'
---|'tsl2561.ADDRESS_VDD'
---@param pckg? number @optional device's package type (slight difference in lux calculation)
---|'tsl2561.PACKAGE_CS'
---|>'tsl2561.PACKAGE_T_FN_CL'
---@return number
function tsl2561.init(sdapin, sclpin, address, pckg) end

---Sets the integration time and gain settings of the device.
---@param integration number|'tsl2561.INTEGRATIONTIME_13MS'|'tsl2561.INTEGRATIONTIME_101MS'|'tsl2561.INTEGRATIONTIME_402MS' @integration
---@param gain number|'tsl2561.GAIN_1X'|'tsl2561.GAIN_16X' @gain
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.settiming(integration, gain) end
