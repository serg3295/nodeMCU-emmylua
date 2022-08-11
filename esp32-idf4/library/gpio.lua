---@meta

--=== gpio ===

---@class gpio
---@field IN integer
---@field OUT integer
---@field IN_OUT integer
---@field FLOATING integer
---@field PULL_UP integer
---@field PULL_DOWN integer
---@field PULL_UP_DOWN integer
---@field INTR_DISABLE integer
---@field INTR_UP integer
---@field INTR_DOWN integer
---@field INTR_UP_DOWN integer
---@field INTR_LOW integer
---@field INTR_HIGH integer
---@field INTR_NONE integer
---@field DRIVE_0 integer
---@field DRIVE_1 integer
---@field DRIVE_2 integer
---@field DRIVE_DEFAULT integer
---@field DRIVE_3 integer
gpio = {}

---@class GpioConfig
---@field gpio integer|table
---@field dir integer
---@field opendrain integer
---@field pull integer

---Configure GPIO mode for one or more pins.
---@param tbl GpioConfig @List of configuration tables:
--- - **gpio** one or more (given as list) pins,
--- - **dir** direction, one of
---   - gpio.IN
---   - gpio.OUT
---   - gpio.IN_OUT
--- - **opendrain** 1 enables opendrain mode, defaults to 0 if omitted
--- - **pull** enable pull-up and -down resistors, one of
---   - gpio.FLOATING -- disables both pull-up and -down
---   - gpio.PULL_UP -- enables pull-up and disables pull-down
---   - gpio.PULL_DOWN -- enables pull-down and disables pull-up
---   - gpio.PULL_UP_DOWN -- enables both pull-up and -down
---@vararg GpioConfig
---@return nil
function gpio.config(tbl, ...) end

---Read digital GPIO pin value.
---@param pin integer @pin to read,
---@return integer @0 = low, 1 = high
function gpio.read(pin) end

---Set the drive strength of a given GPIO pin. The higher the drive strength,\
---the more current can be sourced/sunk from the pin. The exact maximum\
---depends on the power domain of the pin and how much current other pins\
---in that domain are consuming.
---@param pin integer @a valid GPIO pin number.
---@param strength number @the drive strength to set, one of
---|'gpio.DRIVE_0' #weakest drive strength
---|'gpio.DRIVE_1' #stronger drive strength
---|>'gpio.DRIVE_2' #default drive strength
---|>'gpio.DRIVE_DEFAULT' #default drive strength (same as DRIVE_2)
---|'gpio.DRIVE_3' #maximum drive strength
---@return nil
function gpio.set_drive(pin, strength) end

---Establish or clear a callback function to run on interrupt for a GPIO.
---@param pin integer @GPIO
---@param type? number @(optional) trigger type
---|'gpio.INTR_DISABLE' #or `nil` to disable interrupts on this pin (in which case `callback` is ignored and should be `nil` or omitted)
---|'gpio.INTR_UP' #for trigger on rising edge
---|'gpio.INTR_DOWN' #for trigger on falling edge
---|'gpio.INTR_UP_DOWN' #for trigger on both edges
---|'gpio.INTR_LOW' #for trigger on low level
---|'gpio.INTR_HIGH' #for trigger on high level
---@param callback? function @"(optional) function to be called when trigger fires.  \n If `nil` or omitted (and type is not `gpio.INTR_DISABLE`) then any previously-set callback will continue to be used. Parameters are:"
--- - pin
--- - level
---@return nil
function gpio.trig(pin, type, callback) end

---Configure whether the given pin should trigger wake up from light sleep initiated by `node.sleep()`.
---@param pin integer @GPIO
---@param level number @wake-up level, one of
---|'gpio.INTR_NONE' #changes to the level of this pin will not trigger wake from light sleep
---|'gpio.INTR_LOW' #if this pin is low it should trigger wake from light sleep
---|'gpio.INTR_HIGH' #if this pin is high it should trigger wake from light sleep
---@return nil
function gpio.wakeup(pin, level) end

---Set digital GPIO pin value.
---@param pin integer @pin to write
---@param level integer|'1'|'0' @**1** or **0**
---@return nil
function gpio.write(pin, level) end
