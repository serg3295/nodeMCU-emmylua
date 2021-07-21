--=== apa102 ===

---@class apa102
apa102 = {}

---Send ABGR data in 8 bits to a APA102 chain.
---@param data_pin integer @any GPIO pin 0, 1, 2, ...
---@param clock_pin integer @any GPIO pin 0, 1, 2, ...
---@param data any @"payload to be sent to one or more APA102 LEDs. It may be a `pixbuf`  \n with four channels or a string, composed from a ABGR quadruplet per element:"
--- - A1 - the first pixel's Intensity channel (0-31)
--- - B1 - the first pixel's Blue channel (0-255)
--- - G1 - the first pixel's Green channel (0-255)
--- - R1 - the first pixel's Red channel (0-255) ... You can connect a lot of APA102 ...\
---A2, B2, G2, R2 are the next APA102s Intensity,\
---Blue, Green and Red channel parameters
---@return nil
function apa102.write(data_pin, clock_pin, data) end
