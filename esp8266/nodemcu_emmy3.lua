--*** LIQUID CRYSTAL ***
---@class liquidcrystal
local liquidcrystal = lc_meta()

---@class backend_obj

---@class i2c4bitCfg
---@field sda integer
---@field scl integer
---@field busid integer
---@field busad integer
---@field speed integer
---@field rs integer
---@field rw integer
---@field en integer
---@field bl integer
---@field d4 integer
---@field d5 integer
---@field d6 integer
---@field d7 integer

--- Loading I²C backend module returns initialization closure. It configures I²C backend and returns backend object.
---@param tbl i2c4bitCfg @In most cases only **sda** and **scl** parameters are required
--- - **sda**: I²C data pin. If set to `nil`, I²C bus initialization step via `i2c.setup` will be skipped
--- - **scl**: I²C clock pin. If set to `nil`, I²C bus initialization step via `i2c.setup` will be skipped
--- - **busid**: I²C bus ID. Defaults to 0
--- - **busad**: chip I²C address. Defaults to 0x27 (default PCF8574 address)
--- - **speed**: I²C speed. Defaults to i2c.SLOW
--- - **rs**: bit position assigned to RS pin in I²C word. Defaults to 0
--- - **rw**: bit position assigned to RW pin in I²C word. Defaults to 1
--- - **en**: bit position assigned to EN pin in I²C word. Defaults to 2
--- - **bl**: bit position assigned to backlight pin in I²C word. Defaults to 3
--- - **d4**: bit position assigned to D4 pin in I²C word. Defaults to 4
--- - **d5**: bit position assigned to D5 pin in I²C word. Defaults to 5
--- - **d6**: bit position assigned to D6 pin in I²C word. Defaults to 6
--- - **d7**: bit position assigned to D7 pin in I²C word. Defaults to 7
---@return backend_obj @backend object
function i2c4bit_meta(tbl) end

---@class gpio4bitCfg
---@field rs integer
---@field rw integer
---@field en integer
---@field bl integer
---@field d4 integer
---@field d5 integer
---@field d6 integer
---@field d7 integer

---Loading GPIO 4 bit backend module returns initialization closure. It configures GPIO 4 bit backend and returns backend object.
---@param tbl gpio4bitCfg @>
--- - **rs**: GPIO pin connected to RS pin. Defaults to 0
--- - **rw**: GPIO pin connected to RW pin. If set to `nil` then busy, position and readChar functions will not be available. Note that RW pin must be pulled to the ground if not connected to GPIO
--- - **en**: GPIO pin connected to EN pin. Defaults to 1
--- - **bl**: GPIO pin controlling backlight. It is assumed, that high level turns backlight on, low level turns backlight off. If set to `nil` then backlight function will not be available
--- - **d4**: GPIO pin connected to D4 pin. Defaults to 2
--- - **d5**: GPIO pin connected to D5 pin. Defaults to 3
--- - **d6**: GPIO pin connected to D6 pin. Defaults to 4
--- - **d7**: GPIO pin connected to D7 pin. Defaults to 5
---@return backend_obj @backend object
function gpio4bit_meta(tbl) end

---@class gpio8bitCfg
---@field rs integer
---@field rw integer
---@field he integer
---@field en integer
---@field bl integer
---@field d0 integer
---@field d1 integer
---@field d2 integer
---@field d3 integer
---@field d4 integer
---@field d5 integer
---@field d6 integer
---@field d7 integer

---Loading GPIO 8 bit backend module returns initialization closure. It configures GPIO 8 bit backend and returns backend object.
---@param tbl gpio8bitCfg @>
--- - **rs**: GPIO pin connected to RS pin. Defaults to 0
--- - **rw**: GPIO pin connected to RW pin. If set to `nil` then busy, position and readChar functions will not be available. Note that RW pin must be pulled to the ground if not connected to GPIO
--- - **en**: GPIO pin connected to EN pin. Defaults to 1
--- - **bl**: GPIO pin controlling backlight. It is assumed, that high level turns backlight on, low level turns backlight off. If set to `nil` then backlight function will not be available
--- - **d0**: GPIO pin connected to D0 pin. Defaults to 2
--- - **d1**: GPIO pin connected to D1 pin. Defaults to 3
--- - **d2**: GPIO pin connected to D2 pin. Defaults to 4
--- - **d3**: GPIO pin connected to D3 pin. Defaults to 5
--- - **d4**: GPIO pin connected to D4 pin. Defaults to 6
--- - **d5**: GPIO pin connected to D5 pin. Defaults to 7
--- - **d6**: GPIO pin connected to D6 pin. Defaults to 8
--- - **d7**: GPIO pin connected to D7 pin. Defaults to 9
---@return backend_obj @backend object
function gpio8bit_meta(tbl) end

