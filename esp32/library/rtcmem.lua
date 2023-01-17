---@meta

--=== rtcmem ===

---@class rtcmem
rtcmem = {}

---Reads one or more 32bit values from RTC user memory.
---@param idx integer @zero-based index to start reading from
---@param num? integer @(optional) number of slots to read (default 1)
---@return any @The value(s) read from RTC user memory.
---If `idx` is outside the valid range [0,127] this function returns nothing.\
---If `num` results in overstepping the end of available memory,\
---the function only returns the data from the valid slots.
function rtcmem.read32(idx, num) end

---Writes one or more values to RTC user memory, starting at index `idx`.\
---Writing to indices outside the valid range [0,127] has no effect.
---@param idx integer @"zero-based index to start writing to.  \nAuto-increments if multiple values are given.""
---@param val any @value to store (32bit)
---@param ... any @(optional) additional values to store
---@return nil
function rtcmem.write32(idx, val, ...) end
