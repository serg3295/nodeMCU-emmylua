---@meta

--=== pipe ===

---@class pipe
pipe = {}

---@class pobj
local pobj = {}

---Create a pipe.
---@param CB_function? fun(p:pobj) @"optional reader callback which is called through the `node.task.post()`  \n when the pipe is written to. If the CB returns a boolean, then the reposting action is forced:  \n it is reposted if `true` and not if `false`. If the return is `nil` or omitted then the deault is to repost if  \n a pipe write has occured since the last call."
---@param task_priority? integer @(optional) low | medium | high
---|`node.task.LOW_PRIORITY` #0
---|>`node.task.MEDIUM_PRIORITY` #1
---|`node.task.HIGH_PRIORITY` #2
---@return pobj @A pipe resource.
---@nodiscard
function pipe.create(CB_function, task_priority) end

---Read a record from a pipe object.
---@param size_or_endChar? number|string @(optional)
--- - If numeric then a string of size length will be returned from the pipe.
--- - If a string then this is a single character delimiter, followed by an optional "+" flag.\
---The delimiter is used as an end-of-record to split the character stream into separate records.\
---If the flag "+" is specified then the delimiter is also returned at the end of the record,\
---otherwise it is discarded.
--- - If omitted, then this defaults to "\n+"
---Note that if the last record in the pipe is missing a delimiter or is too short,\
---then it is still returned, emptying the pipe.
---@return string|nil @A string or `nil` if the pipe is empty
---@nodiscard
function pobj:read(size_or_endChar) end

---Returns a Lua **iterator** function for a pipe object.
---@param size_or_endChar? number|string @(optional)
--- - If numeric then a string of size length will be returned from the pipe.
--- - If a string then this is a single character delimiter, followed by an optional "+" flag.\
---The delimiter is used as an end-of-record to split the character stream into separate records.\
---If the flag "+" is specified then the delimiter is also returned at the end of the record,\
---otherwise it is discarded.
--- - If omitted, then this defaults to "\n+"
---@return function @`myFunc` iterator function
---@nodiscard
function pobj:reader(size_or_endChar) end

---Write a string to the head of a pipe object.\
---This can be used to back-out a previous read.
---@param s string @"Any input string. Note that with all Lua strings,  \n these may contain all character values including '\\0'."
function pobj:unread(s) end

---Write a string to a pipe object.
---@param s string @Any input string.
---Note that with all Lua strings, these may contain \
---all character values including '\0'.
function pobj:write(s) end

---Return the number of internal records in the pipe. Each\
---record ranges from 1 to 256 bytes in length, with full\
---chunks being the most common case. As extracting from \
---a pipe only to unread if too few bytes are available,\
---it may be useful to have a quickly estimated upper\
---bound on the length of the string that would be returned.
---@return number @the number of internal records in the pipe.
---@nodiscard
function pobj:nrec() end
