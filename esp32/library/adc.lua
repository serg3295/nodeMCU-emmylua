---@meta

--=== adc ===

---@class adc
---@field ADC1 integer
---@field ATTEN_0db integer
---@field ATTEN_2_5db integer
---@field ATTEN_6db integer
---@field ATTEN_11db integer
adc = {}

---The configuration is in effect for all channels of ADC1.
---@param adc_number integer|`adc.ADC1` @Only adc.ADC1 now
---@param bits integer|`9`|`10`|`11`|`12` @One of 9/10/11/12.
---@return nil
function adc.setwidth(adc_number, bits) end

---Configuration ADC1 capture attenuation of channels.
---@param adc_number integer|`adc.ADC1` @Only adc.ADC1 now
---@param channel integer @When using adc.ADC1: 0 to 7
---|`0` #GPIO36
---|`1` #GPIO37
---|`2` #GPIO38
---|`3` #GPIO39
---|`4` #GPIO32
---|`5` #GPIO33
---|`6` #GPIO34
---|`7` #GPIO35
---@param atten number @One of following constants
---|`adc.ATTEN_0db` #Vinp will be reduced to about 1/1 (1.1V when VDD_A=3.3V)
---|`adc.ATTEN_2_5db` #Vinp will be reduced to about 1/1.34 (1.5V when VDD_A=3.3V)
---|`adc.ATTEN_6db` #Vinp will be reduced to about 1/2 (2.2V when VDD_A=3.3V)
---|`adc.ATTEN_11db` #Vinp will be reduced to about 1/3.6 (3.9V when VDD_A=3.3V, maximum voltage is limited by VDD_A)
---@return nil
function adc.setup(adc_number, channel, atten) end

---Samples the ADC. You should to call `setwidth()` before `read()`.
---@param adc_number integer|`adc.ADC1` @Only adc.ADC1 now
---@param channel integer|`0`|`1`|`2`|`3`|`4`|`5`|`6`|`7` @0 to 7 for adc.ADC1
---@return number @the sampled value
---@nodiscard
function adc.read(adc_number, channel) end

---Read Hall sensor (GPIO36, GPIO39).\
---We recommend using 12-bits width on ADC1.
---@return number @the sampled value
---@nodiscard
function adc.read_hall_sensor() end
