---@meta

--=== bit ===

---@class bit
bit = {}

---Arithmetic right shift a number equivalent to `value >> shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted right (arithmetically)
---@nodiscard
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1 & val2 & ... & valn` in C.
---@param val1 integer @first *AND* argument
---@param val2 integer @second *AND* argument
---@param ... integer
---@return integer @the bitwise *AND* of all the arguments
---@nodiscard
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation).\
---Equivalent to `1 << position` in C
---@param position integer @position of the bit that will be set to 1
---@return integer @a number with only one 1 bit at position (the rest are set to 0)
---@nodiscard
function bit.bit(position) end

---Bitwise negation, equivalent to `~value` in C.
---@param value integer @the number to negate
---@return integer @the bitwise negated value of the number
---@nodiscard
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1 | val2 | ... | valn` in C.
---@param val1 integer @first *OR* argument.
---@param val2 integer @second *OR* argument.
---@param ... integer
---@return integer @the bitwise *OR* of all the arguments
---@nodiscard
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1 ^ val2 ^ ... ^ valn` in C.
---@param val1 integer @first *XOR* argument
---@param val2 integer @second *XOR* argument
---@param ... integer
---@return integer @the bitwise *XOR* of all the arguments
---@nodiscard
function bit.bxor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer @the base number
---@param pos1 integer @position of the first bit to clear
---@param ... integer
---@return integer @the number with the bit(s) cleared in the given position(s)
---@nodiscard
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 0, `false` othewise
---@nodiscard
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value integer @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 0, `false` othewise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value << shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted left
---@nodiscard
function bit.lshift(value, shift) end

---Logical right shift a number, quivalent to\
---`( unsigned )value >> shift` in C.
---@param value integer @the value to shift.
---@param shift integer @positions to shift.
---@return integer @the number shifted right (logically)
---@nodiscard
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer @the base number.
---@param pos1 integer @position of the first bit to set.
---@param ... integer
---@return integer @the number with the bit(s) set in the given position(s)
---@nodiscard
function bit.set(value, pos1, ...) end
