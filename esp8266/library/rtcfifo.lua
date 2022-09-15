---@meta

--=== rtcfifo ===

---@class rtcfifo
rtcfifo = {}

---Deep sleep until it's time to take the next sample
---@param minsleep_us number @minimum sleep time, in microseconds
function rtcfifo.dsleep_until_sample(minsleep_us) end

---Reads a sample from the rtcfifo. An offset into the rtcfifo may be specified,\
--- but by default it reads the first sample (offset 0).
---@param offset? number @(optional) Peek at sample at position `offset` in the fifo.
---@return number timestamp @timestamp in seconds
---@return number value @the value
---@return number neg_e @scaling factor
---@return any @"sensor name.If no sample is available (at the specified offset),  \n  nothing is returned."
---@nodiscard
function rtcfifo.peek(offset) end

---Reads the first sample from the rtcfifo,\
---and removes it from there.
---@return number timestamp @timestamp in seconds
---@return number value @the value
---@return number neg_e @scaling factor
---@return any @sensor name
---@nodiscard
function rtcfifo.pop() end

---Initializes the rtcfifo module for use. Calling `rtcfifo.prepare()` unconditionally re-initializes the storage - any samples stored are discarded.
---@param tbl? table @(optional) This function takes an optional configuration *table* as an argument. The following items may be configured:
--- - **interval_us** If wanting to make use of the `rtcfifo.sleep_until_sample()` function, this field sets the sample interval (in microseconds) to use.\
---It is effectively the first argument of `rtctime.dsleep_aligned()`.
--- - **sensor_count** Specifies the number of different sensors to allocate name space for. This directly corresponds to a number of slots reserved\
---for names in the variable block. The default value is 5, minimum is 1, and maximum is 16.
--- - **storage_begin** Specifies the first RTC user memory slot to use for the variable block. Default is 32. Only takes effect if storage_end is also specified.
--- - **storage_end** Specified the end of the RTC user memory slots. This slot number will not be touched. Default is 128.\
---Only takes effect if storage_begin is also specified.
---@return nil
function rtcfifo.prepare(tbl) end

---Puts a sample into the rtcfifo. If the rtcfifo has not been prepared, this function does nothing.
---@param timestamp number @Timestamp in seconds.
---@param value any @The value to store.
---@param neg_e any @The effective value stored is valueE^neg_e
---@param name string @Name of the sensor. Only the first four (ASCII) characters of name are used.
---@return nil
function rtcfifo.put(timestamp, value, neg_e, name) end

---Returns non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
---@return number @Non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
---@nodiscard
function rtcfifo.ready() end
