---@meta

--=== tls ===

---@class tls
tls = {}

---@class tls.cert
tls.cert = {}

---@class TLS
local TLS = {}

---Creates TLS connection.
---@return TLS tls.socket @sub module
function tls.createConnection() end

---Closes socket.
---@return nil
function TLS:close() end

---Connect to a remote server.
---@param port number @port number
---@param ip_domain string @IP address or domain name string
---@return nil
function TLS:connect(port, ip_domain) end

---Retrieve port and ip of peer.
---@return number @ip of peer
---@return number @port of peer
function TLS:getpeer() end

---Throttle data reception by placing a request\
---to block the TCP receive function.
---@return nil
function TLS:hold() end

---Register callback functions for specific events.
---@param event string|"dns"|"connection"|"reconnection"|"disconnection"|"receive"|"sent" @event
---@param callback fun(tls.socket:TLS, str:string) @function. The first parameter is the socket.
--- - If event is *"receive"*, the second parameter is the received data as string.
--- - If event is *"reconnection"*, the second parameter is the reason of connection error (string).
--- - If event is *"dns"*, the second parameter will be either `nil` or a string rendering of\
--- the resolved address.
---@return nil
function TLS:on(event, callback) end

---Sends data to remote peer.
---@param string string @data in string which will be sent to server
---@return nil
function TLS:send(string) end

---Unblock TCP receiving data\
---by revocation of a preceding `hold()`.
---@return nil
function TLS:unhold() end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param enable boolean @"A boolean which indicates whether verification should be enabled or not.  \n The default at boot is false."
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.verify(enable) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param pemdata string @"A string containing the CA certificate to use for verification.  \n There can be several of these."
---@param pemdata1? string @(optional)
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.verify(pemdata, pemdata1) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param callback function @A Lua function which returns TLS keys and certificates for use with connections.
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.verify(callback) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param enable boolean @"A boolean, specifying whether subsequent TLS connections  \n will present a client certificate. The default at boot is false."
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.auth(enable) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param pemdata string @"Two strings, the first containing the PEM-encoded clients  \n certificate and the second containing the PEM-encoded clients private key."
---@param pemdata1? string @(optional)
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.auth(pemdata, pemdata1) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param callback function @A Lua function which returns TLS keys and certificates for use with connections.
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.auth(callback) end