---Loading Liquidcrystal module returns initialization closure. It requires backend object and returns LCD object.
---@param backend backend_obj @backend object
---@param onelinemode boolean @`true` to use one line mode, `false` to use two line mode
---@param eightdotsmode boolean @`true` to use 5x8 dot font, `false` to use 5x10 dot font
---@param column_width number @number of characters in column. Used for offset calculations in function cursorMove. If set to `nil`, functionality of cursorMove will be limited. For most displays column width is 20 characters.
---@return liquidcrystal LCD_obj @screen object
function lc_meta(backend, onelinemode, eightdotsmode, column_width) end

---Autoscroll text when printing. When turned off, cursor moves and text stays still, when turned on, vice versa.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function liquidcrystal:autoscroll(on) end

---Control LCDs backlight. When using GPIO backend without **bl** argument specification function does nothing.
---@param on boolean @`true` to turn on, `false` to turn off
---@return boolean @backlight status
function liquidcrystal:backlight(on) end

---Control cursors blink mode.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function liquidcrystal:blink(on) end

---Get busy status of the LCD. When using GPIO backend without rw argument specification function does nothing.
---@return boolean @`true` if device is busy, `false` if device is ready to receive commands
function liquidcrystal:busy() end

---Clear LCD screen.
---@return any @sent data
function liquidcrystal:clear() end

---Move cursor one character to the left.
---@return any dat @sent data
function liquidcrystal:cursorLeft() end

---Move cursor to position. If **row** not specified, move cursor to address **col**.
---@param col integer @new cursor position column. If row not specified, new cursor position address
---@param row integer @new cursor position row or `nil`
---@return any @sent data
function liquidcrystal:cursorMove(col, row) end

---Control cursors highlight mode.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function liquidcrystal:cursor(on) end

---Move cursor one character to the right.
---@return any @sent data
function liquidcrystal:cursorRight() end

---Define new custom char. Up to 8 custom characters with indexes 0 to 7 may be defined in eight dot mode.
---@param index number @custom char index in range from 0 to 7
---@param bytes number @array of 8 bytes in eight bit mode or 11 bytes in ten bit mode (eleventh line is a cursor line that can also be used) that defines new char bitmap line by line
---@return nil
function liquidcrystal:customChar(index, bytes) end

---Turn display on and off. Does not affect display backlight. Does not clear the display.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function liquidcrystal:display(on) end

---Reset cursor and screen position.
---@return any @sent data
function liquidcrystal:home() end

---Print text left to right (default).
---@return any @sent data
function liquidcrystal:leftToRight() end

---Get current position of the cursor. Position is 0 indexed. When using GPIO backend without **rw** argument specification function does nothing.
---@return number @0 indexed position of the cursor
function liquidcrystal:position() end

---Return current character numerical representation. When using GPIO backend without **rw** argument specification function does nothing.
---@return number @numerical representation of the current character
function liquidcrystal:read() end

---Return custom char byte array. When using GPIO backend without **rw** argument specification function returns zeros.
---@param index integer custom char index in range from 0 to 7
---@return table @table of size 8 in eight dot mode or 11 in ten dot mode. Each 8 bit number represents a character dot line
function liquidcrystal:readCustom(index) end

---Print text right to left.
---@return any @sent data
function liquidcrystal:rightToLeft() end

---Move text to the left.
---@return any @sent data
function liquidcrystal:scrollLeft() end

---Move text to the right.
---@return any @sent data
function liquidcrystal:scrollRight() end

---Print text. vararg - strings or char codes.
---@vararg string
---@return nil
function liquidcrystal:write(...) end

