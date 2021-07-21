--=== lm92 ===

---@class lm92
lm92 = {}

---Function used to setup the address for lm92.
---@param address number @I²C address used by LM92.
---@return nil
function lm92.setup(address) end

---Returns the temperature register's content.
---@return number Temperature @in degree Celsius.
function lm92.getTemperature() end

---Makes the chip enter the low power shutdown mode.
---@return nil
function lm92.shutdown() end

---Makes the chip exit the low power shutdown mode.
---@return nil
function lm92.wakeup() end

---Set hysteresis Temperature.
---@param htemp number @Hysteresis temperature from 130 to -55 in ºC
---@return nil
function lm92.setThyst(htemp) end

---Set Critical Temperature.
---@param ctemp number @Critical temperature from 130 to -55 in ºC
---@return nil
function lm92.setTcrit(ctemp) end

---Set Low Window Temperature.
---@param lwtemp number @Low window temperature from 130 to -55 in ºC
---@return nil
function lm92.setTlow(lwtemp) end

---Set High Window Temperature.
---@param hwtemp number @High window temperature from 130 to -55 in ºC
---@return nil
function lm92.setThigh(hwtemp) end

---Get hysteresis Temperature.
---@return number @Hysteresis Temperature in degree Celsius.
function lm92.getThyst() end

---Get Critical Temperature.
---@return number @Critical Temperature in degree Celsius.
function lm92.getTcrit() end

---Get Low Window Temperature.
---@return number @Low Window Temperature in degree Celsius.
function lm92.getTlow() end

---Get High Window Temperature.
---@return number @High Window Temperature in degree Celsius.
function lm92.getThigh() end
