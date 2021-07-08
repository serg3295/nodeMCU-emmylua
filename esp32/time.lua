--=== time ===

---@class time
time = {}

---@class CalendarTable
---@field year integer
---@field mon integer
---@field day integer
---@field hour integer
---@field min integer
---@field sec integer

---Converts calendar table to a timestamp in Unix epoch
---@param calendar CalendarTable @Table containing calendar info.
--- - **year** 1970 ~ 2038
--- - **mon** month 1 ~ 12 in current year
--- - **day** day 1 ~ 31 in current month
--- - **hour**
--- - **min**
--- - **sec**
---@return integer @number of seconds since the Epoch
function time.cal2epoch(calendar) end

---Converts timestamp in Unix epoch to calendar format
---@param time integer @number of seconds since the Epoch
---@return { year:number, mon:number, day:number, hour:number, min:number, sec:number, yday:number, wday:number, dst:number } @A table containing the fields:
--- - **year** 1970 ~ 2038
--- - **mon** month 1 ~ 12 in current year
--- - **day** day 1 ~ 31 in current month
--- - **hour**
--- - **min**
--- - **sec**
--- - **yday** day 1 ~ 366 in current year
--- - **wday** day 1 ~ 7 in current weak (Sunday is 1)
--- - **dst** day time adjustment:
---   - 1, (DST in effect, i.e. daylight time)
---   - 0, (DST not in effect, i.e. standard time)
---   - -1, (Unknown DST status)
function time.epoch2cal(time) end

---Returns current system time in the Unix epoch\
---(seconds from midnight 1970/01/01).
---@return integer sec @seconds since the Unix epoch
---@return integer usec @the microseconds part
function time.get() end

---Returns current system time adjusted for\
---the locale in calendar format.
---@return { year:number, mon:number, day:number, hour:number, min:number, sec:number, yday:number, wday:number, dst:number } @A table containing the fields:
--- - **year** 1970 ~ 2038
--- - **mon** month 1 ~ 12 in current year
--- - **day** day 1 ~ 31 in current month
--- - **hour**
--- - **min**
--- - **sec**
--- - **yday** day 1 ~ 366 in current year
--- - **wday** day 1 ~ 7 in current weak (Sunday is 1)
--- - **dst** day time adjustment:
---   - 1, (DST in effect, i.e. daylight time)
---   - 0, (DST not in effect, i.e. standard time)
---   - -1, (Unknown DST status)
function time.getlocal() end

---Initializes and starts NTP client
---@param ntpAddr? string @"(optional) address of a NTP server,  \n defaults to 'pool.ntp.org' if none is specified"
---@return nil
function time.initntp(ntpAddr) end

---Checks if NTP client is enabled.
---@return boolean @`true' if NTP client is enabled.
function time.ntpenabled() end

---Stops NTP client.
---@return nil
function time.ntpstop() end

---Sets system time to a given timestamp in the Unix epoch\
---(seconds from midnight 1970/01/01).
---@param time integer @number of seconds since the Epoch
---@return nil
function time.set(time) end

---Sets correct format for Time Zone locale
---@param timezone string @"a string representing timezone,  \n can also include DST adjustment."
---For full syntax see [TZ variable documentation](http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html).
---@return nil
function time.settimezone(timezone) end
