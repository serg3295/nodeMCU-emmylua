--*** GPIO ***
gpio = {}

---@class pulser
local pulser = {}

---Initialize pin to GPIO mode, set the pin in/out direction, and optional internal weak pull-up.
---@param pin integer @pin to configure, IO index
---@param mode integer|' gpio.OUTPUT'|' gpio.INPUT'|' gpio.OPENDRAIN'|' gpio.INT' @interrupt mode
---@param pullup? integer @(optional) enables the weak pull-up resistor; default is gpio.FLOAT
---|' gpio.PULLUP'
---|>' gpio.FLOAT'
---@return nil
function gpio.mode(pin, mode , pullup) end

---Read digital GPIO pin value.
---@param pin integer @pin to read, IO index
---@return number @0 = low, 1 = high
function gpio.read(pin) end

---Serialize output based on a sequence of delay-times in µs. After each delay, the pin is toggled.\
---After the last cycle and last delay the pin is not toggled.
---@param pin integer @pin to use, IO index
---@param start_level integer|' gpio.HIGH'|' gpio.LOW' @level to start on
---@param delay_times table @an array of delay times in µs between each toggle of the gpio pin.
---@param cycle_num? integer @an optional number of times to run through the sequence. (default is 1)
---@param callback? function|' function() end' @(optional) function or `number`, if present the function returns immediately and goes asynchronous. (optional)
---@return nil
function gpio.serout(pin, start_level, delay_times , cycle_num, callback) end

---Establish or clear a callback function to run on interrupt for a pin.
---@param pin integer @1-12, pin to trigger on, IO index.
---@param type? string @(optional) If the type is "none" or omitted then the callback function is removed and the interrupt is disabled.
---|' "up"'   #rising edge
---|' "down"' #falling edge
---|' "both"' #both edges
---|' "low"'  #low level
---|' "high"' #high level
---@param callback? function|' function(level, when, eventcount)' @(optional) `function(level, when, eventcount)` when trigger occurs. The parameters are:
--- - level - The level of the specified pin at the interrupt
--- - when - timestamp of the event
--- - eventcount - is the number of interrupts that were elided for this callback.
---@return nil
function gpio.trig(pin, type , callback) end

---Set digital GPIO pin value.
---@param pin integer @pin to write, IO index
---@param level integer|' gpio.HIGH'|' gpio.LOW' @high | low
---@return nil
function gpio.write(pin, level) end

---@class GpioPulse
---@field delay integer
---@field min integer
---@field max integer
---@field count integer
---@field loop integer

---This builds the `gpio.pulse` object from the supplied argument
---@param tbl GpioPulse @this is view as an array of instructions. Each instruction is represented by a table as follows:
--- - **[pin] = gpio.level** For example { [1] = gpio.HIGH, }. All numeric keys are considered to be pin numbers.\
---The values of each are the value to be set onto the respective GPIO line.
--- - **delay** specifies the number of microseconds after setting the pin values to wait until moving to the next state.
--- - **min** and **max** can be used to specify (along with delay) that this time can be varied.
--- - **count** and **loop** allow simple looping.
---@vararg GpioPulse
---@return pulser obj @gpio.pulse object.
function gpio.pulse.build(tbl, ...) end

---This starts the output operations.
---@param adjust? number @(optional) This is the number of microseconds to add to the next adjustable period.
---@param callback function|' function() end' @This callback is executed when the pulses are complete. The callback is invoked with the same four parameters that are described as the return values of `gpio.pulse:getstate`.
---@return nil
function pulser:start(adjust,  callback) end

---This returns the current state.\
---These four values are also passed into the callback functions.
---@return integer position @is the index of the currently active state.  The first state is state 1. This is `nil` if the output operation is complete.
---@return integer steps @is the number of states that have been executed (including the current one). This allows monitoring of progress when there are loops.
---@return number offset @is the time (in microseconds) until the next state transition. This will be negative once the output operation is complete.
---@return number now @is the value of the `tmr.now()` function at the instant when the `offset` was calculated.
function pulser:getstate() end

---This stops the output operation at some future time.
---@param position? integer @(optional) is the index to stop at. The stopping happens on entry to this state. The stopping happens on entry to this state. If not specified, then stops on the next state transition.
---@param callback? function|' function(pos, steps, offset, now) end' @(optional) is invoked (with the same arguments as are returned by `:getstate`) when the operation has been stopped.
---@return boolean
function pulser:stop(position , callback) end

---This stops the output operation immediately.
---@return integer position @is the index of the currently active state. The first state is state 1. This is `nil` if the output operation is complete.
---@return integer steps @is the number of states that have been executed (including the current one). This allows monitoring of progress when there are loops.
---@return number offset @is the time (in microseconds) until the next state transition. This will be negative once the output operation is complete.
---@return number now @is the value of the `tmr.now()` function at the instant when the offset was calculated.
function pulser:cancel() end

---This adds (or subtracts) time that will get used in the `min / max` delay case.
---@param offset number @is the number of microseconds to be used in subsequent `min / max` delays. This overwrites any pending offset.
---@return integer position @is the index of the currently active state. The first state is state 1. This is `nil` if the output operation is complete.
---@return integer steps @is the number of states that have been executed (including the current one). This allows monitoring of progress when there are loops.
---@return number offset @is the time (in microseconds) until the next state transition. This will be negative once the output operation is complete.
---@return number now @is the value of the `tmr.now()` function at the instant when the `offset` was calculated.
function pulser:adjust(offset) end

---This can change the contents of a particular step in the output program.
---@param entrynum number @is the number of the entry in the original pulse sequence definition. The first entry is numbered 1.
---@param entrytable GpioPulse @this is view as an array of instructions. Each instruction is represented by a table as follows:
--- - **[pin] = gpio.level** For example { [1] = gpio.HIGH, }. All numeric keys are considered to be pin numbers.\
---The values of each are the value to be set onto the respective GPIO line.
--- - **delay** specifies the number of microseconds after setting the pin values to wait until moving to the next state.
--- - **min** and **max** can be used to specify (along with delay) that this time can be varied.
--- - **count** and **loop** allow simple looping.
function pulser:update(entrynum, entrytable) end

--*** HDC1080 ***
hdc1080 = {}

---Samples the sensor then returns temperature and humidity value.
---@return number TH @Temperature data in centigrade and humidity data in percentage (0-100)
function hdc1080.read() end

