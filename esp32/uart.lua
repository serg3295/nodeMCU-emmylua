--=== uart ===

---@class uart
---@field PARITY_NONE integer
---@field PARITY_ODD integer
---@field PARITY_EVEN integer
---@field STOPBITS_1 integer
---@field STOPBITS_1_5 integer
---@field STOPBITS_2 integer
---@field MODE_UART integer
---@field MODE_RS485_COLLISION_DETECT integer
---@field MODE_RS485_APP_CONTROL integer
---@field MODE_RS485_HALF_DUPLEX integer
---@field MODE_IRDA integer
uart = {}

---Sets the callback function to handle UART events. To unregister the callback, provide only the "data" parameter.
---@param id? integer @(optional) uart id, default value is uart num of the console.
---@param method string @data | error
---|'"data"' #"data", data has been received on the UART.
---|'"error"' #error occurred on the UART.
---@param number_or_endChar? number @(optional) Only for event data.
--- - if pass in a number *n* < 255, the callback will called when *n* chars are received.
--- - if *n* = 0, will receive every char in buffer.
--- - if pass in a one char string "c", the callback will called when "c" is encounterd, or max *n* = 255 received.
---@param callback? function @(optional) function for event
---|'function(data) end' #for event "data"
---|'function(err) end' #for event "error" `err` could be one of "out_of_memory", "break", "rx_error".
---@param run_input? integer @(optional) **0** or **1**. Only for "data" event on console uart.
---|'0' #input from UART will not go into Lua interpreter, can accept binary data.
---|'1' #input from UART will go into Lua interpreter, and run.
---@return nil
function uart.on(id, method, number_or_endChar, callback, run_input) end

---@class UartCfg
---@field tx integer
---@field rx integer
---@field cts integer
---@field rts integer
---@field tx_inverse boolean
---@field rx_inverse boolean
---@field cts_inverse boolean
---@field rts_inverse boolean
---@field flow_control integer

--- (Re-)configures the communication parameters of the UART.
---@param id integer @uart id
---@param baud integer|'300'|'600'|'1200'|'2400'|'4800'|'9600'|'19200'|'31250'|'34400'|'57600'|'74880'|'115200'|'230000'|'256000'|'460800'|'921600'|'1843200'|'3686400' @300 - 3686400
---@param databits integer|'8'|'7'|'6'|'5' @one of 5, 6, 7, 8
---@param parity integer|'uart.PARITY_NONE'|'uart.PARITY_ODD'|'uart.PARITY_EVEN' @none | odd | even
---@param stopbits integer|'uart.STOPBITS_1'|'uart.STOPBITS_1_5'|'uart.STOPBITS_2' @1 | 1.5 | 2
---@param echo_or_pins integer|UartCfg @for *console uart*, this should be a int. if 0, disable echo, otherwise enable echo; for others, this is a table:
--- - **tx** int. TX pin. Required
--- - **rx** int. RX pin. Required
--- - **cts** in. CTS pin. Optional
--- - **rts** in. RTS pin. Optional
--- - **tx_inverse** boolean. Inverse TX pin. Default: false
--- - **rx_inverse** boolean. Inverse RX pin. Default: false
--- - **cts_inverse** boolean. Inverse CTS pin. Default: false
--- - **rts_inverse** boolean. Inverse RTS pin. Default: false
--- - **flow_control** int. Combination of uart.FLOWCTRL_NONE, uart.FLOWCTRL_CTS, uart.FLOWCTRL_RTS. Default: uart.FLOWCTRL_NONE
---@return number @configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo_or_pins) end

---Returns the current configuration parameters of the UART.
---@param id integer @UART id
---@return integer baud
---@return integer databits
---@return integer parity
---@return integer stopbits
function uart.getconfig(id) end

---Start the UART. You do not need to call\
---`start()` on the console uart.
---@param id integer @uart id, except console uart
---@return boolean @`true` if uart is started.
function uart.start(id) end

---Stop the UART. You should not call `stop()`\
---on the console uart.
---@param id integer @uart id, except console uart
---@return nil
function uart.stop(id) end

---Set UART controllers communication mode
---@param id integer @uart id
---@param mode integer @value should be one of
---|>'uart.MODE_UART' #default UART mode, is set after uart.setup() call
---|'uart.MODE_RS485_COLLISION_DETECT' #receiver must be always enabled, transmitter is automatically switched using RTS pin, collision is detected by UART hardware (note: no event is generated on collision, limitation of esp-idf)
---|'uart.MODE_RS485_APP_CONTROL' #receiver/transmitter control is left to the application
---|'uart.MODE_RS485_HALF_DUPLEX' #receiver/transmitter are controlled by RTS pin
---|'uart.MODE_IRDA'
---@return nil
function uart.setmode(id, mode) end

---Wait for any data currently in the UART transmit buffers to be written out.\
---It can be useful to call this immediately before a call to `node.sleep()`\
---because otherwise data might not get written until after wakeup.
---@param id number @uart id
---@return nil
function uart.txflush(id) end

---Configure the light sleep wakeup threshold. This is the number of \
---positive edges that must be seen on the UART RX pin before\
---a light sleep wakeup will be triggered. The minimum value is 3.
---@param id integer @uart id
---@param val number @the new value. The default value is undefined.
---@return nil
function uart.wakeup(id, val) end

---Write string or byte to the UART.
---@param id integer @uart id
---@param data1 any @... string or byte to send via UART
---@vararg any @string or byte to send via UART
---@return nil
function uart.write(id, data1, ...) end
