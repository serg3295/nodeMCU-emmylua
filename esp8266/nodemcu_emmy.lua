--********* FTP server ****************--
---@class ftp
local FTP = node.LFS.ftpserver()

---Create the FTP server on the standard ports 20 and 21.
---@param user string | '""'
---@param pass string | ' ""'
---@param dbgFlag boolean
---@return nil
function FTP:createServer(user, pass, dbgFlag) end

---Wrapper to createServer() which also connects to the WiFi channel.
---@param user string | '""'
---@param pass string | ' ""'
---@param ssid string | ' ""'
---@param wifipwd string | ' ""'
---@param dbgFlag boolean
---@return nil
function FTP:open(user, pass, ssid, wifipwd, dbgFlag) end

---Close down server including any sockets and return all resources to Lua.
---@return nil
function FTP:close() end

--********* Telnet server *************--
---@class telnet
local TELNET = require('telnet')

---Open a telnet server based on the provided parameters.
---@param ssid string | '""'
---@param pwd string | ' ""'
---@param port integer | ' 2323'
---@return nil
function TELNET:open(ssid, pwd, port) end

---Close a telnet server and release all resources.
---@return nil
function TELNET:close() end

--************ ADC  ********************--
adc = {}

---Checks and if necessary reconfigures the ADC `mode` setting in the ESP init data block.
---@param mode_value string | '"adc.INIT_ADC"' | '"adc.INIT_VDD33"'
---@return boolean
function adc.force_init_mode(mode_value) end

---Samples the ADC.
---@param channel integer | '0'
---@return number
function adc.read(channel) end

---Reads the system voltage.
---@return number
function adc.readvdd33() end

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

---Generate a number with a 1 bit (used for mask generation).
---@param position number
---@return number
function bit.bit(position) end

---Bitwise negation, equivalent to ~value in C.
---@param value number
---@return number
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
---@param value number
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

--*********** BME280 TODO *************--
bme280 = {}

--*********** BME280_MATH TODO *************--
bme280_math = {}

--*********** CRON *************--
cron = {}

---@class cron
local CRON = cron.schedule()

---Creates a new schedule entry.
---@param mask string | '"* * * * *"'
---@param callback function | ' function(e) end'
---@return function
function cron.schedule(mask, callback) end

---Removes all scheduled entries.
---@return nil
function cron.reset() end

---Sets a new handler for entry.
---@param callback function | ' function(e) end'
---@return nil
function CRON:handler(callback) end

---Sets a new schedule mask.
---@param mask string | '"* * * * *"'
function CRON:schedule(mask) end

---Disables schedule.
---@return nil
function CRON:unschedule() end

--*********** crypto TODO *************--
crypto = {}

---Encrypts Lua strings.
---@param algo any
---@param key any
---@param plain any
---@param iv? any
---@return any
function crypto.encrypt(algo, key, plain , iv) end

---Decrypts previously encrypted data.
---@param algo any
---@param key any
---@param cipher any
---@param iv? any
---@return any
function crypto.decrypt(algo, key, cipher , iv) end

---Compute a cryptographic hash of a a file.
---@param algo any
---@param filename any
---@return any
function crypto.fhash(algo, filename)	end

---Compute a cryptographic hash of a Lua string.
---@param algo any
---@param str any
---@return any
function crypto.hash(algo, str) end

---Create a digest/hash object that can have any number of strings added to it.
---@param algo any
---@return any
function crypto.new_hash(algo) end

---	Compute a HMAC (Hashed Message Authentication Code) signature for a Lua string.
---@param algo any
---@param str any
---@param key any
---@return any
function crypto.hmac(algo, str, key) end

---Create a hmac object that can have any number of strings added to it.
---@param algo any
---@param key any
---@return any
function crypto.new_hmac(algo, key) end

---Applies an XOR mask to a Lua string.
---@param message any
---@param mask any
---@return any
function crypto.mask(message, mask) end

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

--************* FILE  ******************--
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

---Format the file system.
---@return nil
function file.format() end

---Returns the flash address and physical size of the file system area, in bytes.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Open and read the contents of a file.
---@param filename string | '""'
---@return any | nil
function file.getcontents(filename) end

---Lists all files in the file system.
---@return table
function file.list(pattern) end

