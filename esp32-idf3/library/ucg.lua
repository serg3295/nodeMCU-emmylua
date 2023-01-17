---@meta

--=== ucg ===

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

---@class ucgDispObj
local ucgDispObj = {}

---Initialize a display via Hardware SPI.
---@param bus integer @SPI master bus
---@param cs integer @GPIO pin for /CS
---@param dc integer @GPIO pin for DC
---@param res? integer @(optional) GPIO pin for /RES, none if omitted
---@return ucgDispObj @ucg display object
---@nodiscard
function ucg.ucgDisplayType(bus, cs, dc, res) end

---Send init code to the display, setup internal data structures\
---and define the text output mode.
---@param fontmode integer|`ucg.FONT_MODE_TRANSPARENT`|`ucg.FONT_MODE_SOLID` @font mode
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

---Draw a filled box. Use current color from index 0. The top-left pixel is at `x`, `y`.\
---The box has width of `w` and the height is `h` pixel.
---@param x integer @Top-left position of the box.
---@param y integer @Top-left position of the box.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function ucgDispObj:drawBox(x, y, w, h) end

---Draw a full circle or a quarter of a circle. Use current color from index 0.\
---The center of the circle is at `x0`, `y0`. The circle has a diameter of `2*rad+1` pixel.
---@param x0 integer @Center of the circle.
---@param y0 integer @Center of the circle.
---@param rad integer @Radius of the circle.
---@param option integer|`ucg.DRAW_ALL`|`ucg.DRAW_UPPER_RIGHT`|`ucg.DRAW_UPPER_LEFT`|`ucg.DRAW_LOWER_LEFT`|`ucg.DRAW_LOWER_RIGHT` @One of the following constants:
function ucgDispObj:drawCircle(x0, y0, rad, option) end

---Draw a filled full circle or a quarter of a filled circle. Use current color from index 0.\
---The center of the filled circle is at `x0`, `y0`. The filled circle has a diameter of `2*rad+1` pixel.
---@param x0 integer @Center of the filled circle.
---@param y0 integer @Center of the filled circle.
---@param rad integer @Radius of the filled circle.
---@param option integer|`ucg.DRAW_ALL`|`ucg.DRAW_UPPER_RIGHT`|`ucg.DRAW_UPPER_LEFT`|`ucg.DRAW_LOWER_LEFT`|`ucg.DRAW_LOWER_RIGHT` @One of the following constants:
function ucgDispObj:drawDisc(x0, y0, rad, option) end

---Draw a rectangle. Use current color from index 0. The top-left pixel is at `x`, `y`.\
---The rectangle has width of `w` and the height is `h` pixel.
---@param x integer @Top-left position of the rectangle.
---@param y integer @Top-left position of the rectangle.
---@param w integer @Width of the rectangle.
---@param h integer @Height of the rectangle.
function ucgDispObj:drawFrame(x, y, w, h) end

---Draw a single character. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`,\
---then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer @Reference position of the character.
---@param y integer @Reference position of the character.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param encoding integer @Code number of the character.
---@return number @Width of the gylph.
function ucgDispObj:drawGlyph(x, y, dir, encoding) end

---Draw a filled box. The upper left position is at `x`, `y`. Dimensions of the box are `w` (width) and `h` (height) pixel.\
---The pixel at the upper left will have the color from index 0, upper right pixel has color from index 1, lower left\
---from index 2 and lower right from index 3. The remaining colors will be interpolated between the four colors.
---@param x integer @Start position of the line.
---@param y integer @Start position of the line.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
function ucgDispObj:drawGradientBox(x, y, w, h) end

---Draw a horizontal or vertical line. The line will start at `x`, `y` and has a total of `len` pixel. The pixel at `x`, `y`\
---will have the color from index 0. The color will be changed until it matches the color of index 1.
---@param x integer @Start position of the line.
---@param y integer @Start position of the line.
---@param len integer @Length of the line.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
function ucgDispObj:drawGradientLine(x, y, len, dir) end

---Draw a horizontal line. Use current color from index 0. The leftmost pixel is at\
---`x`, `y` and the rightmost pixel is at `x+len-1`, `y`
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

---Draw a box/frame with round edges, starting at x/y position (upper left edge).\
---The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries.\
---Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked.\
---Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the box.
---@param h integer @Height of the box.
---@param r integer @Radius for the four edges.
function ucgDispObj:drawRBox(x, y, w, h, r) end

---Draw a box/frame with round edges, starting at x/y position (upper left edge).\
---The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries.\
---Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked.\
---Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer @Position of upper left edge.
---@param y integer @Position of upper left edge.
---@param w integer @Width of the frame.
---@param h integer @Height of the frame.
---@param r integer @Radius for the four edges.
function ucgDispObj:drawRFrame(x, y, w, h, r) end

---Draw a string. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`,\
---then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer @Reference position of the string.
---@param y integer @Reference position of the string.
---@param dir integer @One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param str string @String, which will be printed on the screen.
---@return number @The width of the string.
function ucgDispObj:drawString(x, y, dir, str) end

---Draw a filled tetragon (a shape with four corners), defined by four edge points. Use current color from index 0.\
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

