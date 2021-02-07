--*** ADC ***
adc = {}

---The configuration is in effect for all channels of ADC1.
---@param adc_number integer|'adc.ADC1' Only adc.ADC1 now
---@param bits integer|' 9'|' 10'|' 11'|' 12' One of 9/10/11/12.
---@return nil
function adc.setwidth(adc_number, bits) end

---Configuration ADC1 capture attenuation of channels.
---@param adc_number integer|'adc.ADC1' Only adc.ADC1 now
---@param channel integer
---|' 0' #GPIO36
---|' 1' #GPIO37
---|' 2' #GPIO38
---|' 3' #GPIO39
---|' 4' #GPIO32
---|' 5' #GPIO33
---|' 6' #GPIO34
---|' 7' #GPIO35
---@param atten number
---|' adc.ATTEN_0db' #Vinp will be reduced to about 1/1 (1.1V when VDD_A=3.3V)
---|' adc.ATTEN_2_5db' #Vinp will be reduced to about 1/1.34 (1.5V when VDD_A=3.3V)
---|' adc.ATTEN_6db' #Vinp will be reduced to about 1/2 (2.2V when VDD_A=3.3V)
---|' adc.ATTEN_11db' #Vinp will be reduced to about 1/3.6 (3.9V when VDD_A=3.3V, maximum voltage is limited by VDD_A)
---@return nil
function adc.setup(adc_number, channel, atten) end

---Samples the ADC. You should to call `setwidth()` before `read()`.
---@param adc_number integer|'adc.ADC1' Only adc.ADC1 now
---@param channel integer|' 0'|' 1'|' 2'|' 3'|' 4'|' 5'|' 6'|' 7' 0 to 7 for adc.ADC1
---@return number #the sampled value
function adc.read(adc_number, channel) end

---Read Hall sensor (GPIO36, GPIO39). We recommend using 12-bits width on ADC1.
---@return number #the sampled value
function adc.read_hall_sensor() end

--*** BIT ***
bit = {}

---Arithmetic right shift a number equivalent to `value >> shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer #the number shifted right (arithmetically)
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1 & val2 & ... & valn` in C.
---@param val1 integer first *AND* argument
---@param val2 integer second *AND* argument
---@vararg integer
---@return integer #the bitwise *AND* of all the arguments
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation). Equivalent to `1 << position` in C
---@param position integer position of the bit that will be set to 1
---@return integer #a number with only one 1 bit at position (the rest are set to 0)
function bit.bit(position) end