---Mounts a FatFs volume on SD card.
---@param ldrv string|'"/SD0"'|'"/SD1"'
---@param pin? integer
---@return any
function file.mount(ldrv, pin) end

---Registers callback functions.
---@param event string|'"rtc"'
---@param foo? function|' function() end'
---@return nil
function file.on(event, foo) end

---@alias mode_f
---|>' "r"' # read mode
---| ' "w"' # write mode
---| ' "a"' # append mode
---| ' "r+"' # update mode, all previous data is preserved
---| ' "w+"' # update mode, all previous data is erased
---| ' "a+"' # append update mode, previous data is preserved, writing is only allowed at the end of file

---Opens a file for access, potentially creating it (for write modes).
---@param filename string | '""'
---@param mode mode_f
---@return nil | file
function file.open(filename, mode) end

---Remove a file from the file system. The file must not be currently open.
---@param filename string | '""'
---@return nil
function file.remove(filename) end

---Open and write the contents of a file.
---@param filename string | '""'
---@param contents any
---@return boolean | nil
function file.putcontents(filename, contents) end

---Renames a file.
---@param oldname string | '""'
---@param newname string | ' ""'
---@return boolean
function file.rename(oldname, newname) end

---Get attribtues of a file or directory in a table.
---@param filename string | '""'
---@return table
function file.stat(filename) end

---Closes the open file, if any.
---@return nil
function file.close() end
---@return nil
function fObj:close() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart.
---@return nil
function file.flush() end
---@return nil
function fObj:flush() end

---Read content from the open file.
---@param n_or_char integer
---@return string | nil
function file.read(n_or_char) end
---@param n_or_char integer
---@return string | nil
function fObj:read(n_or_char) end

---Read the next line from the open file.
---@return string | nil
function file.readline() end
---@return string | nil
function fObj:readline() end

---@alias seekwhence_f
---| '"set"' # Base is position 0 (beginning of the file)
---|>'"cur"' # Base is current position
---| '"end"' # Base is end of file
---Sets and gets the file position, measured from the beginning of the file, to the position given by `offset` plus a base specified by the string whence.
---@param whence? seekwhence_f
---@param offset? integer
---@return integer offset | nil
function file.seek(whence , offset) end

---@param whence? seekwhence_f
---@param offset? integer
---@return integer offset | nil
function fObj:seek(whence , offset) end

---Write a string to the open file.
---@param str string | '""'
---@return boolean | nil
function file.write(str) end
---@param str string | '""'
---@return boolean | nil
function fObj:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string | '""'
---@return boolean | nil
function file.writeline(str) end
---@param str string | '""'
---@return boolean | nil
function fObj:writeline(str) end

--*********** GPIO  *************--
gpio = {}

---@class gpio
local pulser = gpio.pulse.build()

---Initialize pin to GPIO mode, set the pin in/out direction, and optional internal weak pull-up.
---@param pin integer
---@param mode integer|' "gpio.OUTPUT"'|' "gpio.INPUT"'|' "gpio.OPENDRAIN"'|' "gpio.INT"'
---@param pullup? string|' "gpio.PULLUP"'|' "gpio.FLOAT"'
---@return nil
function gpio.mode(pin, mode , pullup) end

---Read digital GPIO pin value.
---@param pin integer
---@return number
function gpio.read(pin) end

---Serialize output based on a sequence of delay-times in µs.
---@param pin integer
---@param start_level string|' "gpio.HIGH"'|' "gpio.LOW"'
---@param delay_times table
---@param cycle_num? integer
---@param callback? function|' function() end'
---@return nil
function gpio.serout(pin, start_level, delay_times , cycle_num, callback) end

---@alias trigger_mod
---|' "up"'     #rising edge
---|' "down"'   #falling edge
---|' "both"'   #both edges
---|' "low"'    #low level
---|' "high"'   #high level
---Establish or clear a callback function to run on interrupt for a pin.
---@param pin integer
---@param type? trigger_mod
---@param callback_function? function
---@return nil
function gpio.trig(pin, type , callback_function) end

---Set digital GPIO pin value.
---@param pin integer
---@param level integer|' "gpio.HIGH"'|' "gpio.LOW"'
---@return nil
function gpio.write(pin, level) end

---This builds the gpio.
---@param tbl table
---@return any
function gpio.pulse.build(tbl) end

