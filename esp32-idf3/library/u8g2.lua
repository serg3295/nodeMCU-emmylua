---@meta

--=== u8g2 ===

---@class u8g2
---I²C Display Drivers
---@field ld7032_i2c_60x32 function
---@field sh1106_i2c_128x64_vcomh0 function
---@field sh1106_i2c_128x64_noname function
---@field sh1107_i2c_64x128 function
---@field sh1107_i2c_128x128 function
---@field sh1107_i2c_seeed_96x96 function
---@field sh1108_i2c_160x160 function
---@field sh1122_i2c_256x64 function
---@field ssd0323_i2c_os128064 function
---@field ssd1305_i2c_128x32_noname function
---@field ssd1306_i2c_64x48_er function
---@field ssd1306_i2c_96x16_er function
---@field ssd1306_i2c_128x32_univision function
---@field ssd1306_i2c_128x64_alt0 function
---@field ssd1306_i2c_128x64_noname function
---@field ssd1306_i2c_128x64_vcomh0 function
---@field ssd1309_i2c_128x64_noname0 function
---@field ssd1309_i2c_128x64_noname2 function
---@field ssd1318_i2c_128x96 function
---@field ssd1318_i2c_128x96_xcp function
---@field ssd1325_i2c_nhd_128x64 function
---@field ssd1326_i2c_er_256x32 function
---@field ssd1327_i2c_ea_w128128 function
---@field ssd1327_i2c_midas_128x128 function
---@field ssd1327_i2c_seeed_96x96 function
---@field st7567_i2c_64x32 function
---@field st7588_i2c_jlx12864 function
---@field st75256_i2c_jlx256128 function
---@field st75256_i2c_jlx256160 function
---@field st75256_i2c_jlx240160 function
---@field st75256_i2c_jlx25664 function
---@field st75256_i2c_jlx172104 function
---@field uc1601_i2c_128x32 function
---@field uc1604_i2c_jlx19264 function
---@field uc1608_i2c_240x128 function
---@field uc1608_i2c_erc24064 function
---@field uc1610_i2c_ea_dogxl160 function
---@field uc1611_i2c_ea_dogm240 function
---@field uc1611_i2c_ea_dogxl240 function
---@field uc1611_i2c_ew50850 function
---SPI Display Drivers
---@field hx1230_96x68 function
---@field il3820_v2_296x128 function
---@field ist3020_erc19264 function
---@field lc7981_160x80 function
---@field lc7981_160x160 function
---@field lc7981_240x64 function
---@field lc7981_240x128 function
---@field ld7032_60x32 function
---@field ls013b7dh03_128x128 function
---@field max7219_32x8 function
---@field nt7534_tg12864r function
---@field pcd8544_84x48 function
---@field pcf8812_96x65 function
---@field sed1520_122x32 function
---@field sh1107_64x128 function
---@field sh1106_128x64_noname function
---@field sh1106_128x64_vcomh0 function
---@field sh1107_128x128 function
---@field sh1108_160x160 function
---@field sh1107_seeed_96x96 function
---@field sh1122_256x64 function
---@field ssd0323_os128064 function
---@field ssd1305_128x32_noname function
---@field ssd1306_64x48_er function
---@field ssd1306_96x16_er function
---@field ssd1306_128x32_univision function
---@field ssd1306_128x64_alt0 function
---@field ssd1306_128x64_noname function
---@field ssd1306_128x64_vcomh0 function
---@field ssd1309_128x64_noname0 function
---@field ssd1309_128x64_noname2 function
---@field ssd1318_128x96 function
---@field ssd1318_128x96_xcp function
---@field ssd1322_nhd_128x64 function
---@field ssd1322_nhd_256x64 function
---@field ssd1325_nhd_128x64 function
---@field ssd1326_er_256x32 function
---@field ssd1327_ea_w128128 function
---@field ssd1327_midas_128x128 function
---@field ssd1327_seeed_96x96 function
---@field ssd1329_128x96_noname function
---@field ssd1606_172x72 function
---@field ssd1607_200x200 function
---@field ssd1607_gd_200x200 function
---@field ssd1607_ws_200x200 function
---@field st7565_64128n function
---@field st7565_ea_dogm132 function
---@field st7565_ea_dogm128 function
---@field st7565_erc12864 function
---@field st7565_erc12864_alt function
---@field st7565_lm6059 function
---@field st7565_nhd_c12832 function
---@field st7565_nhd_c12864 function
---@field st7565_zolen_128x64 function
---@field st7567_enh_dg128064i function
---@field st7567_64x32 function
---@field st7567_jlx12864 function
---@field st7567_pi_132x64 function
---@field st7586s_erc240160 function
---@field st7586s_s028hn118a function
---@field st7588_jlx12864 function
---@field st7920_s_192x32 function
---@field st7920_s_128x64 function
---@field st75256_jlx25664 function
---@field st75256_jlx172104 function
---@field st75256_jlx240160 function
---@field st75256_jlx256128 function
---@field st75256_jlx256160 function
---@field t6963_128x64 function
---@field t6963_160x80 function
---@field t6963_240x64 function
---@field t6963_240x128 function
---@field t6963_256x64 function
---@field uc1601_128x32 function
---@field uc1604_jlx19264 function
---@field uc1608_240x128 function
---@field uc1608_erc24064 function
---@field uc1610_ea_dogxl160 function
---@field uc1611_ea_dogm240 function
---@field uc1611_ea_dogxl240 function
---@field uc1611_ew50850 function
---@field uc1701_ea_dogs102 function
---@field uc1701_mini12864 function
---fonts
---@field font_6x10_tf number
---@field font_unifont_t_symbols number
---constants
---@field DRAW_UPPER_RIGHT number
---@field DRAW_UPPER_LEFT number
---@field DRAW_LOWER_RIGHT number
---@field DRAW_LOWER_LEFT number
---@field DRAW_ALL number
---@field MIRROR number
---@field R0 number
---@field R1 number
---@field R2 number
---@field R3 number
u8g2 = {}

