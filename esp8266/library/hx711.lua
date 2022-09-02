---@meta

--=== hx711 ===

---@class hx711
hx711 = {}

---Initialize io pins for hx711 clock and data.
---@param clk integer @pin the hx711 clock signal is connected to
---@param data integer @pin the hx711 data signal is connected to
---@return nil
function hx711.init(clk, data) end

---@alias hx711_a1 integer
---|`0` #channel A, gain 128
---|`1` #channel B, gain 32
---|`2` #channel A, gain 64

---Read digital loadcell ADC value.
---@param mode hx711_a1 @"ADC mode. This parameter specifies which input and  \n the gain to apply to that input."
---@return number @24 bit signed ADC value extended to the machine int size
function hx711.read(mode) end

---Starts to read multiple samples from the ADC.
---@param mode hx711_a1 @ADC mode
---@param samples number @The number of samples before the callback is invoked.
---@param callback function @The callback is invoked with three arguments
--- - s - A string which contains samples packed 24 bit values.\
---This can be unpacked with the struct module (using the "i3" format).
--- - t - The time in microseconds of the reception of the last sample in the buffer.
--- - d - The number of samples dropped before the start of this buffer\
---(after the end of the previous buffer).
---@return nil
function hx711.start(mode, samples, callback) end

---Stops a previously started set of reads.\
---Any data in buffers is lost.\
---No more callbacks will be invoked.
---@return nil
function hx711.stop() end