---Initializes the module.
---@return nil
function hdc1080.setup() end

--*** HMC5883L ***
hmc5883l = {}

---Samples the sensor and returns X,Y and Z data.
---@return integer x @measurements multiplied with 10
---@return integer y @measurements multiplied with 10
---@return integer z @measurements multiplied with 10
function hmc5883l.read() end

---Initializes the module.
---@return nil
function hmc5883l.setup() end

--*** HTTP ***
http = {}

---@alias urlHTTP string
---|'"http://"' #The URL to fetch, including the http:// or https:// prefix
---|'"https://"'
---@alias headersHTTP string
---|' ""' #Optional additional headers to append, including \r\n; may be `nil`
---@alias bodyHTTP string
---|' ""' #The body to post; must already be encoded in the appropriate format, but may be empty
---@alias callbackHTTP function
---|' function(code, data) end' #The callback function to be invoked when the response has been received or an error occurred; it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1.

---Executes a HTTP DELETE request. Note that concurrent requests are not supported.
---@param url urlHTTP
---@param headers headersHTTP
---@param body bodyHTTP
---@param callback callbackHTTP
---@return nil
function http.delete(url, headers, body, callback) end

---Executes a HTTP GET request. Note that concurrent requests are not supported.
---@param url urlHTTP
---@param headers headersHTTP
---@param callback callbackHTTP
---@return nil
function http.get(url, headers, callback) end

---Executes a HTTP POST request. Note that concurrent requests are not supported.
---@param url urlHTTP
---@param headers headersHTTP
---@param body bodyHTTP
---@param callback callbackHTTP
---@return nil
function http.post(url, headers, body, callback) end

---Executes a HTTP PUT request. Note that concurrent requests are not supported.
---@param url urlHTTP
---@param headers headersHTTP
---@param body bodyHTTP
---@param callback callbackHTTP
---@return nil
function http.put(url, headers, body, callback) end

---Execute a custom HTTP request for any HTTP method. Note that concurrent requests are not supported.
---@param url urlHTTP
---@param method string |' "GET"'|' "HEAD"'|' "POST"'|' "PUT"'|' "DELETE"'|' "CONNECT"'|' "TRACE"'|' "PATCH"'|' "OPTIONS"'
---@param headers headersHTTP
---@param body bodyHTTP
---@param callback callbackHTTP
---@return nil
function http.request(url, method, headers, body, callback) end

--*** HX711 ***
hx711 = {}

---Initialize io pins for hx711 clock and data.
---@param clk integer @pin the hx711 clock signal is connected to
---@param data integer @pin the hx711 data signal is connected to
---@return nil
function hx711.init(clk, data) end

---@alias hx711_a1 integer
---|'0' #channel A, gain 128
---|'1' #channel B, gain 32
---|'2' #channel A, gain 64

---Read digital loadcell ADC value.
---@param mode hx711_a1 @ADC mode. This parameter specifies which input and the gain to apply to that input.
---@return number @24 bit signed ADC value extended to the machine int size
function hx711.read(mode) end

---Starts to read multiple samples from the ADC.
---@param mode hx711_a1 @ADC mode
---@param samples number @The number of samples before the callback is invoked.
---@param callback function @The callback is invoked with three arguments
--- - s - A string which contains samples packed 24 bit values.\
---This can be unpacked with the struct module (using the "i3" format).
--- - t - The time in microseconds of the reception of the last sample in the buffer.
--- - d - The number of samples dropped before the start of this buffer\
---(after the end of the previous buffer).
---@return nil
function hx711.start(mode, samples, callback) end

---Stops a previously started set of reads.\
---Any data in buffers is lost.\
---No more callbacks will be invoked.
---@return nil
function hx711.stop() end

--*** I2C ***
i2c = {}

---Setup I²C address and read/write mode for the next transfer.
---@param id integer @bus number
---@param device_addr number @7-bit device address.
---@param direction integer|' i2c.TRANSMITTER'|' i2c.RECEIVER' @transmitter | receiver
---@return boolean @`true` if ack received, `false` if no ack received.
function i2c.address(id, device_addr, direction) end

---Read data for variable number of bytes.
---@param id integer @bus number
---@param len number @number of data bytes
---@return string @string of received data
function i2c.read(id, len) end

---Initialize the I²C bus with the selected bus number, pins and speed.
---@param id integer @0~9, bus number
---@param pinSDA integer @1~12, IO index
---@param pinSCL integer @0~12, IO index
---@param speed integer|' i2c.SLOW'|' i2c.FAST'|' i2c.FASTPLUS' @slow | fast | fastplus
---@return integer @speed the selected speed, 0 if bus initialization error.
function i2c.setup(id, pinSDA, pinSCL, speed) end

---Send an I²C start condition.
---@param id integer @bus number
---@return nil
function i2c.start(id) end

---Send an I²C stop condition.
---@param id integer @bus number
---@return nil
function i2c.stop(id) end

---Write data to I²C bus. Data items can be multiple numbers, strings or lua tables.
---@param id integer @bus number
---@param data1 string|table|number @data can be numbers, string or Lua table.
---@return number @number of bytes written
function i2c.write(id, data1, ...) end

--*** L3G4200D ***
l3g4200d = {}

---Samples the sensor and\
---returns the gyroscope output.
---@return number X @gyroscope output
---@return number Y @gyroscope output
---@return number Z @gyroscope output
function l3g4200d.read() end

---Initializes the module.
---@return nil
function l3g4200d.setup() end

--*** MCP4725 ***
mcp4725 = {}

---Gets contents of the dac register and EEPROM.
---@param tbl table @{[a0], [a1], [a2]}
--- - **A0** Address bit 0. This bit is user configurable via MCP4725 pin 6(A0).\
---(valid states: 0 or 1) (default: 0)
--- - **A1** Address bit 1. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **A2** Address bit 2. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
---@return number cur_pwrdn @Current power down configuration value.
---@return number cur_val @Current value stored in dac register.
---@return number eeprom_pwrdn @Power down configuration stored in EEPROM.
---@return number eeprom_val @DAC value stored in EEPROM.
---@return number eeprom_state @EEPROM write status
--- - 0 - EEPROM write is incomplete.
--- - 1 - EEPROM write has completed
---@return number por_state @Power-On-Reset status;
--- - 0 - The MCP4725 is performing reset and is not ready.
--- - 1 - The MCP4725 has successfully performed reset.
function mcp4725.read(tbl) end