--*** U8G2 ***
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

---@class u8g2DisplayObj
local u8g2DispObj = {}

---Initialize a display via I²C.
---@param id integer @i2c interface id, see i2c module
---@param address integer @I²C slave address of display (unshifted)
---@param cb_fn? function @optional callback function, see Framebuffer callback
---@return u8g2DisplayObj @u8g2 display object
function u8g2.u8g2DisplayTypeI2C(id, address, cb_fn) end

---Initialize a display via Hardware SPI.
---@param bus integer @SPI master bus
---@param cs integer @GPIO pin for CS
---@param dc integer @GPIO pin for DC
---@param res? integer @(optional) GPIO pin for RES, none if omitted
---@param cb_fn? function @optional callback function, `function(rle_line?)`. **rle_line** is a string containing a run-length encoded framebuffer line, or `nil` to indicate start of frame.
---@return u8g2DisplayObj @u8g2 display object
function u8g2.u8g2DisplayTypeSPI(bus, cs, dc, res, cb_fn) end

---Clears all pixel in the memory frame buffer.
function u8g2DispObj:clearBuffer() end

---Draw a box (filled frame), starting at `x/y` position (upper left edge). The box has width `w` and height `h`.
---@param x integer @X-position of upper left edge.
---@param y integer @Y-position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function u8g2DispObj:drawBox(x, y, w, h) end

---Draw a circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer @Position of the center of the circle.
---@param y0 integer @Position of the center of the circle.
---@param rad integer  @Defines the size of the circle: Radus = rad.
---@param opt? integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawCircle(x0, y0, rad, opt) end

---Draw a filled circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer @Position of the center of the disc.
---@param y0 integer @Position of the center of the disc.
---@param rad integer @Defines the size of the circle: Radus = rad.
---@param opt? integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawDisc(x0, y0, rad, opt) end

---Draw an ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer @Position of the center of the filled circle.
---@param y0 integer @Position of the center of the filled circle.
---@param rx integer @Defines the size of the ellipse.
---@param ry integer @Defines the size of the ellipse.
---@param opt integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawEllipse(x0, y0, rx, ry, opt) end

---Draw a filled ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer @Position of the center of the filled circle.
---@param y0 integer @Position of the center of the filled circle.
---@param rx integer @Defines the size of the ellipse.
---@param ry integer @Defines the size of the ellipse.
---@param opt integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' @is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawFilledEllipse(x0, y0, rx, ry, opt) end

---Draw a frame (empty box), starting at `x/y` position (upper left edge). The box has width `w` and height `h`.
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

---Draw a horizontal line, starting at `x/y` position (left edge). The width (length) of the line is `w` pixel.
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

---Draw a pixel at the specified `x/y` position. Position (0,0) is at the upper left corner of the display.
---@param x integer @Position of pixel.
---@param y integer @Position of pixel.
function u8g2DispObj:drawPixel(x, y) end

---Draw a box with round edges, starting at `x/y` position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
---@param r integer @Radius for the four edges.
function u8g2DispObj:drawRBox(x, y, w, h, r) end

---Draw a frame with round edges, starting at `x/y` position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
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

---Draw a vertical line, starting at `x/y` position (upper end). The height (length) of the line is `h` pixel.
---@param x integer @Top position of the line.
---@param y integer @Top position of the line.
---@param h integer @The height (length) of the vertical line.
function u8g2DispObj:drawVLine(x, y, h) end

---Draw a XBM Bitmap. Position (`x,y`) is the upper left corner of the bitmap. XBM contains monochrome, 1-bit bitmaps.
---@param x integer @X-position.
---@param y integer @Y-position.
---@param w integer @Width of the bitmap.
---@param h integer @Height of the bitmap.
---@param bitmap string @bitmap string.char()
function u8g2DispObj:drawXBM(x, y, w, h, bitmap) end

---Returns the reference height of the glyphs above the baseline (ascent).
---@return number @The ascent of the current font.
function u8g2DispObj:getAscent() end

---Returns the reference height of the glyphs below the baseline (descent).
---@return number @The descent of the current font.
function u8g2DispObj:getDescent() end

