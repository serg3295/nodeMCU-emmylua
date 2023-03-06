---@meta

--=== liquidcrystal ===

---@class lc
local lc = {}

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

---Loading I²C backend module returns initialization closure.\
---It configures I²C backend and returns backend object.
---@param tbl i2c4bitCfg @In most cases only **sda** and **scl** parameters are required
--- - **sda**: I²C data pin. If set to `nil`,\
---I²C bus initialization step via `i2c.setup` will be skipped
--- - **scl**: I²C clock pin. If set to `nil`,\
---I²C bus initialization step via `i2c.setup` will be skipped
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
---@nodiscard
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

---Loading GPIO 4 bit backend module returns initialization closure.\
---It configures GPIO 4 bit backend and returns backend object.
---@param tbl gpio4bitCfg @>
--- - **rs**: GPIO pin connected to RS pin. Defaults to 0
--- - **rw**: GPIO pin connected to RW pin. If set to `nil` then busy,\
---position and readChar functions will not be available. Note that\
---RW pin must be pulled to the ground if not connected to GPIO
--- - **en**: GPIO pin connected to EN pin. Defaults to 1
--- - **bl**: GPIO pin controlling backlight. It is assumed, that high level\
---turns backlight on, low level turns backlight off. If set to `nil`\
---then backlight function will not be available
--- - **d4**: GPIO pin connected to D4 pin. Defaults to 2
--- - **d5**: GPIO pin connected to D5 pin. Defaults to 3
--- - **d6**: GPIO pin connected to D6 pin. Defaults to 4
--- - **d7**: GPIO pin connected to D7 pin. Defaults to 5
---@return backend_obj @backend object
---@nodiscard
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

---Loading GPIO 8 bit backend module returns initialization closure.\
---It configures GPIO 8 bit backend and returns backend object.
---@param tbl gpio8bitCfg @>
--- - **rs**: GPIO pin connected to RS pin. Defaults to 0
--- - **rw**: GPIO pin connected to RW pin. If set to `nil` then busy,\
---position and readChar functions will not be available.\
---Note that RW pin must be pulled to the ground if not connected to GPIO
--- - **en**: GPIO pin connected to EN pin. Defaults to 1
--- - **bl**: GPIO pin controlling backlight. It is assumed,\
---that high level turns backlight on, low level turns backlight off.\
---If set to `nil` then backlight function will not be available
--- - **d0**: GPIO pin connected to D0 pin. Defaults to 2
--- - **d1**: GPIO pin connected to D1 pin. Defaults to 3
--- - **d2**: GPIO pin connected to D2 pin. Defaults to 4
--- - **d3**: GPIO pin connected to D3 pin. Defaults to 5
--- - **d4**: GPIO pin connected to D4 pin. Defaults to 6
--- - **d5**: GPIO pin connected to D5 pin. Defaults to 7
--- - **d6**: GPIO pin connected to D6 pin. Defaults to 8
--- - **d7**: GPIO pin connected to D7 pin. Defaults to 9
---@return backend_obj @backend object
---@nodiscard
function gpio8bit_meta(tbl) end

---Loading Liquidcrystal module returns initialization closure. It requires backend object and returns LCD object.
---@param backend backend_obj @backend object
---@param onelinemode boolean @`true` to use one line mode, `false` to use two line mode
---@param eightdotsmode boolean @`true` to use 5x8 dot font, `false` to use 5x10 dot font
---@param column_width number @"number of characters in column. Used for offset calculations in function cursorMove. If set to `nil`,  \n functionality of cursorMove will be limited. For most displays column width is 20 characters."
---@return lc LCD_obj @screen object
---@nodiscard
function lc_meta(backend, onelinemode, eightdotsmode, column_width) end

---Autoscroll text when printing. When turned off, cursor\
---moves and text stays still, when turned on, vice versa.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function lc:autoscroll(on) end

---Control LCDs backlight. When using GPIO backend\
---without **bl** argument specification function does nothing.
---@param on boolean @`true` to turn on, `false` to turn off
---@return boolean @backlight status
function lc:backlight(on) end

---Control cursors blink mode.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function lc:blink(on) end

---Get busy status of the LCD. When using GPIO backend\
---without rw argument specification function does nothing.
---@return boolean @"`true` if device is busy,  \n `false` if device is ready to receive commands"
function lc:busy() end

---Clear LCD screen.
---@return any @sent data
function lc:clear() end

---Move cursor one character to the left.
---@return any dat @sent data
function lc:cursorLeft() end

---Move cursor to position. If **row** not specified,\
---move cursor to address **col**.
---@param col integer @"new cursor position column.  \n If row not specified, new cursor position address"
---@param row integer @new cursor position row or `nil`
---@return any @sent data
function lc:cursorMove(col, row) end

---Control cursors highlight mode.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function lc:cursor(on) end

---Move cursor one character to the right.
---@return any @sent data
function lc:cursorRight() end

---Define new custom char. Up to 8 custom characters with indexes 0 to 7\
---may be defined in eight dot mode.
---@param index number @custom char index in range from 0 to 7
---@param bytes number @"array of 8 bytes in eight bit mode or 11 bytes in ten bit mode  \n (eleventh line is a cursor line that can also be used) that defines new char bitmap  \n line by line"
---@return nil
function lc:customChar(index, bytes) end

---Turn display on and off. Does not affect display backlight.\
---Does not clear the display.
---@param on boolean @`true` to turn on, `false` to turn off
---@return any @sent data
function lc:display(on) end

---Reset cursor and screen position.
---@return any @sent data
function lc:home() end

---Print text left to right (default).
---@return any @sent data
function lc:leftToRight() end

---Get current position of the cursor. Position is 0 indexed.\
---When using GPIO backend without **rw** argument\
---specification function does nothing.
---@return number @0 indexed position of the cursor
---@nodiscard
function lc:position() end

---Return current character numerical representation. When\
---using GPIO backend without **rw** argument specification\
---function does nothing.
---@return number @numerical representation of the current character
---@nodiscard
function lc:read() end

---Return custom char byte array. When using GPIO backend\
--- without **rw** argument specification function returns zeros.
---@param index integer custom char index in range from 0 to 7
---@return table @table of size 8 in eight dot mode or 11 in ten dot mode.
---Each 8 bit number represents a character dot line
---@nodiscard
function lc:readCustom(index) end

---Print text right to left.
---@return any @sent data
function lc:rightToLeft() end

---Move text to the left.
---@return any @sent data
function lc:scrollLeft() end

---Move text to the right.
---@return any @sent data
function lc:scrollRight() end

---Print text. vararg - strings or char codes.
---@param ... string
---@return nil
function lc:write(...) end
