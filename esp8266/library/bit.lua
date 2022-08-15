---@meta

--=== bit ===

---@class bit
bit = {}

---Arithmetic right shift a number equivalent to `value >> shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted right (arithmetically)
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1 & val2 & ... & valn` in C.
---@param val1 integer @first *AND* argument
---@param val2 integer @second *AND* argument
---@param ... integer
---@return integer @the bitwise *AND* of all the arguments
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation).\
---Equivalent to `1 << position` in C.
---@param position number @position of the bit that will be set to 1
---@return number @a number with only one 1 bit at position (the rest are set to 0)
function bit.bit(position) end

---Bitwise negation, equivalent to `~value` in C.
---@param value number @the number to negate
---@return number @the bitwise negated value of the number
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1 | val2 | ... | valn` in C.
---@param val1 integer @first *OR* argument.
---@param val2 integer @second *OR* argument.
---@param ... integer
---@return integer @the bitwise *OR* of all the arguments
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1 ^ val2 ^ ... ^ valn` in C.
---@param val1 integer @first *XOR* argument
---@param val2 integer @second *XOR* argument
---@param ... integer
---@return integer @the bitwise *XOR* of all the arguments
function bit.bxor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer @the base number
---@param pos1 integer @position of the first bit to clear
---@param ... integer
---@return integer @the number with the bit(s) cleared in the given position(s)
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 0, `false` otherwise
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value number @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 1, `false` otherwise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value << shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted left
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to\
---`( unsigned )value >> shift` in C.
---@param value integer @the value to shift.
---@param shift integer @positions to shift.
---@return integer @the number shifted right (logically)
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer @the base number.
---@param pos1 integer @position of the first bit to set.
---@param ... integer
---@return integer @the number with the bit(s) set in the given position(s)
function bit.set(value, pos1, ...) end
