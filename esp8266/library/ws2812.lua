---@meta

--=== ws2812 ===

---@class ws2812
---@field MODE_SINGLE integer
---@field MODE_DUAL integer
---@field FADE_IN integer
---@field FADE_OUT integer
---@field SHIFT_LOGICAL integer
---@field SHIFT_CIRCULAR integer
ws2812 = {}

---@class buffer
local buffer = {}

---Initialize UART1 and GPIO2, should be called once and before write().\
---Initialize UART0 (TXD0) too if `ws2812.MODE_DUAL` is set.
---@param mode? integer @(optional) single | dual
---|>'ws2812.MODE_SINGLE'
---|'ws2812.MODE_DUAL' #you will be able to handle two strips in parallel
---@return nil
function ws2812.init(mode) end

---Send data to one or two led strip using its native format, which is generally\
---Green, Red, Blue for RGB strips and Green, Red, Blue, White for RGBW strips.
---@param data1 string|nil @payload to be sent to one or more WS2812 like leds through GPIO2
---@param data2? string|nil @"(optional) payload to be sent to one or more WS2812 like leds  \n through TXD0 (`ws2812.MODE_DUAL mode` required) Payload type could be:"
--- - `nil` any @nothing is done
--- - `string` any @representing bytes to send
--- - a `pixbuf` object containing the bytes to send. The pixbuf's type is not checked!
---@return nil
function ws2812.write(data1, data2) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer @length of the led strip
---@param bytesPerLed integer @3 for RGB strips and 4 for RGBW strips
---@return buffer ws2812.buffer
function ws2812.newBuffer(numberOfLeds, bytesPerLed) end

---Return the value at the given position
---@param index integer @position in the buffer (1 for first led)
---@return number @(color)
function buffer:get(index) end

---Set the value at the given position
---@param index integer @position in the buffer (1 for the first led)
---@param color number|any @payload of the color. Payload could be:
--- - **number, number, ...** you should pass as many arguments as bytesPerLed
--- - **table** should contains bytesPerLed numbers
--- - **string** should contains bytesPerLed bytes
---@return nil
function buffer:set(index, color) end

---Return the size of the buffer in number of leds
---@return integer
function buffer:size() end

---Fill the buffer with the given color. The number of given bytes\
---must match the number of bytesPerLed of the buffer
---@param color any @"bytes of the color,  \n you should pass as many arguments as bytesPerLed"
---@return nil
function buffer:fill(color) end

---Returns the contents of the buffer\
---(the pixel values) as a string.
---@return string @A string containing the pixel values.
function buffer:dump() end

---Inserts a string (or a buffer) into another buffer with an offset.
---@param source string|any @"the pixel values to be set into the buffer.  \n This is either a string or a buffer."
---@param offset? integer @"(optional) the offset where the source is to be placed  \n in the buffer. Default is 1. Negative values can be used."
---@return nil
function buffer:replace(source, offset) end

---This is a general method that loads data into a buffer\
---that is a linear combination of data from other buffers.
---@param factor1 number @"This is the factor that the contents of buffer1 are multiplied by.  \n This factor is scaled by a factor of 256. Thus factor1 value of 256 is a factor of 1.0."
---@param buffer1 any @"This is the source buffer.  \n It must be of the same shape as the destination buffer."
---@return nil
function buffer:mix(factor1, buffer1, ...) end

---Computes the total energy requirement for the buffer.
---@return integer @An integer which is the sum of all the pixel values.
function buffer:power() end

---Fade in or out. Defaults to out
---@param value number @value by which to divide or multiply each byte
---@param direction? integer|'ws2812.FADE_IN'|'ws2812.FADE_OUT' @(optional) Defaults to ws2812.FADE_OUT
---@return nil
function buffer:fade(value, direction) end

---Shift the content of (a piece of) the buffer in positive or negative direction.
---@param value number @"number of pixels by which to rotate the buffer.  \n Positive values rotate forwards, negative values backwards."
---@param mode? integer @(optional) is the shift mode to use.
---|>'ws2812.SHIFT_LOGICAL' #the freed pixels are set to 0 (off).
---|'ws2812.SHIFT_CIRCULAR' #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end
---@param i? integer @"(optional) is the first offset in the buffer to be affected.  \n Negative values are permitted and count backwards from the end. Default is 1."
---@param j? integer @"(optional) is the last offset in the buffer to be affected.  \n Negative values are permitted and count backwards from the end. Default is -1."
---@return nil
function buffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub.
---@param i integer @"This is the start of the extracted data.  \n Negative values can be used."
---@param j? integer @"(optional) this is the end of the extracted data.  \n Negative values can be used. The default is -1."
---@return buffer buff @A buffer containing the extracted piece.
function buffer:sub(i, j) end
