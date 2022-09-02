---@meta

--=== ds3231 ===

---@class ds3231
---@field EVERYSECOND integer
---@field EVERYMINUTE integer
---@field SECOND integer
---@field MINUTE integer
---@field HOUR integer
---@field DAY integer
---@field DATE integer
ds3231 = {}

---Sets the current date and time.
---@param second number @00-59
---@param minute number @00-59
---@param hour number @00-23
---@param day number @1-7 (Sunday = 1, Saturday = 7)
---@param date number @01-31
---@param month number @01-12
---@param year number @00-99
---@param disableOscillator? integer @(optional) 0-1, defaults to 0 if omitted
---@return nil
function ds3231.setTime(second, minute, hour, day, date, month, year, disableOscillator) end

---Get the current date and time.
---@return integer second @00-59
---@return integer minute @00-59
---@return integer hour @00-23
---@return integer day @1-7 (Sunday = 1, Saturday = 7)
---@return integer date @01-31
---@return integer month @01-12
---@return integer year @00-99
function ds3231.getTime() end

---@alias ds3231_a1 integer
---|`ds3231.EVERYSECOND` #works only with alarm1 and triggers every second;
---|`ds3231.EVERYMINUTE` #works only with alarm2 and triggers every minute (at 00 seconds);
---|`ds3231.SECOND` #triggers when time match given seconds parameter;
---|`ds3231.MINUTE` #triggers when time match given seconds and minutes parameters;
---|`ds3231.HOUR` #triggers when time match given seconds, minutes, and hours parameters;
---|`ds3231.DAY` #triggers when time match given seconds, minutes, and hours on week day date/day parameters;
---|`ds3231.DATE` #triggers when time match given seconds, minutes, and hours on date (day of the month) date/day parameters;

---Set an alarm to be triggered on SQW pin
---@param alarmId integer @1-2
---@param alarmType ds3231_a1 @1-7
---@param seconds integer @00-59
---@param minutes integer @00-59
---@param hours integer @00-23
---@param date_or_day integer @01-31 or 1-7 (Sunday = 1, Saturday = 7)
---@return nil
function ds3231.setAlarm(alarmId, alarmType, seconds, minutes, hours, date_or_day) end

---Reload an already triggered alarm.
---@return nil
function ds3231.reloadAlarms() end

---Enable an already setted alarm with the previous\
---matching conditions.
---@param alarmId integer @1-2
---@return nil
function ds3231.enableAlarm(alarmId) end

---Disable an already set alarm with the previous\
---matching conditions.
---@param alarmId integer @0-2
---@return nil
function ds3231.disableAlarm(alarmId) end

---Get bytes of control, for debug purpose,\
---and status of DS3231.
---@return integer control @0-255
---@return integer status @0-143 (bit 6-5-4 unused)
function ds3231.getBytes() end

---@return nil
function ds3231.resetStopFlag() end
