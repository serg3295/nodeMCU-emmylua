--=== rtctime ===

---@class rtctime
rtctime = {}

---Puts the ESP8266 into deep sleep mode, like node.dsleep().
---@param microseconds number @of microseconds to sleep for.
---@param option any @sleep option, see node.dsleep() for specifics.
function rtctime.dsleep(microseconds, option) end

---For applications where it is necessary to take samples with high regularity, this function is useful.
---@param aligned_us number @boundary interval in microseconds
---@param minsleep_us number @minimum time that will be slept, if necessary skipping an interval.
---@param option? any @(optional) as with dsleep(), the option sets the sleep option, if specified.
function rtctime.dsleep_aligned(aligned_us, minsleep_us, option) end

---Converts a Unix timestamp to calendar format.
---@param timestamp integer
---@return table rtctbl @containing the fields:
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
---@return number sec @seconds since the Unix epoch
---@return number usec @the microseconds part
---@return number rate @"the current clock rate offset.  \n This is an offset of rate / 2^32"
function rtctime.get() end

---Sets the rtctime to a given timestamp in the Unix epoch.
---@param seconds? number @(optional) the seconds part, counted from the Unix epoch
---@param microseconds? number @(optional) the microseconds part
---@param rate? number @(optional) the rate in the same units as for rtctime.get()
---@return nil
function rtctime.set(seconds, microseconds, rate) end

---This takes a time interval in 'system clock microseconds' based on\
---the timestamps returned by tmr.
---@param microseconds number @"a time interval measured in system clock  \n microseconds."
---@return number @The same interval but measured in wall clock microseconds
function rtctime.adjust_delta(microseconds) end
