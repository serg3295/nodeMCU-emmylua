---@meta

--=== tmr ===

---@class tmr
---@field ALARM_SINGLE integer
---@field ALARM_SEMI integer
---@field ALARM_AUTO integer
tmr = {}

---@class tObj
local tObj = {}

---Busyloops the processor for a specified\
---number of microseconds.
---@param us number @us microseconds to busyloop for
---@return nil
function tmr.delay(us) end

---Returns the system counter, which counts\
---in microseconds. Limited to 31 bits,\
---after that it wraps around back to zero.
---@return number @the current value of the system counter
function tmr.now() end

---Provides a simple software watchdog, which needs to be re-armed\
---or disabled before it expires, or the system will be restarted.
---@param timeout_s number @watchdog timeout, in seconds.
---To disable the watchdog, use -1 (or any other negative value).
---@return nil
function tmr.softwd(timeout_s) end

---Returns the system uptime, in seconds. Limited to\
---31 bits, after that it wraps around back to zero.
---@return number @"the system uptime, in seconds,  \n possibly wrapped around"
function tmr.time() end

---Feed the system watchdog.
---@return nil
function tmr.wdclr() end

---Get value of CPU CCOUNT register which contains CPU ticks.\
---The register is 32-bit and rolls over. Converting the register's CPU\
---ticks to us is done by dividing it to 80 or 160 (CPU80/CPU160)\
--- i.e. `tmr.ccount() / node.getcpufreq()`.\
---Register arithmetic works without need to account for roll over,\
---unlike `tmr.now()`. Because of same reason when CCOUNT is having\
--- its 32nd bit set, it appears in Lua as negative number.
---@return number @The current value of CCOUNT register.
function tmr.ccount() end

---Creates a dynamic timer object
---@return tObj @timer object
function tmr.create() end

---@alias tmr_m integer
---|`tmr.ALARM_SINGLE` #a one-shot alarm (and no need to call unregister())
---|`tmr.ALARM_SEMI` #manually repeating alarm
---|`tmr.ALARM_AUTO` #automatically repeating alarm (call start() to restart)

---This is a convenience function combining `tobj:register()` and `tobj:start()` into a single call.
---@param interval number @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode tmr_m @timer mode
---@param callback fun(t:tObj) @function which is invoked with the timer object as an argument
---@return boolean @`true` if the timer was (re)started, `false` on error
function tObj:alarm(interval, mode, callback) end

---Changes a registered timer's expiry interval.
---@param interval_ms integer @"new timer interval in milliseconds.  \n Maximum value is 6870947 (1:54:30.947).""
---@return nil
function tObj:interval(interval_ms) end

---Configures a timer and registers the callback function to call on expiry.\
---Note that registering does not start the alarm.
---@param interval_ms integer @new timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode tmr_m @timer mode
---@param callback fun(t:tObj) @function which is invoked with the timer object as an argument
---@return nil
function tObj:register(interval_ms, mode, callback) end

---Starts or restarts a previously configured timer. If the timer is running the timer is restarted\
---only when restart parameter is `true`. Otherwise `false` is returned signaling error.
---@param restart? boolean @optional boolean parameter forcing to restart already running timer
---@return boolean @`true` if the timer was (re)started, `false` on error
function tObj:start(restart) end

---Checks the state of a timer.
---@return boolean|integer|nil @"If the specified timer is registered,  \n returns whether it is currently started and its mode.  \n If the timer is not registered, `nil` is returned."
function tObj:state() end

---Stops a running timer, but does *not* unregister it.\
---A stopped timer can be restarted with `tobj:start()`.
---@return boolean @`true` if the timer was stopped, `false` on error
function tObj:stop() end

---Stops the timer (if running) and\
---unregisters the associated callback.
---@return nil
function tObj:unregister() end
