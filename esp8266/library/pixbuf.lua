---@meta

--=== pixbuf ===

---@class pixbuf
---@field FADE_IN integer
---@field FADE_OUT integer
---@field SHIFT_LOGICAL integer
---@field SHIFT_CIRCULAR integer
pixbuf = {}

---@class pixbuffer
local pixbuffer = {}

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer @length of the led strip (in pixels)
---@param numberOfChannels integer @the channel count (bytes per pixel)
---@return pixbuffer @pixbuf.buffer object
function pixbuf.newBuffer(numberOfLeds, numberOfChannels) end

---Return the value at the given position, in native\
---strip color order.
---@param index integer @position in the buffer (1 for first led)
---@return number @(color)
function pixbuffer:get(index) end

---Set the value at the given position, in native strip color order.
---@param index integer @position in the buffer (1 for the first led)
---@param color number|any @payload of the color. Payload could be:
--- - **number, number, ...** passing as many colors as required by the array type
--- - **table** should contain one value per color required by the array type
--- - **string** with a natural multiple of the colors required by the array type.
---**string** inputs may be used to set multiple consecutive pixels!
---@return nil
function pixbuffer:set(index, color) end

---Return the size of the buffer in number of LEDs.
---@return integer
function pixbuffer:size() end

---Return the buffer's channel count.
---@return integer
function pixbuffer:channels() end

---Fill the buffer with the given color.\
---The number of given bytes must match\
---the channel count of the buffer.
---@param color any @bytes for each channel
---@return any @The buffer
function pixbuffer:fill(color) end

---Returns the contents of the buffer (the pixel values) as a string.\
---This can then be saved to a file or sent over a network and\
---may be fed back to` pixbuf.buffer:set()`.
---@return string @A string containing the pixel values.
function pixbuffer:dump() end

---Inserts a string (or a pixbuf) into another buffer with an offset.\
---The buffer must be of the same type or an error will be thrown.
---@param source string|any @"The pixel values to be set into the buffer.  \n This is either a string or a pixbuf."
---@param offset? integer @"(optional) the offset where the source is to be placed  \n  in the buffer. Default is 1. Negative values can be used."
---@return nil
function pixbuffer:replace(source, offset) end

---This is a general method that loads data into a buffer that is a linear combination of data from other buffers.
---@param factor1 number @"This is the factor that the contents of buffer1 are multiplied by.  \n This factor is scaled by a factor of 256. Thus factor1 value of 256 is a factor of 1.0."
---@param buffer1 any @This is the source buffer. It must be of the same shape as the destination buffer.
---@return nil
function pixbuffer:mix(factor1, buffer1, ...) end

---Like pixbuf.buffer:mix() but treats the first channel\
---as a scaling, 5-bit intensity value.\
---The buffers must all have four channels.
function pixbuffer:mix4I5() end

---Computes the total energy requirement for the buffer.
---@return integer @An integer which is the sum of all the pixel values.
function pixbuffer:power() end

---Like `pixbuf.buffer:power()` but treats the first\
---channel as a scaling intensity value.
function pixbuffer:powerI() end

---Fade in or out. Defaults to out. Multiply or divide each byte of each led with/by\
---the given value.
---@param value number @value by which to divide or multiply each byte
---@param direction? integer|`pixbuf.FADE_IN`|`pixbuf.FADE_OUT` @(optional) Defaults to pixbuf.FADE_OUT
---@return nil
function pixbuffer:fade(value, direction) end

---Like `pixbuf.buffer:fade()` but treats the first\
---channel as a scaling intensity value.
function pixbuffer:fadeI() end

---Shift the content of (a piece of) the buffer in positive or negative direction. This allows simple animation effects.\
---A slice of the buffer can be specified by using the standard start and end offset Lua notation.\
---Negative values count backwards from the end of the buffer.
---@param value number @"number of pixels by which to rotate the buffer.  \n Positive values rotate forwards, negative values backwards."
---@param mode? integer @(optional) is the shift mode to use.
---|>`pixbuf.SHIFT_LOGICAL` #the freed pixels are set to 0 (off).
---|`pixbuf.SHIFT_CIRCULAR` #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end
---@param i? integer @"(optional) is the first offset in the buffer to be affected.  \n Negative values are permitted and count backwards from the end. Default is 1."
---@param j? integer @"(optional) is the last offset in the buffer to be affected.  \n Negative values are permitted and count backwards from the end. Default is -1."
---@return nil
function pixbuffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub.\
---The indexes are in leds and all the same rules apply.
---@param i integer @"This is the start of the extracted data.  \n Negative values can be used."
---@param j? integer @"(optional) This is the end of the extracted data.  \n Negative values can be used. The default is -1."
---@return pixbuffer @A buffer containing the extracted piece.
function pixbuffer:sub(i, j) end

---Map a function across each pixel of one, or zip a function along two, pixbuf(s), storing into the buffer on which it is called.
---@param f function @"This is the mapping function; it is applied for each pixel to all channels of buffer1 and all channels of `buffer2`,  \n if given. It must return a value for each channel of the output buffer, `buffer0`."
---@param buffer1? any @(optional) The first source buffer. Defaults to `buffer0`.
---@param start1? integer @"(optional) This is the start of the mapped range of `buffer1`. Negative values can be used and will be interpreted as  \n before the end of `buffer1`. The default is 1."
---@param end1? integer @(optional) This is the end of the mapped range. Negative values can be used. The default is -1 (i.e., the end of `buffer1`).
---@param buffer2? any @(optional) is a second buffer, for zip operations
---@param start2? integer @(optional) This is the start of the mapped range within `buffer2`. Negative values can be used and will be interpreted as before the end of `buffer2`. The default is 1.
---@return pixbuffer buffer0 @buffer0
function pixbuffer:map(f, buffer1, start1, end1, buffer2, start2) end
