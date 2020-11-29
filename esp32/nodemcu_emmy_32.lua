--*********** ADC *************--
adc = {}

---The configuration is in effect for all channels of ADC1.
---@param adc_number integer|'adc.ADC1'
---@param bits integer|' 9'|' 10'|' 11'|' 12'
---@return nil
function adc.setwidth(adc_number, bits) end

---@alias chan_adc
---| ' 0' # GPIO36
---| ' 1' # GPIO37
---| ' 2' # GPIO38
---| ' 3' # GPIO39
---| ' 4' # GPIO32
---| ' 5' # GPIO33
---| ' 6' # GPIO34
---| ' 7' # GPIO35
---@alias atten_adc
---| ' adc.ATTEN_0db' #Vinp will be reduced to about 1/1
---|' adc.ATTEN_2_5db' #Vinp will be reduced to about 1/1.34
---|' adc.ATTEN_6db' #Vinp will be reduced to about 1/2
---|' adc.ATTEN_11db' #Vinp will be reduced to about 1/3.6

---Configuration ADC1 capture attenuation of channels.
---@param adc_number integer|'adc.ADC1'
---@param channel chan_adc
---@param atten atten_adc
---@return nil
function adc.setup(adc_number, channel, atten) end

---Samples the ADC. You should to call setwidth() before read().
---@param adc_number integer|'adc.ADC1'
---@param channel integer|' 0'|' 1'|' 2'|' 3'|' 4'|' 5'|' 6'|' 7'
---@return number
function adc.read(adc_number, channel) end

---Read Hall sensor (GPIO36, GPIO39). We recommend using 12-bits width on ADC1.
---@return number
function adc.read_hall_sensor() end

--*********** BIT *************--
bit = {}

