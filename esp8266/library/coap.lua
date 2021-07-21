--=== coap ===

---@class coap
---@field CON integer
---@field NON integer
---@field TEXT_PLAIN integer
---@field LINKFORMAT integer
---@field XML integer
---@field OCTET_STREAM integer
---@field EXI integer
---@field JSON integer
coap = {}

---@class coap_client
local coap_client = {}

---@class coap_server
local coap_server = {}

---Creates a CoAP client.
---@return coap_client @CoAP client
function coap.Client() end

---Creates a CoAP server.
---@return coap_server @CoAP server
function coap.Server() end

---Issues a GET request to the server.
---@param type number|'coap.CON'|'coap.NON' @"defaults to CON. If the type is CON and request fails, the library  \n retries four more times before giving up."
---@param uri string @"the URI such as 'coap://192.168.18.103:5683/v1/v/myvar',  \n only IP addresses are supported i.e. no hostname resoltion."
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:get(type, uri, payload) end

---Issues a PUT request to the server.
---@param type number|'coap.CON'|'coap.NON' @"defaults to CON. If the type is CON and request fails, the library  \n retries four more times before giving up."
---@param uri string @"the URI such as 'coap://192.168.18.103:5683/v1/v/myvar',  \n only IP addresses are supported i.e. no hostname resoltion."
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:put(type, uri, payload) end

---Issues a POST request to the server.
---@param type number|'coap.CON'|'coap.NON' @"defaults to CON. when type is CON, and request failed,  \n the request will retry another 4 times before giving up."
---@param uri string @the uri such as coap://192.168.18.103:5683/v1/v/myvar, only IP is supported.
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:post(type, uri, payload) end

---Issues a DELETE request to the server.
---@param type number|'coap.CON'|'coap.NON' @"defaults to CON. If the type is CON and request fails,  \n the library retries four more times before giving up."
---@param uri string @"the URI such as 'coap://192.168.18.103:5683/v1/v/myvar',  \n only IP addresses are supported i.e. no hostname resoltion."
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:delete(type, uri, payload) end

---Starts the CoAP server on the given port.
---@param port number @server port
---@param ip? any @(optional) IP address
---@return nil
function coap_server:listen(port, ip) end

---Closes the CoAP server.
---@return nil
function coap_server:close() end

---Registers a Lua variable as an endpoint in the server.
---@param name string @the Lua variable's name
---@param content_type? any @(optional) defaults to coap.TEXT_PLAIN
---@return nil
function coap_server:var(name, content_type) end

---Registers a Lua function as an endpoint in the server.
---@param name string @the Lua function's name
---@param content_type? any @(optional) defaults to coap.TEXT_PLAIN
---@return nil
function coap_server:func(name, content_type) end
