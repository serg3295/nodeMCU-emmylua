---@meta

--=== tmr ===

---@class tmr
---@field ALARM_AUTO integer
---@field ALARM_SINGLE integer
---@field ALARM_SEMI integer
tmr = {}

---@class tObj
local tObj = {}

---Creates a dynamic timer object.
---@return tObj @timer object
function tmr.create() end

---@alias t32 integer
---|`tmr.ALARM_AUTO` #automatically repeating alarm
---|`tmr.ALARM_SINGLE` #a one-shot alarm (and no need to call tmr.unregister())
---|`tmr.ALARM_SEMI` #manually repeating alarm (call tmr.start() to restart)

---This is a convenience function combining `tmr.obj:register()` and `tmr.obj:start()` into a single call.
---@param interval integer @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 @timer mode
---@param callback fun(t:tObj) @function which is invoked with the timer object as an argument
---@return boolean
function tObj:alarm(interval, mode, callback) end

---Changes a registered timer's expiry interval.
---@param interval integer @"new timer interval in milliseconds.  \n Maximum value is 6870947 (1:54:30.947)."
---@return nil
function tObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval integer @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 @timer mode
---@param callback fun(t:tObj) @function which is invoked with the timer object as an argument
---@return nil
function tObj:register(interval, mode, callback) end

---Starts or restarts a previously configured timer.
---@return boolean
function tObj:start() end

---Checks the state of a timer.
---@return boolean|nil @If the specified timer is registered, returns whether it is currently started
---@return integer|nil @and its mode. If the timer is not registered, `nil` is returned.
function tObj:state() end

---Stops a running timer, but does not unregister it.\
---A stopped timer can be restarted with `tmr.obj:start()`.
---@return boolean
function tObj:stop() end

---Stops the timer (if running) and unregisters the associated callback.\
---This isn't necessary for one-shot timers (*tmr.ALARM_SINGLE*),\
---as those automatically unregister themselves when fired.
---@return nil
function tObj:unregister() end