---Arithmetic right shift a number equivalent to `value` >> `shift` in C.
---@param value integer
---@param shift integer
---@return integer
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1` & `val2` & ... & `valn` in C.
---@param val1 integer
---@param val2 integer
---@return integer
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation). Equivalent to 1 << position in C
---@param position integer
---@return integer
function bit.bit(position) end

---Bitwise negation, equivalent to `~value in C.
---@param value integer
---@return integer
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1` | `val2` | ... | `valn` in C.
---@param val1 integer
---@param val2 integer
---@return integer
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1` ^ `val2` ^ ... ^ `valn` in C.
---@param val1 integer
---@param val2 integer
---@return integer
function bit.xor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer
---@param pos1 integer
---@return integer
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer
---@param position integer
---@return boolean
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value integer
---@param position integer
---@return boolean
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value` << `shift` in C.
---@param value integer
---@param shift integer
---@return integer
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to ( unsigned )`value` >> `shift` in C.
---@param value integer
---@param shift integer
---@return integer
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer
---@param pos1 integer
---@return integer
function bit.set(value, pos1, ...) end

--********** BTHCI ************--
bthci = {}

---Sends a raw HCI command to the BlueTooth controller.
---@param hcibytes any
---@param callback? function
---@return nil
function bthci.rawhci(hcibytes , callback) end

---Resets the BlueTooth controller.
---@param callback? function
---@return nil
function bthci.reset(callback) end

---Enables or disables BlueTooth LE advertisements.
---@param onoff integer|'0'|'1'
---@param callback? function
---@return nil
function bthci.adv.enable(onoff , callback) end

---Configures the data to advertise.
---@param advbytes any
---@param callback? function
---@return nil
function bthci.adv.setdata(advbytes , callback) end

---Configures advertisement parameters.
---@param paramtable table
---@param callback? function
---@return nil
function bthci.adv.setparams(paramtable , callback) end

---Enables or disable scanning for advertisements from other BlueTooth devices.
---@param onoff integer|'0'|'1'
---@param callback? function
---@return nil
function bthci.scan.enable(onoff , callback) end

---Configures scan parameters.
---@param paramstable table
---@param callback? function
---@return nil
function bthci.scan.setparams(paramstable , callback) end

---Registers the callback to be passed any received advertisements.
---@param event string|'"adv_report"'
---@param callback? function
---@return nil
function bthci.scan.on(event , callback) end

--*********** CAN TODO *************--
can = {}

---Send a frame.
---@param format integer|'can.STANDARD_FRAME'|'can.EXTENDED_FRAME'
---@param msg_id any
---@param data any
---@return nil
function can.send(format, msg_id, data) end

---Configuration CAN controller.
---@param tbl table
---@param fun function
---@return nil
function can.setup(tbl, fun) end

---Start CAN controller.
---@return nil
function can.start() end

---Stop CAN controller.
---@return nil
function can.stop() end

--********* CRYPTO ************--
crypto = {}

---Create a digest/hash object that can have any number of strings added to it.
---@param algo any
---@return any
function crypto.new_hash(algo) end

---Create an object for calculating a HMAC (Hashed Message Authentication Code, aka "signature").
---@param algo any
---@param key any
---@return any update
---@return any finalize
function crypto.new_hmac(algo, key) end

--*********** DAC *************--
dac = {}

---Disables DAC output on the related GPIO.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2'
---@return nil
function dac.disable(channel) end

---Enables DAC output on the related GPIO.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2'
---@return nil
function dac.enable(channel) end

---Sets the output value of the DAC.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2'
---@param value number
---@return nil
function dac.write(channel, value) end

--*********** DHT *************--
dht = {}

---Read DHT11 humidity temperature combo sensor.
---@param pin integer
---@return integer status
---@return number temp
---@return number humi
---@return number temp_dec
---@return number humi_dec
function dht.read11(pin) end

---Read DHT21/22/33/43 and AM2301/2302/2303 humidity temperature combo sensors.
---@param pin integer
---@return integer status
---@return number temp
---@return number humi
---@return number temp_dec
---@return number humi_dec
function dht.read2x(pin) end

--********* ENCODER ***********--
encoder = {}

---Provides a Base64 representation of a (binary) Lua string.
---@param binary string
---@return string
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string back into the original string.
---@param b64 string
---@return string
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string.
---@param binary string
---@return string
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string.
---@param hexstr string
---@return string
function encoder.fromHex(hexstr) end

--*********** ETH *************--
eth = {}

---Get MAC address.
---@return string
function eth.get_mac() end

---Get Ethernet connection speed.
---@return any
function eth.get_speed() end

---Initialize the PHY chip and set up its tcpip adapter.
---@param cfg table
---@return nil
function eth.init(cfg) end

---Register or unregister callback functions for Ethernet events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"got_ip"'
---@param callback nil|function | ' function(event, info) end'
function eth.on(event, callback) end

---Set MAC address.
---@param mac string
---@return nil
function eth.set_mac(mac) end

--********** FILE *************--
file = {}

---@class file
local fObj = file.open()

---Change current directory (and drive).
---@param dir string | '"/FLASH"' | '"/SD0"' | '"/SD1"'
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string | '""'
---@return boolean
function file.exists(filename) end

---Format the file system. Completely erases any existing file system and writes a new one.
---@return nil
function file.format() end

---Returns the flash address and physical size of the file system area, in bytes.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system. The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Lists all files in the file system.
---@return table
function file.list(pattern) end

---Registers callback functions.
---@param event string|'"rtc"'
---@param foo function? | ' function() end'
---@return nil
function file.on(event, foo) end

---@alias mode32_f
---|>' "r"' # read mode
---| ' "w"' # write mode
---| ' "a"' # append mode
---| ' "r+"' # update mode, all previous data is preserved
---| ' "w+"' # update mode, all previous data is erased
---| ' "a+"' # append update mode, previous data is preserved, writing is only allowed at the end of file

---Opens a file for access, potentially creating it (for write modes).
---@param filename string | '""'
---@param mode mode32_f
---@return nil | any
function file.open(filename, mode) end

---Remove a file from the file system. The file must not be currently open.
---@param filename string | '""'
---@return nil
function file.remove(filename) end

---Renames a file. If a file is currently open, it will be closed first.
---@param oldname string | '""'
---@param newname string | ' ""'
---@return boolean
function file.rename(oldname, newname) end

---Closes the open file, if any.
---@return nil
function file.close() end
---Closes the open file, if any.
---@return nil
function fObj:close() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart.
---@return nil
function file.flush() end
---Flushes any pending writes to the file system, ensuring no data is lost on a restart.
---@return nil
function fObj:flush() end

---Read content from the open file.
---@param n_or_char? integer
---@return string | nil
function file.read(n_or_char) end
---Read content from the open file.
---@param n_or_char? integer
---@return string | nil
function fObj:read(n_or_char) end

---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string | nil
function file.readline() end
---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string | nil
function fObj:readline() end

---@alias seekwhence32_f
---| '"set"' # Base is position 0 (beginning of the file)
---|>'"cur"' # Base is current position
---| '"end"' # Base is end of file
---Sets and gets the file position, measured from the beginning of the file, to the position given by offset plus a base specified by the string whence.
---@param whence? seekwhence32_f
---@param offset? integer
---@return integer offset | nil
function file.seek(whence , offset) end
---Sets and gets the file position, measured from the beginning of the file, to the position given by offset plus a base specified by the string whence.
---@param whence? seekwhence32_f
---@param offset? integer
---@return integer offset | nil
function fObj:seek(whence , offset) end

---Write a string to the open file.
---@param str string | '""'
---@return boolean | nil
function file.write(str) end
---Write a string to the open file.
---@param str string | '""'
---@return boolean | nil
function fObj:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string | '""'
---@return boolean | nil
function file.writeline(str) end
---Write a string to the open file and append '\n' at the end.
---@param str string | '""'
---@return boolean | nil
function fObj:writeline(str) end

--********** GPIO *************--
gpio = {}

---@alias pull_gpio32
---| 'pull=gpio.FLOATING'     #disables both pull-up and -down
---| 'pull=gpio.PULL_UP '     #enables pull-up and disables pull-down
---| 'pull=gpio.PULL_DOWN'    #enables pull-down and disables pull-up
---| 'pull=gpio.PULL_UP_DOWN' #enables both pull-up and -down
---Configure GPIO mode for one or more pins.
---@param gpio integer
---@param dir string |' dir=gpio.IN'|'dir=gpio.OUT'|'dir=gpio.IN_OUT'
---@param opendrain string| 'opendrain = 0'|'opendrain = 1'
---@param pull pull_gpio32
---@return nil
function gpio.config(gpio, dir, opendrain, pull) end

---Read digital GPIO pin value.
---@param pin integer
---@return integer
function gpio.read(pin) end

---@alias strenght32
---|'gpio.DRIVE_0' #weakest drive strength
---|'gpio.DRIVE_1' #stronger drive strength
---|'gpio.DRIVE_2' #default drive strength
---|'gpio.DRIVE_DEFAULT' #default drive strength (same as DRIVE_2)
---|'gpio.DRIVE_3' #maximum drive strength
---Set the drive strength of a given GPIO pin.
---@param pin integer
---@param strength strenght32
---@return nil
function gpio.set_drive(pin, strength) end

---@alias type_trig32
---|' "gpio.INTR_DISABLE"' #or nil to disable interrupts on this pin (in which case callback is ignored and should be nil or omitted)
---|' "gpio.INTR_UP"' #for trigger on rising edge
---|' "gpio.INTR_DOWN"' #for trigger on falling edge
---|' "gpio.INTR_UP_DOWN"' #for trigger on both edges
---|' "gpio.INTR_LOW"' #for trigger on low level
---|'"gpio.INTR_HIGH"' #for trigger on high level
---Establish or clear a callback function to run on interrupt for a GPIO.
---@param pin integer
---@param type type_trig32
---@param callback function
---@return nil
function gpio.trig(pin , type , callback) end

---@alias level_gpio32
---|' "gpio.INTR_NONE"'  #to disable wake-up
---|' "gpio.INTR_LOW"'   #for wake-up on low level
---|' "gpio.INTR_HIGH"'  #for wake-up on high level
---Configuring wake-from-sleep-on-GPIO-level.
---@param pin integer
---@param level level_gpio32
---@return nil
function gpio.wakeup(pin, level) end

---Set digital GPIO pin value.
---@param pin integer
---@param level integer|' 1'|' 0'
---@return nil
function gpio.write(pin, level) end

--********** HTTP *************--
http = {}

---@class http
HTTP = http.createConnection()

---Creates a connection object which can be configured and then executed.
---@param url string|'"http://"'|'"https://"'
---@param method? integer|' http.GET'|' http.POST'|' http.DELETE'|' http.HEAD'
---@param options? any
---@return http
function http.createConnection(url, method, options) end

---@alias event32_http
---|' "connect"' #Called when the connection is first established. Callback receives no arguments.
---|' "headers"' #Called once the HTTP headers from the remote end have been received. Callback is called as callback(status_code, headers_table).
---|' "data"' #Can be called multiple times, each time more (non-headers) data is received. Callback is called as callback(status_code, data).
---|' "complete"' #Called once all data has been received. Callback is called as callback status_code, connected) where connected is true if the connection is still open.
---Set a callback to be called when a certain event occurs.
---@param event event32_http
---@param callback? function|nil|' function() end'
---@return nil
function HTTP:on(event, callback) end

---Opens the connection to the server and issues the request.
---@return nil|any
function HTTP:request() end

---Sets the connection method.
---@param method? integer|'http.GET'|'http.POST'|'http.DELETE'|'http.HEAD'
---@return nil
function HTTP:setmethod(method) end

---Sets the connection URL.
---@param url string|'""'
---@return nil
function HTTP:seturl(url) end

---Sets an individual header in the request.
---@param name string
---@param value? string|nil
---@return nil
function HTTP:setheader(name, value) end

---Sets the POST data to be used for this request.
---@param data any|nil
---@return nil
function HTTP:setpostdata(data) end

---Completes a callback that was previously delayed by returning http.DELAYACK.
---@return nil
function HTTP:ack() end

---Closes the connection if it is still open.
---@return nil
function HTTP:close() end

---Make an HTTP GET request. If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string | '"http://"'|'"https://"'
---@param options? any|nil
---@param callback? function|nil|' function() end'
---@return nil|any
function http.get(url, options, callback) end

---Executes a single HTTP POST request and closes the connection. If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string | '"http://"'|'"https://"'
---@param options any|nil
---@param body any
---@param callback? function|nil|' function() end'
---@return nil|any
function http.post(url, options, body, callback) end

--*********** I2C TODO *************--
i2c = {}

--*********** I2S TODO *************--
i2s ={}

--********** LEDC TODO *************--
ledc = {}

--********** MQTT *************--
mqtt = {}

---@class mqtt
local MQTT32 = mqtt.Client()

---Creates a MQTT client.
---@param clientid string | '""'
---@param keepalive integer
---@param username? string|' ""'
---@param password? string|' ""'
---@param cleansession? boolean |' 1'|' 0'
---@return mqtt
function mqtt.Client(clientid, keepalive, username, password, cleansession) end

---Closes connection to the broker.
---@return boolean
function MQTT32:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string |' ""'
---@param port? integer | ' 1883'
---@param secure? boolean
---@param conn_est? function fun(client: any)
---@param conn_notest? function fun(client: any, reason: any)
---@return boolean
function MQTT32:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string |' ""'
---@param message string |' ""'
---@param qos? integer |' 0'|' 1'|' 2'
---@param retain? integer |' 0'|' 1'
---@return nil
function MQTT32:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"message"'|'"offline"'
---@param handler function|' function(client, topic?:string, message?:string) end'
---@return nil
function MQTT32:on(event, handler) end

---Publishes a message.
---@param topic string|'""'
---@param payload string|' ""'
---@param qos integer|' 0'|' 1'|' 2'
---@param retain integer|' 0'|' 1'
---@param f_puback function?|' function(client) end'
---@return boolean
function MQTT32:publish(topic, payload, qos, retain, f_puback) end

---Subscribes to one or several topics.
---@param topic string|'""'
---@param qos integer|' 0'|' 1'|' 2'
---@param f32_client? function |' function(client) end'
---@return boolean
function MQTT32:subscribe(topic, qos, f32_client) end

---Unsubscribes from one or several topics.
---@param topic string | '""'
---@param f32_client? function | ' function(client) end'
---@return boolean
function MQTT32:unsubscribe(topic, f32_client) end

--*********** NET *************--
net = {}

---@class net
local NETSOCKET32 = net.createConnection()
local NETSRV32= net.createServer()
local UDPSOCKET32 = net.createUDPSocket()

---Creates a client.
---@param type? integer|'net.TCP'|'net.UDP'
---@param secure? integer|'0'
---@return any
function net.createConnection(type, secure) end

---Creates a server.
---@param type? integer|'net.TCP'|'net.UDP'
---@param timeout? integer
---@return any
function net.createServer(type, timeout) end

---Creates an UDP socket.
---@return any
function net.createUDPSocket() end

---Join multicast group.
---@param if_ip string
---@param multicast_ip string
---@return any
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string
---@param multicast_ip string
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server. net.server.close()
---@return nil
function NETSRV32.close() end

---Listen on port from IP address. net.server.listen()
---@param port? integer
---@param ip? string
---@param fun function |'function(net.socket) end'
---@return nil
function NETSRV32.listen(port, ip, fun) end

---Returns server local address/port. net.server.getaddr()
---@return integer port |nil
---@return string ip |nil
function NETSRV32.getaddr() end

---Closes socket. net.socket:close()
---@return nil
function NETSOCKET32:close() end

---Connect to a remote server. net.socket:connect()
---@param port integer
---@param ip_domain string
---@return nil
function NETSOCKET32:connect(port, ip_domain) end

---Provides DNS resolution for a hostname. net.socket:dns()
---@param domain string
---@param fun |'function(net.socket, ip) end'
---@return nil
function NETSOCKET32:dns(domain, fun) end

---Retrieve port and ip of remote peer. net.socket:getpeer()
---@return integer port |nil
---@return string ip |nil
function NETSOCKET32:getpeer() end

---Retrieve local port and ip of socket. net.socket:getaddr()
---@return integer port |nil
---@return string ip |nil
function NETSOCKET32:getaddr() end

---Throttle data reception by placing a request to block the TCP receive function. net.socket:hold()
---@return nil
function NETSOCKET32:hold() end

---Register callback functions for specific events. net.socket:on()
---@param event string|' "connection"'|' "reconnection"'|' "disconnection"'|' "receive"'|' "sent"'
---@param fun nil|function|' function(net.socket[, string]) end)'
---@return nil
function NETSOCKET32:on(event, fun) end

---Sends data to remote peer. net.socket:send()
---@param str string
---@param fun function|' function(sent) end'
---@return nil
function NETSOCKET32:send(str, fun) end

---Unblock TCP receiving data by revocation of a preceding hold(). net.socket:unhold()
---@return nil
function NETSOCKET32:unhold() end

---Closes UDP socket. net.udpsocket:close()
---@return nil
function UDPSOCKET32:close() end

---Listen on port from IP address. net.udpsocket:listen()
---@param port? integer
---@param ip? string
---@return nil
function UDPSOCKET32:listen(port, ip) end

---Register callback functions for specific events. net.udpsocket:on()
---@param event string|' "receive"'|' "sent"'|' "dns"'
---@param fun nil|function|' function(net.socket[, string]) end)'
---@return nil
function UDPSOCKET32:on(event, fun) end

---Sends data to specific remote peer. net.udpsocket:send()
---@param port integer
---@param ip string
---@param data any
---@return nil
function UDPSOCKET32:send(port, ip, data) end

---Provides DNS resolution for a hostname. net.udpsocket:dns()
---@param domain string
---@param fun |'function(net.socket, ip) end'
---@return nil
function UDPSOCKET32:dns(domain, fun) end

---Retrieve local port and ip of socket. net.udpsocket:getaddr()
---@return integer port |nil
---@return string ip |nil
function UDPSOCKET32:getaddr() end

---Gets the IP address of the DNS server used to resolve hostnames. net.dns.getdnsserver()
---@param dns_index integer|'0'|'1'
---@return string
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. net.dns.resolve() Doesn't require a socket like net.socket.dns().
---@param host string
---@param fun function|' function(sk, ip) end'
---@return nil
function net.dns.resolve(host, fun) end

---Sets the IP of the DNS server used to resolve hostnames. net.dns.setdnsserver()
---@param dns_ip_addr string
---@param dns_index integer|'0'|'1'
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end

--********** NODE *************--
node = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode
---@return integer reason
---@return ...
function node.bootreason() end

---Returns the ESP chip ID.
---@return string
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as.
---@param filename string | '".lua"'
---@return nil
function node.compile(filename) end

---Enters deep sleep mode.
---@param usecs number
function node.dsleep(usecs) end

---Enters deep sleep mode.
---@param options table
function node.dsleep(options) end

---Returns the flash chip ID.
---@return number
function node.flashid() end

---Returns the current available heap size in bytes.
---@return number
function node.heap() end

---Returns NodeMCU version, chipid, flashid, flash size, flash mode, flash speed.
---@return number majorVer
---@return number minorVer
---@return number devVer
---@return number chipid
---@return number flashid
---@return number flashsize
---@return number flashmode
---@return number flashspeed
function node.info() end

---Submits a string to the Lua interpreter. Similar to pcall(loadstring(str)), but without the single-line limitation.
---@param str string
---@return nil
function node.input(str) end

---Redirects the Lua interpreter output to a callback function. Optionally also prints it to the serial console.
---@param fun function | nil
---@param serial_output integer|'1'|'0'
---@return nil
function node.output(fun, serial_output) end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults using the SDK function system_restore(), which doesn't document precisely what it erases/restores.
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ'
---@return number
function node.setcpufreq(speed) end

---@alias level_n32
---| '1' #don't discard debug info
---| '2' #discard Local and Upvalue debug info
---| '3' #discard Local, Upvalue and line-number debug info
---Controls the amount of debug information kept during node.compile(), and allows removal of debug information from already compiled Lua code.
---Controls the amount of debug information kept during node.compile(), and allows removal of debug information from already compiled Lua code.
---@param level? level_n32
---@param fun? function
---@return integer|nil
function node.stripdebug(level, fun) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean
function node.osprint(enabled) end

---Returns the value of the system counter, which counts in microseconds starting at 0 when the device is booted.
---@return number lowbits
---@return number highbits
function node.uptime() end

---Sets the Emergency Garbage Collector mode.
---@param mode integer|'node.egc.NOT_ACTIVE'|'node.egc.ON_ALLOC_FAILURE'|'node.egc.ON_MEM_LIMIT'|'node.egc.ALWAYS'
---@param level number
---@return nil
function node.egc.setmode(mode, level) end

---@alias task_prio32
---| '0' #node.task.LOW_PRIORITY
---| '1' #node.task.MEDIUM_PRIORITY
---| '2' #node.task.HIGH_PRIORITY
---Enable a Lua callback or task to post another task request.
---@param task_priority? task_prio32
---@param fun function | ' function() end'
---@return nil
function node.task.post(task_priority, fun) end

--*********** OTA *************--
otaupgrade = {}

---The boot info and application state and version info can be queried with this function.
---@return string
---@return string
---@return table
function otaupgrade.info() end

---Wipes the spare application partition and prepares to receive the new application firmware.
---@return nil
function otaupgrade.commence() end

---Write a chunk of application firmware data to the correct partition and location.
---@param data string|any
---@return nil
function otaupgrade.write(data) end

---Finalises the upgrade, and optionally reboots into the new application firmware right away.
---@param reboot integer|nil
---@return nil
function otaupgrade.complete(reboot) end

---When the installed boot loader is built with rollback support, a new application image is by default only booted once.
---@return nil
function otaupgrade.accept() end

---A new firmware may decide that it is not performing as expected, and request an explicit rollback to the previous version.
function otaupgrade.rollback() end

--********* 1-WIRE ************--
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string
---@param inverted_crc0 any
---@param inverted_crc1 any
---@param crc? any
---@return boolean
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf any
---@param crc? any
---@return number
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used in the ROM and scratchpad registers.
---@param buf string
---@return number
function ow.crc8(buf) end

---Stops forcing power onto the bus.
---@param pin integer
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer
---@return integer
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer
---@param size any
---@return string
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer
---@return integer
function ow.reset(pin) end

---Clears the search state so that it will start from the beginning again.
---@param pin integer
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer
---@return string|nil
function ow.search(pin) end

---Issues a 1-Wire rom select command. Make sure you do the ow.reset(pin) first.
---@param pin integer
---@param rom string
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command, to address all on bus.
---@param pin integer
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code. The search itself has to be initiated with a subsequent call to ow.search().
---@param pin integer
---@param family_code integer
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end for parasitically powered devices.
---@param pin integer
---@param v integer
---@param power integer
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end for parasitically powered devices.
---@param pin integer
---@param buf string
---@param power integer
---@return nil
function ow.write_bytes(pin, buf, power) end

--********* PULCECNT TODO **********--
pulsecnt = {}

--******** QRCODEGEN TODO **********--
qrcodegen = {}

--********** SDMMC TODO ************--
sdmmc = {}

--******* SIGMA DELTA TODO *********--
sigma_delta = {}

--********** SJSON ************--
sjson = {}

---@class sjson
local encoder = sjson.encoder()
local decoder = sjson.decoder()

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table
---@param opts table
function sjson.encoder(tbl , opts) end

---This gets a chunk of JSON encoded data.
---@param size integer
---@return string | nil
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table
---@param opts table
---@return string
function sjson.encode(tbl , opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts table
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string
---@return any | nil
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string
---@param opts table
function sjson.decode(str, opts) end

--********** SODIUM TODO ***********--
sodium = {}

--********** SPI TODO **************--
spi = {}

--********* STRUCT TODO ************--
struct = {}

--*********** TIME ************--
time = {}

---Converts calendar table to a timestamp in Unix epoch
---@param calendar table
---@return integer
function time.cal2epoch(calendar) end

---Converts timestamp in Unix epoch to calendar format
---@param time integer
---@return table
function time.epoch2cal(time) end

---Returns current system time in the Unix epoch (seconds from midnight 1970/01/01).
---@return integer sec
---@return integer usec
function time.get() end

---Returns current system time adjusted for the locale in calendar format.
---@return table
function time.getlocal() end

---Initializes and starts NTP client
---@param ntpAddr string | '""'
---@return nil
function time.initntp(ntpAddr) end

---Checks if NTP client is enabled.
---@return boolean
function time.ntpenabled() end

---Stops NTP client.
---@return nil
function time.ntpstop() end

---Sets system time to a given timestamp in the Unix epoch (seconds from midnight 1970/01/01).
---@param time integer
---@return nil
function time.set(time) end

---Sets correct format for Time Zone locale
---@param timezone string | '"EST+3"'
---@return nil
function time.settimezone(timezone) end

--*********** TMR *************--
tmr = {}

---@class tmr
local tObj = tmr.create()

---Creates a dynamic timer object.
---@return tmr
function tmr.create() end

---@alias tmr32
---| " tmr.ALARM_AUTO"   #automatically repeating alarm
---| " tmr.ALARM_SINGLE" #a one-shot alarm (and no need to call tmr.unregister())
---| " tmr.ALARM_SEMI"   #manually repeating alarm (call tmr.start() to restart)
---This is a convenience function combining tmr.obj:register() and tmr.obj:start() into a single call.
---@param interval integer
---@param mode tmr32
---@param foo function | " function(t) end"
---@return boolean
function tObj:alarm(interval, mode, foo) end

---Changes a registered timer's expiry interval.
---@param interval integer
---@return nil
function tObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval integer
---@param mode tmr32
---@param foo function |" function() end"
---@return nil
function tObj:register(interval, mode, foo) end

---Starts or restarts a previously configured timer.
---@return boolean
function tObj:start() end

---Checks the state of a timer.
---@return boolean | integer | nil
function tObj:state() end

---Stops a running timer, but does not unregister it. A stopped timer can be restarted with tmr.obj:start().
---@return boolean
function tObj:stop() end

---Stops the timer (if running) and unregisters the associated callback.
---@return nil
function tObj:unregister() end

--********** TOUCH TODO ************--
touch ={}

--*********** U8G2 TODO ************--
u8g2 = {}

--*********** UART ************--
uart = {}

---Sets the callback function to handle UART events.
---@param id? integer |'0'|'1'
---@param method string | ' "data"' | ' "error"'
---@param number_end_char? number
---@param fun? function | ' function() end'
---@param run_input? integer |'0'|'1'
---@return nil
function uart.on(id, method, number_end_char, fun, run_input) end

---(Re-)configures the communication parameters of the UART.
---@param id integer | '0' | '1'
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400'
---@param databits integer|' 8'|' 7'|' 6'|' 5'
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN'
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2'
---@param echo_or_pins table | integer |' 0'
---@return number
function uart.setup(id, baud, databits, parity, stopbits, echo_or_pins) end

---Returns the current configuration parameters of the UART.
---@param id integer | '0' | '1'
---@return integer baud
---@return integer databits
---@return integer parity
---@return integer stopbits
function uart.getconfig(id) end

---Start the UART.
---@param id integer | '0' | '1'
---@return boolean
function uart.start(id) end

---Stop the UART.
---@param id integer | '0' | '1'
---@return nil
function uart.stop(id) end

---Set UART controllers communication mode
---@param id integer | '0' | '1'
---@param mode integer|'uart.MODE_UART'|'uart.MODE_RS485_COLLISION_DETECT'|'uart.MODE_RS485_APP_CONTROL'|'uart.MODE_RS485_HALF_DUPLEX'|'uart.MODE_IRDA'
---@return nil
function uart.setmode(id, mode) end

---Write string or byte to the UART.
---@param id integer | '0' | '1'
---@param data1 any
---@return nil
function uart.write(id, data1, ...) end

--*********** UCG TODO *************--
ucg = {}

--*********** WIFI ************--
wifi = {}

---Gets the current WiFi channel.
---@return integer
---@return integer
function wifi.getchannel() end

---Gets WiFi operation mode.
---@return string
function wifi.getmode() end

---Configures the WiFi mode to use.
---@param mode string |'wifi.STATION'|'wifi.SOFTAP'|'wifi.STATIONAP'|'wifi.NULLMODE'
---@param save? boolean
---@return any
function wifi.mode(mode, save) end

---Starts the WiFi interface(s).
---@return nil
function wifi.start() end

---Shuts down the WiFi interface(s).
---@return nil
function wifi.stop() end

---Sets the WiFi station configuration.
---@param station_config table
---@param save boolean
---@return nil
function wifi.sta.config(station_config, save) end

---Connects to the configured AP in station mode. You only ever need to call this if auto-connect was disabled in wifi.sta.config().
---@return nil
function wifi.sta.connect() end

---Disconnects from AP in station mode.
---@return nil
function wifi.sta.disconnect() end

---Registers callbacks for WiFi station status events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"authmode_changed"'|'"got_ip"'
---@param callback function | ' function(event, info) end'
---@return nil
function wifi.sta.on(event, callback) end

---Gets MAC address in station mode.
---@return string
function wifi.sta.getmac() end

---Scan for available networks.
---@param cfg table
---@param callback function | ' function(ap_list) end'
---@return nil
function wifi.sta.scan(cfg, callback) end

---Sets IP address, netmask, gateway, dns address in station mode.
---@param cfg table
---@return nil
function wifi.sta.setip(cfg) end

---Sets station hostname
---@param hostname string|'""'
---@return boolean
function wifi.sta.sethostname(hostname) end

---Configures the AP.
---@param cfg table
---@param save boolean
---@return nil
function wifi.ap.config(cfg, save) end

---Registers callbacks for WiFi AP events.
---@param event string|'"start"'|'"stop"'|'"sta_connected"'|'"sta_disconnected"'|'"probe_req"'
---@param callback function | ' function(event, info) end'
function wifi.ap.on(event, callback) end

---Gets MAC address in access point mode.
---@return string
function wifi.ap.getmac() end

---Sets IP address, netmask, gateway, dns address in AccessPoint mode.
---@param cfg table
---@return nil
function wifi.ap.setip(cfg) end

---Sets AccessPoint hostname.
---@param hostname string|'""'
---@return boolean
function wifi.ap.sethostname(hostname) end

--********** WS2812 TODO ***********--
ws2812 = {}