---This starts the output operations.
---@param adjust? number
---@param callback? function | ' function() end'
---@return nil
function pulser:start(adjust,  callback) end

---This returns the current state.
---@return integer position
---@return integer steps
---@return number offset
---@return number now
function pulser:getstate() end

---This stops the output operation at some future time.
---@param position? integer
---@param callback? function | ' function() end'
---@return boolean
function pulser:stop(position , callback) end

---This stops the output operation immediately.
---@return integer position
---@return integer steps
---@return number offset
---@return number now
function pulser:cancel() end

---This adds (or subtracts) time that will get used in the min / max delay case.
---@param offset number
---@return integer position
---@return integer steps
---@return number offset
---@return number now
function pulser:adjust(offset) end

---This can change the contents of a particular step in the output program.
---@param entrynum number
---@param entrytable table
function pulser:update(entrynum, entrytable) end

--*********** HTTP *************--
http = {}

---Executes a HTTP DELETE request.
---@param url string |'"http://"'|'"https://"'
---@param headers string |' ""'
---@param body string |' ""'
---@param callback function|' function() end'
---@return nil
function http.delete(url, headers, body, callback) end

---Executes a HTTP GET request.
---@param url string |'"http://"'|'"https://"'
---@param headers string |' ""'
---@param callback function |' function() end'
---@return nil
function http.get(url, headers, callback) end

---Executes a HTTP POST request.
---@param url string |'"http://"'|'"https://"'
---@param headers string |' ""'
---@param body string|' ""'
---@param callback function|' function() end'
---@return nil
function http.post(url, headers, body, callback) end

---Executes a HTTP PUT request.
---@param url string | '"http://"'|'"https://"'
---@param headers string | ' ""'
---@param body string | ' ""'
---@param callback function |' function() end'
---@return nil
function http.put(url, headers, body, callback) end

---Execute a custom HTTP request for any HTTP method.
---@param url string |'"http://"'|'"https://"'
---@param method string |' "GET"'|' "HEAD"'|' "POST"'|' "PUT"'|' "DELETE"'|' "CONNECT"'|' "TRACE"'|' "PATCH"'|' "OPTIONS"'
---@param headers string |' ""'
---@param body string |' ""'
---@param callback function |' function() end'
---@return nil
function http.request(url, method, headers, body, callback) end

--*********** MQTT **************--
mqtt = {}

---@class mqtt
local MQTT = mqtt.Client()

---Creates a MQTT client.
---@param clientid string | '""'
---@param keepalive integer
---@param username? string|' ""'
---@param password? string|' ""'
---@param cleansession? boolean |' 1'|' 0'
---@param max_message_length? integer
---@return mqtt
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Closes connection to the broker.
---@return boolean
function MQTT:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string |' ""'
---@param port? integer | ' 1883'
---@param secure? boolean
---@param conn_est? function fun(client: any)
---@param conn_notest? function fun(client: any, reason: any)
---@return nil
function MQTT:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string |' ""'
---@param message string |' ""'
---@param qos? integer |' 0'|' 1'|' 2'
---@param retain? integer |' 0'|' 1'
---@return nil
function MQTT:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"connfail"'|'"suback"'|'"unsuback"'|'"puback"'|'"message"'|'"overflow"'|'"offline"'
---@param handler function|' function(client, topic, message) end'
---@return nil
function MQTT:on(event, handler) end

---Publishes a message.
---@param topic string | '""'
---@param payload string | ' ""'
---@param qos integer |' 0'|' 1'|' 2'
---@param retain integer |' 0'|' 1'
---@param f_puback function? | ' function(client) end'
---@return boolean
function MQTT:publish(topic, payload, qos, retain, f_puback) end

---Subscribes to one or several topics.
---@param topic string | '""'
---@param qos integer |' 0'|' 1'|' 2'
---@param f_client? function | ' function(client) end'
---@return boolean
function MQTT:subscribe(topic, qos, f_client) end

---Subscribes to one or several topics.
---@param tbl table | '{}'
---@param f_client? function | ' function(client) end'
---@return boolean
function MQTT:subscribe(tbl, f_client) end

---Unsubscribes from one or several topics.
---@param topic string | '""'
---@param f_client? function | ' function(client) end'
---@return boolean
function MQTT:unsubscribe(topic, f_client) end

