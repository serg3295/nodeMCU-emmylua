---@meta

--=== pwm ===

---@class pwm
pwm = {}

---Quit PWM mode for the specified GPIO pin.
---@param pin integer @1~12, IO index
---@return nil
function pwm.close(pin) end

---Get selected PWM frequency of pin.
---@param pin integer @1~12, IO index
---@return number @PWM frequency of pin
function pwm.getclock(pin) end

---Get selected duty cycle of pin.
---@param pin integer @1~12, IO index
---@return number @duty cycle, max 1023
function pwm.getduty(pin) end

---Set PWM frequency.
---@param pin integer @1~12, IO index
---@param clock integer @1~1000, PWM frequency
---@return nil
function pwm.setclock(pin, clock) end

---Set duty cycle for a pin.
---@param pin integer @1~12, IO index
---@param duty integer @0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setduty(pin, duty) end

---Set pin to PWM mode. Only 6 pins can be set to PWM mode at the most.
---@param pin integer @1~12, IO index
---@param clock integer @1~1000, PWM frequency
---@param duty integer @0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setup(pin, clock, duty) end

---PWM starts, the waveform is applied to the GPIO pin.
---@param pin integer @1~12, IO index
---@return nil
function pwm.start(pin) end

---Pause the output of the PWM waveform.
---@param pin integer @1~12, IO index
---@return nil
function pwm.stop(pin) end
