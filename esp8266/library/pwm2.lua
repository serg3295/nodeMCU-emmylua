---@meta

--=== pwm2 ===

---@class pwm2
pwm2 = {}

---Assigns PWM frequency expressed as Hz to given pin.
---@param pin integer @1-12
---@param frequencyAsHz number @desired frequency in Hz, for example 1000 for 1KHz
---@param pulsePeriod number @discreet steps in single PWM pulse, for example 100
---@param initialDuty number @initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number @(optional) an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_hz(pin,frequencyAsHz,pulsePeriod,initialDuty ,frequencyDivisor) end

---Assigns PWM frequency expressed as one impulse per second(s) to given pin.
---@param pin integer @1-12
---@param frequencyAsSec number @desired frequency as one impulse for given seconds,
---@param pulsePeriod number @discreet steps in single PWM pulse, for example 100
---@param initialDuty number @initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number @(optional) an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_sec(pin,frequencyAsSec,pulsePeriod,initialDuty ,frequencyDivisor) end

---Starts PWM for all setup pins. At this moment GPIO pins are marked\
---as output and TIMER1 is being reserved for this module.
---@return boolean @"`true` if PWM started ok,  \n `false` of TIMER1 is reserved by another module."
function pwm2.start() end

---Stops PWM for all pins. All GPIO pins\
---and TIMER1 are being released.
---@return nil
function pwm2.stop() end

---Sets duty cycle for one or more a pins.
---@param pin integer @1~12, IO index
---@param duty number @0~period, pwm duty cycle
---@param pinN? integer @(optional) 1~12, IO index
---@param dutyN? number @(optional) 0~period, pwm duty cycle
---@return nil
function pwm2.set_duty(pin, duty, pinN, dutyN) end

---Releases given pin from previously done setup.
---@param pin integer @1~12, IO index
---@return nil
function pwm2.release_pin(pin) end

---Prints internal data structures related to the timer.
---@return boolean isStarted @if `true` PWM2 has been started
---@return integer interruptTimerCPUTicks @int, desired timer interrupt period in CPU ticks
---@return integer interruptTimerTicks @int, actual timer interrupt period in timer ticks
function pwm2.get_timer_data() end

---Prints internal data structures related to given GPIO pin.
---@param pin integer @1~12, IO index
---@return boolean isPinSetup @bool, if 1 pin is setup
---@return integer duty @int, assigned duty
---@return integer pulseResolutions @int, assigned pulse periods
---@return integer divisableFrequency @int, assigned frequency
---@return integer frequencyDivisor @int, assigned frequency divisor
---@return integer resolutionCPUTicks @int, calculated one pulse period in CPU ticks
---@return integer resolutionInterruptCounterMultiplier @"int, how many timer  \n interrupts constitute one pulse period"
function pwm2.get_pin_data(pin) end
