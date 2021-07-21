--=== hdc1000 ===

---@class HDC1000
HDC1000 = {}

---Function to setup the HDC1000 sensor.
---@param drdyn number @DRDYn pin number.
---@return nil
function HDC1000.setup(drdyn) end

---Function to configure various options of HDC1000 sensor.
---@param address number @I²C sensor address. Default value is 0x40.
---@param resolution number @Temperature and humidity sensor resolution.
---@param heater number @Heater setting. 0x20 to enable and 0x00 to disable.
---@return nil
function HDC1000.config(address, resolution, heater) end

---Reads the temperature from HDC1000 sensor.
---@return number Temperature @in Celsius degrees.
function HDC1000.getTemp() end

---Reads the humidity value from HDC1000 sensor.
---@return number Humidity @in percents.
function HDC1000.getHumi() end

---Function that checks if voltage of sensor power supply\
---is bellow or above 2.8V.
---@return boolean @"`true` if battery voltage is bellow 2.8V,  \n `false` otherwise."
function HDC1000.batteryDead() end
