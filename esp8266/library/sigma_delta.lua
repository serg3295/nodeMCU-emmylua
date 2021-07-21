---@meta

--=== sigma_delta ===

---@class sigma_delta
sigma_delta = {}

---Stops signal generation and reenables GPIO\
---functionality at the specified pin.
---@param pin integer @1~12
---@return nil
function sigma_delta.close(pin) end

---Sets the prescale value.
---@param value integer @prescale 1 to 255
---@return nil
function sigma_delta.setprescale(value) end

---Operate the sigma-delta module in PWM-like mode\
---with fixed base frequency.
---@param ratio integer @"0...255 for duty cycle 0...100%,  \n 0 stops the signal at low"
---@return nil
function sigma_delta.setpwmduty(ratio) end

---Sets the target value.
---@param value integer @target 0 to 255
---@return nil
function sigma_delta.settarget(value) end

---Stops the signal generator and routes it\
---to the specified pin.
---@param pin integer @1~12
---@return nil
function sigma_delta.setup(pin) end
