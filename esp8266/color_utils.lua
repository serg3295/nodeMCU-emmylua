--=== color_utils ===

---@class color_utils
color_utils = {}

---Convert HSV color to GRB color.
---@param hue number @value, between 0 and 360
---@param saturation number @value, between 0 and 255
---@param value number @value, between 0 and 255
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
function color_utils.hsv2grb(hue, saturation, value) end

---Convert HSV color to GRB color and explicitly return a white value.
---@param hue number @value, between 0 and 360
---@param saturation number @value, between 0 and 255
---@param value number @value, between 0 and 255
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
---@return number white
function color_utils.hsv2grbw(hue, saturation, value) end

---Convert GRB color to HSV color.
---@param green number @is the green value, between 0 and 255
---@param red number @is the red value, between 0 and 255
---@param blue number @is the blue value, between 0 and 255
---@return number hue @as values between 0 and 360, respective 0 and 255
---@return number saturation
---@return number value
function color_utils.grb2hsv(green, red, blue) end

---makes use of the HSV color space and calculates colors based on\
---the color circle.
---@param angle number @is the angle on the color circle, between 0 and 359
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
function color_utils.colorWheel(angle) end
