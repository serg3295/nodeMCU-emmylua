--=== uart ===

---@class uart
---@field PARITY_NONE integer
---@field PARITY_ODD integer
---@field PARITY_EVEN integer
---@field STOPBITS_1 integer
---@field STOPBITS_1_5 integer
---@field STOPBITS_2 integer
---@field DIR_RX integer
---@field DIR_TX integer
uart = {}

---Change UART pin assignment.
---@param on integer @0 or 1
--- - **0** for standard pins
--- - **1** to use alternate pins GPIO13 and GPIO15
---@return nil
function uart.alt(on) end

---Sets the callback function to handle UART events. To unregister the callback, provide only the `"data"` parameter.
---@param method string|'"data"' @`"data"`, data has been received on the UART.
---@param number_or_endChar? any @(optional) number or end char
--- - **number** if n=0, will receive every char in buffer
--- - **number** if n<255, the callback is called when n chars are received
--- - **end_char** if one char "c", the callback will be called when "c" is encountered, or max n=255 received
---@param callback? function|'function(data) end' @(optional) function, event `"data"` has a callback like this: `function(data) end`
---@param run_input? integer @(optional) 0 or 1.
--- - **0** input from UART will not go into Lua interpreter, and this can accept binary data.
--- - **1** input from UART is treated as a text stream with the `DEL`, `BS`, `CR` and `LF` characters processed as normal.\
---Completed lines will be passed to the Lua interpreter for execution.
---@return nil
function uart.on(method, number_or_endChar, callback, run_input) end

--- (Re-)configures the communication parameters of the UART.
---@param id integer @UART id (0 or 1).
---@param baud integer|'300'|'600'|'1200'|'2400'|'4800'|'9600'|'19200'|'31250'|'34400'|'57600'|'74880'|'115200'|'230000'|'256000'|'460800'|'921600'|'1843200'|'3686400' @300 - 3686400
---@param databits integer|'8'|'7'|'6'|'5' @5 - 8
---@param parity integer|'uart.PARITY_NONE'|'uart.PARITY_ODD'|'uart.PARITY_EVEN' @none |  even | odd
---@param stopbits integer|'uart.STOPBITS_1'|'uart.STOPBITS_1_5'|'uart.STOPBITS_2' @1 | 1.5 | 2
---@param echo? integer @(optional) 0 - disable echo, 1 - enable echo (default if omitted)
---@return number baudrate @configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo) end

---Returns the current configuration parameters of the UART.
---@param id integer @UART id (0 or 1).
---@return number baud @one of 300, ..., 3686400
---@return number databits @one of 5, 6, 7, 8
---@return number parity @uart.PARITY_NONE | uart.PARITY_ODD | uart.PARITY_EVEN
---@return number stopbits @uart.STOPBITS_1 | uart.STOPBITS_1_5 | uart.STOPBITS_2
function uart.getconfig(id) end

---Write string or byte to the UART.
---@param id integer @UART id (0 or 1).
---@param data1 string|number @... string or byte to send via UART
---@vararg string|number
---@return nil
function uart.write(id, data1, ...) end

---Report the depth, in bytes, of TX or RX hardware queues\
---associated with the UART.
---@param id integer @UART id (0 or 1).
---@param dir integer|'uart.DIR_RX'|'uart.DIR_TX' @`uart.DIR_RX` for the RX FIFO, `uart.DIR_TX` for TX FIFO.
---@return integer @The number of bytes in the selected FIFO.
function uart.fifodepth(id, dir) end