---Return the pixel width of string.
---@param s string @text
---@return number @Width of the string if drawn with the current font (setFont).
function u8g2DispObj:getStrWidth(s) end

---Return the pixel width of an UTF-8 encoded string.
---@param s string UTF-8 encoded text.
---@return number @Width of the string if drawn with the current font (setFont).
function u8g2DispObj:getUTF8Width(s) end

---Send the content of the memory frame buffer to the display.
function u8g2DispObj:sendBuffer() end

---Defines, whether the bitmap functions will write the background color (mode 0/solid, `is_transparent` = 0) or not (mode 1/transparent, `is_transparent` = 1). Default mode is 0 (solid mode).
---@param is_transparent integer @Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setBitmapMode(is_transparent) end

---Set the contrast or brightness for the display (if supported).
---@param value integer @Contrast or brightness from 0 to 255.
function u8g2DispObj:setContrast(value) end

---Changes the display rotation.
---@param u8g2_cb integer @Display rotation argument.
---|'u8g2.R0' #No rotation, landscape
---|'u8g2.R1' #90 degree clockwise rotation
---|'u8g2.R2' #180 degree clockwise rotation
---|'u8g2.R3' #270 degree clockwise rotation
---|'u8g2.MIRROR' #No rotation, landscape, display content is mirrored
function u8g2DispObj:setDisplayRotation(u8g2_cb) end

---Defines the bit value (color index) for all drawing functions.
---@param color integer @**0** (clear pixel value in the display RAM), **1** (set pixel value) or **2** (XOR mode)
function u8g2DispObj:setDrawColor(color) end

---Set flip (180 degree rotation) mode.
---@param is_enable integer @Enable (1) or disable (0) 180 degree rotation of the display
function u8g2DispObj:setFlipMode(is_enable) end

---Define a u8g2 font for the glyph and string drawing functions. They can be supplied as strings or compiled into the firmware image.
---@param font number|'u8g2.font_6x10_tf'|'u8g2.font_unifont_t_symbols'
function u8g2DispObj:setFont(font) end

---Set the drawing direction of all strings or glyphs.
---@param dir integer @Writing direction/string rotation.
---|'0' #0 degree   Left to right
---|'1' #90 degree  Top to down
---|'2' #180 degree Right to left
---|'3' #270 degree Down to top
function u8g2DispObj:setFontDirection(dir) end

---Defines, whether the glyph and string drawing functions will write the background color (mode 0/solid, 'is_transparent' = 0) or not (mode 1/transparent, 'is_transparent' = 1). Default mode is 0 (background color of the characters is overwritten).
---@param is_transparent integer @Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setFontMode(is_transparent) end

---Change the reference position for the glyph and string draw functions to "baseline".
function u8g2DispObj:setFontPosBaseline() end

---Change the reference position for the glyph and string draw functions to "bottom".
function u8g2DispObj:setFontPosBottom() end

---Change the reference position for the glyph and string draw functions to "top".
function u8g2DispObj:setFontPosTop() end

---Change the reference position for the glyph and string draw functions to "center".
function u8g2DispObj:setFontPosCenter() end

---Set ascent and descent calculation mode to "highest and lowest glyph".
function u8g2DispObj:setFontRefHeightAll() end

---Set ascent and descent calculation mode to "highest of [A1(], lowest of [g(]".
function u8g2DispObj:setFontRefHeightExtendedText() end

---Set ascent and descent calculation mode to "highest of [A1], lowest of [g]".
function u8g2DispObj:setFontRefHeightText() end

---Activate or disable power save mode of the display.
---@param is_enable integer Enable (1) or disable (0) power save mode for the display.
function u8g2DispObj:setPowerSave(is_enable) end

---Updates the display.
function u8g2DispObj:updateDisplay() end

---Updates the specified rectangle area of the display.
---@param tx integer @Upper left corner of the area, given as tile position.
---@param ty integer @Upper left corner of the area, given as tile position.
---@param tw integer @Width of the area in tiles.
---@param th integer @Height of the area in tiles.
function u8g2DispObj:updateDisplayArea(tx, ty, tw, th) end

