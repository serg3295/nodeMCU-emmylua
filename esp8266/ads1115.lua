--=== ads1115 ===

---@class ads1115
---@field ADDR_GND integer
---@field ADDR_VDD integer
---@field ADDR_SDA integer
---@field ADDR_SCL integer
---@field GAIN_6_144V integer
---@field GAIN_4_096V integer
---@field GAIN_2_048V integer
---@field GAIN_1_024V integer
---@field GAIN_0_512V integer
---@field GAIN_0_256V integer
---@field DR_8SPS integer
---@field DR_16SPS integer
---@field DR_32SPS integer
---@field DR_64SPS integer
---@field DR_128SPS integer
---@field DR_250SPS integer
---@field DR_475SPS integer
---@field DR_490SPS integer
---@field DR_860SPS integer
---@field DR_920SPS integer
---@field DR_1600SPS integer
---@field DR_2400SPS integer
---@field DR_3300SPS integer
---@field SINGLE_0 integer
---@field SINGLE_1 integer
---@field SINGLE_2 integer
---@field SINGLE_3 integer
---@field DIFF_0_1 integer
---@field DIFF_0_3 integer
---@field DIFF_1_3 integer
---@field DIFF_2_3 integer
---@field SINGLE_SHOT integer
---@field CONTINUOUS integer
---@field CMODE_TRAD integer
---@field CMODE_WINDOW integer
---@field CONV_RDY_1 integer
---@field CONV_RDY_2 integer
---@field CONV_RDY_4 integer
---@field COMP_1CONV integer
---@field COMP_2CONV integer
---@field COMP_4CONV integer
ads1115 = {}

---@class ads1x15
local ads1x15 = {}

---Registers ADS1115 (ADS1113, ADS1114) device.
---@param I2C_ID number @always 0
---@param I2C_ADDR number|'ads1115.ADDR_GND'|'ads1115.ADDR_VDD'|'ads1115.ADDR_SDA'|'ads1115.ADDR_SCL' @I²C address of a device
---@return ads1x15 obj @Registered device object
function ads1115.ads1115(I2C_ID, I2C_ADDR) end

---Registers ADS1015 (ADS1013, ADS1014) device.
---@param I2C_ID number @always 0
---@param I2C_ADDR number|'ads1115.ADDR_GND'|'ads1115.ADDR_VDD'|'ads1115.ADDR_SDA'|'ads1115.ADDR_SCL' @I²C address of a device
---@return ads1x15 obj @Registered device object
function ads1115.ads1015(I2C_ID, I2C_ADDR) end

---Reset all devices connected to I²C interface.
---@return nil
function ads1115.reset() end

---Gets the result stored in the register of a previously\
---issued conversion, e.g. in continuous mode or with\
---conversion ready interrupt.
---@return number volt @voltage in mV
---@return number volt_dec @voltage decimal in uV
---@return number adc @raw adc register value
---@return number|nil sign @sign of the result
function ads1x15:read() end

---Configuration settings for the ADC.
---@param GAIN number @Programmable gain amplifier
---|'ads1115.GAIN_6_144V' #2/3x Gain
---|'ads1115.GAIN_4_096V' #1x Gain
---|'ads1115.GAIN_2_048V' #2x Gain
---|'ads1115.GAIN_1_024V' #4x Gain
---|'ads1115.GAIN_0_512V' #8x Gain
---|'ads1115.GAIN_0_256V' #16x Gain
---@param SAMPLES number @Data rate in samples per second
---|'ads1115.DR_8SPS' #ADS1115 only
---|'ads1115.DR_16SPS' #ADS1115 only
---|'ads1115.DR_32SPS' #ADS1115 only
---|'ads1115.DR_64SPS' #ADS1115 only
---|'ads1115.DR_128SPS'
---|'ads1115.DR_250SPS'
---|'ads1115.DR_475SPS' #ADS1115 only
---|'ads1115.DR_490SPS' #ADS1015 only
---|'ads1115.DR_860SPS' #ADS1115 only
---|'ads1115.DR_920SPS' #ADS1015 only
---|'ads1115.DR_1600SPS' #ADS1015 only
---|'ads1115.DR_2400SPS' #ADS1015 only
---|'ads1115.DR_3300SPS' #ADS1015 only
---@param CHANNEL number @Input multiplexer for single-ended or differential measurement
---|'ads1115.SINGLE_0' #channel 0 to GND
---|'ads1115.SINGLE_1' #channel 1 to GND
---|'ads1115.SINGLE_2' #channel 2 to GND
---|'ads1115.SINGLE_3' #channel 3 to GND
---|'ads1115.DIFF_0_1' #channel 0 to 1
---|'ads1115.DIFF_0_3' #channel 0 to 3
---|'ads1115.DIFF_1_3' #channel 1 to 3
---|'ads1115.DIFF_2_3' #channel 2 to 3
---@param MODE number @Device operating mode
---|'ads1115.SINGLE_SHOT' #single-shot mode
---|'ads1115.CONTINUOUS' #continuous mode
---@param CONVERSION_RDY? number|'ads1115.CONV_RDY_1'|'ads1115.CONV_RDY_2'|'ads1115.CONV_RDY_4' @(optional) Number of conversions after conversion ready asserts
---@param COMPARATOR? number|'ads1115.COMP_1CONV'|'ads1115.COMP_2CONV'|'ads1115.COMP_4CONV' @(optional) Number of conversions after comparator asserts
---@param THRESHOLD_LOW number @>
--- - **0** - **+ GAIN_MAX** in mV for single-ended inputs
--- - **- GAIN_MAX** - **+ GAIN_MAX** in mV for differential inputs
---@param THRESHOLD_HI number @>
--- - **0** - **+ GAIN_MAX** in mV for single-ended inputs
--- - **- GAIN_MAX** - **+ GAIN_MAX** in mV for differential inputs
---@param COMP_MODE? number @(optional) Comparator mode
---|'ads1115.CMODE_TRAD' #traditional comparator mode (with hysteresis)
---|'ads1115.CMODE_WINDOW' #window comparator mode
---@return nil
function ads1x15:setting(GAIN, SAMPLES, CHANNEL, MODE, CONVERSION_RDY, COMPARATOR, THRESHOLD_LOW, THRESHOLD_HI,COMP_MODE) end

---Starts the ADC reading for single-shot mode and after the conversion is done it will invoke\
---an optional callback function in which the ADC conversion result can be obtained.
---@param callback function|'function(volt, volt_dec, adc, sign) end' @function which will be invoked after the adc conversion is done
---@return nil
function ads1x15:startread(callback) end