---@class u8g2DispObj
local u8g2DispObj = {}

---Initialize a display via I²C.
---@param id integer @i2c interface id, see i2c module
---@param address integer @I²C slave address of display (unshifted)
---@param cb_fn? function @optional callback function, see Framebuffer callback
---@return u8g2DispObj @u8g2 display object
---@nodiscard
function u8g2.u8g2DisplayTypeI2C(id, address, cb_fn) end

---Initialize a display via Hardware SPI.
---@param bus integer @SPI master bus
---@param cs integer @GPIO pin for CS
---@param dc integer @GPIO pin for DC
---@param res? integer @(optional) GPIO pin for RES, none if omitted
---@param cb_fn? function @"(optional) callback function, `function(rle_line?)`.  \n **rle_line** is a string containing a run-length encoded framebuffer line, or `nil` to indicate start of frame."
---@return u8g2DispObj @u8g2 display object
---@nodiscard
function u8g2.u8g2DisplayTypeSPI(bus, cs, dc, res, cb_fn) end

---Clears all pixel in the memory frame buffer.
function u8g2DispObj:clearBuffer() end

---Draw a box (filled frame), starting at `x/y` position (upper left edge).\
---The box has width `w` and height `h`.
---@param x integer @X-position of upper left edge.
---@param y integer @Y-position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function u8g2DispObj:drawBox(x, y, w, h) end

---Draw a circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer @Position of the center of the circle.
---@param y0 integer @Position of the center of the circle.
---@param rad integer @Defines the size of the circle: Radus = rad.
---@param opt? integer|`u8g2.DRAW_ALL`|`u8g2.DRAW_UPPER_RIGHT`|`u8g2.DRAW_UPPER_LEFT`|`u8g2.DRAW_LOWER_LEFT`|`u8g2.DRAW_LOWER_RIGHT` @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawCircle(x0, y0, rad, opt) end

---Draw a filled circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer @Position of the center of the disc.
---@param y0 integer @Position of the center of the disc.
---@param rad integer @Defines the size of the circle: Radus = rad.
---@param opt? integer|`u8g2.DRAW_ALL`|`u8g2.DRAW_UPPER_RIGHT`|`u8g2.DRAW_UPPER_LEFT`|`u8g2.DRAW_LOWER_LEFT`|`u8g2.DRAW_LOWER_RIGHT` @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawDisc(x0, y0, rad, opt) end

---Draw an ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer @Position of the center of the filled circle.
---@param y0 integer @Position of the center of the filled circle.
---@param rx integer @Defines the size of the ellipse.
---@param ry integer @Defines the size of the ellipse.
---@param opt integer|`u8g2.DRAW_ALL`|`u8g2.DRAW_UPPER_RIGHT`|`u8g2.DRAW_UPPER_LEFT`|`u8g2.DRAW_LOWER_LEFT`|`u8g2.DRAW_LOWER_RIGHT` @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawEllipse(x0, y0, rx, ry, opt) end

