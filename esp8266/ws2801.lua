--=== ws2801 ===

---@class ws2801
ws2801 = {}

---Initializes the module and sets the pin configuration.
---@param pin_clk integer @pin for the clock. Supported are GPIO 0, 2, 4, 5.
---@param pin_data integer @pin for the data. Supported are GPIO 0, 2, 4, 5.
---@return nil
function ws2801.init(pin_clk, pin_data) end

---Sends data of RGB Data in 24 bits to WS2801.
---@param data any @"payload to be sent to one or more WS2801.  \n Payload type could be:"
---- `string` representing bytes to send
---  It should be composed from an RGB triplet per element.
---   - `R1` the first pixel's red channel value (0-255)
---   - `G1` the first pixel's green channel value (0-255)
---   - `B1` the first pixel's blue channel value (0-255) \
---    ... You can connect a lot of WS2801...
---   - `R2`, `G2`, `B2` are the next WS2801's Red, Green, and Blue channel values
---- a `pixbuf` object containing the bytes to send. The pixbuf's type is not checked!
---@return nil
function ws2801.write(data) end
