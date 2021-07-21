--=== websocket ===

---@class websocket
websocket = {}

---@class ws
local ws = {}

---Creates a new websocket client. This client should be stored in a variable\
---and will provide all the functions to handle a connection.\
---When the connection becomes closed, the same client can still be reused -\
---the callback functions are kept - and you can connect again to any server.\
---Before disposing the client, make sure to call `ws:close()`.
---@return ws websocketclient
function websocket.createClient() end

---Closes a websocket connection. he client issues a close frame and\
---attempts to gracefully close the websocket. If server doesn't reply,\
---the connection is terminated after a small timeout. This function\
---can be called even if the websocket isn't connected. This function\
---must *always* be called before disposing the reference\
---to the websocket client.
---@return nil
function ws:close() end

---@class WsCfg
---@field headers table

---Configures websocket client instance.
---@param params WsCfg @"with configuration parameters.  \n Following keys are recognized:  \n **headers** - table of extra request headers affecting every request"
---@return nil
function ws:config(params) end

---Attempts to establish a websocket connection to the given URL.
---@param url string @the URL for the websocket.
---@return nil @"`nil`. If it fails, an error will be delivered via  \n `websocket:on('close', handler)`."
function ws:connect(url) end

---Registers the callback function to handle websockets events\
---(there can be only one handler function registered per event type).
---@param eventName integer|'connection'|'receive'|'close' @the type of websocket event to register the callback function
---@param callback function|'funtion(ws, ...) end' @"The function first parameter is always the **websocketclient**.  \n Other arguments are required depending on the event type. If `nil`, any previously  \n configured callback is unregistered."
---@return nil
function ws:on(eventName, callback) end

---Sends a message through the websocket connection.
---@param message any @the data to send.
---@param opcode integer @"optionally set the opcode  \n (default: 1, text message)"
---@return nil @'nil', or an error if socket is not connected
function ws:send(message, opcode) end