---Draw a filled ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer @Position of the center of the filled circle.
---@param y0 integer @Position of the center of the filled circle.
---@param rx integer @Defines the size of the ellipse.
---@param ry integer @Defines the size of the ellipse.
---@param opt integer|`u8g2.DRAW_ALL`|`u8g2.DRAW_UPPER_RIGHT`|`u8g2.DRAW_UPPER_LEFT`|`u8g2.DRAW_LOWER_LEFT`|`u8g2.DRAW_LOWER_RIGHT` @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawFilledEllipse(x0, y0, rx, ry, opt) end

---Draw a frame (empty box), starting at `x/y` position (upper left edge).\
---The box has width `w` and height `h`.
---@param x integer @X-position of upper left edge.
---@param y integer @Y-position of upper left edge.
---@param w integer @Width of the frame.
---@param h integer @Height of the frame.
function u8g2DispObj:drawFrame(x, y, w, h) end

---Draw a single character. The character is placed at the specified pixel posion `x` and `y`.
---@param x integer @Position of the character on the display.
---@param y integer @Position of the character on the display.
---@param encoding integer @Unicode value of the character.
function u8g2DispObj:drawGlyph(x, y, encoding) end

---Draw a horizontal line, starting at `x/y` position (left edge).\
---The width (length) of the line is `w` pixel.
---@param x integer @X-position
---@param y integer @Y-position
---@param w integer @Length of the horizontal line.
function u8g2DispObj:drawHLine(x, y, w) end

---Draw a line between two points.
---@param x0 integer @X-position of the first point.
---@param y0 integer @Y-position of the first point.
---@param x1 integer @X-position of the second point.
---@param y1 integer @Y-position of the second point.
function u8g2DispObj:drawLine(x0, y0, x1, y1) end

---Draw a pixel at the specified `x/y` position.\
---Position (0,0) is at the upper left corner of the display.
---@param x integer @Position of pixel.
---@param y integer @Position of pixel.
function u8g2DispObj:drawPixel(x, y) end

---Draw a box with round edges, starting at `x/y` position (upper left edge).\
---The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries.\
---Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
---@param r integer @Radius for the four edges.
function u8g2DispObj:drawRBox(x, y, w, h, r) end

---Draw a frame with round edges, starting at `x/y` position (upper left edge).\
---The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries.\
---Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the frame.
---@param h integer @Height of the frame.
---@param r integer @Radius for the four edges.
function u8g2DispObj:drawRFrame(x, y, w, h, r) end

---Draw a string. The first character is placed at position `x` and `y`.
---@param x integer @Position of the first character on the display.
---@param y integer @Position of the first character on the display.
---@param s string @String, which will be printed on the screen.
---@return number @The width of the string.
function u8g2DispObj:drawStr(x, y, s) end

---Draw a triangle (filled polygon).
---@param x0 integer @Point 0 of the triangle.
---@param y0 integer @Point 0 of the triangle.
---@param x1 integer @Point 1 of the triangle.
---@param y1 integer @Point 1 of the triangle.
---@param x2 integer @Point 2 of the triangle.
---@param y2 integer @Point 2 of the triangle.
function u8g2DispObj:drawTriangle(x0, y0, x1, y1, x2, y2) end

---Draw a string which is encoded as UTF-8.
---@param x integer @Position of the first character on the display.
---@param y integer @Position of the first character on the display.
---@param s string  @UTF-8 encoded text.
---@return number @The width of the string.
function u8g2DispObj:drawUTF8(x, y, s) end

---Draw a vertical line, starting at `x/y` position (upper end).\
---The height (length) of the line is `h` pixel.
---@param x integer @Top position of the line.
---@param y integer @Top position of the line.
---@param h integer @The height (length) of the vertical line.
function u8g2DispObj:drawVLine(x, y, h) end

---Draw a XBM Bitmap. Position (`x,y`) is the upper left corner of the bitmap.\
---XBM contains monochrome, 1-bit bitmaps.
---@param x integer @X-position.
---@param y integer @Y-position.
---@param w integer @Width of the bitmap.
---@param h integer @Height of the bitmap.
---@param bitmap string bitmap string.char()
function u8g2DispObj:drawXBM(x, y, w, h, bitmap) end

---Returns the reference height of the glyphs\
---above the baseline (ascent).
---@return number @The ascent of the current font.
---@nodiscard
function u8g2DispObj:getAscent() end