--*** UCG ***
---@class ucg
---@field hx8352c_18x240x400_hw_spi function
---@field ili9163_18x128x128_hw_spi function
---@field ili9341_18x240x320_hw_spi function
---@field ili9486_18x320x480_hw_spi function
---@field pcf8833_16x132x132_hw_spi function
---@field seps225_16x128x128_uvis_hw_spi function
---@field ssd1351_18x128x128_hw_spi function
---@field ssd1351_18x128x128_ft_hw_spi function
---@field ssd1331_18x96x64_uvis_hw_spi function
---@field st7735_18x128x160_hw_spi function
---fonts
---@field font_7x13B_tr number
---@field font_helvB08_hr number
---@field font_helvB10_hr number
---@field font_helvB12_hr number
---@field font_helvB18_hr number
---@field font_ncenB24_tr number
---@field font_ncenR12_tr number
---@field font_ncenR14_hr number
---constants
---@field FONT_MODE_SOLID number
---@field FONT_MODE_TRANSPARENT number
---@field DRAW_UPPER_RIGHT number
---@field DRAW_UPPER_LEFT number
---@field DRAW_LOWER_RIGHT number
---@field DRAW_LOWER_LEFT number
---@field DRAW_ALL number
ucg = {}

---@class ucgDisplayObj
local ucgDispObj = {}

---Initialize a display via Hardware SPI.
---@param bus integer @SPI master bus
---@param cs integer @GPIO pin for /CS
---@param dc integer @GPIO pin for DC
---@param res? integer @(optional) GPIO pin for /RES, none if omitted
---@return ucgDisplayObj @ucg display object
function ucg.ucgDisplayType(bus, cs, dc, res) end

---Send init code to the display, setup internal data structures and define the text output mode.
---@param fontmode integer|'ucg.FONT_MODE_TRANSPARENT'|'ucg.FONT_MODE_SOLID' @font mode
---@return number @0, if the init procedure fails.
function ucgDispObj:begin(fontmode) end

---Clear the screen and reset the clip range to maximum.
function ucgDispObj:clearScreen() end

---ucg.draw90Line
---@param x integer
---@param y integer
---@param len integer
---@param dir integer
---@param col_idx integer
function ucgDispObj:draw90Line(x, y, len, dir, col_idx) end

---Draw a filled box. Use current color from index 0. The top-left pixel is at `x`, `y`. The box has width of `w` and the height is `h` pixel.
---@param x integer @Top-left position of the box.
---@param y integer @Top-left position of the box.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function ucgDispObj:drawBox(x, y, w, h) end

---Draw a full circle or a quarter of a circle. Use current color from index 0. The center of the circle is at `x0`, `y0`. The circle has a diameter of `2*rad+1` pixel.
---@param x0 integer @Center of the circle.
---@param y0 integer @Center of the circle.
---@param rad integer @Radius of the circle.
---@param option integer|' ucg.DRAW_ALL'|' ucg.DRAW_UPPER_RIGHT'|' ucg.DRAW_UPPER_LEFT'|' ucg.DRAW_LOWER_LEFT'|' ucg.DRAW_LOWER_RIGHT' @One of the following constants:
function ucgDispObj:drawCircle(x0, y0, rad, option) end

---Draw a filled full circle or a quarter of a filled circle. Use current color from index 0. The center of the filled circle is at `x0`, `y0`. The filled circle has a diameter of `2*rad+1` pixel.
---@param x0 integer @Center of the filled circle.
---@param y0 integer @Center of the filled circle.
---@param rad integer @Radius of the filled circle.
---@param option integer|' ucg.DRAW_ALL'|' ucg.DRAW_UPPER_RIGHT'|' ucg.DRAW_UPPER_LEFT'|' ucg.DRAW_LOWER_LEFT'|' ucg.DRAW_LOWER_RIGHT' @One of the following constants:
function ucgDispObj:drawDisc(x0, y0, rad, option) end

---Draw a rectangle. Use current color from index 0. The top-left pixel is at `x`, `y`. The rectangle has width of `w` and the height is `h` pixel.
---@param x integer @Top-left position of the rectangle.
---@param y integer @Top-left position of the rectangle.
---@param w integer @Width of the rectangle.
---@param h integer @Height of the rectangle.
function ucgDispObj:drawFrame(x, y, w, h) end

