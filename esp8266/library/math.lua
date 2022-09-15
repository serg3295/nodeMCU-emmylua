---@meta

---@class math
---A value larger than any other numeric value.
---@field huge number
---An integer with the maximum value for an integer.
---@field maxinteger integer
---An integer with the minimum value for an integer.
---@field mininteger integer
---The value of *π*.
---@field pi number
math = {}

---Returns the absolute value of `x`.
---@param x number
---@return number
---@nodiscard
function math.abs(x) end

---@version 5.3
---Returns the arc cosine of `x` (in radians).
---@param x number
---@return number
---@nodiscard
function math.acos(x) end

---@version 5.3
---Returns the arc sine of `x` (in radians).
---@param x number
---@return number
---@nodiscard
function math.asin(x) end

---@version 5.3
---Returns the arc tangent of `y/x` (in radians).
---@param y number
---@param x? number
---@return number
---@nodiscard
function math.atan(y, x) end

---Returns the smallest integral value\
---larger than or equal to `x`.
---@param x number
---@return integer
---@nodiscard
function math.ceil(x) end

---@version 5.3
---Returns the cosine of `x`\
--- (assumed to be in radians).
---@param x number
---@return number
---@nodiscard
function math.cos(x) end

---@version 5.3
---Converts the angle `x` from radians to degrees.
---@param x number
---@return number
---@nodiscard
function math.deg(x) end

---@version 5.3
---Returns the value `e^x` (where `e`\
---is the base of natural logarithms).
---@param x number
---@return number
---@nodiscard
function math.exp(x) end

---Returns the largest integral value smaller\
---than or equal to `x`.
---@param x number
---@return number
---@nodiscard
function math.floor(x) end

---@version 5.3
---Returns the remainder of the division of `x` by `y`\
---that rounds the quotient towards zero.
---@param x number
---@param y number
---@return number
---@nodiscard
function math.fmod(x, y) end

---@version 5.3
---Returns the logarithm of `x` in the given base.
---@param x number
---@param base? integer
---@return number
---@nodiscard
function math.log(x, base) end

---Returns the argument with the maximum value,\
---according to the Lua operator `<`.
---@param x number
---@param ... number
---@return number
---@nodiscard
function math.max(x, ...) end

---Returns the argument with the minimum value,\
---according to the Lua operator `<`.
---@param x number
---@param ... number
---@return number
---@nodiscard
function math.min(x, ...) end

---@version 5.3
---Returns the integral part of `x`\
---and the fractional part of `x`.
---@param x number
---@return integer
---@return number
---@nodiscard
function math.modf(x) end

---@version 5.1
---Returns `x ^ y` .
---@param x number
---@param y number
---@return number
---@nodiscard
function math.pow(x, y) end

---@version 5.3
---Converts the angle `x` from degrees to radians.
---@param x number
---@return number
---@nodiscard
function math.rad(x) end

--- * `math.random()`: Returns a float in the range [0,1).
--- * `math.random(n)`: Returns a integer in the range [1, n].
--- * `math.random(m, n)`: Returns a integer in the range [m, n].
---@overload fun():number
---@overload fun(m: integer):integer
---@param m integer
---@param n integer
---@return integer
---@nodiscard
function math.random(m, n) end

---Sets `x` as the "seed" for the pseudo-random generator.
---@param x integer
function math.randomseed(x) end

---@version 5.3
---Returns the sine of `x`\
--- (assumed to be in radians).
---@param x number
---@return number
---@nodiscard
function math.sin(x) end

---Returns the square root of `x`
---@param x number
---@return number
---@nodiscard
function math.sqrt(x) end

---@version 5.3
---Returns the tangent of `x`\
---(assumed to be in radians).
---@param x number
---@return number
---@nodiscard
function math.tan(x) end

---@version 5.3
---If the value `x` is convertible to an integer,\
---returns that integer.
---@param x number
---@return integer?
function math.tointeger(x) end

---@version 5.3
---Returns `"integer"` if `x` is an integer,\
--- `"float"` if it is a float, or `nil`\
---if `x` is not a number.
---@param x any
---@return string|nil @\"integer\" | \"float\" | `nil`
---@nodiscard
function math.type(x) end

---@version 5.3
---Returns `true` if and only if `m` is below `n` when\
---they are compared as unsigned integers.
---@param m integer
---@param n integer
---@return boolean
---@nodiscard
function math.ult(m, n) end