---Draw a vertical line. Use current color from index 0.\
---The topmost pixel is at `x`, `y`. The bottom pixel is at `x,y+len-1`
---@param x integer @Top position of the vertical line.
---@param y integer @Top position of the vertical line.
---@param len integer @Length of the vertical line.
function ucgDispObj:drawVLine(x, y, len) end

---Returns the height of the character 'A' or the number '1' above the baseline.\
---For the font in the example below, getFontAscent returns the value 24.
---@return number @The height of the font.
---@nodiscard
function ucgDispObj:getFontAscent() end

---Some glphys of a font might are extended below the baseline ('g' or ')').\
---This procedure returns the extension of these characters above baseline.\
---If the extension is below the baseline (which is usually the case) then\
---a negative number is returned.
---@return number @The extension of the characters below the baseline.
---@nodiscard
function ucgDispObj:getFontDescent() end

---Returns the height of the display.
---@return number @The height of the display.
---@nodiscard
function ucgDispObj:getHeight() end

---Returns the number of pixels, required for the text in `*s`\
---with the current font settings. Some extra pixels are added\
---in front and after the text as defined in the current font.
---@param str string string
---@return number @Width of the text in pixel.
---@nodiscard
function ucgDispObj:getStrWidth(str) end

---Returns the width of the display.
---@return number @The width of the display.
---@nodiscard
function ucgDispObj:getWidth() end

---Print text or values. The position of the output is defined by `setPrintPos()`,\
---the writing direction is defined by `setPrintDir()`. Values and text will have\
---the current color from index 0. If the setFontMode is `ucg.FONT_MODE_SOLID`, then\
---the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).\
---For best results use `h`, `m` or `8` fonts with `ucg.FONT_MODE_SOLID`
---@param str string @string
---@return number @Number of characters.
function ucgDispObj:print(str) end

--- Defines the drawing area for all other commands. Graphics commands are "clipped"\
--- against this area. By default this is the complete visible area of the screen.
---@param x integer @Upper left position of the drawing area.
---@param y integer @Upper left position of the drawing area.
---@param w integer @Width of the drawing area. Behavior is undefined for w=0 or h=0.
---@param h integer @Height of the drawing area.
function ucgDispObj:setClipRange(x, y, w, h) end

---Defines up to four different colors for the graphics primitives. Most commands will use the color\
---at index position 0. If the index (first argument) is skipped, then the color is stored as index 0.
---@param idx integer @The index of the color being set. See each drawing function to determine the index to use. (Default: 0)
---@param r integer @Red,
---@param g integer @green, and
---@param b integer @blue component of the color. Color range is always from 0 to 255 for each of the color components.
function ucgDispObj:setColor(idx, r, g, b) end

---Define a ucg font for the glyph and string drawing functions.\
---They are available as `ucg.<font_name>` in Lua.
---@param font integer|`ucg.font_7x13B_tr`|`ucg.font_helvB08_hr`|`ucg.font_helvB10_hr`|`ucg.font_helvB12_hr`|`ucg.font_helvB18_hr`|`ucg.font_ncenB24_tr`|`ucg.font_ncenR12_tr`|`ucg.font_ncenR14_hr` @constant to identify pre-compiled font
---@return nil
function ucgDispObj:setFont(font) end

---Define the text output mode.
---@param fontmode integer|`ucg.FONT_MODE_TRANSPARENT`|`ucg.FONT_MODE_SOLID`
---@return number @0, if the init procedure fails.
function ucgDispObj:setFontMode(fontmode) end

---Change the reference position for the character output\
---procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBaseline() end

---Change the reference position for the character output\
---procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBottom() end

---Change the reference position for the character output\
---procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosCenter() end

---Change the reference position for the character output\
---procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosTop() end

---This command will reset the clip area to the full display size.\
---It will undo any settings from *setClipRange*.
function ucgDispObj:setMaxClipRange() end

--- This command will set the print direction for the following "print" commands.
---@param dir integer @"One of the values:  \n **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)."
function ucgDispObj:setPrintDir(dir) end

---This command will set the position for next "print" command.
---@param x integer @Reference position for the characters of the next print command.
---@param y integer @Reference position for the characters of the next print command.
function ucgDispObj:setPrintPos(x, y) end

---Rotate the screen by 90 degree.\
---Depending on the aspect ratio of the display, this\
---will put the display in portrait or landscape mode.
function ucgDispObj:setRotate90() end

---Rotate the screen by 180 degree.\
---Depending on the aspect ratio of the display, this\
---will put the display in portrait or landscape mode.
function ucgDispObj:setRotate180() end

---Rotate the screen by 270 degree.\
---Depending on the aspect ratio of the display, this\
---will put the display in portrait or landscape mode.
function ucgDispObj:setRotate270() end

---Scale everything by 2. This includes position values,\
---lines, fonts, circles, etc. As long as scaling is active,\
---the screen rotation commands must not be used.
function ucgDispObj:setScale2x2() end

---Removes the clip window. All graphics commands\
---can now write to the entire screen.
function ucgDispObj:undoClipRange() end

---Restore the original display orientation.
function ucgDispObj:undoRotate() end

---Return to none scaling mode.
function ucgDispObj:undoScale() end