---Draw a single character. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer @Reference position of the character.
---@param y integer @Reference position of the character.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param encoding integer @Code number of the character.
---@return number @Width of the gylph.
function ucgDispObj:drawGlyph(x, y, dir, encoding) end

---Draw a filled box. The upper left position is at `x`, `y`. Dimensions of the box are `w` (width) and `h` (height) pixel. The pixel at the upper left will have the color from index 0, upper right pixel has color from index 1, lower left from index 2 and lower right from index 3. The remaining colors will be interpolated between the four colors.
---@param x integer @Start position of the line.
---@param y integer @Start position of the line.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function ucgDispObj:drawGradientBox(x, y, w, h) end

---Draw a horizontal or vertical line. The line will start at `x`, `y` and has a total of `len` pixel. The pixel at `x`, `y` will have the color from index 0. The color will be changed until it matches the color of index 1.
---@param x integer @Start position of the line.
---@param y integer @Start position of the line.
---@param len integer @Length of the line.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
function ucgDispObj:drawGradientLine(x, y, len, dir) end

---Draw a horizontal line. Use current color from index 0. The leftmost pixel is at `x`, `y` and the rightmost pixel is at `x+len-1`, `y`
---@param x integer @Left position of the horizontal line.
---@param y integer @Left position of the horizontal line.
---@param len integer @Length of the line.
function ucgDispObj:drawHLine(x, y, len) end

---Draw a line from pixel at `x1`, `y1` to pixel `x2`, `y2`. Use current color from index 0.
---@param x1 integer @Start pixel of the line.
---@param y1 integer @Start pixel of the line.
---@param x2 integer @End pixel of the line.
---@param y2 integer @End pixel of the line.
function ucgDispObj:drawLine(x1, y1, x2, y2) end

---Draw a pixel at position `x`, `y`. Use current color from index 0.
---@param x integer @Position of pixel.
---@param y integer @Position of pixel.
function ucgDispObj:drawPixel(x, y) end

---Draw a box/frame with round edges, starting at x/y position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked. Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
---@param r integer @Radius for the four edges.
function ucgDispObj:drawRBox(x, y, w, h, r) end

---Draw a box/frame with round edges, starting at x/y position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked. Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the frame.
---@param h integer @Height of the frame.
---@param r integer @Radius for the four edges.
function ucgDispObj:drawRFrame(x, y, w, h, r) end

---Draw a string. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer @Reference position of the string.
---@param y integer @Reference position of the string.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param str string @String, which will be printed on the screen.
---@return number @The width of the string.
function ucgDispObj:drawString(x, y, dir, str) end

---Draw a filled tetragon (a shape with four corners), defined by four edge points. Use current color from index 0.
---This procedure will only draw "simple"/convex tetragons. The result will be undefined, if the tetragon is not convex.
---@param x0 integer @Point 0 of the tetragon.
---@param y0 integer @Point 0 of the tetragon.
---@param x1 integer @Point 1 of the tetragon.
---@param y1 integer @Point 1 of the tetragon.
---@param x2 integer @Point 2 of the tetragon.
---@param y2 integer @Point 2 of the tetragon.
---@param x3 integer @Point 3 of the tetragon.
---@param y3 integer @Point 3 of the tetragon.
function ucgDispObj:drawTetragon(x0, y0, x1, y1, x2, y2, x3, y3) end

---Draw a filled triangle, defined by three edge points. Use current color from index 0.
---@param x0 integer @Point 0 of the triangle.
---@param y0 integer @Point 0 of the triangle.
---@param x1 integer @Point 1 of the triangle.
---@param y1 integer @Point 1 of the triangle.
---@param x2 integer @Point 2 of the triangle.
---@param y2 integer @Point 2 of the triangle.
function ucgDispObj:drawTriangle(x0, y0, x1, y1, x2, y2) end

---Draw a vertical line. Use current color from index 0. The topmost pixel is at `x`, `y`. The bottom pixel is at `x,y+len-1`
---@param x integer @Top position of the vertical line.
---@param y integer @Top position of the vertical line.
---@param len integer @Length of the vertical line.
function ucgDispObj:drawVLine(x, y, len) end

