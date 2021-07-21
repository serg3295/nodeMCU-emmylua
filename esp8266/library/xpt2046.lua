--=== xpt2046 ===

---@class xpt2046
xpt2046 = {}

---Initiates the XPT2046 module to read touch values from the display.
---@param cs_pin integer @GPIO pin for cs
---@param irq_pin integer @GPIO pin for irq
---@param height integer @display height in pixel
---@param width integer @display width in pixel
---@return nil
function xpt2046.init(cs_pin, irq_pin, height, width) end

---Sets the calibration of the display.
---@param x1 integer @raw x value at top left
---@param y1 integer @raw y value at top left
---@param x2 integer @raw x value at bottom right
---@param y2 integer @raw y value at bottom right
---@return nil
function xpt2046.setCalibration(x1, y1, x2, y2) end

---Checks if the touch panel is touched.
---@return boolean touch @"`true` if the display is touched,  \n else `false`"
function xpt2046.isTouched() end

---Returns the position the display is touched\
---using the calibration values and given\
---width and height.
---@return integer posX
---@return integer posY
function xpt2046.getPosition() end

---reads the position three times and averages\
---the two positions with the least distance.
---@return integer posX
---@return integer posY
function xpt2046.getPositionAvg() end

---Reads the raw value from the display.
---@return integer rawX @position X as a raw value.
---@return integer rawY @position Y as a raw value.
function xpt2046.getRaw() end
