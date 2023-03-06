---@meta

--=== cohelper ===

---@class cohelper
cohelper = {}

---Execute a function which is wrapped by a coroutine handler.
---@param func function @Lua function to be executed as a coroutine.
---@param params any @"list of 0 or more parameters used to initialise func.  \n the number and types must be matched to the funct declaration"
---@return any @Return result of first yield.
function cohelper.exec(func, params) end