---Unsubscribes from one or several topics.
---@param tbl table | '{}'
---@param f_client? function | ' function(client) end'
---@return boolean
function MQTT:unsubscribe(tbl, f_client) end

--*********** NET **************--
net = {}

---@class net
local NETSOCKET = net.createConnection()
local NETSRV = net.createServer()
local UDPSOCKET = net.createUDPSocket()

---Creates a TCP client.
---@return any
function net.createConnection() end

---Creates a TCP listening socket (a server).
---@param timeout integer
---@return any
function net.createServer(timeout) end

---Creates an UDP socket.
function net.createUDPSocket() end

---Return information about a network interface, specified by index.
---@param if_index integer|'0'|'1'
---@return nil|table
function net.ifinfo(if_index) end

---Join multicast group.
---@param if_ip string
---@param multicast_ip string
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string
---@param multicast_ip string
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server. net.server.close()
---@return nil
function NETSRV.close() end

---Listen on port from IP address. net.server.listen()
---@param port? integer
---@param ip? string
---@param fun function |'function(net.socket) end'
---@return nil
function NETSRV.listen(port, ip, fun) end

---Returns server local address/port. net.server.getaddr()
---@return integer port |nil
---@return string ip |nil
function NETSRV.getaddr() end

---Closes socket. net.socket:close()
---@return nil
function NETSOCKET:close() end

---Connect to a remote server. net.socket:connect()
---@param port integer
---@param ip_domain string
---@return nil
function NETSOCKET:connect(port, ip_domain) end

---Provides DNS resolution for a hostname. net.socket:dns()
---@param domain string
---@param fun |'function(net.socket, ip) end'
---@return nil
function NETSOCKET:dns(domain, fun) end

---Retrieve port and ip of remote peer. net.socket:getpeer()
---@return integer port |nil
---@return string ip |nil
function NETSOCKET:getpeer() end

---Retrieve local port and ip of socket. net.socket:getaddr()
---@return integer port |nil
---@return string ip |nil
function NETSOCKET:getaddr() end

---Throttle data reception by placing a request to block the TCP receive function. net.socket:hold()
---@return nil
function NETSOCKET:hold() end

---Register callback functions for specific events. net.socket:on()
---@param event string|' "connection"'|' "reconnection"'|' "disconnection"'|' "receive"'|'  "sent"'
---@param fun nil|function|' function(net.socket[, string]) end)'
---@return nil
function NETSOCKET:on(event, fun) end

---Sends data to remote peer. net.socket:send()
---@param str string
---@param fun function|' function(sent) end'
---@return nil
function NETSOCKET:send(str, fun) end

---Changes or retrieves Time-To-Live value on socket. net.socket:ttl()
---@param ttl integer
---@return integer
function NETSOCKET:ttl(ttl) end

---Unblock TCP receiving data by revocation of a preceding hold(). net.socket:unhold()
---@return nil
function NETSOCKET:unhold() end

---Closes UDP socket. net.udpsocket:close()
---@return nil
function UDPSOCKET:close() end

---Listen on port from IP address. net.udpsocket:listen()
---@param port? integer
---@param ip? string
---@return nil
function UDPSOCKET:listen(port, ip) end

---Register callback functions for specific events. net.udpsocket:on()
---@param event string|' "receive"'|' "sent"'|' "dns"'
---@param fun nil|function|' function(net.socket[, string]) end)'
---@return nil
function UDPSOCKET:on(event, fun) end

---Sends data to specific remote peer. net.udpsocket:send()
---@param port integer
---@param ip string
---@param data any
---@return nil
function send(port, ip, data) end

---Provides DNS resolution for a hostname. net.udpsocket:dns()
---@param domain string
---@param fun |'function(net.socket, ip) end'
---@return nil
function UDPSOCKET:dns(domain, fun) end

---Retrieve local port and ip of socket. net.udpsocket:getaddr()
---@return integer port |nil
---@return string ip |nil
function UDPSOCKET:getaddr() end

---Changes or retrieves Time-To-Live value on socket. net.udpsocket:ttl()
---@param ttl integer
---@return integer
function UDPSOCKET:ttl(ttl) end

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

--************* NODE *******************--
node = {}

---Returns the boot reason and extended reset info.
---@return any
function node.bootreason() end

---Returns the ESP chip ID.
---@return number
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as.
---@param filename string | '".lua"'
---@return nil
function node.compile(filename) end