---Write configuration to dac register or dac register and eeprom.
---@param tbl table @{[a0], [a1], [a2], value, [pwrdn], [save]}
--- - **A0** Address bit 0. This bit is user configurable via MCP4725 pin 6(A0).\
---(valid states: 0 or 1) (default: 0)
--- - **A1** Address bit 1. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **A2** Address bit 2. This bit is hard-wired during manufacture.\
---(valid states: 0 or 1) (default: 0)
--- - **value** The value to be used to configure DAC (and EEPROM). (Range: 0 - 4095)
--- - **pwrdn** Set power down bits.
---   - mcp4725.PWRDN_NONE MCP4725 - output enabled. (Default)
---   - mcp4725.PWRDN_1K MCP4725 - output disabled,\
---output pulled to ground via 1K restistor.
---   - mcp4725.PWRDN_100K MCP4725 - output disabled,\
---output pulled to ground via 100K restistor.
---   - mcp4725.PWRDN_500K MCP4725 - output disabled,\
---output pulled to ground via 500K restistor.
--- - **save** Save pwrdn and dac values to EEPROM. (Values are loaded on power-up\
---or during reset.)
---   - `true` Save configuration to EEPROM.
---   - `false` Do not save configuration to EEPROM. (Default)
---@return nil
function mcp4725.write(tbl) end

--*** MDNS ***
mdns ={}

---Register a hostname and start the mDNS service.
---@param hostname string @The hostname for this device. Alphanumeric characters are best.
---@param attributes? table @A optional table of options. The keys must all be strings.
---@return nil
function mdns.register(hostname , attributes) end

---Shut down the mDNS service.\
---This is not normally needed.
---@return nil
function mdns.close() end

--*** MQTT ***
mqtt = {}

---@class mqtt
local MQTT = {}

