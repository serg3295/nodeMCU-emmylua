---@meta

--=== dac ===

---@class dac
dac = {}

---Disables DAC output on the related GPIO.
---@param channel integer|`dac.CHANNEL_1`|`dac.CHANNEL_2` @DAC channel, one of
---@return nil
function dac.disable(channel) end

---Enables DAC output on the related GPIO.
---@param channel integer|`dac.CHANNEL_1`|`dac.CHANNEL_2` @DAC channel, one of
---@return nil
function dac.enable(channel) end

---Sets the output value of the DAC.
---@param channel integer|`dac.CHANNEL_1`|`dac.CHANNEL_2` @DAC channel 1 | 2
---@param value number @output value
---@return nil
function dac.write(channel, value) end