---Enters deep sleep mode, wakes up when timed out.
---@param us integer
---@param option integer
---@param instant integer
---@return nil
function node.dsleep(us, option, instant) end

---Returns the current theoretical maximum deep sleep duration.
---@return number
function node.dsleepMax() end

---Returns the flash chip ID
function node.flashid() end

---Returns the flash chip size in bytes.
---@return integer
function node.flashsize() end

---Get the current CPU Frequency.
---@return number
function node.getcpufreq() end

---Get the current LFS and SPIFFS partition information.
---@return table
function node.getpartitiontable() end

---Returns the current available heap size in bytes.
---@return number
function node.heap() end

---Returns information about hardware, software version and build configuration.
---@param group table
---@return table
function node.info(group) end

---Submits a string to the Lua interpreter.
---@param str any
---@return nil
function node.input(str) end

---Returns the function reference for a function in LFS.
---@param modulename string | '""'
---@return string
function node.LFS.get(modulename) end

---List the modules in LFS.
---@return nil | any
function node.LFS.list() end

---Reload LFS with the flash image provided.
---@param imageName string | '""'
---@return any|nil
function node.LFS.reload(imageName) end

---Redirects the Lua interpreter to a stdout pipe when a CB function is specified (See pipe module) and resets output to normal otherwise.
---@param fun function|'fumction(pipe) end'
---@param serial_debug integer|'1'|'0'
---@return nil
function node.output(fun, serial_debug) end

---@return nil
function node.restart() end

---Restores system configuration to defaults using the SDK function system_restore()
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ'
---@return number
function node.setcpufreq(speed) end

---Sets the current LFS and / or SPIFFS partition information.
---@param partition_info table
function node.setpartitiontable(partition_info) end

---@alias int_type_n
---| 'node.INT_UP'   #Rising edge
---| 'node.INT_DOWN' #Falling edge
---| 'node.INT_BOTH' #Both edges
---|>'node.INT_LOW'  #Low level
---| 'node.INT_HIGH' #High level
---Put NodeMCU in light sleep mode to reduce current consumption.
---@param wake_pin integer
---@param int_type? int_type_n
---@param resume_cb? function|' function() end'
---@param preserve_mode? boolean
---@return nil
function node.sleep(wake_pin, int_type, resume_cb, preserve_mode) end

---Query the performance of system startup.
---@param marker any
---@return table
function node.startupcounts(marker) end

---Get/set options that control the startup process. This interface will grow over time.
---@param tbl table
---@return table
function node.startup(tbl) end

---@alias level_n
---| '1' #don't discard debug info
---| '2' #discard Local and Upvalue debug info
---| '3' #discard Local, Upvalue and line-number debug info
---Controls the amount of debug information kept during node.compile(), and allows removal of debug information from already compiled Lua code.
---@param level? level_n
---@param fun? function
---@return integer|nil
function node.stripdebug(level, fun) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean
function node.osprint(enabled) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
---@param l number
---@param u number
---@return number
function node.random(l, u) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
---@param n? integer
---@return number
function node.random(n) end

---Sets the Emergency Garbage Collector mode.
---@param mode integer|'node.egc.NOT_ACTIVE'|'node.egc.ON_ALLOC_FAILURE'|'node.egc.ON_MEM_LIMIT'|'node.egc.ALWAYS'
---@param level number
---@return nil
function node.egc.setmode(mode, level) end

---Returns memory usage information for the Lua runtime.
---@return number total_allocated
---@return number estimated_used
function node.egc.meminfo() end

---@alias task_prio
---| '0' #node.task.LOW_PRIORITY
---|>'1' #node.task.MEDIUM_PRIORITY
---| '2' #node.task.HIGH_PRIORITY
---Enable a Lua callback or task to post another task request.
---@param task_priority? task_prio
---@param fun function|' function() end'
---@return nil
function node.task.post(task_priority, fun) end

--*********** 1-wire *************--
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

--*********** RTCMEM  *************--
rtcmem = {}

---Reads one or more 32bit values from RTC user memory.
---@param idx integer
---@param num number
---@return any
function rtcmem.read32(idx , num) end

---Writes one or more values to RTC user memory, starting at index idx.
---@param idx integer
---@param val number
---@return nil
function rtcmem.write32(idx , val) end

--*********** RTCTIME *************--
rtctime = {}