---Creates a MQTT client.
---@param clientid string @client ID
---@param keepalive integer @keepalive seconds
---@param username? string @(optional) user name
---@param password? string @(optional) user password
---@param cleansession? integer @(optional) **0/1** for `false/true`. Default is 1 (`true`).
---@param max_message_length? integer @(optional) how large messages to accept. Default is 1024.
---@return mqtt MQTT @MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Closes connection to the broker.
---@return boolean
function MQTT:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string @host, domain or IP
---@param port? integer @(optional) broker port (number), default 1883
---@param secure? boolean @(optional) if `true`, use TLS.
---@param conn_est? function|' function(client) end' @(optional) `function(client)` callback function for when the connection was established
---@param conn_notest? function|' function(client, reason) end' @(optional) `function(client, reason)` callback function for when the connection could not be established. No further callbacks should be called.
---@return nil
function MQTT:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string @the topic to publish to (string)
---@param message string @the message to publish, (buffer or string)
---@param qos? integer|' 0'|' 1'|' 2' @(optional) QoS level, default 0
---@param retain? integer|' 0'|' 1' @(optional) retain flag, default 0
---@return nil
function MQTT:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"connfail"'|'"suback"'|'"unsuback"'|'"puback"'|'"message"'|'"overflow"'|'"offline"' @event
---@param callback function|' function(client, topic, message) end' @`function(client, topic, message)`. The first parameter is always the client object itself. Any remaining parameters passed differ by event:
--- - If event is `"message"`, the 2nd and 3rd parameters are received topic and message, respectively, as Lua strings;
--- - If the event is `"overflow"`, the parameters are as with `"message"``,save that the message string is truncated to the maximum message size;
--- - If the event is `"connfail"`, the 2nd parameter will be the connection failure code;
--- - Other event types do not provide additional arguments.
---@return nil
function MQTT:on(event, callback) end

---Publishes a message.
---@param topic string @the topic to publish to (topic string)
---@param payload string @the message to publish, (buffer or string)
---@param qos integer|' 0'|' 1'|' 2' @QoS level
---@param retain integer|' 0'|' 1' @retain flag
---@param callback? function|' function(client) end' @(optional) `function(client)` fired when PUBACK received (for QoS 1 or 2) or when message sent (for QoS 0).
---@return boolean
function MQTT:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string|table @a topic string, or table array of `topic, qos` pairs to subscribe to.
---@param qos integer|' 0'|' 1'|' 2' @QoS subscription level, default 0
---@param callback? function|' function(client) end' @(optional) `function(client)` fired when subscription(s) succeeded.
---@return boolean
function MQTT:subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string|table @a topic string, or table array of `topic, anything` pairs to unsubscribe from.
---@param callback? function|' function(client) end' @(optional) `function(client)` fired when unsubscription(s) succeeded.
---@return boolean
function MQTT:unsubscribe(topic, callback) end

--*** NET ***
net = {}

---@class netsocket
local NETSOCKET = {}
---@class netsrv
local NETSRV = {}
---@class udpsocket
local UDPSOCKET = {}

---Creates a TCP client.
---@return netsocket @net.socket submodule
function net.createConnection() end

---Creates a TCP listening socket (a server).
---@param timeout integer @seconds until disconnecting an inactive client; 1~28'800 seconds, 30 sec by default.
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
---@param if_ip string @string containing the interface ip to join the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string @string of the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string @string containing the interface ip to leave the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string @string of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server.
---@return nil
function NETSRV:close() end

---Listen on port from IP address.
---@param port? integer @(optional) port number, can be omitted (random port will be chosen)
---@param ip? string @(optional) IP address string, can be omitted
---@param callback function|' function(net.socket) end' @`function(net.socket)`, pass to caller function as param if a connection is created successfully
---@return nil
function NETSRV:listen(port, ip, callback) end

---Returns server local address/port.
---@return integer|nil @port or `nil` if not listening
---@return string|nil @ip or `nil` if not listening
function NETSRV:getaddr() end

---Closes socket.
---@return nil
function NETSOCKET:close() end

---Connect to a remote server.
---@param port integer @port number
---@param ip_domain string @IP address or domain name string
---@return nil
function NETSOCKET:connect(port, ip_domain) end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback function|' function(net.socket, ip) end' @`function(net.socket, ip)`. The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function NETSOCKET:dns(domain, callback) end

---Retrieve port and ip of remote peer.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function NETSOCKET:getpeer() end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function NETSOCKET:getaddr() end

---Throttle data reception by placing\
---a request to block the TCP receive function.
---@return nil
function NETSOCKET:hold() end

---Register callback functions for specific events.
---@param event string|' "connection"'|' "reconnection"'|' "disconnection"'|' "receive"'|'  "sent"' @event
---@param callback nil|function|' function(net.socket, string?) end)' @callback function. Can be `nil` to remove callback. The first parameter of callback is the socket.
--- - If event is `"receive"`, the second parameter is the received data as string.\
--- - If event is `"disconnection"` or `"reconnection"`, the second parameter is error code.\
---If reconnection event is specified, disconnection receives only "normal close" events.\
---Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function NETSOCKET:on(event, callback) end

---Sends data to remote peer.
---@param str string @data in string which will be sent to server
---@param callback? function|' function(sent) end' @(optional) `function(sent)` for sending string
---@return nil
function NETSOCKET:send(str, callback) end

---Changes or retrieves Time-To-Live value on socket.
---@param ttl? integer @(optional) new time-to-live value
---@return integer ttl @current / new ttl value
function NETSOCKET:ttl(ttl) end

---Unblock TCP receiving data\
---by revocation of a preceding `hold()`.
---@return nil
function NETSOCKET:unhold() end

---Closes UDP socket.
---@return nil
function UDPSOCKET:close() end

---Listen on port from IP address.
---@param port? integer @(optional) port number, can be omitted (random port will be chosen)
---@param ip? string @(optional) IP address string, can be omitted
---@return nil
function UDPSOCKET:listen(port, ip) end

---Register callback functions for specific events.
---@param event string|' "receive"'|' "sent"'|' "dns"' @event
---@param callback nil|function|' function(net.socket, string) end)' @`function(net.socket, string?)`. Can be `nil` to remove callback.
---The first parameter of callback is the socket.
---The seconf parameter:
--- - If event is `"receive"`, the second parameter is the received data as string.\
---The `receive` callback receives port and ip *after* the data argument.\
---Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function UDPSOCKET:on(event, callback) end

---Sends data to specific remote peer.
---@param port integer @remote socket port
---@param ip string @remote socket IP
---@param data any @the payload to send
---@return nil
function UDPSOCKET:send(port, ip, data) end

---Provides DNS resolution for a hostname.
---@param domain string @domain name
---@param callback function|' function(net.socket, ip) end' @`function(net.socket, ip)`. The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function UDPSOCKET:dns(domain, callback) end

---Retrieve local port and ip of socket.
---@return integer|nil @port or `nil` if not connected
---@return string|nil @ip or `nil` if not connected
function UDPSOCKET:getaddr() end

---Changes or retrieves Time-To-Live value on socket.
---@param ttl? integer @(optional) new time-to-live value
---@return integer ttl @current / new ttl value
function UDPSOCKET:ttl(ttl) end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer @which DNS server to get (range 0~1)
---@return string @IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. Doesn't require a socket like net.socket.dns().
---@param host string @hostname to resolve
---@param callback function|' function(sk, ip) end' @`function(sk, ip)` called when the name was resolved. **sk** is always `nil`.
---@return nil|string @IP address.
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

--*** NODE ***
node = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode @The first value returned is the raw code,
---not the new "reset info" code which was introduced in recent SDKs. Values are:
--- - 1, power-on
--- - 2, reset (software?)
--- - 3, hardware reset via reset pin
--- - 4, WDT reset (watchdog timeout)
---@return integer reason @The second value returned is the extended reset cause. Values are:
--- - 0, power-on
--- - 1, hardware watchdog reset
--- - 2, exception reset
--- - 3, software watchdog reset
--- - 4, software restart
--- - 5, wake from deep sleep
--- - 6, external reset
---In case of extended reset cause 3 (exception reset),\
---additional values are returned containing the crash information.\
---These are, in order, EXCCAUSE, EPC1, EPC2, EPC3, EXCVADDR, and DEPC.
function node.bootreason() end

---Returns the ESP chip ID.
---@return number @chip ID
function node.chipid() end

---Compiles a Lua text file into Lua bytecode,\
---and saves it as .lc file.
---@param filename string|'".lua"' @name of Lua text file
---@return nil
function node.compile(filename) end

---Enters deep sleep mode, wakes up when timed out.
---@param us integer @number (integer) or `nil`, sleep time in micro second. If *us* == 0, it will sleep forever. If *us* == nil, will not set sleep time.
---@param option integer @number (integer) or `nil`. If `nil`, it will use last alive setting as default option.
--- - 0 , init data byte 108 is valuable
--- - \>0, init data byte 108 is valueless
--- - 0, RF_CAL or not after deep-sleep wake up, depends on init data byte 108
--- - 1, RF_CAL after deep-sleep wake up, there will be large current
--- - 2, no RF_CAL after deep-sleep wake up, there will only be small current
--- - 4, disable RF after deep-sleep wake up, just like modem sleep, there will be the smallest current
---@param instant integer @number (integer) or `nil`. If present and non-zero, the chip will enter Deep-sleep immediately and will not wait for the Wi-Fi core to be shutdown.
---@return nil
function node.dsleep(us, option, instant) end

---Returns the current theoretical\
---maximum deep sleep duration.
---@return number max_duration
function node.dsleepMax() end

---Returns the flash chip ID
---@return number flashID
function node.flashid() end

---Returns the flash chip size in bytes.
---@return integer @flash size in bytes
function node.flashsize() end

---Get the current CPU Frequency.
---@return number @Current CPU frequency
function node.getcpufreq() end

---Get the current LFS and SPIFFS partition information.
---@return table @An array containing entries for
---**lfs_addr, lfs_size, spiffs_addr** and **spiffs_size**.\
---The address values are offsets relative to the start of\
---the Flash memory.
function node.getpartitiontable() end

---Returns the current available heap size in bytes.
---@return number heap @system heap size left in bytes
function node.heap() end

---Returns information about hardware, software version and build configuration.
---@param group? string|'"hw"'|'"sw_version"'|'"build_config"' @(optional) A designator for a group of properties.
---@return any @If a group is given the return value will be a table containing the following elements:
--- - for group = `"hw"`
---   - **chip_id** (number)
---   - **flash_id** (number)
---   - **flash_size** (number)
---   - **flash_mode** (number) 0 = QIO, 1 = QOUT, 2 = DIO, 15 = DOUT.
---   - **flash_speed** (number)
--- - for group = `"lfs"`
---   - **lfs_base** (number) Flash offset of selected LFS region
---   - **lfs_mapped** (number) Mapped memory address of selected LFS region
---   - **lfs_size** (number) size of selected LFS region
---   - **lfs_used** (number) actual size used by current LFS image
--- - for group = `"sw_version"`
---   - **git_branch** (string)
---   - **git_commit_id** (string)
---   - **git_release** (string) release name +additional commits e.g. "2.0.0-master_20170202 +403"
---   - **git_commit_dts** (string) commit timestamp in an ordering format. e.g. "201908111200"
---   - **node_version_major** (number)
---   - **node_version_minor** (number)
---   - **node_version_revision** (number)
--- - for group = `"build_config"`
---   - **ssl** (boolean)
---   - **lfs_size** (number) as defined at build time
---   - **modules** (string) comma separated list
---   - **number_type** (string) integer or float
function node.info(group) end

---Submits a string to the Lua interpreter.\
---Similar to `pcall(loadstring(str))`,\
---but without the single-line limitation.
---@param str any @Lua chunk
---@return nil
function node.input(str) end

---Returns the function reference for a function in LFS.
---@param modulename string|'""' @The name of the module to be loaded.
---@return function|nil @If the LFS is loaded and the modulename is a string
---that is the name of a valid module in the LFS, then the function\
--- is returned in the same way the `load()` and the other\
---Lua load functions do. Otherwise `nil` is returned.
function node.LFS.get(modulename) end

---List the modules in LFS.
---@return table|nil @If no LFS image IS LOADED then `nil` is returned.
---Otherwise an sorted array of the name of modules in LFS is returned.
function node.LFS.list() end

---Reload LFS with the flash image provided.
---@param imageName string|'""' @The name of a image file in the filesystem to be loaded into the LFS.
---@return any|nil @In the case when the imagename is a valid LFS image, this is expanded and loaded into flash,
---and the ESP is then immediately rebooted, *so control is not returned to the calling Lua application*\
---in the case of a successful reload. The reload process internally makes multiple passes\
---through the LFS image file. The first pass validates the file and header formats and detects many errors.\
---If any is detected then an error string is returned.
function node.LFS.reload(imageName) end

---Redirects the Lua interpreter to a `stdout` pipe when a CB function is specified (See `pipe` module)\
---and resets output to normal otherwise. Optionally also prints to the serial console.
---@param foo function|'function(pipe) end' @`output_fn(pipe)` a function accept every output as str, and can send the output to a socket (or maybe a file).
---Note that this function must conform to the fules for a pipe reader callback.
---@param serial_debug integer @**1** - output also show in serial. **0** - no serial output.
---@return nil
function node.output(foo, serial_debug) end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults\
---using the SDK function `system_restore()`
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ' @constant
---@return number @target CPU frequency
function node.setcpufreq(speed) end

---Overrides the default crash handling which always restarts the system.\
---It can be used to e.g. write an error to a logfile or to secure connected hardware\
---before restarting.\
---**!!! attention** It is strongly advised to ensure that the callback ends with a restart.\
---Something has gone quite wrong and it is probably not safe to just wait for\
---the next event (e.g., timer tick) and hope everything works out.\
---```
---    node.setonerror(function(s)
---        print("Error: "..s)
---        node.restart()
---      end)
---```
---@param callback function @function to be executed when an error occurs, gets the error string as an argument, remember to **trigger a restart** at the end of the callback
---@return nil
function node.setonerror(callback) end

---@class NodeSetPartTbl
---@field lfs_addr number
---@field lfs_size number
---@field spiffs_addr number
---@field spiffs_size number

---Sets the current LFS and / or SPIFFS partition information.
---@param partition_info NodeSetPartTbl @An array containing one or more of the following enties.
---The address values are byte offsets relative to the start of the Flash memory.\
---The size values are in bytes.\
---Note that these parameters must be a multiple of 8Kb to align to Flash page boundaries.
--- - **lfs_addr** - The base address of the LFS region.
--- - **lfs_size** - The size of the LFS region.
--- - **spiffs_addr** - The base address of the SPIFFS region.
--- - **spiffs_size** - The size of the SPIFFS region.
function node.setpartitiontable(partition_info) end

---Put NodeMCU in light sleep mode to reduce current consumption.
---@param wake_pin integer @1-12, pin to attach wake interrupt to. Note that pin 0(GPIO 16) does not support interrupts.
---@param int_type? integer @(optional) type of interrupt that you would like to wake on.
---| 'node.INT_UP'   #Rising edge
---| 'node.INT_DOWN' #Falling edge
---| 'node.INT_BOTH' #Both edges
---|>'node.INT_LOW'  #Low level
---| 'node.INT_HIGH' #High level
---@param resume_cb? function|' function() end' @(optional) Callback to execute when WiFi wakes from suspension.
---@param preserve_mode? boolean @(optional) preserve current WiFi mode through node sleep.
---|'true' #Station and StationAP modes will automatically reconnect to previously configured Access Point when NodeMCU resumes.
---|'false' #discard WiFi mode and leave NodeMCU in wifi.NULL_MODE. WiFi mode will be restored to original mode on restart.
---@return nil
function node.sleep(wake_pin, int_type, resume_cb, preserve_mode) end

---Query the performance of system startup.
---@param marker? any @(optional) If present, this will add another entry into the startup counts
---@return table @An array of tables which indicate how many CPU cycles had been consumed at each step of platform boot.
function node.startupcounts(marker) end

---@class NodeStartup
---@field banner boolean
---@field frequency number
---@field delay_mount number
---@field command number

---Get/set options that control the startup process. This interface will grow over time.
---@param tbl? NodeStartup @(optional) If the argument is omitted, then no change is made to the current set of startup options.
---If the argument is the empty table **{ }** then all options are reset to their default values. Table one or more options:
--- - **banner** - set to `true` or `false` to indicate whether the startup banner should be displayed or not. (default: true)
--- - **frequency** - set to node.CPU80MHZ or node.CPU160MHZ to indicate the initial CPU speed. (default: node.CPU80MHZ)
--- - **delay_mount** - set to true or false to indicate whether the SPIFFS filesystem mount is delayed until it is first needed or not.\
---(default: false)
--- - **command** - set to a string which is the initial command that is run. This is the same string as in the node.startupcommand.
---@return table @This is the complete set of options in the state that will take effect on the next boot.
---Note that the command key may be missing in which case the default value will be used.
function node.startup(tbl) end

---Controls the amount of debug information kept during `node.compile()`,\
---and allows removal of debug information from already compiled Lua code.
---@param level? integer @(optional) level
---|'1' #don't discard debug info
---|'2' #discard Local and Upvalue debug info
---|'3' #discard Local, Upvalue and line-number debug info
---@param foo? function @(optional) a compiled function to be stripped per setfenv except 0 is not permitted.
---@return integer|nil @If invoked without arguments, returns the current level settings. Otherwise, `nil` is returned.
function node.stripdebug(level, foo) end

---Controls whether the debugging output\
---from the Espressif SDK is printed.
---@param enabled boolean @This is either `true` to enable printing, or `false` to disable it. The default is `false`.
function node.osprint(enabled) end

---This behaves like math.random except that it uses true random numbers derived from\
---the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
---* `node.random()` Returns a random real number with uniform distribution in the interval [0,1).
---* `node.random(u)` Returns an integer random number x such that 1 <= x <= u.
---* `node.random(l, u)` Returns a pseudo-random integer x such that l <= x <= u.
---@overload fun():number
---@overload fun(u: integer):integer
---@param l integer @the lower bound of the range
---@param u integer @the upper bound of the range
---@return integer @The random number in the appropriate range.
---Note that the zero argument form will always return 0 in the integer build.
function node.random(l, u) end

---Sets the Emergency Garbage Collector mode.
---@param mode integer @mode
---|'node.egc.NOT_ACTIVE' #EGC inactive, no collection cycle will be forced in low memory situations
---|'node.egc.ON_ALLOC_FAILURE' #Try to allocate a new block of memory, and run the garbage collector if the allocation fails. If the allocation fails even after running the garbage collector, the allocator will return with error.
---|'node.egc.ON_MEM_LIMIT' #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit. If the upper limit can't be satisfied even after running the garbage collector, the allocator will return with error. If the given limit is negative, it is interpreted as the desired amount of heap which should be left available. Whenever the free heap (as reported by node.heap() falls below the requested limit, the garbage collector will be run.
---|'node.egc.ALWAYS' #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error. This mode is very efficient with regards to memory savings, but it's also the slowest.
---@param level? number @(optional) in the case of **node.egc.ON_MEM_LIMIT**, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Returns memory usage information for the Lua runtime.
---@return number total_allocated @The total number of bytes allocated by the Lua runtime.
---This is the number which is relevant when using the **node.egc.ON_MEM_LIMIT** option with positive limit values.
---@return number estimated_used @This value shows the estimated usage of the allocated memory.
function node.egc.meminfo() end

---Enable a Lua callback or task to post another task request.
---@param task_priority? integer @(optional) 0 | 1 | 2
---| 'node.task.LOW_PRIORITY' #=0
---|>'node.task.MEDIUM_PRIORITY' #=1
---| 'node.task.HIGH_PRIORITY' #=2
---@param callback function|' function() end' @function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, callback) end

--*** OW ***
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string @value, data to be calculated check sum in string
---@param inverted_crc0 number @LSB of received CRC
---@param inverted_crc1 number @MSB of received CRC
---@param crc? number @(optional) CRC starting value
---@return boolean @`true` if the CRC matches, `false` otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf string @value, data to be calculated check sum in string
---@param crc? number @(optional) CRC starting value
---@return number @the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC,\
---these are used in the ROM and scratchpad registers.
---@param buf string @value, data to be calculated check sum in string
---@return number CRC @result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus.
---@param pin integer @1~12, I/O index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer @1~12, I/O index
---@return integer @byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer @1~12, I/O index
---@param size number @of bytes to be read from slave device (up to 256)
---@return string @bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer @1~12, I/O index
---@return integer @**1** if a device responds with a presence pulse;
---**0** if there is no device or the bus is shorted\
---or otherwise held low for more than 250 µS
function ow.reset(pin) end

---Clears the search state so that it will start\
---from the beginning again.
---@param pin integer @1~12, I/O index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer @1~12, I/O index
---@return string|nil @string with length of 8 upon success.
---It contains the rom code of slave device.\
---Returns `nil` if search was unsuccessful.
function ow.search(pin) end

---Issues a 1-Wire rom select command.\
---Make sure you do the `ow.reset(pin)` first.
---@param pin integer @1~12, I/O index
---@param rom string @string value, len 8, rom code of the slave device
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer @1~12, I/O index
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command,\
---to address all on bus.
---@param pin integer @1~12, I/O index
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code.\
---The search itself has to be initiated with a subsequent call to `ow.search()`.
---@param pin integer @1~12, I/O index
---@param family_code integer @byte for family code
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end\
---for parasitically powered devices.
---@param pin integer @1~12, I/O index
---@param v integer @byte to be written to slave device
---@param power integer @1 for wire being held high for parasitically powered devices
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end\
---for parasitically powered devices.
---@param pin integer @1~12, I/O index
---@param buf string @string to be written to slave device
---@param power integer @1 for wire being held high for parasitically powered devices
---@return nil
function ow.write_bytes(pin, buf, power) end

--*** PCM ***
pcm ={}

---@class pcm
local pcmdrv = {}

---Initializes the audio driver.
---@param pcm_SD any @pcm.SD use sigma-delta hardware
---@param pin integer @pin 1~10, IO index
---@return pcm obj @Audio driver object.
function pcm.new(pcm_SD, pin) end

---Stops playback and releases\
---the audio hardware.
---@return nil
function pcmdrv:close() end

---Register callback functions for events.
---@param event string @`event` identifier, one of:
---|'"data"' #callback function is supposed to return a string containing the next chunk of data.
---|'"drained"' #playback was stopped due to lack of data. The last 2 invocations of the data callback didn't provide new chunks in time (intentionally or unintentionally) and the internal buffers were fully consumed.
---|'"paused"' #playback was paused by pcm.drv:pause().
---|'"stopped"' #playback was stopped by pcm.drv:stop().
---|'"vu"' #new peak data, cb_fn is triggered freq times per second (1 to 200 Hz).
---@param callback? function @(optional) function for the specified event. Unregisters previous function if omitted. First parameter is `drv`, followed by peak data for `vu` callback.
---@return nil
function pcmdrv:on(event, callback) end

---Starts playback.
---@param rate integer|'pcm.RATE_1K'|'pcm.RATE_2K'|'pcm.RATE_4K'|'pcm.RATE_5K'|'pcm.RATE_8K'|'pcm.RATE_10K'|'pcm.RATE_12K'|'pcm.RATE_16K' @defaults to RATE_8K if omitted
---@return nil
function pcmdrv:play(rate) end

---Pauses playback. A call to `drv:play()`\
---will resume from the last position.
---@return nil
function pcmdrv:pause() end

---Stops playback and releases\
---buffered chunks.
---@return nil
function pcmdrv:stop() end

--*** PERF ***
perf = {}

---Starts a performance monitoring session.
---@param start? number @(optional) The lowest PC address for the histogram. Default is 0x40000000.
---@param endaddr? number @(optional) The highest address for the histogram. Default is the end of the used space in the flash memory.
---@param nbins? number @(optional) The number of bins in the histogram. Keep this reasonable otherwise you will run out of memory. Default is 1024.
---@return nil
function perf.start(start, endaddr, nbins) end

---Terminates a performance monitoring session and returns the histogram.
---@return number total @The total number of samples captured in this run
---@return number outside @The number of samples that were outside the histogram range
---@return number histogram @The histogram represented as a table indexed by address where the value is the number of samples.
---@return number binsize @The number of bytes per histogram bin.
function perf.stop() end

--*** PIPE ***
pipe = {}

---@class pipe
local pobj = {}

---Create a pipe.
---@param CB_function? function @optional reader callback which is called through the `node.task.post()` when the pipe is written to. If the CB returns a boolean, then the reposting action is forced: it is reposted if true and not if false. If the return is nil or omitted then the deault is to repost if a pipe write has occured since the last call.
---@param task_priority? integer @(optional) low | medium | high
---|' node.task.LOW_PRIORITY' #0
---|>' node.task.MEDIUM_PRIORITY' #1
---|' node.task.HIGH_PRIORITY' #2
---@return pipe obj @A pipe resource.
function pipe.create(CB_function,task_priority) end

---Read a record from a pipe object.
---@param size_or_endChar? number|string @(optional) If omitted, then this defaults to "\n+"
--- - If numeric then a string of size length will be returned from the pipe.
--- - If a string then this is a single character delimiter, followed by an optional "+" flag.\
---The delimiter is used as an end-of-record to split the character stream into separate records.\
---If the flag "+" is specified then the delimiter is also returned at the end of the record,\
---otherwise it is discarded.
---@return string|nil @A string or `nil` if the pipe is empty
function pobj:read(size_or_endChar) end

---Returns a Lua iterator function for a pipe object.
---@param size_or_endChar? number|string @(optional) If omitted, then this defaults to "\n+"
--- - If numeric then a string of size length will be returned from the pipe.
--- - If a string then this is a single character delimiter, followed by an optional "+" flag.\
---The delimiter is used as an end-of-record to split the character stream into separate records.\
---If the flag "+" is specified then the delimiter is also returned at the end of the record,\
---otherwise it is discarded.
---@return function @myFunc iterator function
function pobj:reader(size_or_endChar) end

---Write a string to the head of a pipe object.\
---This can be used to back-out a previous read.
---@param s string @Any input string. Note that with all Lua strings, these may contain all character values including "\0".
function pobj:unread(s) end

---Write a string to a pipe object.
---@param s string @Any input string. Note that with all Lua strings, these may contain all character values including "\0".
function pobj:write(s) end

--*** PWM ***
pwm = {}

---Quit PWM mode for the specified GPIO pin.
---@param pin integer @1~12, IO index
---@return nil
function pwm.close(pin) end

---Get selected PWM frequency of pin.
---@param pin integer @1~12, IO index
---@return number @PWM frequency of pin
function pwm.getclock(pin) end

---Get selected duty cycle of pin.
---@param pin integer @1~12, IO index
---@return number @duty cycle, max 1023
function pwm.getduty(pin) end

---Set PWM frequency.
---@param pin integer @1~12, IO index
---@param clock integer @1~1000, PWM frequency
---@return nil
function pwm.setclock(pin, clock) end

---Set duty cycle for a pin.
---@param pin integer @1~12, IO index
---@param duty integer @0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setduty(pin, duty) end

---Set pin to PWM mode. Only 6 pins can be set to PWM mode at the most.
---@param pin integer @1~12, IO index
---@param clock integer @1~1000, PWM frequency
---@param duty integer @0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setup(pin, clock, duty) end

---PWM starts, the waveform is applied to the GPIO pin.
---@param pin integer @1~12, IO index
---@return nil
function pwm.start(pin) end

---Pause the output of the PWM waveform.
---@param pin integer @1~12, IO index
---@return nil
function pwm.stop(pin) end

--*** PWM2 ***
pwm2 = {}

---Assigns PWM frequency expressed as Hz to given pin.
---@param pin integer @1-12
---@param frequencyAsHz number @desired frequency in Hz, for example 1000 for 1KHz
---@param pulsePeriod number @discreet steps in single PWM pulse, for example 100
---@param initialDuty number @initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number @(optional) an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_hz(pin,frequencyAsHz,pulsePeriod,initialDuty ,frequencyDivisor) end

---Assigns PWM frequency expressed as one impulse per second(s) to given pin.
---@param pin integer @1-12
---@param frequencyAsSec number @desired frequency as one impulse for given seconds,
---@param pulsePeriod number @discreet steps in single PWM pulse, for example 100
---@param initialDuty number @initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number @(optional) an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_sec(pin,frequencyAsSec,pulsePeriod,initialDuty ,frequencyDivisor) end

---Starts PWM for all setup pins. At this moment GPIO pins are marked\
---as output and TIMER1 is being reserved for this module.
---@return boolean @`true` if PWM started ok, `false` of TIMER1 is reserved by another module.
function pwm2.start() end

---Stops PWM for all pins.\
---All GPIO pins and TIMER1\
---are being released.
---@return nil
function pwm2.stop() end

---Sets duty cycle for one or more a pins.
---@param pin integer @1~12, IO index
---@param duty number @0~period, pwm duty cycle
---@param pinN? integer @(optional) 1~12, IO index
---@param dutyN? number @(optional) 0~period, pwm duty cycle
---@return nil
function pwm2.set_duty(pin, duty, pinN, dutyN) end

---Releases given pin from previously done setup.
---@param pin integer @1~12, IO index
---@return nil
function pwm2.release_pin(pin) end

---Prints internal data structures related to the timer.
---@return boolean isStarted @if `true` PWM2 has been started
---@return integer interruptTimerCPUTicks @int, desired timer interrupt period in CPU ticks
---@return integer interruptTimerTicks @int, actual timer interrupt period in timer ticks
function pwm2.get_timer_data() end

---Prints internal data structures related to given GPIO pin.
---@param pin integer @1~12, IO index
---@return boolean isPinSetup @bool, if 1 pin is setup
---@return integer duty @int, assigned duty
---@return integer pulseResolutions @int, assigned pulse periods
---@return integer divisableFrequency @int, assigned frequency
---@return integer frequencyDivisor @int, assigned frequency divisor
---@return integer resolutionCPUTicks @int, calculated one pulse period in CPU ticks
---@return integer resolutionInterruptCounterMultiplier @int, how many timer interrupts constitute one pulse period
function pwm2.get_pin_data(pin) end

--*** RFSWITCH ***
rfswitch = {}

---Transmit data using the radio module.
---@param protocol_id integer @positive integer value, from 1-6
---@param pulse_length integer @length of one pulse in microseconds, usually from 100 to 650
---@param repeat_val integer @repeat value, usually from 1 to 5. This is a synchronous task.
---@param pin integer @I/O index of pin, example 6 is for GPIO12
---@param value integer @positive integer value, this is the primary data which will be sent
---@param length integer @bit length of value, if value length is 3 bytes, then length is 24
---@return nil
function rfswitch.send(protocol_id, pulse_length, repeat_val, pin, value, length) end

--*** ROTARY ***
rotary = {}

---Initialize the nodemcu to talk to a rotary encoder switch.
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
---@param pina integer @This is a GPIO number (excluding 0) and connects to pin phase A on the rotary switch.
---@param pinb integer @This is a GPIO number (excluding 0) and connects to pin phase B on the rotary switch.
---@param pinpress? integer @(optional) This is a GPIO number (excluding 0) and connects to the press switch.
---@param longpress_time_ms? integer @(optional) The number of milliseconds (default 500) of press to be considered a long press.
---@param dblclick_time_ms? integer @(optional) The number of milliseconds (default 500) between a release and a press for the next release to be considered a double click.
---@return any @Nothing. If the arguments are in error, or the operation cannot be completed, then an error is thrown. For all API calls, if the channel number is out of range, then an error will be thrown.
function rotary.setup(channel, pina, pinb, pinpress, longpress_time_ms, dblclick_time_ms) end

---Sets a callback on specific events.
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
---@param eventtype integer @This defines the type of event being registered.
---|' rotary.PRESS' #= 1 The eventtype for the switch press.
---|' rotary.LONGPRESS' #= 2 The eventtype for a long press.
---|' rotary.RELEASE' #= 4 The eventtype for the switch release.
---|' rotary.TURN' #= 8 The eventtype for the switch rotation.
---|' rotary.CLICK' #= 16 The eventtype for a single click (after release)
---|' rotary.DBLCLICK' #= 32 The eventtype for a double click (after second release)
---|' rotary.ALL' #= 63 All event types.
---@param callback? function @(optional) This is a function that will be invoked when the specified event happens.
---@return any @If an invalid eventtype is supplied, then an error will be thrown.
function rotary.on(channel, eventtype, callback) end

---Gets the current position and press status of the switch
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
---@return number @The current position of the switch.
---@return boolean @A boolean indicating if the switch is currently pressed.
function rotary.getpos(channel) end

---Releases the resources associated with the rotary switch.
---@param channel integer @The rotary module supports three switches. The channel is either 0, 1 or 2.
function rotary.close(channel) end

--*** RTCFIFO ***
rtcfifo = {}

---deep sleep until it's time to take the next sample
---@param minsleep_us number @minimum sleep time, in microseconds
function rtcfifo.dsleep_until_sample(minsleep_us) end

---Reads a sample from the rtcfifo. An offset into the rtcfifo\
---may be specified, but by default it reads the first sample (offset 0).
---@param offset? number @(optional) Peek at sample at position `offset` in the fifo.
---@return number timestamp @timestamp in seconds
---@return number value @the value
---@return number neg_e @scaling factor
---@return any @sensor name. If no sample is available (at the specified offset), nothing is returned.
function rtcfifo.peek(offset) end

---Reads the first sample from the rtcfifo,\
---and removes it from there.
---@return number timestamp @timestamp in seconds
---@return number value @the value
---@return number neg_e @scaling factor
---@return any @sensor name
function rtcfifo.pop() end

---Initializes the rtcfifo module for use. Calling `rtcfifo.prepare()` unconditionally re-initializes the storage - any samples stored are discarded.
---@param tbl? table @(optional) This function takes an optional configuration *table* as an argument. The following items may be configured:
--- - **interval_us** If wanting to make use of the `rtcfifo.sleep_until_sample()` function, this field sets the sample interval (in microseconds) to use.\
---It is effectively the first argument of `rtctime.dsleep_aligned()`.
--- - **sensor_count** Specifies the number of different sensors to allocate name space for. This directly corresponds to a number of slots reserved\
---for names in the variable block. The default value is 5, minimum is 1, and maximum is 16.
--- - **storage_begin** Specifies the first RTC user memory slot to use for the variable block. Default is 32. Only takes effect if storage_end is also specified.
--- - **storage_end** Specified the end of the RTC user memory slots. This slot number will not be touched. Default is 128.\
---Only takes effect if storage_begin is also specified.
---@return nil
function rtcfifo.prepare(tbl) end

---Puts a sample into the rtcfifo. If the rtcfifo has not been prepared, this function does nothing.
---@param timestamp number @Timestamp in seconds.
---@param value any @The value to store.
---@param neg_e any @The effective value stored is valueE^neg_e
---@param name string @Name of the sensor. Only the first four (ASCII) characters of name are used.
---@return nil
function rtcfifo.put(timestamp, value, neg_e, name) end

---Returns non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
---@return number @Non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
function rtcfifo.ready() end
