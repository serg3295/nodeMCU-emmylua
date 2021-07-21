---@meta

--=== httpserver ===

---@class httpserver
httpserver = {}

---Function to start HTTP server.
---@param port integer @Port number for HTTP server. Most HTTP servers listen at port 80.
---@param handler fun(req:any, res:any) @"callback function for when HTTP request was made.  \n Callback function handler(req, res) has 2 arguments: `req` (request) and `res` (response)."
---@return any @net.server sub module.
function httpserver.createServer(port, handler) end
