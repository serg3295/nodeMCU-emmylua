---@meta

--=== rtctime ===

---@class rtctime
rtctime = {}

---Puts the ESP8266 into deep sleep mode, like node.dsleep().
---@param microseconds integer @of microseconds to sleep for.
---@param option integer|nil @sleep option, see node.dsleep() for specifics.
function rtctime.dsleep(microseconds, option) end

---For applications where it is necessary to take samples with high regularity, this function is useful.
---@param aligned_us integer @boundary interval in microseconds
---@param minsleep_us integer @minimum time that will be slept, if necessary skipping an interval.
---@param option? integer|nil @(optional) as with dsleep(), the option sets the sleep option, if specified.
function rtctime.dsleep_aligned(aligned_us, minsleep_us, option) end

---Converts a Unix timestamp to calendar format.
---@param timestamp integer
---@return { year:integer, mon:integer, day:integer, hour:integer, min:integer, sec:integer, yday:integer, wday:integer } rtctbl @containing the fields:
--- - **year** 1970 ~ 2038
--- - **mon** month 1 ~ 12 in current year
--- - **day** day 1 ~ 31 in current month
--- - **hour**
--- - **min**
--- - **sec**
--- - **yday** day 1 ~ 366 in current year
--- - **wday** day 1 ~ 7 in current weak (Sunday is 1)
function rtctime.epoch2cal(timestamp) end

---Returns the current time.
---@return integer sec @seconds since the Unix epoch
---@return integer usec @the microseconds part
---@return integer rate @"the current clock rate offset.  \n This is an offset of rate / 2^32"
function rtctime.get() end

---Sets the rtctime to a given timestamp in the Unix epoch.
---@param seconds? integer @(optional) the seconds part, counted from the Unix epoch
---@param microseconds? integer @(optional) the microseconds part
---@param rate? integer @(optional) the rate in the same units as for rtctime.get()
---@return nil
function rtctime.set(seconds, microseconds, rate) end

---This takes a time interval in 'system clock microseconds' based on\
---the timestamps returned by tmr.
---@param microseconds integer @"a time interval measured in system clock  \n microseconds."
---@return integer @The same interval but measured in wall clock microseconds
function rtctime.adjust_delta(microseconds) end