---Returns the reference height of the glyphs\
---below the baseline (descent).
---@return number @The descent of the current font.
---@nodiscard
function u8g2DispObj:getDescent() end

---Return the pixel width of string.
---@param s string @text
---@return number @Width of the string if drawn with the current font (setFont).
---@nodiscard
function u8g2DispObj:getStrWidth(s) end

---Return the pixel width of an UTF-8 encoded string.
---@param s string @UTF-8 encoded text.
---@return number @Width of the string if drawn with the current font (setFont).
---@nodiscard
function u8g2DispObj:getUTF8Width(s) end

---Send the content of the memory frame buffer to the display.
function u8g2DispObj:sendBuffer() end

---Defines, whether the bitmap functions will write the background color\
---(mode 0/solid, `is_transparent` = 0) or not (mode 1/transparent,\
---`is_transparent` = 1). Default mode is 0 (solid mode).
---@param is_transparent integer @Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setBitmapMode(is_transparent) end

---Set the contrast or brightness for the display (if supported).
---@param value integer @Contrast or brightness from 0 to 255.
function u8g2DispObj:setContrast(value) end

---Changes the display rotation.
---@param u8g2_cb integer @Display rotation argument.
---|`u8g2.R0` #No rotation, landscape
---|`u8g2.R1` #90 degree clockwise rotation
---|`u8g2.R2` #180 degree clockwise rotation
---|`u8g2.R3` #270 degree clockwise rotation
---|`u8g2.MIRROR` #No rotation, landscape, display content is mirrored
function u8g2DispObj:setDisplayRotation(u8g2_cb) end

---Defines the bit value (color index) for all drawing functions.
---@param color integer @>
--- - **0** - clear pixel value in the display RAM
--- - **1** - set pixel value
--- - **2** - XOR mode
function u8g2DispObj:setDrawColor(color) end

---Set flip (180 degree rotation) mode.
---@param is_enable integer @Enable (1) or disable (0) 180 degree rotation of the display
function u8g2DispObj:setFlipMode(is_enable) end

---Define a u8g2 font for the glyph and string drawing functions.\
---They can be supplied as strings or compiled into the firmware image.
---@param font number|`u8g2.font_6x10_tf`|`u8g2.font_unifont_t_symbols`
function u8g2DispObj:setFont(font) end

---Set the drawing direction of all strings or glyphs.
---@param dir integer @Writing direction/string rotation.
---|`0` #0 degree   Left to right
---|`1` #90 degree  Top to down
---|`2` #180 degree Right to left
---|`3` #270 degree Down to top
function u8g2DispObj:setFontDirection(dir) end

---Defines, whether the glyph and string drawing functions will write the background color\
---(mode 0/solid, 'is_transparent' = 0) or not (mode 1/transparent, 'is_transparent' = 1).\
---Default mode is 0 (background color of the characters is overwritten).
---@param is_transparent integer @Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setFontMode(is_transparent) end

---Change the reference position for the glyph and\
---string draw functions to "baseline".
function u8g2DispObj:setFontPosBaseline() end

---Change the reference position for the glyph and\
---string draw functions to "bottom".
function u8g2DispObj:setFontPosBottom() end

---Change the reference position for the glyph and\
---string draw functions to "top".
function u8g2DispObj:setFontPosTop() end

---Change the reference position for the glyph and\
---string draw functions to "center".
function u8g2DispObj:setFontPosCenter() end

---Set ascent and descent calculation mode to "highest and lowest glyph".
function u8g2DispObj:setFontRefHeightAll() end

---Set ascent and descent calculation mode to "highest of [A1(], lowest of [g(]".
function u8g2DispObj:setFontRefHeightExtendedText() end

---Set ascent and descent calculation mode to "highest of [A1], lowest of [g]".
function u8g2DispObj:setFontRefHeightText() end

---Activate or disable power save mode of the display.
---@param is_enable integer @Enable (1) or disable (0) power save mode for the display.
function u8g2DispObj:setPowerSave(is_enable) end

---Updates the display.
function u8g2DispObj:updateDisplay() end

---Updates the specified rectangle area of the display.
---@param tx integer @Upper left corner of the area, given as tile position.
---@param ty integer @Upper left corner of the area, given as tile position.
---@param tw integer @Width of the area in tiles.
---@param th integer @Height of the area in tiles.
function u8g2DispObj:updateDisplayArea(tx, ty, tw, th) end