---Returns the height of the character 'A' or the number '1' above the baseline. For the font in the example below, getFontAscent returns the value 24.
---@return number @The height of the font.
function ucgDispObj:getFontAscent() end

---Some glphys of a font might are extended below the baseline ('g' or ')'). This procedure returns the extension of these characters above baseline. If the extension is below the baseline (which is usually the case) then a negative number is returned. In the example below, the returned descent value is "-7".
---@return number @The extension of the characters below the baseline.
function ucgDispObj:getFontDescent() end

---Returns the height of the display.
---@return number @The height of the display.
function ucgDispObj:getHeight() end

---Returns the number of pixels, required for the text in `*s` with the current font settings. Some extra pixels are added in front and after the text as defined in the current font.
---@param str string string
---@return number @Width of the text in pixel.
function ucgDispObj:getStrWidth(str) end

---Returns the width of the display.
---@return number @The width of the display.
function ucgDispObj:getWidth() end

---Print text or values. The position of the output is defined by `setPrintPos()`, the writing direction is defined by `setPrintDir()`. Values and text will have the current color from index 0. If the setFontMode is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`). For best results use `h`, `m` or `8` fonts with `ucg.FONT_MODE_SOLID`
---@param str string @string
---@return number @Number of characters.
function ucgDispObj:print(str) end

--- Defines the drawing area for all other commands. Graphics commands are "clipped" against this area. By default this is the complete visible area of the screen.
---@param x integer @Upper left position of the drawing area.
---@param y integer @Upper left position of the drawing area.
---@param w integer @Width of the drawing area. Behavior is undefined for w=0 or h=0.
---@param h integer @Height of the drawing area.
function ucgDispObj:setClipRange(x, y, w, h) end

---Defines up to four different colors for the graphics primitives. Most commands will use the color at index position 0. If the index (first argument) is skipped, then the color is stored as index 0.
---@param idx integer The index of the color being set. See each drawing function to determine the index to use. (Default: 0)
---@param r integer @Red,
---@param g integer @green, and
---@param b integer @blue component of the color. Color range is always from 0 to 255 for each of the color components.
function ucgDispObj:setColor(idx, r, g, b) end

---Define a ucg font for the glyph and string drawing functions. They are available as `ucg.<font_name>` in Lua.
---@param font integer|'ucg.font_7x13B_tr'|'ucg.font_helvB08_hr'|'ucg.font_helvB10_hr'|'ucg.font_helvB12_hr'|'ucg.font_helvB18_hr'|'ucg.font_ncenB24_tr'|'ucg.font_ncenR12_tr'|'ucg.font_ncenR14_hr' @constant to identify pre-compiled font
---@return nil
function ucgDispObj:setFont(font) end

---Define the text output mode.
---@param fontmode integer|'ucg.FONT_MODE_TRANSPARENT'|'ucg.FONT_MODE_SOLID' @fontmode
---@return number @0, if the init procedure fails.
function ucgDispObj:setFontMode(fontmode) end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBaseline() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBottom() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosCenter() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosTop() end

---This command will reset the clip area to the full display size. It will undo any settings from *setClipRange*.
function ucgDispObj:setMaxClipRange() end

--- This command will set the print direction for the following "print" commands.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up).
function ucgDispObj:setPrintDir(dir) end

---This command will set the position for next "print" command.
---@param x integer @Reference position for the characters of the next print command.
---@param y integer @Reference position for the characters of the next print command.
function ucgDispObj:setPrintPos(x, y) end

---Rotate the screen by 90 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate90() end

---Rotate the screen by 180 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate180() end

---Rotate the screen by 270 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate270() end

---Scale everything by 2. This includes position values, lines, fonts, circles, etc. As long as scaling is active, the screen rotation commands must not be used.
function ucgDispObj:setScale2x2() end

---Removes the clip window. All graphics commands can now write to the entire screen.
function ucgDispObj:undoClipRange() end

---Restore the original display orientation.
function ucgDispObj:undoRotate() end

---Return to none scaling mode.
function ucgDispObj:undoScale() end

--*** COHELPER TODO ***
---@class cohelper
local cohelper = require("cohelper")

---Execute a function which is wrapped by a coroutine handler.
---@param func function @Lua function to be executed as a coroutine.
---@param params any @list of 0 or more parameters used to initialise func. the number and types must be matched to the funct declaration
---@return any @Return result of first yield.
function cohelper.exec(func, params) end

--*** FIFO TODO ***
fifo = {}

---@class fifo
local fifo = (require "fifo").new()

---Fetch an element from the fifo and pass it to the function `k`, together with a boolean indicating whether this is the last element in the fifo. If the fifo is empty, `k` will not be called and the fifo will enter "immediate dequeue" mode.
---@param k function
---@return boolean @`true` if the queue contained at least one non-phantom entry, `false` otherwise.
function fifo:dequeue(k) end

---Enqueue the element `a` onto the fifo. If `k` is not `nil` and the fifo is in "immediate dequeue" mode (whence it starts), immediately pass the first element of the fifo (usually, but not necessarily, `a`) to `k`, as if `fifo:dequeue(k)` had been called, and exit "immediate dequeue" mode.
---@param a any
---@param k any
function fifo:queue(a,k) end

--*** GOSSIP ***
gossip = {}

---@class GossipCfg
---@field seedList integer
---@field roundInterval integer
---@field comPort integer
---@field debug integer
---@field debugOutput integer

---Sets the configuration for gossip.
---@param config GossipCfg @table. The available options are:
--- - **seedList**: the list of seeds gossip will start with; this will be updated as new nodes are discovered. Note that it's enough for all nodes to start with the same IP in the seedList, as once they have one seed in common, the data will propagate. Default: `nil`.
--- - **roundInterval**: interval in milliseconds at which gossip will pick a random node from the seed list and send a SYN request. Default: 10000 (10 seconds)
--- - **comPort**: port for the listening UDP socket. Default: 5000.
--- - **debug**: flag that will provide debugging messages. Default: false.
--- - **debugOutput**: if debug is set to true, then this method will be used as a callback with the debug message as the first parameter. Default: print
function gossip.setConfig(config) end

---Starts gossip, sets the started flag to `true` and initiates the revision.
function gossip.start() end

---If declared, this function will get called every time there is a SYN with new data.
---```lua
---gossip.callbackFunction = function(data)
---  processData(data)
---end
---gossip.callbackFunction = nil -- stop the callback
---```
function gossip.callbackFunction() end

---Send a SYN request outside of the normal gossip round. The IP is optional and if none given, it will pick a random node.
---@param data any|nil @By calling `pushGossip(nil)` you effectively remove the **data** table from the node's network state and notify other nodes of this.
---@param ip? string @The IP is optional and if none given, it will pick a random node.
function gossip.pushGossip(data, ip) end

---The only scenario when rev should be set manually is when a new node is added to the network and has the same IP. Having a smaller revision than the previous node with the same IP would make gossip think the data it received is old, thus ignoring it.
function gossip.setRevFileValue(number) end

---The network state can be directly accessed as a Lua table : `gossip.networkState` or it can be received as a JSON with this method.
---@return string @JSON formatted string regarding the network state.
function gossip.getNetworkState() end

--*** GDBSTUB ***
gdbstub = {}

---Runs gdbstub initialization routine. Note that subsequent calls are ignored and the break functions will do this automatically if not already done so this is options
function gdbstub.open() end

---Enters gdb by executing a break 0,0 instruction, and if necessary first does initialisation.
function gdbstub.brk() end

---Enters gdb by executing a break 0,0 instruction, and if necessary first does initialisation; It also set the gdboutput mode to 1 allowing the debug client to capture and echo UART output through the debug session.
function gdbstub.pbrk() end

---Controls whether system output is encapsulated in gdb remote debugging protocol.
---@param enable boolean @If `true`, then output is wrapped in gdb remote debugging protocol. If `false`, then it is sent straight to the UART.
function gdbstub.gdboutput(enable) end

--*** DEBUG ***

---Returns a sorted array of the strings returned from the `lua_getstrings` function.
---@param type string|'RAM'|'ROM'
---@return table
function debug.getstrings(type) end
