--=== bloom ===

---@class bloom
bloom = {}

---@class filter
local filter = {}

---Create a filter object.
---@param elements number @The largest number of elements to be added to the filter.
---@param errorrate number @The error rate (the false positive rate).
---@return filter objfilter @A filter object.
function bloom.create(elements, errorrate) end

---Adds a string to the set and returns an indication of whether\
---the string was already present.
---@param str string @The string to be added to the filter set.
---@return boolean @"`true` if the string was already present in the filter.  \n `false` otherwise."
function filter:add(str) end

---Checks to see if a string is present in the filter set.
---@param str string @The string to be checked for membership in the set.
---@return boolean @"`true` if the string was already present in the filter.  \n `false` otherwise."
function filter:check(str) end

---Empties the filter.
function filter:reset() end

---Get some status information on the filter.
---@return number @The number of bits in the filter.
---@return number @The number of hash functions in use.
---@return number @The number of bits set in the filter.
---@return number @The approximate chance that the next check
---will return true when it should return false
function filter:info() end
