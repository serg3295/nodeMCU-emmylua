---@meta

--=== ftpserver ===

---@class FTP
FTP = {}

---Create the FTP server on the standard ports 20 and 21.\
---The global variable FTP is set to the server object.
---@param user string @Username for access to the server
---@param pass string @Password for access to the server
---@param dbgFlag? boolean @optional flag. If set `true` then internal debug output is printed
---@return nil
function FTP:createServer(user, pass, dbgFlag) end

---Wrapper to `createServer()` which also connects to the WiFi channel.
---@param user string @Username for access to the server
---@param pass string @Password for access to the server
---@param ssid string @SSID for WiFi service
---@param wifipwd string @password for WiFi service
---@param dbgFlag? boolean @optional flag. If set `true` then internal debug output is printed
---@return nil
function FTP:open(user, pass, ssid, wifipwd, dbgFlag) end

---Close down server including any sockets\
---and return all resources to Lua.
---@return nil
function FTP:close() end
