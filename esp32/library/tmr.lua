---@meta

--=== tmr ===

---@class tmr
tmr = {
	ALARM_SINGLE = 0, -- a one-shot alarm (and no need to call `unregister()`)
	ALARM_AUTO = 1, -- automatically repeating alarm
	ALARM_SEMI = 2, -- manually repeating alarm (call `start()` to restart)
}

---@class tmrObj
local tmrObj = {}

---Creates a dynamic timer object.
---@return tmrObj @timer object
---@nodiscard
function tmr.create() end

---@alias t32 integer
---|`tmr.ALARM_SINGLE` #**0**; a one-shot alarm (and no need to call unregister())
---|`tmr.ALARM_AUTO` #**1**; automatically repeating alarm (call start() to restart)
---|`tmr.ALARM_SEMI` #**2**; manually repeating alarm

---This is a convenience function combining `tmr.obj:register()` and `tmr.obj:start()` into a single call.
---@param interval integer @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 @timer mode
---@param callback fun(t:tmrObj) @function which is invoked with the timer object as an argument
---@return boolean #`true` if the timer was started, `false` on error
function tmrObj:alarm(interval, mode, callback) end

---Changes a registered timer's expiry interval.
---@param interval integer @"new timer interval in milliseconds.  \n Maximum value is 6870947 (1:54:30.947)."
---@return nil
function tmrObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval integer @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 @timer mode
---@param callback fun(t:tmrObj) @function which is invoked with the timer object as an argument
---@return nil
function tmrObj:register(interval, mode, callback) end

---Starts or restarts a previously configured timer.
---@return boolean #`true` if the timer was started, `false` on error
function tmrObj:start() end

---Checks the state of a timer.
---@return boolean|nil @If the specified timer is registered, returns whether it is currently started
---@return integer|nil @and its mode. If the timer is not registered, `nil` is returned.
function tmrObj:state() end

---Stops a running timer, but does *not* unregister it.\
---A stopped timer can be restarted with `tmr.obj:start()`.
---@return boolean #`true` if the timer was stopped, `false` on error
function tmrObj:stop() end

---Stops the timer (if running) and unregisters the associated callback.\
---This isn't necessary for one-shot timers (*tmr.ALARM_SINGLE*),\
---as those automatically unregister themselves when fired.
---@return nil
function tmrObj:unregister() end

---Resets the watchdog timer to prevent a reboot due to a perceived hung task.\
---Use with caution, as this could prevent a reboot to recover from a genuinely hung task.
---@return nil
function tmr.wdclr() end
