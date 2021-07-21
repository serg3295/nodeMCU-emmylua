---@meta

--=== fifo ===

---@class FIFO
FIFO = {}

---@class fifo
local fifo = {}

---Constructor.\
---fifo = (`require "fifo"`).new()
---@return fifo
function FIFO.new() end

---Fetch an element from the fifo and pass it to the function `k`, together with a boolean\
---indicating whether this is the last element in the fifo. If the fifo is empty,\
---`k` will not be called and the fifo will enter "immediate dequeue" mode.
---@param k function
---@return boolean @`true` if the queue contained at least one non-phantom entry, `false` otherwise.
function fifo:dequeue(k) end

---Enqueue the element `a` onto the fifo. If `k` is not `nil` and the fifo is in\
---"immediate dequeue" mode (whence it starts), immediately pass the first\
---element of the fifo (usually, but not necessarily, `a`) to `k`, as if\
---`fifo:dequeue(k)` had been called, and exit "immediate dequeue" mode.
---@param a any
---@param k any
function fifo:queue(a, k) end
