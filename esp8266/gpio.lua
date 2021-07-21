--=== gpio ===

---@class gpio
---@field OUTPUT integer
---@field INPUT integer
---@field OPENDRAIN integer
---@field INT integer
---@field PULLUP integer
---@field FLOAT integer
---@field HIGH integer
---@field LOW integer
gpio = {}

---@class gpio.pulse
gpio.pulse = {}

---@class pulser
local pulser = {}

---Initialize pin to GPIO mode, set the pin in/out direction, and optional internal weak pull-up.
---@param pin integer @pin to configure, IO index
---@param mode integer|'gpio.OUTPUT'|'gpio.INPUT'|'gpio.OPENDRAIN'|'gpio.INT' @interrupt mode
---@param pullup? integer @(optional) enables the weak pull-up resistor; default is gpio.FLOAT
---|'gpio.PULLUP'
---|>'gpio.FLOAT'
---@return nil
function gpio.mode(pin, mode , pullup) end

---Read digital GPIO pin value.
---@param pin integer @pin to read, IO index
---@return number @0 = low, 1 = high
function gpio.read(pin) end

---Serialize output based on a sequence of delay-times in µs. After each delay, the pin is toggled.\
---After the last cycle and last delay the pin is not toggled.
---@param pin integer @pin to use, IO index
---@param start_level integer|'gpio.HIGH'|'gpio.LOW' @level to start on
---@param delay_times table @an array of delay times in µs between each toggle of the gpio pin.
---@param cycle_num? integer @an optional number of times to run through the sequence. (default is 1)
---@param callback? fun() @(optional) function or `number`, if present the function returns immediately and goes asynchronous.
---@return nil
function gpio.serout(pin, start_level, delay_times , cycle_num, callback) end

---Establish or clear a callback function to run on interrupt for a pin.
---@param pin integer @1-12, pin to trigger on, IO index.
---@param type? string @(optional) If the type is 'none' or omitted then the callback function is removed and the interrupt is disabled.
---|'"up"'   #rising edge
---|'"down"' #falling edge
---|'"both"' #both edges
---|'"low"'  #low level
---|'"high"' #high level
---@param callback? fun(level:number, when:number, eventcount:number)' @(optional) `function(level, when, eventcount)` when trigger occurs. The parameters are:
--- - level - The level of the specified pin at the interrupt
--- - when - timestamp of the event
--- - eventcount - is the number of interrupts that were elided for this callback.
---@return nil
function gpio.trig(pin, type , callback) end

---Set digital GPIO pin value.
---@param pin integer @pin to write, IO index
---@param level integer|'gpio.HIGH'|'gpio.LOW' @high | low
---@return nil
function gpio.write(pin, level) end

---@class GpioPulse
---@field delay integer
---@field min integer
---@field max integer
---@field count integer
---@field loop integer

---This builds the `gpio.pulse` object from the supplied argument
---@param tbl GpioPulse @this is view as an array of instructions. Each instruction is represented by a table as follows:
--- - **[pin] = gpio.level** For example { [1] = gpio.HIGH, }. All numeric keys are considered to be pin numbers.\
---The values of each are the value to be set onto the respective GPIO line.
--- - **delay** specifies the number of microseconds after setting the pin values to wait until moving to the next state.
--- - **min** and **max** can be used to specify (along with delay) that this time can be varied.
--- - **count** and **loop** allow simple looping.
---@vararg GpioPulse
---@return pulser obj @gpio.pulse object.
function gpio.pulse.build(tbl, ...) end

---This starts the output operations.
---@param adjust? number @(optional) This is the number of microseconds to add to the next adjustable period.
---@param callback fun(position:number, steps:number, offset:number, now:number) @"This callback is executed when the pulses are complete. The callback is invoked  \n with the same four parameters that are described as the return values of `gpio.pulse:getstate`."
---@return nil
function pulser:start(adjust,  callback) end

---This returns the current state.\
---These four values are also passed into the callback functions.
---@return integer position @"is the index of the currently active state. The first state is state 1.  \n This is `nil` if the output operation is complete."
---@return integer steps @"is the number of states that have been executed (including  \n the current one). This allows monitoring of progress when there are loops."
---@return number offset @"is the time (in microseconds) until the next state transition.  \n This will be negative once the output operation is complete."
---@return number now @"is the value of the `tmr.now()` function at the instant when the `offset`  \n was calculated."
function pulser:getstate() end

---This stops the output operation at some future time.
---@param position? integer @"(optional) is the index to stop at. The stopping happens on entry to this state.  \n If not specified, then stops on the next state transition."
---@param callback? fun(position:number, steps:number, offset:number, now:number) @(optional) is invoked (with the same arguments as are returned by `:getstate`) when the operation has been stopped.
---@return boolean
function pulser:stop(position , callback) end

---This stops the output operation immediately.
---@return integer position @"is the index of the currently active state. The first state is state 1.  \n This is `nil` if the output operation is complete."
---@return integer steps @"is the number of states that have been executed (including the current one).  \n This allows monitoring of progress when there are loops."
---@return number offset @"is the time (in microseconds) until the next state transition.  \n This will be negative once the output operation is complete."
---@return number now @is the value of the `tmr.now()` function at the instant when the offset was calculated.
function pulser:cancel() end

---This adds (or subtracts) time that will get used in the `min / max` delay case.
---@param offset number @"is the number of microseconds to be used in subsequent `min / max` delays.  \n This overwrites any pending offset."
---@return integer position @"is the index of the currently active state. The first state is state 1.  \n This is `nil` if the output operation is complete."
---@return integer steps @"is the number of states that have been executed (including the current one).  \n This allows monitoring of progress when there are loops."
---@return number offset @"is the time (in microseconds) until the next state transition.  \n This will be negative once the output operation is complete."
---@return number now @is the value of the `tmr.now()` function at the instant when the `offset` was calculated.
function pulser:adjust(offset) end

---This can change the contents of a particular step in the output program.
---@param entrynum number @is the number of the entry in the original pulse sequence definition. The first entry is numbered 1.
---@param entrytable GpioPulse @this is view as an array of instructions. Each instruction is represented by a table as follows:
--- - **[pin] = gpio.level** For example { [1] = gpio.HIGH, }. All numeric keys are considered to be pin numbers.\
---The values of each are the value to be set onto the respective GPIO line.
--- - **delay** specifies the number of microseconds after setting the pin values to wait until moving to the next state.
--- - **min** and **max** can be used to specify (along with delay) that this time can be varied.
--- - **count** and **loop** allow simple looping.
function pulser:update(entrynum, entrytable) end
