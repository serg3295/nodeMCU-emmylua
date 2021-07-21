---@meta

--=== adc ===

---@class adc
---@field INIT_ADC integer
---@field INIT_VDD33 integer
adc = {}

---Checks and if necessary reconfigures the ADC `mode` setting in\
---the ESP init data block.
---@param mode_value integer|'adc.INIT_ADC'|'adc.INIT_VDD33' @mode
---@return boolean @"`true` if the function had to change the mode,  \n `false` if the mode was already configured."
function adc.force_init_mode(mode_value) end

---Samples the ADC.
---@param channel integer|'0' @always 0 on the ESP8266
---@return number @the sampled value
function adc.read(channel) end

---Reads the system voltage.
---@return number @system voltage in millivolts
function adc.readvdd33() end
