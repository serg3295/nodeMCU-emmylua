--=== mcp4725 ===

---@class mcp4725
---@field PWRDN_NONE integer
---@field PWRDN_1K integer
---@field PWRDN_100K integer
---@field PWRDN_500K integer
mcp4725 = {}

---Gets contents of the dac register and EEPROM.
---@param tbl table @{[a0], [a1], [a2]}
--- - **A0** Address bit 0. This bit is user configurable via MCP4725 pin 6(A0).\
---(valid states: 0 or 1) (default: 0)
--- - **A1** Address bit 1. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **A2** Address bit 2. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
---@return number cur_pwrdn @Current power down configuration value.
---@return number cur_val @Current value stored in dac register.
---@return number eeprom_pwrdn @Power down configuration stored in EEPROM.
---@return number eeprom_val @DAC value stored in EEPROM.
---@return number eeprom_state @EEPROM write status
--- - 0 - EEPROM write is incomplete.
--- - 1 - EEPROM write has completed
---@return number por_state @Power-On-Reset status;
--- - 0 - The MCP4725 is performing reset and is not ready.
--- - 1 - The MCP4725 has successfully performed reset.
function mcp4725.read(tbl) end

---Write configuration to dac register or dac register and eeprom.
---@param tbl table @{[a0], [a1], [a2], value, [pwrdn], [save]}
--- - **A0** Address bit 0. This bit is user configurable via MCP4725 pin 6(A0).\
---(valid states: 0 or 1) (default: 0)
--- - **A1** Address bit 1. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **A2** Address bit 2. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **value** The value to be used to configure DAC (and EEPROM). (Range: 0 - 4095)
--- - **pwrdn** Set power down bits.
---   - mcp4725.PWRDN_NONE MCP4725 - output enabled. (Default)
---   - mcp4725.PWRDN_1K MCP4725 - output disabled,\
---output pulled to ground via 1K restistor.
---   - mcp4725.PWRDN_100K MCP4725 - output disabled,\
---output pulled to ground via 100K restistor.
---   - mcp4725.PWRDN_500K MCP4725 - output disabled,\
---output pulled to ground via 500K restistor.
--- - **save** Save pwrdn and dac values to EEPROM. (Values are loaded on power-up\
---or during reset.)
---   - `true` Save configuration to EEPROM.
---   - `false` Do not save configuration to EEPROM. (Default)
---@return nil
function mcp4725.write(tbl) end
