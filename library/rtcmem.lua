---@meta

--=== rtcmem ===

---@class rtcmem
rtcmem = {}

---Reads one or more 32bit values from RTC user memory.
---@param idx integer @zero-based index to start reading from
---@param num? number @(optional) number of slots to read (default 1)
---@return any @The value(s) read from RTC user memory.
---@nodiscard
function rtcmem.read32(idx, num) end

---Writes one or more values to RTC user memory, starting at index idx.
---@param idx integer @zero-based index to start writing to.
---@param val number @value to store (32bit)
---@param ... number @(optional) additional values to store
---@return nil
function rtcmem.write32(idx, val, ...) end