---Bitwise negation, equivalent to `~value in C.
---@param value integer the number to negate
---@return integer #the bitwise negated value of the number
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1 | val2 | ... | valn` in C.
---@param val1 integer first *OR* argument.
---@param val2 integer second *OR* argument.
---@vararg integer
---@return integer #the bitwise *OR* of all the arguments
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1 ^ val2 ^ ... ^ valn` in C.
---@param val1 integer first *XOR* argument
---@param val2 integer second *XOR* argument
---@vararg integer
---@return integer #the bitwise *XOR* of all the arguments
function bit.xor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer the base number
---@param pos1 integer position of the first bit to clear
---@vararg integer
---@return integer #the number with the bit(s) cleared in the given position(s)
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer the value to test
---@param position integer bit position to test
---@return boolean #`true` if the bit at the given position is 0, `false` othewise
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value integer the value to test
---@param position integer bit position to test
---@return boolean #`true` if the bit at the given position is 0, `false` othewise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value << shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer #the number shifted left
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to `( unsigned )value >> shift` in C.
---@param value integer the value to shift.
---@param shift integer positions to shift.
---@return integer #the number shifted right (logically)
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer the base number.
---@param pos1 integer position of the first bit to set.
---@vararg integer
---@return integer #the number with the bit(s) set in the given position(s)
function bit.set(value, pos1, ...) end

--*** BTHCI ***
bthci = {}

---Sends a raw HCI command to the BlueTooth controller.
---@param hcibytes any raw HCI command bytes to send to the BlueTooth controller.
---@param callback? function optional function to be invoked when the reset completes. Its first argument is the HCI error code, or `nil` on success. The second argument contains any subsequent raw result bytes, or an empty string if the result only contained the status code.
---@return nil
function bthci.rawhci(hcibytes, callback) end

---Resets the BlueTooth controller.
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.reset(callback) end

---Enables or disables BlueTooth LE advertisements. Before enabling advertisements, both parameters and data should be set.
---@param onoff integer|'0'|'1' **1** or **0** to enable or disable advertisements, respectively.
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.adv.enable(onoff, callback) end

---Configures the data to advertise.
---@param advbytes any the raw bytes to advertise (up to 31 bytes), in the correct format
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.adv.setdata(advbytes, callback) end

---Configures advertisement parameters.
---@param paramtable table a table with zero or more of the following fields:
--**interval_min** value in units of 0.625ms. Default 0x0400 (0.64s).
--**interval_max** value in units of 0.625ms. Default 0x0800 (1.28s).
--**type** advertising type, one of following constants:
-- - bthci.adv.CONN_UNDIR, the default (ADV_IND in BT spec)
-- - bthci.adv.CONN_DIR_HI (ADV_DIRECT_IND, high duty cycle in the BT spec)
-- - bthci.adv.SCAN_UNDIR (ADV_SCAN_IND in the BT spec)
-- - bthci.adv.NONCONN_UNDIR (ADV_NONCONN_IND in the BT spec)
-- - bthci.adv.CONN_DIR_LO (ADV_DIRECT_IND, low duty cycle in the BT spec)
--**own_addr_type** own address type. Default 0 (public address).
--**peer_addr_type** peer address type. Default 0 (public address).
--**peer_addr** TODO, not yet implemented
--**channel_map** which channels to advertise on. The constants *bthci.adv.CHAN_37, bthci.adv.CHAN_38, bthci.adv.CHAN_39* or *bthci.adv.CHAN_ALL* may be used. Default is all channels.
--**filter_policy** filter policy, default 0 (no filtering).
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.adv.setparams(paramtable, callback) end

---Enables or disable scanning for advertisements from other BlueTooth devices.
---@param onoff integer|'0'|'1' **1** or **0** to enable or disable advertisements, respectively.
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.scan.enable(onoff, callback) end

---Configures scan parameters.
---@param paramstable table a table with zero or more of the following fields:
--**mode** scanning mode, 0 for passive, 1 for active. Default 0.
--**interval** scanning interval in units of 0.625ms. Default 0x0010.
--**window** length of scanning window in units of 0.625ms. Default 0x0010.
--**own_addr_type** own address type. Default 0 (public).
--**filter_policy** filtering policy. Default 0 (no filtering).
---@param callback? function optional function to be invoked when the reset completes. Its only argument is the HCI error code, or `nil` on success.
---@return nil
function bthci.scan.setparams(paramstable, callback) end

---Registers the callback to be passed any received advertisements.
---@param event string|'"adv_report"' the string describing the event.
---@param callback? function the callback function to receive the advertising reports, or `nil` to deregister the callback. This callback receives the raw bytes of the advertisement payload.
---@return nil
function bthci.scan.on(event, callback) end

--*** CAN ***
can = {}

---Send a frame.
---@param format integer|'can.STANDARD_FRAME'|'can.EXTENDED_FRAME'
---@param msg_id any msg_id CAN Message ID
---@param data any data CAN data, up to 8 bytes
---@return nil
function can.send(format, msg_id, data) end

---Configuration CAN controller.
---@param tbl table config table
--**speed** kbps. One of following value: 1000, 800, 500, 250, 100.
--**tx** Pin num for TX.
--**rx** Pin num for RX.
--**dual_filter** `true` dual filter mode, `false` single filter mode (default)
--**code** 4-bytes integer. Use this with mask to filter CAN frame. Default: 0. See SJA1000
--**mask** 4-bytes integer. Default: 0xffffffff
---@param callback function|' function(format, msg_id, data) end' function to be called when CAN data received.
--**format** Frame format. can.STANDARD_FRAME or can.EXTENDED_FRAME
--**msg_id** CAN Messge ID
--**data** CAN data, up to 8 bytes
---@return nil
function can.setup(tbl, callback) end

---Start CAN controller.
---@return nil
function can.start() end

---Stop CAN controller.
---@return nil
function can.stop() end

--*** CRYPTO ***
crypto = {}

---@class hashobj
local hashobj = {}
---for streaming data through the hash function
function hashobj:update(str) end
---for finalizing and returning the resulting signature
function hashobj:finalize() end

---@alias crypto_algo string
---|'"MD5"'
---|'"SHA1"'
---|'"RIPEMD160"'
---|'"SHA224"'
---|'"SHA256"'
---|'"SHA384"'
---|'"SHA512"'

---Create a digest/hash object that can have any number of strings added to it.
---@param algo crypto_algo the hash algorithm to use, case insensitive string
---@return hashobj #Hasher object with update and finalize functions available.
function crypto.new_hash(algo) end

---Create an object for calculating a HMAC (Hashed Message Authentication Code, aka "signature").
---@param algo crypto_algo the hash algorithm to use, case insensitive string
---@param key any the signing key (may be a binary string)
---@return hashobj #Hasher object with update and finalize functions available.
function crypto.new_hmac(algo, key) end

--*** DAC ***
dac = {}

---Disables DAC output on the related GPIO.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2' DAC channel, one of
---@return nil
function dac.disable(channel) end

---Enables DAC output on the related GPIO.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2' DAC channel, one of
---@return nil
function dac.enable(channel) end

---Sets the output value of the DAC.
---@param channel integer|'dac.CHANNEL_1'|'dac.CHANNEL_2' DAC channel
---@param value number output value
---@return nil
function dac.write(channel, value) end

--*** DHT ***
dht = {}

---Read DHT11 humidity temperature combo sensor.
---@param pin integer IO index
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal (always 0)
---@return number humi_dec humidity decimal (always 0)
function dht.read11(pin) end

---Read DHT21/22/33/43 and AM2301/2302/2303 humidity temperature combo sensors.
---@param pin integer IO index
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal (always 0)
---@return number humi_dec humidity decimal (always 0)
function dht.read2x(pin) end

--*** ENCODER ***
encoder = {}

---Provides a Base64 representation of a (binary) Lua string.
---@param binary string binary input string to Base64 encode
---@return string #A Base64 encoded string.
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string back into the original string. An error is thrown if the string is not a valid base64 encoding.
---@param b64 string Base64 encoded input string
---@return string #The decoded Lua (binary) string.
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string. Each byte in the input string is represented as two hex characters in the output.
---@param binary string binary input string to get hex representation for
---@return string #An ASCII hex string.
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string. Each byte in the output string is represented as two hex characters in the input. An error is thrown if the string is not a valid base64 encoding.
---@param hexstr string hexstr An ASCII hex string.
---@return string #Decoded string of hex representation.
function encoder.fromHex(hexstr) end

--*** ETH ***
eth = {}

---Get MAC address.
---@return string #MAC address as string "aa:bb:cc:dd:ee:dd".
function eth.get_mac() end

---Get Ethernet connection speed.
---@return any #Connection speed in Mbit/s, or error if not connected. - 10 - 100
function eth.get_speed() end

---Initialize the PHY chip and set up its tcpip adapter.
---@param cfg table table containing configuration data. All entries are mandatory:
--**addr** PHY address, 0 to 31
--**clock_mode** external/internal clock mode selection, one of
-- - eth.CLOCK_GPIO0_IN
-- - eth.CLOCK_GPIO0_OUT
-- - eth.CLOCK_GPIO16_OUT
-- - eth.CLOCK_GPIO17_OUT
--**mdc** MDC pin number
--**mdio** MDIO pin number
--**phy** PHY chip model, one of
-- - eth.PHY_IP101
-- - eth.PHY_LAN8720
-- - eth.PHY_TLK110
--**power** power enable pin, optional
---@return nil
function eth.init(cfg) end

---Register or unregister callback functions for Ethernet events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"got_ip"' event
---@param callback function|' function(event, info) end' callback function(event, info) to perform when event occurs, or nil to unregister the callback for the event. The info argument given to the callback is a table containing additional information about the event.
--Event information provided for each event is as follows:
--**start**: no additional info
--**stop**: no additional info
--**connected**: no additional info
--**disconnected**: no additional info
--**got_ip**: IP network information:
--*ip*: the IP address assigned
--*netmask*: the IP netmask
--*gw*: the gateway ("0.0.0.0" if no gateway)
function eth.on(event, callback) end

---Set MAC address.
---@param mac string MAC address as string "aa:bb:cc:dd:ee:ff"
---@return nil
function eth.set_mac(mac) end

--*** FILE ***
file = {}

---@class file
local fObj = {}

---Change current directory (and drive). This will be used when no drive/directory is prepended to filenames.
---@param dir string|'"/FLASH"'|'"/SD0"'|'"/SD1"' directory name
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string|'""' file to check
---@return boolean #`true` of the file exists (even if 0 bytes in size), and `false` if it does not exist
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
---@return table #a lua table which contains the `{file name: file size}` pairs
function file.list(pattern) end

---Registers callback functions.
---@param event string|'"rtc"' Trigger events are: **rtc** deliver current date & time to the file system. Function is expected to return a table containing the fields **year, mon, day, hour, min, sec** of current date and time. Not supported for internal flash.
---@param callback function|' function() end' function. Unregisters the callback if function() is omitted.
---@return nil
function file.on(event, callback) end

---Opens a file for access, potentially creating it (for write modes). When done with the file, it must be closed using `file.close()`.
---@param filename string|'""' #file to be opened, directories are not supported
---@param mode string
---|>' "r"' # read mode
---| ' "w"' # write mode
---| ' "a"' # append mode
---| ' "r+"' # update mode, all previous data is preserved
---| ' "w+"' # update mode, all previous data is erased
---| ' "a+"' # append update mode, previous data is preserved, writing is only allowed at the end of file
---@return file #file object if file opened ok. nil if file not opened, or not exists (read modes).
function file.open(filename, mode) end

---Remove a file from the file system. The file must not be currently open.
---@param filename string|'""' file to remove
---@return nil
function file.remove(filename) end

---Renames a file. If a file is currently open, it will be closed first.
---@param oldname string|'""' old file name
---@param newname string|' ""' new file name
---@return boolean
function file.rename(oldname, newname) end

---Closes the open file, if any.
---@return nil
function file.close() end
---Closes the open file, if any.
---@return nil
function fObj:close() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart. Closing the open file using `file.close() / fd:close()` performs an implicit flush as well.
---@return nil
function file.flush() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart. Closing the open file using `file.close() / fd:close()` performs an implicit flush as well.
---@return nil
function fObj:flush() end

---Read content from the open file.
---@param n_or_char? integer :
---if nothing passed in, then read up to FILE_READ_CHUNK bytes or the entire file (whichever is smaller).
---if passed a number n, then read up to n bytes or the entire file (whichever is smaller).
---if passed a string containing the single character char, then read until char appears next in the file, FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil #File content as a string, or `nil` when EOF
function file.read(n_or_char) end

---Read content from the open file.
---@param n_or_char? integer :
---if nothing passed in, then read up to FILE_READ_CHUNK bytes or the entire file (whichever is smaller).
---if passed a number `n`, then read up to *n* bytes or the entire file (whichever is smaller).
---if passed a string containing the single character `char`, then read until char appears next in the file, FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil #File content as a string, or `nil` when EOF
function fObj:read(n_or_char) end

---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string|nil #File content in string, line by line, including EOL('\n'). Return `nil` when EOF.
function file.readline() end

---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string|nil #File content in string, line by line, including EOL('\n'). Return `nil` when EOF.
function fObj:readline() end

---@alias seekwhence32_f
---| '"set"' #Base is position 0 (beginning of the file)
---|>'"cur"' #Base is current position
---| '"end"' #Base is end of file

---Sets and gets the file position, measured from the beginning of the file, to the position given by offset plus a base specified by the string whence. If no parameters are given, the function simply returns the current file offset.
---@param whence? seekwhence32_f
---@param offset? integer default 0
---@return integer #the resulting file position, or `nil` on error
function file.seek(whence, offset) end

---Sets and gets the file position, measured from the beginning of the file, to the position given by offset plus a base specified by the string whence. If no parameters are given, the function simply returns the current file offset.
---@param whence? seekwhence32_f
---@param offset? integer default 0
---@return integer #the resulting file position, or `nil` on error
function fObj:seek(whence, offset) end

---Write a string to the open file.
---@param str string|'""' content to be write to file
---@return boolean|nil #`true` if write ok, `nil` on error
function file.write(str) end

---Write a string to the open file.
---@param str string|'""' content to be write to file
---@return boolean|nil #`true` if write ok, `nil` on error
function fObj:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string|'""' content to be write to file
---@return boolean|nil #`true` if write ok, `nil` on error
function file.writeline(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string|'""' content to be write to file
---@return boolean|nil #`true` if write ok, `nil` on error
function fObj:writeline(str) end

--*** GPIO ***
gpio = {}

---Configure GPIO mode for one or more pins.
---@param tbl table List of configuration tables:
---**gpio** one or more (given as list) pins,
---**dir** direction, one of
-- - gpio.IN
-- - gpio.OUT
-- - gpio.IN_OUT
---**opendrain** 1 enables opendrain mode, defaults to 0 if omitted
---**pull** enable pull-up and -down resistors, one of
-- - gpio.FLOATING -- disables both pull-up and -down
-- - gpio.PULL_UP -- enables pull-up and disables pull-down
-- - gpio.PULL_DOWN -- enables pull-down and disables pull-up
-- - gpio.PULL_UP_DOWN -- enables both pull-up and -down
---@return nil
function gpio.config(tbl) end

---Read digital GPIO pin value.
---@param pin integer pin to read,
---@return integer #0 = low, 1 = high
function gpio.read(pin) end

---Set the drive strength of a given GPIO pin. The higher the drive strength, the more current can be sourced/sunk from the pin. The exact maximum depends on the power domain of the pin and how much current other pins in that domain are consuming.
---@param pin integer a valid GPIO pin number.
---@param strength number
---|' gpio.DRIVE_0' #weakest drive strength
---|' gpio.DRIVE_1' #stronger drive strength
---|>' gpio.DRIVE_2' #default drive strength
---|>' gpio.DRIVE_DEFAULT' #default drive strength (same as DRIVE_2)
---|' gpio.DRIVE_3' #maximum drive strength
---@return nil
function gpio.set_drive(pin, strength) end

---Establish or clear a callback function to run on interrupt for a GPIO.
---@param pin integer GPIO
---@param type? number
---|' gpio.INTR_DISABLE' #or `nil` to disable interrupts on this pin (in which case `callback` is ignored and should be `nil` or omitted)
---|' gpio.INTR_UP' #for trigger on rising edge
---|' gpio.INTR_DOWN' #for trigger on falling edge
---|' gpio.INTR_UP_DOWN' #for trigger on both edges
---|' gpio.INTR_LOW' #for trigger on low level
---|' gpio.INTR_HIGH' #for trigger on high level
---@param callback? function optional function to be called when trigger fires. If `nil` or omitted (and type is not `gpio.INTR_DISABLE`) then any previously-set callback will continue to be used. Parameters are:
-- - pin
-- - level
---@return nil
function gpio.trig(pin , type , callback) end

---Configuring wake-from-sleep-on-GPIO-level.
---@param pin integer GPIO
---@param level number
---|' gpio.INTR_NONE' #to disable wake-up
---|' gpio.INTR_LOW'  #for wake-up on low level
---|' gpio.INTR_HIGH' #for wake-up on high level
---@return nil
function gpio.wakeup(pin, level) end

---Set digital GPIO pin value.
---@param pin integer pin to write
---@param level integer|' 1'|' 0' **1** or **0**
---@return nil
function gpio.write(pin, level) end

--*** HTTP ***
http = {}

---@class http
local HTTP = {}

---Creates a connection object which can be configured and then executed.
---@param url string|'"http://"'|'"https://"' The URL to fetch, including the http:// or https:// prefix. Required.
---@param method? integer|' http.GET'|' http.POST'|' http.DELETE'|' http.HEAD' The HTTP method to use. Optional and may be omitted, the default is http.GET.
---@param options? table An optional table containing any or all of:
--**async** If true, the request is processed asynchronously, meaning `request()` returns immediately rather than blocking until the connection is complete and all callbacks have been made. Some other connection APIs behave differently in asynchronous mode, see their documentation for details. If not specified, the default is false, meaning requests are processed synchronously.
--**bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--**cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--**headers** Table of headers to add to the request.
--**max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10. Specify 0 to disable following redirects entirely.
--**timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@return http #The connection object.
function http.createConnection(url, method, options) end

---Set a callback to be called when a certain event occurs.
---@param event string
---|'"connect"' #Called when the connection is first established. Callback receives no arguments.
---|'"headers"' #Called once the HTTP headers from the remote end have been received. Callback is called as callback(status_code, headers_table).
---|'"data"' #Can be called multiple times, each time more (non-headers) data is received. Callback is called as callback(status_code, data).
---|'"complete"' #Called once all data has been received. Callback is called as callback status_code, connected) where connected is true if the connection is still open.
---@param callback? function|nil|' function() end' a function to be called when the given event occurs. Can be `nil` to remove a previously configured callback.
---@return nil
function HTTP:on(event, callback) end

---Opens the connection to the server and issues the request.
---@return any|nil #In asynchronous mode, always returns `nil`. In synchronous mode, it returns 2 results, `status_code`, `connected` where connected is `true` if the connection is still open.
function HTTP:request() end

---Sets the connection method.
---@param method? integer|'http.GET'|'http.POST'|'http.DELETE'|'http.HEAD' method one of
---@return nil
function HTTP:setmethod(method) end

---Sets the connection URL.
---@param url string|'""' Required. The URL to use for the next `request()` call.
---@return nil
function HTTP:seturl(url) end

---Sets an individual header in the request.
---@param name string name of the header to set.
---@param value? string|nil what to set it to. Must be a string, or `nil` to unset it.
---@return nil
function HTTP:setheader(name, value) end

---Sets the POST data to be used for this request. Also sets the method to http.POST if it isn't already.
---@param data any|nil The data to POST. Unless a custom Content-Type header has been set, this data should be in application/x-www-form-urlencoded format. Can be `nil` to unset what to post and the Content-Type header.
---@return nil
function HTTP:setpostdata(data) end

---Completes a callback that was previously delayed by returning http.DELAYACK.
---@return nil
function HTTP:ack() end

---Closes the connection if it is still open.
---@return nil
function HTTP:close() end

---Make an HTTP GET request. If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string|'"http://"'|'"https://"' The URL to fetch
---@param options? any|nil Same options as http.createConnection(), except that async is set for you based on whether a callback is specified or not. May be `nil` or omitted.
--**bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--**cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--**headers** Table of headers to add to the request.
--**max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10. Specify 0 to disable following redirects entirely.
--**timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@param callback? function|nil|' function(code, data) end'
---@return any|nil #In synchronous mode, returns 3 results `status_code, body, headers` once the request has completed. In asynchronous mode, returns `nil` immediately.
function http.get(url, options, callback) end

---Executes a single HTTP POST request and closes the connection. If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string|'"http://"'|'"https://"' The URL to fetch
---@param options any|nil Same options as http.createConnection(), except that async is set for you based on whether a callback is specified or not. May be `nil`.
--**bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--**cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--**headers** Table of headers to add to the request.
--**max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10. Specify 0 to disable following redirects entirely.
--**timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@param body any The body to post. Required and must already be encoded in the appropriate format, but may be empty.
---@param callback? function|' function(code, data) end' Should be `nil` or omitted to specify synchronous behaviour, otherwise a callback function to be invoked when the response has been received or an error occurred, which is called with the arguments **status_code**, **body** and **headers**. In case of an error **status_code** will be a negative number.
---@return any|nil #In synchronous mode, returns 3 results **status_code, body, headers** once the request has completed. In asynchronous mode, returns `nil` immediately.
function http.post(url, options, body, callback) end

--*** I2C ***
i2c = {}

---Perform (SW) or enqueue (HWx) an I²C address operation, defining data transfer direction for the next operation (read or write).
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' interface id
---@param device_addr number I²C device address
---@param direction integer
---|' i2c.TRANSMITTER' #for writing mode
---|' i2c.RECEIVER' #for reading mode
---@param ack_check_en? boolean
---|>' true' #enable check for slave ACK
---|' false' #disable check for slave ACK
---@return boolean #>
-- - for interface `i2c.SW`: returns `true` if ack received, `false` if no ack received. This value should be checked to decide whether to continue communication.
-- - for interfaces `i2c.HW0` and `i2c.HW1`: always returns `true`.
function i2c.address(id, device_addr, direction, ack_check_en) end

---Perform (SW) or enqueue (HWx) a data read operation for a variable number of bytes.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' I²C interface id
---@param len number number of data bytes to read
---@return string|nil #>
-- - for software interface `i2c.SW` : returns string of received data
-- - for hardware interfaces `id i2c.HWx` : no value returned
function i2c.read(id, len) end

---Initialize the I²C interface for master mode.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' interface id
---@param pinSDA integer IO index
---@param pinSCL integer IO index
---@param speed integer #bit rate in Hz, positive integer
---|' i2c.SLOW' #for 100000 Hz, max for `i2c.SW`
---|' i2c.FAST' #for 400000 Hz
---|' i2c.FASTPLUS' #for 1000000 Hz
---@param stretchfactor? integer integer multiplier for timeout
---@return integer #>
-- - for interface `i2c.SW`: returns `speed` the selected speed.
-- - for interfaces `i2c.HW0` and `i2c.HW1`: returns `timeout` expressed as CPU clock cycles.
function i2c.setup(id, pinSDA, pinSCL, speed, stretchfactor) end

---Perform (SW) or enqueue (HWx) an I²C start condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' interface id
function i2c.start(id) end

---Perform (SW) or enqueue (HWx) an I²C stop condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' interface id
function i2c.stop(id) end

---Starts a transfer for the specified hardware module.
---@param id integer|'i2c.HW0'|'i2c.HW1' hardware interface id only , `i2c.SW` not allowed
---@param callback? function `function(data, ack)` to be called when transfer finished
---@param to_ms? integer timeout for the transfer in ms, defaults to **0** (infinite)
---@return any|nil #>
-- - for synchronous operation i.e. without any callback function, two values are returned
--**data** - string of received data (`nil` if no read or NACK)
--**ack** - `true` if ACK received, `false` for NACK
-- - for asynchronous operation, i.e. with a callback function, no value is returned
function i2c.transfer(id, callback, to_ms) end

---Perform (SW) or enqueue (HWx) data write to I²C bus.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1' interface id
---@param dataN string|table|number data items can be numbers, strings or lua tables.
---@param ack_check_en? boolean
---|>' true' #enable check for slave ACK
---|' false' #disable check for slave ACK
---@return number #number of bytes written
function i2c.write(id, dataN, ack_check_en) end

---Registers or unregisters an event callback handler.
---@param id integer|'i2c.HW0'|'i2c.HW1' interface id
---@param event integer|' "receive"' data received from master
---@param callback? function|' function(err, data) end' `function(err, data)` to be called when data was received from the master. Unregisters previous callback for event when omitted.
---@return nil
function i2c.slave.on(id, event, callback) end

---Initialize the I²C interface for slave mode.
---@param id integer|'i2c.HW0'|'i2c.HW1' interface id,
---@param slave_config table table containing slave configuration information
--**sda** IO index
--**scl** IO index
--**addr** slave address (7bit or 10bit)
--**10bit** enable 10bit addressing with true, use 7bit with false (optional, defaults to false is omitted)
--**rxbuf_len** length of receive buffer (optional, defaults to 128 if omitted)
--**txbuf_len** length of transmit buffer (optional, defaults to 128 if omitted)
---@return nil
function i2c.slave.setup(id, slave_config) end

---Writes send data for the master into the transmit buffer. This function returns immediately if there's enough room left in the buffer. It blocks if the buffer is doesn't provide enough space.
---@param id integer|'i2c.HW0'|'i2c.HW1' interface id
---@param data1 number|string|table data can be numbers, string or lua table.
---@vararg number|string|table
---@return number #number of bytes written
function i2c.slave.send(id, data1, ...) end

--*** I2S ***
i2s ={}

---Mute the I2S channel. The hardware buffer is instantly filled with silence.
---@param i2s_num integer|'0'|'1' I2S peripheral
---@return nil #An error is thrown in case of invalid parameters or if the i2s driver failed.
function i2s.mute(i2s_num) end

---Read data from I2S receive buffer.
---@param i2s_num integer|'0'|'1' I2S peripheral
---@param size number Bytes to read
---@param wait_ms? number Millisecond to wait if data is not ready. Optional, defaults to 0 (not to wait) when omitted.
---@return any #Data read from data-in pin. If data is not ready in wait_ms millisecond, less than size bytes can be returned. An error is thrown in case of invalid parameters or if the i2s driver failed.
function i2s.read(i2s_num, size, wait_ms) end

---Configuration and start I2S bus.
---@param i2s_num integer|'0'|'1' I2S peripheral
---@param cfg table table containing configuration data:
--**mode** I2S work mode. Optional, defaults to i2s.MODE_MASTER + i2s.MODE_TX when omitted.
-- - i2s.MODE_MASTER
-- - i2s.MODE_SLAVE
-- - i2s.MODE_TX
-- - i2s.MODE_RX
-- - i2s.MODE_DAC_BUILT_IN
-- - i2s.MODE_ADC_BUILT_IN
-- - i2s.MODE_PDM
--**rate** audio sample rate. Optional, defauls to 44100 when omitted.
--**bits** bits per sample. Optional, defaults to 16 when omitted.
--**channel** channel format of I2S stream. Optional, defaults to i2s.CHANNEL_RIGHT_LEFT when omitted.
-- - i2s.CHANNEL_RIGHT_LEFT
-- - i2s.CHANNEL_ALL_LEFT
-- - i2s.CHANNEL_ONLY_LEFT
-- - i2s.CHANNEL_ALL_RIGHT
-- - i2s.CHANNEL_ONLY_RIGHT
--**format** communication format. Optional, defaults to i2s.FORMAT_I2S + i2s.FORMAT_I2S_MSB when omitted.
-- - i2s.FORMAT_I2S
-- - i2s.FORMAT_I2S_MSB
-- - i2s.FORMAT_I2S_LSB
-- - i2s.FORMAT_PCM
-- - i2s.FORMAT_PCM_SHORT
-- - i2s.FORMAT_PCM_LONG
--**buffer_count** number of dma buffers. Optional, defaults to 2 when omitted.
--**buffer_len** size of one dma buffer. Optional, defaults to rate/100 when omitted.
--**bck_pin** clock pin, optional
--**ws_pin** WS pin, optional
--**data_out_pin** data output pin, optional
--**data_in_pin** data input pin, optional
--**dac_mode** DAC mode configuration. Optional, defaults to i2s.
-- - i2s.DAC_CHANNEL_DISABLE (DAC_CHANNEL_DISABLE) when omitted.
-- - i2s.DAC_CHANNEL_RIGHT
-- - i2s.DAC_CHANNEL_LEFT
-- - i2s.DAC_CHANNEL_BOTH
--**adc1_channel** ADC1 channel number 0..7. Optional, defaults to off when omitted.
---@param cb function function called when transmit data is requested or received data is available. The function is called with parameters **i2s_num** and
--**dir**
-- - "tx", for TX data request. Function shall call i2s.write().
-- - "rx", for RX data available. Function shall call i2s.read().
---@return nil
function i2s.start(i2s_num, cfg, cb) end

---Stop I2S bus.
---@param i2s_num integer|'0'|'1' I2S peripheral
---@return nil
function i2s.stop(i2s_num) end

---Write to I2S transmit buffer.
---@param i2s_num integer|'0'|'1' I2S peripheral
---@param data string string containing I2S stream data
---@return nil
function i2s.write(i2s_num, data) end

--*** LEDC ***
ledc = {}

---@class ledc
local channel = {}

---Configures a PIN to be controlled by the LEDC system.
---@param tbl table List of configuration tables:
--**gpio** one or more (given as list) pins, see GPIO Overview
--**bits** Channel duty depth. Defaults to ledc.TIMER_13_BIT. Otherwise one of
-- - ledc.TIMER_10_BIT  ...   ledc.TIMER_15_BIT
--**mode** High-speed mode or low-speed mode
-- - ledc.HIGH_SPEED or ledc.LOW_SPEED
--**timer** The timer source of channel
-- - ledc.TIMER_0  ...  ledc.TIMER_3
--**channel** The timer source of channel
-- - ledc.CHANNEL_0  ...  ledc.CHANNEL_7
--**frequency** Timer frequency(Hz)
--**duty** Channel duty, the duty range is [0, (2**bit_num) - 1]. Example: if `ledc.TIMER_13_BIT` is used maximum value is 4096 x 2 -1 = 8091
---@return ledc #ledc.channel
function ledc.newChannel(tbl) end

---Disable LEDC output, and set idle level.
---@param idleLevel integer|'ledc.IDLE_LOW'|'ledc.IDLE_HIGH' Set output idle level after LEDC stops.
---@return nil
function channel:stop(idleLevel) end

---Set channel frequency (Hz)
---@param frequency number What frequency should be set
---@return nil
function channel:setfreq(frequency) end

---Get channel frequency (Hz)
---@return number #0 error; Others current LEDC frequency
function channel:getfreq() end

---Set channel duty
---@param duty number What duty should be set
---@return nil
function channel:setduty(duty) end

---Get channel duty
---@return number #(-1) parameter error; Others current LEDC duty
function channel:getduty() end

---Resets the timer
---@return nil
function channel:reset() end

---Pauses the timer
---@return nil
function channel:pause() end

---Resumes a paused timer
---@return nil
function channel:resume() end

---Set LEDC fade function, with a limited time.
---@param targetDuty number Target duty of fading.
---@param maxFadeTime number The maximum time of the fading ( ms ).
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE' Whether to block until fading done.
---@return nil
function channel:fadewithtime(targetDuty, maxFadeTime, wait) end

---Set LEDC fade function, with step.
---@param targetDuty number Target duty of fading.
---@param scale number Controls the increase or decrease step scale.
---@param cycleNum integer Increase or decrease the duty every cycle_num cycles
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE' Whether to block until fading done.
---@return nil
function channel:fadewithstep(targetDuty, scale, cycleNum, wait) end

---Set LEDC fade function.
---@param duty number Set the start of the gradient duty.
---@param direction integer|'ledc.FADE_DECREASE'|'ledc.FADE_INCREASE' Set the direction of the gradient.
---@param scale number Set gradient change amplitude.
---@param cycleNum number Set how many LEDC tick each time the gradient lasts.
---@param stepNum number Set the number of the gradient.
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE' Whether to block until fading done.
---@return nil
function channel:fade(duty, direction, scale, cycleNum, stepNum, wait) end

--*** MQTT ***
mqtt = {}

---@class mqtt
local MQTT32 = {}

---Creates a MQTT client.
---@param clientid string client ID
---@param keepalive integer keepalive seconds
---@param username? string user name
---@param password? string user password
---@param cleansession? integer **0/1** for `false/true`. Default is 1 (`true`).
---@return mqtt #MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession) end

---Closes connection to the broker.
---@return boolean
function MQTT32:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string host, domain or IP (string)
---@param port? integer broker port (number), default 1883
---@param secure? boolean|table either an interger with **0/1** for `false/true` (default 0), or a table with optional entries
--**ca_cert CA** - certificate data in PEM format for server verify with SSL
--**client_cert** - client certificate data in PEM format for SSL mutual authentication
--**client_key** - client private key data in PEM format for SSL mutual authentication. Note that both client_cert and client_key have to be provided for mutual authentication.
---@param conn_est? function|' function(client) end' `function(client: any)` callback function for when the connection was established
---@param conn_notest? function|' function(client, reason) end' `function(client: any, reason: number` callback function for when the connection could not be established. No further callbacks should be called.
---@return boolean
function MQTT32:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament. A broker will publish a message with qos = 0, retain = 0, data = "offline" to topic "/lwt" if client does not send keepalive packet.
---@param topic string the topic to publish to (string)
---@param message string the message to publish, (buffer or string)
---@param qos? integer|' 0'|' 1'|' 2' QoS level, default **0**
---@param retain? integer|' 0'|' 1' retain flag, default **0**
---@return nil
function MQTT32:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"message"'|'"offline"' can be "connect", "message" or "offline"
---@param callback function|' function(client, topic, message) end' `function(client, topic?:string, message?:string)`. The first parameter is the client. If event is "message", the 2nd and 3rd param are received topic and message (strings).
---@return nil
function MQTT32:on(event, callback) end

---Publishes a message.
---@param topic string topic the topic to publish to (topic string)
---@param payload string message the message to publish, (buffer or string)
---@param qos integer|' 0'|' 1'|' 2' QoS level
---@param retain integer|' 0'|' 1' retain flag
---@param callback? function|' function(client) end' `function(client)` fired when PUBACK received. (optional) NOTE: When calling `publish()` more than once, the last callback function defined will be called for ALL publish commands.
---@return boolean
function MQTT32:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string a topic string
---@param qos integer|' 0'|' 1'|' 2' QoS subscription level, default 0
---@param callback? function|' function(client) end' `function(client)` fired when subscription(s) succeeded. (optional) NOTE: When calling `subscribe()` more than once, the last callback function defined will be called for ALL subscribe commands.
---@return boolean
function MQTT32:subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string a topic string
---@param callback? function|' function(client) end' `function(client)` fired when unsubscription(s) succeeded. (optional) NOTE: When calling unsubscribe() more than once, the last callback function defined will be called for ALL unsubscribe commands.
---@return boolean
function MQTT32:unsubscribe(topic, callback) end

--*** NET ***
net = {}

---@class netsocket
local NETSOCKET = {}
---@class netsrv
local NETSRV= {}
---@class udpsocket
local UDPSOCKET = {}

---Creates a client.
---@param type? integer|'net.TCP' `net.TCP` (default) or `net.UDP` There's no such thing as a UDP connection because UDP is connection*less*. Thus no connection `type` parameter should be required.
---@param secure? integer 0 for plain (default). Secure connections are not supported, and the `secure` parameter is ignored. For UDP use `net.createUDPSocket()` instead.
---@return netsocket #>
-- - for `net.TCP` - net.socket sub module
-- - for `net.UDP` - net.udpsocket sub module
function net.createConnection(type, secure) end

---Creates a server.
---@param type? integer|'net.TCP' The `type` parameter will be removed in upcoming releases so that `net.createServer` will always create a TCP-based server. For UDP use `net.createUDPSocket()` instead.
---@param timeout? integer for a TCP server timeout is 1~28'800 seconds, 30 sec by default (for an inactive client to be disconnected)
---@return netsrv #>
-- - for `net.TCP` - net.server sub module
-- - for `net.UDP` - net.udpsocket sub module
function net.createServer(type, timeout) end

---Creates an UDP socket.
---@return udpsocket #net.udpsocket submodule
function net.createUDPSocket() end

---Join multicast group.
---@param if_ip string string containing the interface ip to join the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string of the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string string containing the interface ip to leave the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server.
---@return nil
function NETSRV.close() end

---Listen on port from IP address.
---@param port? integer number, can be omitted (random port will be chosen)
---@param ip? string IP address string, can be omitted
---@param callback function|' function(net.socket) end' `function(net.socket)`, pass to caller function as param if a connection is created successfully
---@return nil
function NETSRV.listen(port, ip, callback) end

---Returns server local address/port.
---@return integer|nil #port or `nil` if not listening
---@return string|nil #ip or `nil` if not listening
function NETSRV.getaddr() end

---Closes socket.
---@return nil
function NETSOCKET:close() end

---Connect to a remote server.
---@param port integer port number
---@param ip_or_domain string IP address or domain name string
---@return nil
function NETSOCKET:connect(port, ip_or_domain) end

---Provides DNS resolution for a hostname.
---@param domain string domain name
---@param callback function|' function(net.socket, ip) end' `function(net.socket, ip)`. The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function NETSOCKET:dns(domain, callback) end

---Retrieve port and ip of remote peer.
---@return integer|nil #port or `nil` if not connected
---@return string|nil #ip or `nil` if not connected
function NETSOCKET:getpeer() end

---Retrieve local port and ip of socket.
---@return integer|nil #port or `nil` if not connected
---@return string|nil #ip or `nil` if not connected
function NETSOCKET:getaddr() end

---Throttle data reception by placing a request to block the TCP receive function. This request is not effective immediately, Espressif recommends to call it while reserving 5*1460 bytes of memory.
---@return nil
function NETSOCKET:hold() end

---Register callback functions for specific events.
---@param event string|'"connection"'|'"reconnection"'|'"disconnection"'|'"receive"'|'"sent"' event
---@param callback nil|function|' function(net.socket, string) end)' `function(net.socket, string?)`. Can be `nil` to remove callback.
--The first parameter of callback is the socket.
--The seconf parameter:
-- - If event is `"receive"`, the second parameter is the received data as string.
-- - If event is `"disconnection"` or `"reconnection"`, the second parameter is error code.
--If `"reconnection"` event is specified, disconnection receives only "normal close" events.
--Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function NETSOCKET:on(event, callback) end

---Sends data to remote peer.
---@param str string data in string which will be sent to server
---@param callback? function|' function(sent) end' `function(sent)` for sending string
---@return nil
function NETSOCKET:send(str, callback) end

---Unblock TCP receiving data by revocation of a preceding `hold()`.
---@return nil
function NETSOCKET:unhold() end

---Closes UDP socket.
---@return nil
function UDPSOCKET:close() end

---Listen on port from IP address.
---@param port? integer port number, can be omitted (random port will be chosen)
---@param ip? string IP address string, can be omitted
---@return nil
function UDPSOCKET:listen(port, ip) end

---Register callback functions for specific events.
---@param event string|'"receive"'|'"sent"'|'"dns"' event
---@param callback nil|function|' function(net.socket, string) end)' `function(net.socket, string?)`. Can be nil to remove callback.
--The first parameter of callback is the socket.
--The seconf parameter:
-- - If event is `"receive"`, the second parameter is the received data as string. The `receive` callback receives port and ip *after* the data argument.
--Otherwise, all connection errors (with normal close) passed to disconnection event.
---@return nil
function UDPSOCKET:on(event, callback) end

---Sends data to specific remote peer.
---@param port integer remote socket port
---@param ip string remote socket IP
---@param data any the payload to send
---@return nil
function UDPSOCKET:send(port, ip, data) end

---Provides DNS resolution for a hostname.
---@param domain string domain name
---@param callback function|' function(net.socket, ip) end' `function(net.socket, ip)`. The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function UDPSOCKET:dns(domain, callback) end

---Retrieve local port and ip of socket.
---@return integer|nil #port or `nil` if not connected
---@return string|nil #ip or `nil` if not connected
function UDPSOCKET:getaddr() end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer|'0'|'1' which DNS server to get (range 0~1)
---@return string #IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. Doesn't require a socket like `net.socket.dns()`.
---@param host string hostname to resolve
---@param callback function|' function(sk, ip) end' `function(sk, ip)` called when the name was resolved. **sk** is always `nil`
---@return nil
function net.dns.resolve(host, callback) end

---Sets the IP of the DNS server used to resolve hostnames.
---@param dns_ip_addr string IP address of a DNS server. Default: resolver1.opendns.com (208.67.222.222).
---@param dns_index integer|' 0'|' 1' which DNS server to set (range 0~1). Hence, it supports max. 2 servers.
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end

--*** NODE ***
node = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode The first value returned is the raw code, not the new "reset info" code which was introduced in recent SDKs. Values are:
--1, power-on
--2, reset (software?)
--3, hardware reset via reset pin
--4, WDT reset (watchdog timeout)
---@return integer reason The second value returned is the extended reset cause. Values are:
--0, power-on
--1, hardware watchdog reset
--2, exception reset
--3, software watchdog reset
--4, software restart
--5, wake from deep sleep
--6, external reset
--In case of extended reset cause 3 (exception reset), additional values are returned containing the crash information. These are, in order, EXCCAUSE, EPC1, EPC2, EPC3, EXCVADDR, and DEPC.
function node.bootreason() end

---Returns the ESP chip ID.
---@return string #chip ID
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as .lc file.
---@param filename string|'".lua"' filename name of Lua text file
---@return nil
function node.compile(filename) end

---Enters deep sleep mode.
---@overload fun(options:number)
-- For compatibility, a `number` parameter usecs can be supplied instead of an options table, which is equivalent to `node.dsleep({us = usecs})`.
---@param options table a table containing some of:
--**secs**, a number of seconds to sleep. This permits longer sleep periods compared to using the us parameter.
--**us**, a number of microseconds to sleep. If both secs and us are provided, the values are combined.
--**gpio**, a single GPIO number or a list of GPIOs. These pins must all be RTC-capable otherwise an error is raised.
--**level**. Whether to trigger when *any* of the GPIOs are high (level=1, which is the default if not specified), or when *all* the GPIOs are low (level=0).
--**isolate**. A list of GPIOs to isolate. Isolating a GPIO disables input, output, pullup, pulldown, and enables hold feature for an RTC IO. Use this function if an RTC IO needs to be disconnected from internal circuits in deep sleep, to minimize leakage current.
--**pull**, boolean, whether to keep powering previously-configured internal pullup/pulldown resistors. Default is false if not specified.
--**touch**, boolean, whether to trigger wakeup from any previously-configured touchpads. Default is false if not specified.
function node.dsleep(options) end

---Returns the flash chip ID.
---@return number flashID #flash ID
function node.flashid() end

---Returns the current available heap size in bytes.
---@return number heap #system heap size left in bytes
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
---@param str string Lua chunk
---@return nil
function node.input(str) end

---Redirects the Lua interpreter output to a callback function. Optionally also prints it to the serial console.
---@param callback function `output_fn(str)` a function accept every output as str, and can send the output to a socket (or maybe a file). `nil` to unregister the previous function.
---@param serial_output integer
---|>' 1' #output also sent out the serial port.
---|' 0' #no serial output.
---@return nil
function node.output(callback, serial_output) end

---Redirects the debugging output from the Espressif SDK to a callback function allowing it to be captured or processed in Lua.
---@param callback function `function(str)` a function accepts debugging output as str, and can send the output to a socket (or maybe a file). `nil` to unregister the previous function.
function node.osoutput(callback) end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults using the SDK function *system_restore()*, which doesn't document precisely what it erases/restores.
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ' constant
---@return number #target CPU frequency
function node.setcpufreq(speed) end

---Enters light sleep mode, which saves power without losing state. The state of the CPU and peripherals is preserved during light sleep and is resumed once the processor wakes up. When the processor wakes back up depends on the supplied options.
---@param options table a table containing some of:
--**secs**, a number of seconds to sleep. This permits longer sleep periods compared to using the **us** parameter.
--**us**, a number of microseconds to sleep. If both **secs** and **us** are provided, the values are combined.
--**gpio**, a boolean, whether to allow wakeup by GPIOs. Default is `false` if not specified.
--**touch**, boolean, whether to trigger wakeup from any previously-configured touchpads. Default is `false` if not specified.
--**uart**, an integer or list of integers. Which UARTs should trigger wakeup. Default is the empty list if not specified.
--**ulp**, a boolean, whether to allow the ULP to trigger wakeup. Default is `false` if not specified.
---@return integer #One of the following values, depending on what triggered the wakeup.
-- - node.wakeup.GPIO
-- - node.wakeup.TIMER
-- - node.wakeup.TOUCHPAD
-- - node.wakeup.UART
-- - node.wakeup.ULP
function node.sleep(options) end

---Controls the amount of debug information kept during node.compile(), and allows removal of debug information from already compiled Lua code.
---@param level? number
---|'1' #don't discard debug info
---|'2' #discard Local and Upvalue debug info
---|'3' #discard Local, Upvalue and line-number debug info
---@param callback? function `function` a compiled function to be stripped per setfenv except 0 is not permitted.
---@return integer|nil #If invoked without arguments, returns the current level settings. Otherwise, `nil` is returned.
function node.stripdebug(level, callback) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean
---|'true' #to enable printing
---|>'false' #to disable printing
function node.osprint(enabled) end

---Returns the value of the system counter, which counts in microseconds starting at 0 when the device is booted.
---@return number lowbits the time in microseconds since boot or the last time the counter wrapped
---@return number highbits the number of times the counter has wrapped
function node.uptime() end

---Sets the Emergency Garbage Collector mode.
---@param mode integer
---|'node.egc.NOT_ACTIVE' #EGC inactive, no collection cycle will be forced in low memory situations
---|'node.egc.ON_ALLOC_FAILURE' #Try to allocate a new block of memory, and run the garbage collector if the allocation fails.
---|'node.egc.ON_MEM_LIMIT' #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit.
---|'node.egc.ALWAYS' #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error.
---@param level number in the case of `node.egc.ON_MEM_LIMIT`, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Enable a Lua callback or task to post another task request.
---@param task_priority? number
---|'node.task.LOW_PRIORITY' #= 0
---|>'node.task.MEDIUM_PRIORITY' #= 1
---|'node.task.HIGH_PRIORITY''0' #= 2
---@param callback function|' function() end' function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, callback) end
