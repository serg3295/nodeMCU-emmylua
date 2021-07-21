---@meta

--=== mcp23008 ===

---@class mcp23008
mcp23008 = {}

---Sets the MCP23008 device address's last three bits.
---@param address number @The 3 least significant bits (LSB) of the address
---@param pinSDA number @The pin to use for SDA
---@param pinSCL number @The pin to use for SCL
---@param speed number @The speed of the I2C signal
---@return nil
function mcp23008.begin(address, pinSDA, pinSCL, speed) end

---Writes a byte of data to the GPIO register.
---@param dataByte number @The byte of data to write
---@return nil
function mcp23008.writeGPIO(dataByte) end

---Reads a byte of data from the GPIO register
---@return number @One byte of data
function mcp23008.readGPIO() end

---Writes one byte of data to the IODIR register.
---@param dataByte number @The byte of data to write
---@return nil
function mcp23008.writeIODIR(dataByte) end

---Writes one byte of data to the IODIR register.
---@return number @The byte of data in IODIR
function mcp23008.readIODIR() end

---Writes a byte of data to the GPPU (Pull-UP resistors register)
---@param dataByte number @"the value to write to the GPPU register.  \n Each bit in this byte is assigned to an individual GPIO pin"
---@return nil
function mcp23008.writeGPPU(dataByte) end

---Reads the GPPU (Pull-UP resistors register) byte
---@return number @The GPPU byte i.e. state of all internal pull-up resistors
function mcp23008.readGPPU() end