---Puts the ESP8266 into deep sleep mode, like node.
---@param microseconds number
---@param option any
function rtctime.dsleep(microseconds , option) end

---For applications where it is necessary to take samples with high regularity, this function is useful.
---@param aligned_us number
---@param minsleep_us number
---@param option any
function rtctime.dsleep_aligned(aligned_us, minsleep_us , option) end

---Converts a Unix timestamp to calendar format.
---@param timestamp integer
---@return table
function rtctime.epoch2cal(timestamp) end

---Returns the current time.
---@return number, number, number
function rtctime.get() end

---Sets the rtctime to a given timestamp in the Unix epoch (i.
---@param seconds number
---@param microseconds number
---@param rate number
---@return nil
function rtctime.set(seconds , microseconds, rate) end

---This takes a time interval in 'system clock microseconds' based on the timestamps returned by tmr.
---@param microseconds number
---@return number
function rtctime.adjust_delta(microseconds) end

--*********** SJSON  *************--
sjson = {}

---@class sjson
local encoder = sjson.encoder()
local decoder = sjson.decoder()

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table
---@param opts? table
---@return sjson
function sjson.encoder(tbl , opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer
---@return string | nil
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table
---@param opts? table
---@return string
function sjson.encode(tbl , opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string
---@return any | nil
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string
---@param opts? table
function sjson.decode(str, opts) end

--*********** SNTP *************--
sntp = {}

---Attempts to obtain time synchronization.
---@param server_ip string
---@param callback function | '  function (sec, usec, server, info) end'
---@param errcallback function | ' function()'
---@param autorepeat boolean
---@return nil
function sntp.sync(server_ip, callback, errcallback, autorepeat) end

---Sets the offset between the rtc clock and the NTP time.
---@param offset number
---@return nil
function sntp.setoffset(offset) end

---Gets the offset between the rtc clock and the NTP time.
---@return number
function sntp.getoffset() end

--************ TMR ********************--
tmr = {}

---@class tmr
local tObj = tmr.create()

---Busyloops the processor for a specified number of microseconds.
---@param us number
---@return nil
function tmr.delay(us) end

---Returns the system counter, which counts in microseconds.
---@return number
function tmr.now() end

---Provides a simple software watchdog, which needs to be re-armed or disabled before it expires, or the system will be restarted.
---@param timeout_s number
---@return nil
function tmr.softwd(timeout_s) end

---Returns the system uptime, in seconds.
---@return number
function tmr.time() end

---Feed the system watchdog.
---@return nil
function tmr.wdclr() end

---Get value of CPU CCOUNT register which contains CPU ticks.
---@return number
function tmr.ccount() end

---Creates a dynamic timer object; see below for its method table.
---@return any
function tmr.create() end

---@alias tmr_n
---| " tmr.ALARM_AUTO"   #automatically repeating alarm
---| " tmr.ALARM_SINGLE" #a one-shot alarm (and no need to call unregister())
---| " tmr.ALARM_SEMI"   #manually repeating alarm (call start() to restart)
---This is a convenience function combining tobj:register() and tobj:start() into a single call.
---@param interval number
---@param mode tmr_n
---@param foo function | " function(t) end"
---@return boolean
function tObj:alarm(interval, mode, foo) end

---Changes a registered timer's expiry interval.
---@param interval integer
---@return nil
function tObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval number
---@param mode tmr_n
---@param foo function |" function() end"
---@return nil
function tObj:register(interval, mode, foo) end

---Starts or restarts a previously configured timer.
---@param restart? boolean
---@return boolean
function tObj:start(restart) end

---Checks the state of a timer.
---@return boolean|integer|nil
function tObj:state() end

---Stops a running timer, but does *not* unregister it.
---@return boolean
function tObj:stop() end

---Stops the timer (if running) and unregisters the associated callback.
---@return nil
function tObj:unregister() end

--*********** UART *************--
uart = {}
---Change UART pin assignment.
---@param on integer |'0'|'1'
---@return nil
function uart.alt(on) end
---Sets the callback function to handle UART events.
---@param method string | '"data"'
---@param number_end_char any
---@param fun function | 'function(data) end'
---@param run_input integer |'0'|'1'
---@return nil
function uart.on(method, number_end_char, fun, run_input) end
---(Re-)configures the communication parameters of the UART.
---@param id integer |'0'|'1'
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400'
---@param databits integer|' 8'|' 7'|' 6'|' 5'
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN'
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2'
---@param echo integer |' 1'|' 0'
---@return number
function uart.setup(id, baud, databits, parity, stopbits, echo) end
---Returns the current configuration parameters of the UART.
---@param id integer |'0'|'1'
function uart.getconfig(id) end
---Write string or byte to the UART.
---@param id integer |'0'|'1'
---@param data1 any
---@return nil
function uart.write(id, data1) end
---Report the depth, in bytes, of TX or RX hardware queues associated with the UART.
---@param id integer |'0'|'1'
---@param dir string |' "uart.DIR_RX"'|' "uart.DIR_TX"'
---@return integer
function uart.fifodepth(id, dir) end

--*********** WIFI *************--
wifi = {}

---Gets the current WiFi channel.
---@return integer
function wifi.getchannel() end
---Get the current country info.
---@return table
function wifi.getcountry() end
---Gets default WiFi operation mode.
---@return any
function wifi.getdefaultmode() end
---Gets WiFi operation mode.
---@return any
function wifi.getmode() end
---Gets WiFi physical mode.
---@return any
function wifi.getphymode() end
---Configures whether or not WiFi automatically goes to sleep in NULL_MODE.
---@param enable? boolean
---@return any
function wifi.nullmodesleep(enable) end
---Wake up WiFi from suspended state or cancel pending wifi suspension.
---@param resume_cb function|'function() end'
---@return nil
function wifi.resume(resume_cb) end
---Set the current country info.
---@param country_info table
---@return boolean
function wifi.setcountry(country_info) end
---Configures the WiFi mode to use. NodeMCU can run in one of four WiFi modes.
---@param mode integer|'wifi.STATION'|'wifi.SOFTAP'|'wifi.STATIONAP'|'wifi.NULLMODE'
---@param save? boolean
---@return any
function wifi.setmode(mode, save) end
---Sets WiFi physical mode.
---@param mode integer|'wifi.PHYMODE_B'|'wifi.PHYMODE_G'|'wifi.PHYMODE_N'
---@return any
function wifi.setphymode(mode) end
---Sets WiFi maximum TX power.
---@param max_tpw number
---@return nil
function wifi.setmaxtxpower(max_tpw) end
---Starts to auto configuration, if success set up SSID and password automatically.
---@param type integer|'0'|'1'
---@param callback function|'function() end'
---@return nil
function wifi.startsmart(type, callback) end
---Stops the smart configuring process.
---@return nil
function wifi.stopsmart() end
---Suspend Wifi to reduce current consumption.
---@param duration number|'{'
---@param suspend_cb function
---@param resume_cb function
---@param preserve_mode boolean
---@return integer
function wifi.suspend(duration, suspend_cb, resume_cb, preserve_mode) end
---Auto connects to AP in station mode.
---@param auto integer|'0'|'1'
---@return nil
function wifi.sta.autoconnect(auto) end
---Select Access Point from list returned by wifi.sta.getapinfo()
---@param ap_index integer
---@return boolean
function wifi.sta.changeap(ap_index) end
---Clears the currently saved WiFi station configuration, erasing it from the flash.
---@return boolean
function wifi.sta.clearconfig() end
---Sets the WiFi station configuration.
---@param station_config table
---@return boolean
function wifi.sta.config(station_config) end
---Connects to the configured AP in station mode.
---@param connected_cb function
---@return nil
function wifi.sta.connect(connected_cb) end
---Disconnects from AP in station mode.
---@param disconnected_cb function
---@return nil
function wifi.sta.disconnect(disconnected_cb) end
---Scans AP list as a Lua table into callback function.
---@param cfg table
---@param format integer|'0'|'1'
---@param callback function
---@return nil
function wifi.sta.getap(cfg, format, callback) end
---Get index of current Access Point stored in AP cache.
---@return integer
function wifi.sta.getapindex() end
---Get information of APs cached by ESP8266 station.
---@return table
function wifi.sta.getapinfo() end
---Gets the broadcast address in station mode.
---@return string | nil
function wifi.sta.getbroadcast() end
---Gets the WiFi station configuration.
---@param return_table boolean
---@return table
function wifi.sta.getconfig(return_table) end
---Gets the default WiFi station configuration stored in flash.
---@param return_table boolean
---@return table
function wifi.sta.getdefaultconfig(return_table) end
---Gets current station hostname.
---@return string
function wifi.sta.gethostname() end
---Gets IP address, netmask, and gateway address in station mode.
---@return ...
function wifi.sta.getip() end
---Gets MAC address in station mode.
---@return string
function wifi.sta.getmac() end
---Get RSSI(Received Signal Strength Indicator) of the Access Point which ESP8266 station connected to.
---@return number | nil
function wifi.sta.getrssi() end
---Set Maximum number of Access Points to store in flash. - This value is written to flash
---@param qty integer
---@return boolean
function wifi.sta.setaplimit(qty) end
---Sets station hostname.
---@param hostname string|'""'
---@return boolean
function wifi.sta.sethostname(hostname) end
---Sets IP address, netmask, gateway address in station mode.
---@param cfg table
---@return boolean
function wifi.sta.setip(cfg) end
---Sets MAC address in station mode.
---@param mac string|'""'
---@return boolean
function wifi.sta.setmac(mac) end
---Configures the WiFi modem sleep type to be used while station is connected to an Access Point.
---@param type_wanted integer|'wifi.NONE_SLEEP'|'wifi.LIGHT_SLEEP'|'wifi.MODEM_SLEEP'
---@return any
function wifi.sta.sleeptype(type_wanted) end
---Gets the current status in station mode.
---@return integer
function wifi.sta.status() end
---Sets SSID and password in AP mode.
---@param cfg table
---@return boolean
function wifi.ap.config(cfg) end
---Deauths (forcibly removes) a client from the ESP access point.
---@param MAC string|'""'
---@return boolean
function wifi.ap.deauth(MAC) end
---Gets broadcast address in AP mode.
---@return string
function wifi.ap.getbroadcast() end
---Gets table of clients connected to device in AP mode.
---@return table
function wifi.ap.getclient() end
---Gets the current SoftAP configuration.
---@param return_table boolean
---@return table | any
function wifi.ap.getconfig(return_table) end
---Gets the default SoftAP configuration stored in flash.
---@param return_table boolean
---@return table | any
function wifi.ap.getdefaultconfig(return_table) end
---Gets IP address, netmask and gateway in AP mode.
---@return string
function wifi.ap.getip() end
---Gets MAC address in AP mode.
---@return string
function wifi.ap.getmac() end
---Sets IP address, netmask and gateway address in AP mode.
---@param cfg table
---@return boolean
function wifi.ap.setip(cfg) end
---Sets MAC address in AP mode.
---@param mac string|'""'
---@return boolean
function wifi.ap.setmac(mac) end
---Configure the dhcp service. Currently only supports setting the start address of the dhcp address pool.
---@param dhcp_config table
---@return integer
function wifi.ap.dhcp.config(dhcp_config) end
---Starts the DHCP service.
---@return boolean
function wifi.ap.dhcp.start() end
---Stops the DHCP service.
---@return boolean
function wifi.ap.dhcp.stop() end
---Register callbacks for WiFi event monitor
---@param Event integer|'wifi.eventmon.STA_CONNECTED'|'wifi.eventmon.STA_DISCONNECTED'|'wifi.eventmon.STA_AUTHMODE_CHANGE'|'wifi.eventmon.STA_GOT_IP'|'wifi.eventmon.STA_DHCP_TIMEOUT'|'wifi.eventmon.AP_STACONNECTED'|'wifi.eventmon.AP_STADISCONNECTED'|'wifi.eventmon.AP_PROBEREQRECVED'
---@param fun any
---@return nil
function wifi.eventmon.register(Event, fun) end
---Unregister callbacks for WiFi event monitor
---@param Event integer|'wifi.eventmon.STA_CONNECTED'|'wifi.eventmon.STA_DISCONNECTED'|'wifi.eventmon.STA_AUTHMODE_CHANGE'|'wifi.eventmon.STA_GOT_IP'|'wifi.eventmon.STA_DHCP_TIMEOUT'|'wifi.eventmon.AP_STACONNECTED'|'wifi.eventmon.AP_STADISCONNECTED'|'wifi.eventmon.AP_PROBEREQRECVED'|'wifi.eventmon.WIFI_MODE_CHANGED'
---@return nil
function wifi.eventmon.unregister(Event) end
