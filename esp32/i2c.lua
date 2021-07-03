--=== i2c ===

---@class i2c
---@field TRANSMITTER integer
---@field RECEIVER integer
---@field SW integer
---@field HW0 integer
---@field HW1 integer
i2c = {}

---@class slave
i2c.slave = {}

---Perform (SW) or enqueue (HWx) an I²C address operation,\
---defining data transfer direction for the next operation (read or write).
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @interface id
---@param device_addr number @I²C device address
---@param direction integer @transmitter | receiver
---|'i2c.TRANSMITTER' #for write mode
---|'i2c.RECEIVER' #for read mode
---@param ack_check_en? boolean @(optional) check for slave ACK
---|>'true' #enable check for slave ACK
---|'false' #disable check for slave ACK
---@return boolean @>
--- - for interface `i2c.SW`: returns `true` if ack received, `false` if no ack received.\
---This value should be checked to decide whether to continue communication.
--- - for interfaces `i2c.HW0` and `i2c.HW1`: always returns `true`.
function i2c.address(id, device_addr, direction, ack_check_en) end

---Perform (SW) or enqueue (HWx) a data read operation for a variable number of bytes.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @I²C interface id
---@param len number @number of data bytes to read
---@return string|nil @>
--- - for software interface `i2c.SW` : returns string of received data
--- - for hardware interfaces `id i2c.HWx` : no value returned
function i2c.read(id, len) end

---Initialize the I²C interface for master mode.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @interface id
---@param pinSDA integer @IO index
---@param pinSCL integer @IO index
---@param speed integer|'i2c.SLOW'|'i2c.FAST'|'i2c.FASTPLUS' @bit rate in Hz, integer
--- - **i2c.SLOW** - for 100000 Hz (100 KHz a.k.a Standard Mode), this is the maximum allowed value for the `i2c.SW` interface
--- - **i2c.FAST** - for 400000 Hz (400 KHz a.k.a Fast Mode)
--- - **i2c.FASTPLUS** - for 1000000 Hz (1 MHz, a.k.a. Fast-mode Plus), this is the maximum allowed value for `i2c.HWx`interfaces
---@param stretchfactor? integer @(optional) integer multiplier for timeout
---@return integer @>
--- - for interface `i2c.SW`: returns `speed` the selected speed.
--- - for interfaces `i2c.HW0` and `i2c.HW1`: returns `timeout` expressed as CPU clock cycles.
function i2c.setup(id, pinSDA, pinSCL, speed, stretchfactor) end

---Perform (SW) or enqueue (HWx) an I²C start condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @interface id
function i2c.start(id) end

---Perform (SW) or enqueue (HWx) an I²C stop condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @interface id
function i2c.stop(id) end

---Starts a transfer for the specified hardware module.
---@param id integer|'i2c.HW0'|'i2c.HW1' @hardware interface id only , `i2c.SW` not allowed
---@param callback? function @(optional) `function(data, ack)` to be called when transfer finishes
---@param to_ms? integer @(optional) timeout for the synchronous transfer in ms, defaults to **0** (infinite)
---@return any|nil @>
--- - for synchronous operation i.e. without any callback function, two values are returned
---   - **data** - string of received data (`nil` if no read or NACK)
---   - **ack** - `true` if ACK received, `false` for NACK
--- - for asynchronous operation, i.e. with a callback function, no value is returned
function i2c.transfer(id, callback, to_ms) end

---Perform (SW) or enqueue (HWx) data write to I²C bus.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' @interface id
---@param dataN string|table|number @data items can be numbers, strings or lua tables.
---@param ack_check_en? boolean @(optional)
---|>'true' #enable check for slave ACK
---|'false' #disable check for slave ACK
---@return number @number of bytes written
function i2c.write(id, dataN, ack_check_en) end

---Registers or unregisters an event callback handler.
---@param id integer|'i2c.HW0'|'i2c.HW1' @interface id
---@param event integer|'"receive"' @data received from master
---@param callback? fun(err:any, data:any) @"(optional) `function(err, data)` to be called when data was received from the master.  \n Unregisters previous callback for event when omitted."
---@return nil
function i2c.slave.on(id, event, callback) end

---@class I2cSlaveConfig
---@field sda integer
---@field scl integer
---@field addr number
-- ---@field 10bit boolean
---@field rxbuf_len integer
---@field txbuf_len integer

---Initialize the I²C interface for slave mode.
---@param id integer|'i2c.HW0'|'i2c.HW1' @interface id,
---@param slave_config I2cSlaveConfig @table containing slave configuration information
--- - **sda** IO index
--- - **scl** IO index
--- - **addr** slave address (7bit or 10bit)
--- - **10bit** enable 10bit addressing with true, use 7bit with false\
---(optional, defaults to false is omitted)
--- - **rxbuf_len** length of receive buffer (optional, defaults to 128 if omitted)
--- - **txbuf_len** length of transmit buffer (optional, defaults to 128 if omitted)
---@return nil
function i2c.slave.setup(id, slave_config) end

---Writes send data for the master into the transmit buffer. This function\
---returns immediately if there's enough room left in the buffer.\
---It blocks if the buffer is doesn't provide enough space.
---@param id integer|'i2c.HW0'|'i2c.HW1' @interface id
---@param data1 number|string|table @data can be numbers, string or lua table.
---@vararg number|string|table
---@return number @number of bytes written
function i2c.slave.send(id, data1, ...) end
