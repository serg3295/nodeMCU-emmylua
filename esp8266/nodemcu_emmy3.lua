
--#region
--[[ i2c4bit_meta = require("lc-i2c4bit")
gpio4bit_meta = require("lc-gpio4bit")
gpio8bit_meta = require("lc-gpio8bit") ]]

--[[ ---@class gpio4bit : backend_obj
local backend_obj = gpio4bit_meta{}

---@class gpio8bit : backend_obj
local backend_obj = gpio8bit_meta{}

---@class i2c4bit : backend_obj
local backend_obj = i2c4bit_meta{} ]]
--#endregion

--*** LIQUID CRYSTAL TODO ***
---@class liquidcrystal
local liquidcrystal = lc_meta()

---@class backend_obj

--- Loading I²C backend module returns initialization closure. It configures I²C backend and returns backend object.
---@param tbl table
--**sda**: I²C data pin. If set to nil, I²C bus initialization step via i2c.setup will be skipped
--**scl**: I²C clock pin. If set to nil, I²C bus initialization step via i2c.setup will be skipped
--**busid**: I²C bus ID. Defaults to 0
--**busad**: chip I²C address. Defaults to 0x27 (default PCF8574 address)
--**speed**: I²C speed. Defaults to i2c.SLOW
--**rs**: bit position assigned to RS pin in I²C word. Defaults to 0
--**rw**: bit position assigned to RW pin in I²C word. Defaults to 1
--**en**: bit position assigned to EN pin in I²C word. Defaults to 2
--**bl**: bit position assigned to backlight pin in I²C word. Defaults to 3
--**d4**: bit position assigned to D4 pin in I²C word. Defaults to 4
--**d5**: bit position assigned to D5 pin in I²C word. Defaults to 5
--**d6**: bit position assigned to D6 pin in I²C word. Defaults to 6
--**d7**: bit position assigned to D7 pin in I²C word. Defaults to 7
---@return backend_obj --backend object
function i2c4bit_meta(tbl) end

---Loading GPIO 4 bit backend module returns initialization closure. It configures GPIO 4 bit backend and returns backend object.
---@param tbl table
--**rs**: GPIO pin connected to RS pin. Defaults to 0
--**rw**: GPIO pin connected to RW pin. If set to nil then busy, position and readChar functions will not be available. Note that RW pin must be pulled to the ground if not connected to GPIO
--**en**: GPIO pin connected to EN pin. Defaults to 1
--**bl**: GPIO pin controlling backlight. It is assumed, that high level turns backlight on, low level turns backlight off. If set to nil then backlight function will not be available
--**d4**: GPIO pin connected to D4 pin. Defaults to 2
--**d5**: GPIO pin connected to D5 pin. Defaults to 3
--**d6**: GPIO pin connected to D6 pin. Defaults to 4
--**d7**: GPIO pin connected to D7 pin. Defaults to 5
---@return backend_obj --backend object
function gpio4bit_meta(tbl) end

---Loading GPIO 8 bit backend module returns initialization closure. It configures GPIO 8 bit backend and returns backend object.
---@param tbl table
--**rs**: GPIO pin connected to RS pin. Defaults to 0
--**rw**: GPIO pin connected to RW pin. If set to nil then busy, position and readChar functions will not be available. Note that RW pin must be pulled to the ground if not connected to GPIO
--**en**: GPIO pin connected to EN pin. Defaults to 1
--**bl**: GPIO pin controlling backlight. It is assumed, that high level turns backlight on, low level turns backlight off. If set to nil then backlight function will not be available
--**d0**: GPIO pin connected to D0 pin. Defaults to 2
--**d1**: GPIO pin connected to D1 pin. Defaults to 3
--**d2**: GPIO pin connected to D2 pin. Defaults to 4
--**d3**: GPIO pin connected to D3 pin. Defaults to 5
--**d4**: GPIO pin connected to D4 pin. Defaults to 6
--**d5**: GPIO pin connected to D5 pin. Defaults to 7
--**d6**: GPIO pin connected to D6 pin. Defaults to 8
--**d7**: GPIO pin connected to D7 pin. Defaults to 9
---@return backend_obj --backend object
function gpio8bit_meta(tbl) end

---Loading Liquidcrystal module returns initialization closure. It requires backend object and returns LCD object.
---@param backend backend_obj backend object
---@param onelinemode boolean `true` to use one line mode, `false` to use two line mode
---@param eightdotsmode boolean `true` to use 5x8 dot font, `false` to use 5x10 dot font
---@param column_width number number of characters in column. Used for offset calculations in function cursorMove. If set to nil, functionality of cursorMove will be limited. For most displays column width is 20 characters.
---@return liquidcrystal LCD_obj screen object
function lc_meta(backend, onelinemode, eightdotsmode, column_width) end

