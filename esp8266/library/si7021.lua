---@meta

--=== si7021 ===

---@class si7021
---@field RH12_TEMP14 integer
---@field RH08_TEMP12 integer
---@field RH10_TEMP13 integer
---@field RH11_TEMP11 integer
---@field HEATER_ENABLE integer
---@field HEATER_DISABLE integer
si7021 = {}

---Read the internal firmware revision of the Si7021 sensor.
---@return number @"*0xFF*: Firmware version 1.0;  \n *0x20*: Firmware version 2.0"
function si7021.firmware() end

---`si7021.read()`
---@return number hum @humidity
---@return number temp @temperature
---@return number hum_dec @humidity decimal
---@return number temp_dec @temperature decimal
function si7021.read() end

---Read the individualized 64-bit electronic\
---serial number of the Si7021 sensor.
---@return number @32-bit serial number part a
---@return number @"32-bit serial number part b,  \n upper byte contains the device identification"
function si7021.serial() end

---@alias si7021_a1 number
---|>'si7021.RH12_TEMP14' #Relative Humidity 12 bit - Temperature 14 bit
---|'si7021.RH08_TEMP12' #Relative Humidity 8 bit - Temperature 12 bit
---|'si7021.RH10_TEMP13' #Relative Humidity 10 bit - Temperature 13 bit
---|'si7021.RH11_TEMP11' #Relative Humidity 11 bit - Temperature 11 bit

---@alias si7021_a2 integer
---|'si7021.HEATER_ENABLE' #On-chip Heater Enable
---|>'si7021.HEATER_DISABLE' #On-chip Heater Disable

---Settings for the sensors configuration register.
---@param RESOLUTION si7021_a1 @resolution
---@param HEATER? si7021_a2 @(optional)
---@param HEATER_SETTING? number @(optional) 0x00 - 0x0F 3.09 mA - 94.20 mA
---@return number resolution @0 - 4
---@return integer vdds @0 VDD OK (1.9V - 3.6V) | 1 VDD LOW (1.8V - 1.9V)
---@return integer heater @0 Disabled| 1 Enabled
---@return integer heater_setting @0 - 15
function si7021.setting(RESOLUTION, HEATER, HEATER_SETTING) end

---Initializes the device on fixed\
---I²C device address (0x40).
---@return nil
function si7021.setup() end
