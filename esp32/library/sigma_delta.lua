---@meta

--=== sigma_delta ===

---@class sigma_delta
sigma_delta = {}

---Reenables GPIO functionality at the related pin.
---@param channel integer @0~7, sigma-delta channel index
---@return nil
function sigma_delta.close(channel) end

---Sets the prescale value.
---@param channel integer @0~7, sigma-delta channel index
---@param value integer @prescale 1 to 255
---@return nil
function sigma_delta.setprescale(channel, value) end

---Sets the duty value.
---@param channel integer @0~7, sigma-delta channel index
---@param value integer @duty -128 to 127
---@return nil
function sigma_delta.setduty(channel, value) end

---Routes the sigma-delta channel to the specified pin. Target prescale and duty\
---values should be applied prior to enabling the output with this command.
---@param channel integer @0~7, sigma-delta channel index
---@param pin integer @IO index
---@return nil
function sigma_delta.setup(channel, pin) end