---Autoscroll text when printing. When turned off, cursor moves and text stays still, when turned on, vice versa.
---@param on boolean `true` to turn on, `false` to turn off
---@return any --sent data
function liquidcrystal:autoscroll(on) end

---Control LCDs backlight. When using GPIO backend without **bl** argument specification function does nothing.
---@param on boolean `true` to turn on, `false` to turn off
---@return boolean --backlight status
function liquidcrystal:backlight(on) end

---Control cursors blink mode.
---@param on boolean true to turn on, false to turn off
---@return any --sent data
function liquidcrystal:blink(on) end

---Get busy status of the LCD. When using GPIO backend without rw argument specification function does nothing.
---@return boolean --`true` if device is busy, `false` if device is ready to receive commands
function liquidcrystal:busy() end

---Clear LCD screen.
---@return any --sent data
function liquidcrystal:clear() end

---Move cursor one character to the left.
---@return any dat sent data
function liquidcrystal:cursorLeft() end

---Move cursor to position. If **row** not specified, move cursor to address **col**.
---@param col integer new cursor position column. If row not specified, new cursor position address
---@param row integer new cursor position row or `nil`
---@return any --sent data
function liquidcrystal:cursorMove(col, row) end

---Control cursors highlight mode.
---@param on boolean `true` to turn on, `false` to turn off
---@return any --sent data
function liquidcrystal:cursor(on) end

---Move cursor one character to the right.
---@return any --sent data
function liquidcrystal:cursorRight() end

---Define new custom char. Up to 8 custom characters with indexes 0 to 7 may be defined in eight dot mode.
---@param index number custom char index in range from 0 to 7
---@param bytes number array of 8 bytes in eight bit mode or 11 bytes in ten bit mode (eleventh line is a cursor line that can also be used) that defines new char bitmap line by line
---@return nil
function liquidcrystal:customChar(index, bytes) end

---Turn display on and off. Does not affect display backlight. Does not clear the display.
---@param on boolean `true` to turn on, `false` to turn off
---@return any --sent data
function liquidcrystal:display(on) end

---Reset cursor and screen position.
---@return any --sent data
function liquidcrystal:home() end

---Print text left to right (default).
---@return any --sent data
function liquidcrystal:leftToRight() end

---Get current position of the cursor. Position is 0 indexed. When using GPIO backend without **rw** argument specification function does nothing.
---@return number --0 indexed position of the cursor
function liquidcrystal:position() end

---Return current character numerical representation. When using GPIO backend without **rw** argument specification function does nothing.
---@return number --numerical representation of the current character
function liquidcrystal:read() end

---Return custom char byte array. When using GPIO backend without **rw** argument specification function returns zeros.
---@param index integer custom char index in range from 0 to 7
---@return table --table of size 8 in eight dot mode or 11 in ten dot mode. Each 8 bit number represents a character dot line
function liquidcrystal:readCustom(index) end

---Print text right to left.
---@return any --sent data
function liquidcrystal:rightToLeft() end

---Move text to the left.
---@return any --sent data
function liquidcrystal:scrollLeft() end

---Move text to the right.
---@return any --sent data
function liquidcrystal:scrollRight() end

---Print text.
---@vararg string strings or char codes.
---@return nil
function liquidcrystal:write(...) end

--*** U8G2 TODO ***
u8g2 = {}

--*** UCG TODO ***
ucg ={}

--*** COHELPER TODO ***

--*** FIFO TODO ***
fifo = {}

--*** GOSSIP ***
gossip = {}

---Sets the configuration for gossip.
---@param config table config table. The available options are:
--**seedList**: the list of seeds gossip will start with; this will be updated as new nodes are discovered. Note that it's enough for all nodes to start with the same IP in the seedList, as once they have one seed in common, the data will propagate. Default: `nil`.
--**roundInterval**: interval in milliseconds at which gossip will pick a random node from the seed list and send a SYN request. Default: 10000 (10 seconds)
--**comPort**: port for the listening UDP socket. Default: 5000.
--**debug**: flag that will provide debugging messages. Default: false.
--**debugOutput**: if debug is set to true, then this method will be used as a callback with the debug message as the first parameter. Default: print
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
---@param data any|nil By calling `pushGossip(nil)` you effectively remove the **data** table from the node's network state and notify other nodes of this.
---@param ip? string The IP is optional and if none given, it will pick a random node.
function gossip.pushGossip(data, ip) end

---The only scenario when rev should be set manually is when a new node is added to the network and has the same IP. Having a smaller revision than the previous node with the same IP would make gossip think the data it received is old, thus ignoring it.
function gossip.setRevFileValue(number) end

---The network state can be directly accessed as a Lua table : `gossip.networkState` or it can be received as a JSON with this method.
---@return string --JSON formatted string regarding the network state.
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
---@param enable boolean If `true`, then output is wrapped in gdb remote debugging protocol. If `false`, then it is sent straight to the UART.
function gdbstub.gdboutput(enable) end
