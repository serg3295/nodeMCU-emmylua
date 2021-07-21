---@meta

--=== mcp23017 ===

---@class mcp17
---@field INPUT boolean
---@field OUTPUT boolean
---@field GPA boolean
---@field GPB boolean
---@field HIGH boolean
---@field LOW boolean
local mcp17 = {}

---Configures the address of the module and tests the connection to the i2c bus.
---@param address number @address for MCP23017, default: 0x20 (should be between 0x20 and 0x27)
---@param i2c_id number @id for the i2c bus connection (remember to call i2c.setup before)
---@return mcp17 @"instance for mcp23017. `error` if MCP23017 address is out of range or device  \n MCP23017 on address not found."
function mcp23017(address, i2c_id) end

---Set the mode of a single channel. This can be OUTPUT or INPUT.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@param mode number @"the mode for the channel.  \n This can be mcp23017.INPUT or mcp23017.OUTPUT"
---@return boolean @`true`, in case of error `nil`.
function mcp17:setMode(register, pin, mode) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@param state number @"the state for the channel.  \n This can be mcp23017.HIGH or mcp23017.LOW"
---@return boolean @`true`, in case of error `nil`.
function mcp17:setPin(register, pin, state) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@return boolean @`true` for HIGH, `false` for LOW, in case of error `nil`.
function mcp17:getPinState(register, pin) end

---By calling this function, a safe state is established.\
---All channels are set to input.
function mcp17:reset() end

---Enable or disable the internal pullup resistors.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the pullup resistors
function mcp17:setInternalPullUp(register, byte) end

---Setup the mode of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the mode for all channels for this register
function mcp17:writeIODIR(register, byte) end

---Setup the output state of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the state for all channels for this register
function mcp17:writeGPIO(register, byte) end

---Read the input states of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@return number @byte with states
function mcp17:readGPIO(register) end
