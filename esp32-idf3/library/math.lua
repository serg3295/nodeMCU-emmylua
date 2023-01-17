---@meta

---@class math
---@field huge number
---@field pi number
math = {}

---Returns the absolute value of `x`.
---@param x number
---@return number
---@nodiscard
function math.abs(x) end

---Returns the smallest integral value larger than or equal to `x`.
---@param x number
---@return integer
---@nodiscard
function math.ceil(x) end

---Returns the largest integral value smaller than or equal to `x`.
---@param x number
---@return number
---@nodiscard
function math.floor(x) end

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

---Returns `x ^ y` .
---@param x number
---@param y number
---@return number
---@nodiscard
function math.pow(x, y) end

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

---Returns the square root of `x`.
---@param x number
---@return number
---@nodiscard
function math.sqrt(x) end
