---@meta

--=== ledc ===

---@class ledc
---@field IDLE_LOW integer
---@field IDLE_HIGH integer
---@field FADE_NO_WAIT integer
---@field FADE_WAIT_DONE integer
---@field FADE_DECREASE integer
---@field FADE_INCREASE integer
---@field HIGH_SPEED integer
---@field LOW_SPEED integer
---@field TIMER_0 integer
---@field TIMER_1 integer
---@field TIMER_2 integer
---@field TIMER_10_BIT integer
---@field TIMER_11_BIT integer
---@field TIMER_12_BIT integer
---@field TIMER_13_BIT integer
---@field TIMER_14_BIT integer
---@field TIMER_15_BIT integer
---@field CHANNEL_0 integer
---@field CHANNEL_1 integer
---@field CHANNEL_2 integer
---@field CHANNEL_3 integer
---@field CHANNEL_4 integer
---@field CHANNEL_5 integer
---@field CHANNEL_6 integer
---@field CHANNEL_7 integer
ledc = {}

---@class channel
local channel = {}

---@class LedcNew
---@field gpio integer
---@field bits integer
---@field mode integer
---@field timer integer
---@field channel integer
---@field frequency integer
---@field duty integer

---Configures a PIN to be controlled by the LEDC system.
---@param tbl LedcNew @List of configuration tables:
--- - **gpio** one or more (given as list) pins, see GPIO Overview
--- - **bits** Channel duty depth. Defaults to ledc.TIMER_13_BIT.\
---Otherwise one of
---   - ledc.TIMER_10_BIT  ...   ledc.TIMER_15_BIT
--- - **mode** High-speed mode or low-speed mode
---   - ledc.HIGH_SPEED or ledc.LOW_SPEED
--- - **timer** The timer source of channel
---   - ledc.TIMER_0  ...  ledc.TIMER_3
--- - **channel** The timer source of channel
---   - ledc.CHANNEL_0  ...  ledc.CHANNEL_7
--- - **frequency** Timer frequency(Hz)
--- - **duty** Channel duty, the duty range is [0, (2**bit_num) - 1].\
---Example: if `ledc.TIMER_13_BIT` is used maximum\
---value is 4096 x 2 -1 = 8091
---@return channel @ledc.channel
---@nodiscard
function ledc.newChannel(tbl) end

---Disable LEDC output, and set idle level.
---@param idleLevel integer|`ledc.IDLE_LOW`|`ledc.IDLE_HIGH` @Set output idle level after LEDC stops.
---@return nil
function channel:stop(idleLevel) end

---Set channel frequency (Hz)
---@param frequency number @What frequency should be set
---@return nil
function channel:setfreq(frequency) end

---Get channel frequency (Hz)
---@return number @0 error; Others current LEDC frequency
---@nodiscard
function channel:getfreq() end

---Set channel duty
---@param duty number @What duty should be set
---@return nil
function channel:setduty(duty) end

---Get channel duty
---@return number @"(-1) parameter error;  \n Others current LEDC duty"
---@nodiscard
function channel:getduty() end

---Resets the timer
---@return nil
function channel:reset() end

---Pauses the timer
---@return nil
function channel:pause() end

---Resumes a paused timer
---@return nil
function channel:resume() end

---Set LEDC fade function, with a limited time.
---@param targetDuty number @Target duty of fading.
---@param maxFadeTime number @The maximum time of the fading ( ms ).
---@param wait? integer|`ledc.FADE_NO_WAIT`|`ledc.FADE_WAIT_DONE` @(optional) Whether to block until fading done.
---@return nil
function channel:fadewithtime(targetDuty, maxFadeTime, wait) end

---Set LEDC fade function, with step.
---@param targetDuty number @Target duty of fading.
---@param scale number @Controls the increase or decrease step scale.
---@param cycleNum integer @Increase or decrease the duty every cycle_num cycles
---@param wait? integer|`ledc.FADE_NO_WAIT`|`ledc.FADE_WAIT_DONE` @(optional) Whether to block until fading done.
---@return nil
function channel:fadewithstep(targetDuty, scale, cycleNum, wait) end

---Set LEDC fade function.
---@param duty number @Set the start of the gradient duty.
---@param direction integer|`ledc.FADE_DECREASE`|`ledc.FADE_INCREASE` @Set the direction of the gradient.
---@param scale number @Set gradient change amplitude.
---@param cycleNum number @Set how many LEDC tick each time the gradient lasts.
---@param stepNum number @Set the number of the gradient.
---@param wait? integer|`ledc.FADE_NO_WAIT`|`ledc.FADE_WAIT_DONE` @(optional) Whether to block until fading done.
---@return nil
function channel:fade(duty, direction, scale, cycleNum, stepNum, wait) end
