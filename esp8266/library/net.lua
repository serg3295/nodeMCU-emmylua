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

---Creates a TCP client.
---@return netsocket @net.socket submodule
function net.createConnection() end

---Creates a TCP listening socket (a server).
---@param timeout integer @"seconds until disconnecting an inactive client;  \n 1~28'800 seconds, 30 sec by default."
---@return netsrv @net.server submodule
function net.createServer(timeout) end

---Creates an UDP socket.
---@return udpsocket @net.udpsocket submodule
function net.createUDPSocket() end

---Return information about a network interface, specified by index.
---@param if_index integer @the interface index; on ESP8266, **0** is the wifi client (STA) and **1** is the wifi AP.
---@return table|nil @`nil` if the given if_index does not correspond to an interface. Otherwise, a table containing ...
---**ip**, **netmask**, and **gateway** configured for this interface, as dotted quad strings or nil if none is set.\
---if DHCP was used to configure the interface, then dhcp will be a table containing...
--- - server_ip - the DHCP server itself, as a dotted quad
--- - client_ip - the IP address suggested for the client; likely, this equals ip above,\
---unless the configuration has been overridden.
--- - ntp_server - the NTP server suggested by the DHCP server.\
---DNS servers are not tracked per-interface in LwIP and, as such, are not reported here;\
---use `net.dns:getdnsserver()`.
function net.ifinfo(if_index) end

---Join multicast group.
---@param if_ip string @"string containing the interface ip to join the multicast group.  \n 'any' or '' affects all interfaces."
---@param multicast_ip string @string of the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string @"string containing the interface ip to leave the multicast group.  \n 'any' or '' affects all interfaces."
---@param multicast_ip string @string of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server.
---@return nil
function netsrv:close() end

---Returns server local address/port.
---@return integer|nil @port or `nil` if not listening
---@return string|nil @ip or `nil` if not listening
function netsrv:getaddr() end

---Listen on port from IP address.
---@param port? integer @(optional) port number, can be omitted (random port will be chosen)
---@param ip? string @(optional) IP address string, can be omitted
---@param callback fun(net.socket:netsocket) @"`function(net.socket)`, pass to caller function as param if  \n a connection is created successfully"
---@return nil
function netsrv:listen(port, ip, callback) end

---Connect to a remote server.
---@param port integer @port number
---@param ip_domain string @IP address or domain name string
---@return nil
function netsocket:connect(port, ip_domain) end

---Closes socket.
---@return nil
function netsocket:close() end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback fun(net.socket:netsocket, ip:string) @"`function(net.socket, ip)`. The first parameter is the socket,  \n the second parameter is the IP address as a string."
---@return nil
function netsocket:dns(domain, callback) end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function netsocket:getaddr() end

---Retrieve port and ip of remote peer.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function netsocket:getpeer() end

---Throttle data reception by placing\
---a request to block the TCP receive function.
---@return nil
function netsocket:hold() end

---Register callback functions for specific events.
---@param event string|'"connection"'|'"reconnection"'|'"disconnection"'|'"receive"'|'"sent"' @event
---@param callback fun(net.socket:netsocket, str:string) @"callback function. Can be `nil` to remove callback.  \n The first parameter of callback is the socket."
--- - If event is `"receive"`, the second parameter is the received data as string.\
--- - If event is `"disconnection"` or `"reconnection"`, the second parameter is error code.\
---If reconnection event is specified, disconnection receives only "normal close" events.\
---Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function netsocket:on(event, callback) end

---Sends data to remote peer.
---@param str string @data in string which will be sent to server
---@param callback? fun(sent:string) @(optional) `function(sent)` for sending string
---@return nil
function netsocket:send(str, callback) end

---Changes or retrieves Time-To-Live value on socket.
---@param ttl? integer @(optional) new time-to-live value
---@return integer ttl @current / new ttl value
function netsocket:ttl(ttl) end

---Unblock TCP receiving data\
---by revocation of a preceding `hold()`.
---@return nil
function netsocket:unhold() end

---Closes UDP socket.
---@return nil
function udpsocket:close() end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback fun(net.socket:netsocket, ip:string) @"`function(net.socket, ip)`. The first parameter is the socket,  \n the second parameter is the IP address as a string."
---@return nil
function udpsocket:dns(domain, callback) end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function udpsocket:getaddr() end

---Listen on port from IP address.
---@param port? integer @"(optional) port number,  \n can be omitted (random port will be chosen)"
---@param ip? string @(optional) IP address string, can be omitted
---@return nil
function udpsocket:listen(port, ip) end

---Register callback functions for specific events.
---@param event string|'"receive"'|'"sent"'|'"dns"' @event
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

---Changes or retrieves Time-To-Live value on socket.
---@param ttl? integer @(optional) new time-to-live value
---@return integer ttl @current / new ttl value
function udpsocket:ttl(ttl) end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer @which DNS server to get (range 0~1)
---@return string @IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. Doesn't require a socket like net.socket.dns().
---@param host string @hostname to resolve
---@param callback fun(sk:nil, ip:string) @"`function(sk, ip)` called when the name was resolved.  \n **sk** is always `nil`."
---@return nil @"`nil` but may raise errors for severe network stack issues  \n (e.g., out of DNS query table slots)"
function net.dns.resolve(host, callback) end

---Sets the IP of the DNS server used to resolve hostnames.\
---You can specify up to 2 DNS servers.
---@param dns_ip_addr string @IP address of a DNS server
---@param dns_index integer @which DNS server to set (range 0~1).
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end

---Pings a server. A callback function is called when response is or is not received.\
---Summary statistics can be retrieved via the second callback.
---@param domain string @destination domain or IP address
---@param count? number @(optional) number of ping packets to be sent (default value is 4)
---@param cb_received function @`function(bytes, ipaddr, seqno, rtt)`
---callback function which is invoked when response is received where
--- - **bytes** - number of bytes received from destination server (0 means no response)
--- - **ipaddr** - destination server IP address
--- - **seqno** ICMP sequence number
--- - **rtt** - round trip time in ms If domain name cannot be resolved callback is invoked with bytes parameter\
--- equal to 0 (i.e. no response) and nil values for all other parameters.
---@param cb_sent? function @(optional) `function(ipaddr, total_count, timeout_count, total_bytes, total_time)`
---callback function which is invoked when response is received where
--- - **ipaddrstr** destination server IP address
--- - **total_count** total number of packets sent
--- - **timeout_count** total number of packets lost (not received)
--- - **total_bytes** total number of bytes received from destination server
--- - **total_time** total time to perform ping
---@return nil
function net.ping(domain, count, cb_received, cb_sent) end
