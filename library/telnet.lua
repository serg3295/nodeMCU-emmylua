---@meta

--=== telnet ===

---@class telnet
telnet = {}

---Open a telnet server based on the provided parameters.
---@param ssid string
---@param pwd string
---@param port integer|`2323`
---@return nil
function telnet:open(ssid, pwd, port) end

---Close a telnet server and release all resources.
---@return nil
function telnet:close() end
