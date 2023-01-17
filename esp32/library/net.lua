---@meta

--=== net ===

---@class net
---@field TCP integer
---@field UDP integer
net = {}

---@class net.dns
net.dns = {}

---@class netsocket
local netsocket = {}

---@class netsrv
local netsrv = {}

---@class udpsocket
local udpsocket = {}

---Creates a client.
---@param type? integer|`net.TCP` @"(optional) `net.TCP` (default) or `net.UDP` There`s no such thing as  \n a UDP connection because UDP is connection*less*. Thus no connection `type` parameter  \n should be required. For UDP use `net.createUDPSocket()` instead."
---@param secure? integer @"(optional) 0 for plain (default). Secure connections are not supported,  \n and the `secure` parameter is ignored."
---@return netsocket @>
--- - for `net.TCP` - net.socket sub module
--- - for `net.UDP` - net.udpsocket sub module
---@nodiscard
function net.createConnection(type, secure) end

---Creates a server.
---@param type? integer|`net.TCP` @"(optional) The `type` parameter will be removed in upcoming  \n releases so that `net.createServer` will always create a TCP-based server.  \n For UDP use `net.createUDPSocket()` instead."
---@param timeout? integer @"(optional) for a TCP server timeout is 1~28'800 seconds,  \n 30 sec by default (for an inactive client to be disconnected)"
---@return netsrv @>
--- - for `net.TCP` - net.server sub module
--- - for `net.UDP` - net.udpsocket sub module
---@nodiscard
function net.createServer(type, timeout) end

---Creates an UDP socket.
---@return udpsocket @net.udpsocket submodule
---@nodiscard
function net.createUDPSocket() end

---Join multicast group.
---@param if_ip string @"string containing the interface ip to join the multicast group.  \n 'any' or '' affects all interfaces."
---@param multicast_ip string @of the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string @"string containing the interface ip to leave the multicast group.  \n 'any' or '' affects all interfaces."
---@param multicast_ip string @of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server.
---@return nil
function netsrv:close() end

---Listen on port from IP address.
---@overload fun(self: netsrv, callback: fun(net.socket:netsocket)): nil
---@overload fun(self: netsrv, port: integer, callback: fun(net.socket:netsocket)): nil
---@param port? integer @(optional) number, can be omitted (random port will be chosen)
---@param ip? string @(optional) IP address string, can be omitted
---@param callback fun(net.socket:netsocket) @"`function(net.socket)`, pass to caller function as param if  \n a connection is created successfully"
---@return nil
function netsrv:listen(port, ip, callback) end

---Returns server local address/port.
---@return integer|nil @port or `nil` if not listening
---@return string|nil @ip or `nil` if not listening
---@nodiscard
function netsrv:getaddr() end

---Closes socket.
---@return nil
function netsocket:close() end

---Connect to a remote server.
---@param port integer @port number
---@param ip_or_domain string @IP address or domain name string
---@return nil
function netsocket:connect(port, ip_or_domain) end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback fun(net.socket:netsocket, ip:string) @`function(net.socket, ip)`.
---The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function netsocket:dns(domain, callback) end

---Retrieve port and ip of remote peer.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
---@nodiscard
function netsocket:getpeer() end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
---@nodiscard
function netsocket:getaddr() end

---@deprecated
---This call is no longer available, as the underlying functionality was removed upstream.
---@return nil
function netsocket:hold() end

---Register callback functions for specific events.
---@param event string|"connection"|"reconnection"|"disconnection"|"receive"|"sent" @event
---@param callback fun(net.socket:netsocket, str:string) @`function(net.socket[, string])`. Can be `nil` to remove callback.
---The first parameter of callback is the socket.
--- - If event is `"receive"`, the second parameter is the received data as string.
--- - If event is `"disconnection"` or `"reconnection"`, the second parameter is error code.\
--If `"reconnection"` event is specified, disconnection receives only "normal close" events.\
--Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function netsocket:on(event, callback) end

---Sends data to remote peer.
---@param str string @data in string which will be sent to server
---@param callback? fun(sent:string) @(optional) `function(sent)` for sending string
---@return nil
function netsocket:send(str, callback) end

---@deprecated
---This call is no longer available, as the underlying functionality was removed upstream.
---@return nil
function netsocket:unhold() end

---Closes UDP socket.
---@return nil
function udpsocket:close() end

---Listen on port from IP address.
---@param port? integer @(optional) port number, can be omitted (random port will be chosen)
---@param ip? string @(optional) IP address string, can be omitted
---@return nil
function udpsocket:listen(port, ip) end

---Register callback functions for specific events.
---@param event string|"receive"|"sent"|"dns" @receive | sent | dns
---@param callback fun(net.socket:netsocket, str:string) @`function(net.socket[, string])`. Can be `nil` to remove callback.
---The first parameter of callback is the socket.
--- - If event is `"receive"`, the second parameter is the received data as string.\
---The `receive` callback receives port and ip *after* the data argument.\
---Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function udpsocket:on(event, callback) end

---Sends data to specific remote peer.
---@param port integer @remote socket port
---@param ip string @remote socket IP
---@param data any @the payload to send
---@return nil
function udpsocket:send(port, ip, data) end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback fun(net.socket:netsocket, ip:string) @`function(net.socket, ip)`.
---The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function udpsocket:dns(domain, callback) end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
---@nodiscard
function udpsocket:getaddr() end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer|`0`|`1` @which DNS server to get (range 0~1)
---@return string @IP address (string) of DNS server
---@nodiscard
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. Doesn't require a socket like `net.socket.dns()`.
---@param host string @hostname to resolve
---@param callback fun(ip:string) @`function(ip)` called when the name was resolved.
---@return nil
function net.dns.resolve(host, callback) end

---Sets the IP of the DNS server used to resolve hostnames.
---@param dns_ip_addr string @IP address of a DNS server. Default: resolver1.opendns.com (208.67.222.222).
---@param dns_index integer|`0`|`1` @which DNS server to set (range 0~1). Hence, it supports max. 2 servers.
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end
