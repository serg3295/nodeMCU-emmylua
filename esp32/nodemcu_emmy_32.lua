--*** ADC ***
adc = {}

---The configuration is in effect for all channels of ADC1.
---@param adc_number integer|'adc.ADC1'
---@param bits integer|' 9'|' 10'|' 11'|' 12'
---@return nil
function adc.setwidth(adc_number, bits) end

---Configuration ADC1 capture attenuation of channels.
---@param adc_number integer|'adc.ADC1'
---@param channel integer
---|' 0' # GPIO36
---|' 1' # GPIO37
---|' 2' # GPIO38
---|' 3' # GPIO39
---|' 4' # GPIO32
---|' 5' # GPIO33
---|' 6' # GPIO34
---|' 7' # GPIO35
---@param atten number
---|' adc.ATTEN_0db' #Vinp will be reduced to about 1/1
---|' adc.ATTEN_2_5db' #Vinp will be reduced to about 1/1.34
---|' adc.ATTEN_6db' #Vinp will be reduced to about 1/2
---|' adc.ATTEN_11db' #Vinp will be reduced to about 1/3.6
---@return nil
function adc.setup(adc_number, channel, atten) end

---Samples the ADC. You should to call setwidth() before read().
---@param adc_number integer|'adc.ADC1'
---@param channel integer|' 0'|' 1'|' 2'|' 3'|' 4'|' 5'|' 6'|' 7'
---@return number num the sampled value
function adc.read(adc_number, channel) end

---Read Hall sensor (GPIO36, GPIO39). We recommend using 12-bits width on ADC1.
---@return number num the sampled value
function adc.read_hall_sensor() end

--*** BIT ***
bit = {}

---Arithmetic right shift a number equivalent to `value` >> `shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer num the number shifted right (arithmetically)
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1` & `val2` & ... & `valn` in C.
---@param val1 integer first AND argument
---@param val2 integer second AND argument
---@return integer num the bitwise AND of all the arguments (number)
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation).
---Equivalent to 1 << position in C
---@param position integer position of the bit that will be set to 1
---@return integer num a number with only one 1 bit at position (the rest are set to 0)
function bit.bit(position) end

---Bitwise negation, equivalent to `~value in C.
---@param value integer the number to negate
---@return integer num the bitwise negated value of the number
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1` | `val2` | ... | `valn` in C.
---@param val1 integer first OR argument.
---@param val2 integer second OR argument.
---@return integer
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1` ^ `val2` ^ ... ^ `valn` in C.
---@param val1 integer first XOR argument
---@param val2 integer second XOR argument
---@return integer num the bitwise XOR of all the arguments (number)
function bit.xor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer the base number
---@param pos1 integer  position of the first bit to clear
---@return integer num he number with the bit(s) cleared in the given position(s)
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer  the value to test
---@param position integer bit position to test
---@return boolean b true if the bit at the given position is 0, false othewise
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value integer the value to test
---@param position integer bit position to test
---@return boolean b true if the bit at the given position is 0, false othewise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value` << `shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer num the number shifted left
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to ( unsigned )`value` >> `shift` in C.
---@param value integer the value to shift.
---@param shift integer positions to shift.
---@return integer num the number shifted right (logically)
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer the base number.
---@param pos1 integer position of the first bit to set.
---@return integer num the number with the bit(s) set in the given position(s)
function bit.set(value, pos1, ...) end

--*** BTHCI ***
bthci = {}

---Sends a raw HCI command to the BlueTooth controller.
---@param hcibytes any raw HCI command bytes to send to the BlueTooth controller.
---@param callback? function optional function to be invoked when the reset completes.
---@return nil
function bthci.rawhci(hcibytes, callback) end

---Resets the BlueTooth controller.
---@param callback? function optional function to be invoked when the reset completes.
---@return nil
function bthci.reset(callback) end

---Enables or disables BlueTooth LE advertisements.
---@param onoff integer|'0'|'1' 1 or 0 to enable or disable advertisements, respectively.
---@param callback? function  optional function to be invoked when the reset completes.
---@return nil
function bthci.adv.enable(onoff, callback) end

---Configures the data to advertise.
---@param advbytes any the raw bytes to advertise (up to 31 bytes), in the correct format
---@param callback? function optional function to be invoked when the reset completes.
---@return nil
function bthci.adv.setdata(advbytes, callback) end

---Configures advertisement parameters.
---@param paramtable table
---@param callback? function
---@return nil
function bthci.adv.setparams(paramtable, callback) end

---Enables or disable scanning for advertisements from other BlueTooth devices.
---@param onoff integer|'0'|'1' 1 or 0 to enable or disable advertisements, respectively.
---@param callback? function
---@return nil
function bthci.scan.enable(onoff, callback) end

---Configures scan parameters.
---@param paramstable table
---@param callback? function
---@return nil
function bthci.scan.setparams(paramstable, callback) end

---Registers the callback to be passed any received advertisements.
---@param event string|'"adv_report"'
---@param callback? function
---@return nil
function bthci.scan.on(event, callback) end

--*** CAN ***
can = {}

---Send a frame.
---@param format integer|'can.STANDARD_FRAME'|'can.EXTENDED_FRAME'
---@param msg_id any msg_id CAN Messge ID
---@param data any data CAN data, up to 8 bytes
---@return nil
function can.send(format, msg_id, data) end

---Configuration CAN controller.
---@param tbl table
---config table
---`speed` kbps. One of following value: 1000, 800, 500, 250, 100.
---`tx` Pin num for TX.
---`rx` Pin num for RX.
---`dual_filter` true dual filter mode, false single filter mode (default)
---`code` 4-bytes integer. Use this with mask to filter CAN frame. Default: 0. See SJA1000
---`mask` 4-bytes integer. Default: 0xffffffff
---@param fun function|' function(format, msg_id, data) end'
---callback function to be called when CAN data received.
---*format* Frame format. can.STANDARD_FRAME or can.EXTENDED_FRAME
---*msg_id* CAN Messge ID
---*data* CAN data, up to 8 bytes
---@return nil
function can.setup(tbl, fun) end

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
---@return hashobj obj Hasher object with update and finalize functions available.
function crypto.new_hash(algo) end

---Create an object for calculating a HMAC (Hashed Message Authentication Code, aka "signature").
---@param algo crypto_algo the hash algorithm to use, case insensitive string
---@param key any the signing key (may be a binary string)
---@return hashobj obj Hasher object with update and finalize functions available.
function crypto.new_hmac(algo, key) end

--*** DAC ***
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
---@param value number value output value
---@return nil
function dac.write(channel, value) end

--*** DHT ***
dht = {}

---Read DHT11 humidity temperature combo sensor.
---@param pin integer
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal (always 0)
---@return number humi_dec humidity decimal (always 0)
function dht.read11(pin) end

---Read DHT21/22/33/43 and AM2301/2302/2303 humidity temperature combo sensors.
---@param pin integer
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
---@return string s A Base64 encoded string.
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string back into the original string.
---@param b64 string Base64 encoded input string
---@return string str The decoded Lua (binary) string.
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string.
---@param binary string binary input string to get hex representation for
---@return string s An ASCII hex string.
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string.
---@param hexstr string hexstr An ASCII hex string.
---@return string s Decoded string of hex representation.
function encoder.fromHex(hexstr) end

--*** ETH ***
eth = {}

---Get MAC address.
---@return string mac MAC address as string "aa:bb:cc:dd:ee:dd".
function eth.get_mac() end

---Get Ethernet connection speed.
---@return any sp Connection speed in Mbit/s, or error if not connected. - 10 - 100
function eth.get_speed() end

---Initialize the PHY chip and set up its tcpip adapter.
---@param cfg table
---*cfg* table containing configuration data. All entries are mandatory:
---`addr` PHY address, 0 to 31
---`clock_mode` external/internal clock mode selection, one of
---    eth.CLOCK_GPIO0_IN
---    eth.CLOCK_GPIO0_OUT
---    eth.CLOCK_GPIO16_OUT
---    eth.CLOCK_GPIO17_OUT
---`mdc` MDC pin number
---`mdio` MDIO pin number
---`phy` PHY chip model, one of
---    eth.PHY_IP101
---    eth.PHY_LAN8720
---    eth.PHY_TLK110
---`power` power enable pin, optional
---@return nil
function eth.init(cfg) end

---Register or unregister callback functions for Ethernet events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"got_ip"'
---@param callback function | ' function(event, info) end'
function eth.on(event, callback) end

---Set MAC address.
---@param mac string mac MAC address as string "aa:bb:cc:dd:ee:ff"
---@return nil
function eth.set_mac(mac) end

--*** FILE ***
file = {}

---@class file
local fObj = file.open()

---Change current directory (and drive).
---@param dir string|'"/FLASH"'|'"/SD0"'|'"/SD1"'
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string|'""'
---@return boolean
function file.exists(filename) end

---Format the file system. Completely erases any existing file system and writes a new one.
---@return nil
function file.format() end

---Returns the flash address and physical size of the file system area, in bytes.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system.
---The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Lists all files in the file system.
---@return table
function file.list(pattern) end

---Registers callback functions.
---@param event string|'"rtc"'
---@param foo function?|' function() end'
---@return nil
function file.on(event, foo) end

---Opens a file for access, potentially creating it (for write modes).
---@param filename string | '""'
---@param mode string
---|>' "r"' # read mode
---| ' "w"' # write mode
---| ' "a"' # append mode
---| ' "r+"' # update mode, all previous data is preserved
---| ' "w+"' # update mode, all previous data is erased
---| ' "a+"' # append update mode, previous data is preserved, writing is only allowed at the end of file
---@return file
function file.open(filename, mode) end

---Remove a file from the file system. The file must not be currently open.
---@param filename string|'""'
---@return nil
function file.remove(filename) end

---Renames a file. If a file is currently open, it will be closed first.
---@param oldname string|'""'
---@param newname string|' ""'
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

---Read the next line from the open file.
---Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string | nil
function file.readline() end
---Read the next line from the open file.
---Lines are defined as zero or more bytes ending with a EOL ('\n') byte.
---@return string | nil
function fObj:readline() end

---@alias seekwhence32_f
---| '"set"' # Base is position 0 (beginning of the file)
---|>'"cur"' # Base is current position
---| '"end"' # Base is end of file
---Sets and gets the file position, measured from the beginning of the file,
---to the position given by offset plus a base specified by the string whence.
---@param whence? seekwhence32_f
---@param offset? integer
---@return integer offset | nil
function file.seek(whence, offset) end
---Sets and gets the file position, measured from the beginning of the file,
---to the position given by offset plus a base specified by the string whence.
---@param whence? seekwhence32_f
---@param offset? integer
---@return integer offset | nil
function fObj:seek(whence, offset) end

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

--*** GPIO ***
gpio = {}

---Configure GPIO mode for one or more pins.
---@param tbl table
---`gpio` one or more (given as list) pins,
---`dir` direction, one of
---    gpio.IN
---    gpio.OUT
---    gpio.IN_OUT
---`opendrain` 1 enables opendrain mode, defaults to 0 if omitted
---`pull` enable pull-up and -down resistors, one of
---    gpio.FLOATING --disables both pull-up and -down
---    gpio.PULL_UP --enables pull-up and disables pull-down
---    gpio.PULL_DOWN --enables pull-down and disables pull-up
---    gpio.PULL_UP_DOWN --enables both pull-up and -down
---@return nil
function gpio.config(tbl) end

---Read digital GPIO pin value.
---@param pin integer pin to read,
---@return integer val 0 = low, 1 = high
function gpio.read(pin) end

---Set the drive strength of a given GPIO pin.
---@param pin integer a valid GPIO pin number.
---@param strength number
---|' gpio.DRIVE_0' #weakest drive strength
---|' gpio.DRIVE_1' #stronger drive strength
---|' gpio.DRIVE_2' #default drive strength
---|' gpio.DRIVE_DEFAULT' #default drive strength (same as DRIVE_2)
---|' gpio.DRIVE_3' #maximum drive strength
---@return nil
function gpio.set_drive(pin, strength) end

---Establish or clear a callback function to run on interrupt for a GPIO.
---@param pin integer
---@param type number
---|' "gpio.INTR_DISABLE"' #or nil to disable interrupts on this pin (in which case callback is ignored and should be nil or omitted)
---|' gpio.INTR_UP' #for trigger on rising edge
---|' gpio.INTR_DOWN' #for trigger on falling edge
---|' gpio.INTR_UP_DOWN' #for trigger on both edges
---|' gpio.INTR_LOW' #for trigger on low level
---|' gpio.INTR_HIGH' #for trigger on high level
---@param callback function
---@return nil
function gpio.trig(pin , type , callback) end

---Configuring wake-from-sleep-on-GPIO-level.
---@param pin integer
---@param level number
---|' gpio.INTR_NONE'  #to disable wake-up
---|' gpio.INTR_LOW'   #for wake-up on low level
---|' gpio.INTR_HIGH'  #for wake-up on high level
---@return nil
function gpio.wakeup(pin, level) end

---Set digital GPIO pin value.
---@param pin integer pin to write
---@param level integer|' 1'|' 0'
---@return nil
function gpio.write(pin, level) end

--*** HTTP ***
http = {}

---@class http
local HTTP = http.createConnection()

---Creates a connection object which can be configured and then executed.
---@param url string|'"http://"'|'"https://"'
---@param method? integer|' http.GET'|' http.POST'|' http.DELETE'|' http.HEAD'
---@param options? table
---@return http
function http.createConnection(url, method, options) end

---Set a callback to be called when a certain event occurs.
---@param event string
---|'"connect"' #Called when the connection is first established. Callback receives no arguments.
---|'"headers"' #Called once the HTTP headers from the remote end have been received. Callback is called as callback(status_code, headers_table).
---|'"data"' #Can be called multiple times, each time more (non-headers) data is received. Callback is called as callback(status_code, data).
---|'"complete"' #Called once all data has been received. Callback is called as callback status_code, connected) where connected is true if the connection is still open.
---@param callback? function|nil|' function() end'
---@return nil
function HTTP:on(event, callback) end

---Opens the connection to the server and issues the request.
---@return nil |any
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
---@param data any |nil
---@return nil
function HTTP:setpostdata(data) end

---Completes a callback that was previously delayed by returning http.DELAYACK.
---@return nil
function HTTP:ack() end

---Closes the connection if it is still open.
---@return nil
function HTTP:close() end

---Make an HTTP GET request. If a callback is specifed then the function operates
---in asynchronous mode, otherwise it is synchronous.
---@param url string|'"http://"'|'"https://"'
---@param options? any |nil
---@param callback? function|nil|' function() end'
---@return nil|any
function http.get(url, options, callback) end

---Executes a single HTTP POST request and closes the connection.
---If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string|'"http://"'|'"https://"'
---@param options any|nil
---@param body any
---@param callback? function|' function() end'
---@return nil|any
function http.post(url, options, body, callback) end

--*** I2C ***
i2c = {}

---Send (SW) or queue (HWx) I²C address and read/write mode for the next transfer.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@param device_addr number
---@param direction integer|' i2c.TRANSMITTER'|' i2c.RECEIVER'
---@param ack_check_en? boolean
---|' true'  #enable check for slave ACK
---|' false' #disable check for slave ACK
---@return boolean
function i2c.address(id, device_addr, direction, ack_check_en) end

---Read (SW) or queue (HWx) data for variable number of bytes.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@param len number
---@return string|nil
function i2c.read(id, len) end

---Initialize the I²C interface for master mode.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@param pinSDA integer
---@param pinSCL integer
---@param speed integer|' i2c.SLOW'|' i2c.FAST'|' i2c.FASTPLUS'
---@return integer
function i2c.setup(id, pinSDA, pinSCL, speed) end

---Send (SW) or queue (HWx) an I²C start condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@return nil
function i2c.start(id) end

---Send (SW) or queue (HWx) an I²C stop condition.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@return nil
function i2c.stop(id) end

---Starts a transfer for the specified hardware module.
---@param id integer|'i2c.HW0'|'i2c.HW1'
---@param cb_fn? function
---@param to_ms? integer
---@return any|nil
function i2c.transfer(id, cb_fn, to_ms) end

---Write (SW) or queue (HWx) data to I²C bus.
---Data items can be multiple numbers, strings or lua tables.
---@param id integer|'i2c.SW'|'i2c.HW0'|'i2c.HW1'
---@param dataN string|table|number
---@param ack_check_en boolean
---@return number
function i2c.write(id, dataN, ack_check_en) end

---Registers or unregisters an event callback handler.
---@param id integer|'i2c.HW0'|'i2c.HW1'
---@param event integer|' receive'
---@param cb_fn? function
---@return nil
function i2c.slave.on(id, event, cb_fn) end

---Initialize the I²C interface for slave mode.
---@param id integer|'i2c.HW0'|'i2c.HW1'
---@param slave_config table
---@return nil
function i2c.slave.setup(id, slave_config) end

---Writes send data for the master into the transmit buffer.
---@param id integer|'i2c.HW0'|'i2c.HW1'
---@param data1 any
---@return number
function i2c.slave.send(id, data1, ...) end

--*** I2S ***
i2s ={}

---Mute the I2S channel. The hardware buffer is instantly filled with silence.
---@param i2s_num integer|'0'|'1'
---@return nil
function i2s.mute(i2s_num) end

---Read data from I2S receive buffer.
---@param i2s_num integer|'0'|'1'
---@param size number
---@param wait_ms number
---@return any
function i2s.read(i2s_num, size, wait_ms) end

---Configuration and start I2S bus.
---@param i2s_num integer|'0'|'1'
---@param cfg table
---@param cb function
---@return nil
function i2s.start(i2s_num, cfg, cb) end

---Stop I2S bus.
---@param i2s_num integer|'0'|'1'
---@return nil
function i2s.stop(i2s_num) end

---Write to I2S transmit buffer.
---@param i2s_num integer|'0'|'1'
---@param data string
---@return nil
function i2s.write(i2s_num, data) end

--*** LEDC ***
ledc = {}

---@class ledc
local channel = ledc.newChannel()

---Configures a PIN to be controlled by the LEDC system.
---@param tbl table
---@return ledc obj ledc.channel
function ledc.newChannel(tbl) end

---Disable LEDC output, and set idle level.
---@param idleLevel integer|'ledc.IDLE_LOW'|'ledc.IDLE_HIGH'
---@return nil
function channel:stop(idleLevel) end

---Set channel frequency (Hz)
---@param frequency number
---@return nil
function channel:setfreq(frequency) end

---Get channel frequency (Hz)
---@return number
function channel:getfreq() end

---Set channel duty
---@param duty number
---@return nil
function channel:setduty(duty) end

---Get channel duty
---@return number
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
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE'
---@return nil
function channel:fadewithtime(targetDuty, maxFadeTime, wait) end

---Set LEDC fade function, with step.
---@param targetDuty number Target duty of fading.
---@param scale number Controls the increase or decrease step scale.
---@param cycleNum integer Increase or decrease the duty every cycle_num cycles
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE'
---@return nil
function channel:fadewithstep(targetDuty, scale, cycleNum, wait) end

---Set LEDC fade function.
---@param duty number Set the start of the gradient duty.
---@param direction integer|'ledc.FADE_DECREASE'|'ledc.FADE_INCREASE'
---@param scale number Set gradient change amplitude.
---@param cycleNum number Set how many LEDC tick each time the gradient lasts.
---@param stepNum number  Set the number of the gradient.
---@param wait? integer|' ledc.FADE_NO_WAIT'|' ledc.FADE_WAIT_DONE'
---@return nil
function channel:fade(duty, direction, scale, cycleNum, stepNum, wait) end

--*** MQTT ***
mqtt = {}

---@class mqtt
local MQTT32 = mqtt.Client()

---Creates a MQTT client.
---@param clientid string clientid client ID
---@param keepalive integer keepalive keepalive seconds
---@param username? string username user name
---@param password? string password user password
---@param cleansession? integer cleansession 0/1 for false/true. Default is 1 (true).
---@return mqtt MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession) end

---Closes connection to the broker.
---@return boolean
function MQTT32:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string host host, domain or IP (string)
---@param port? integer port broker port (number), default 1883
---@param secure? boolean|table secure either an interger with 0/1 for false/true (default 0), or a table with optional entries
---*ca_cert CA* certificate data in PEM format for server verify with SSL
---*client_cert* client certificate data in PEM format for SSL mutual authentication
---*client_key* client private key data in PEM format for SSL mutual authentication Note that both client_cert and client_key have to be provided for mutual authentication.
---@param conn_est? function|' function(client: any)'
---@param conn_notest? function|' function(client: any, reason: any)'
---@return boolean
function MQTT32:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string topic the topic to publish to (string)
---@param message string message the message to publish, (buffer or string)
---@param qos? integer|' 0'|' 1'|' 2'
---@param retain? integer|' 0'|' 1'
---@return nil
function MQTT32:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"message"'|'"offline"'
---@param handler function|' function(client, topic?:string, message?:string) end'
---@return nil
function MQTT32:on(event, handler) end

---Publishes a message.
---@param topic string topic the topic to publish to (topic string)
---@param payload string message the message to publish, (buffer or string)
---@param qos integer|' 0'|' 1'|' 2'
---@param retain integer|' 0'|' 1'
---@param f_puback? function|' function(client) end'
---@return boolean
function MQTT32:publish(topic, payload, qos, retain, f_puback) end

---Subscribes to one or several topics.
---@param topic string|'""'
---@param qos integer|' 0'|' 1'|' 2'
---@param f32_client? function|' function(client) end'
---@return boolean
function MQTT32:subscribe(topic, qos, f32_client) end

---Unsubscribes from one or several topics.
---@param topic string|'""'
---@param f32_client? function|' function(client) end'
---@return boolean
function MQTT32:unsubscribe(topic, f32_client) end

--*** NET ***
net = {}

---@class netsocket
local NETSOCKET = net.createConnection()
---@class netsrv
local NETSRV= net.createServer()
---@class udpsocket
local UDPSOCKET = net.createUDPSocket()

---Creates a client.
---@param type? integer|'net.TCP'|'net.UDP'
---@param secure? integer 0 for plain (default)
---@return netsocket submodule net.socket (for net.TCP) or net.udpsocket (for net.UDP)
function net.createConnection(type, secure) end

---Creates a server.
---@param type? integer|'net.TCP'|'net.UDP'
---@param timeout? integer for a TCP server timeout is 1~28'800 seconds, 30 sec by default (for an inactive client to be disconnected)
---@return netsrv submodule net.server (for net.TCP), net.udpsocket (for net.UDP)
function net.createServer(type, timeout) end

---Creates an UDP socket.
---@return udpsocket submodule net.udpsocket
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
---@param ip? string IP address string
---@param fun function |' function(net.socket) end'
--- `fun` callback function, pass to caller function as param if a connection is created successfully
---@return nil
function NETSRV.listen(port, ip, fun) end

---Returns server local address/port.
---@return integer port or nil if not listening
---@return string ip or nil if not listening
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
---@param fun function|' function(net.socket, ip) end'
--- callback function. The first parameter is the socket, the second parameter is the IP address as a string.
---@return nil
function NETSOCKET:dns(domain, fun) end

---Retrieve port and ip of remote peer.
---@return integer port or nil if not connected
---@return string ip or nil if not connected
function NETSOCKET:getpeer() end

---Retrieve local port and ip of socket.
---@return integer port or nil if not connected
---@return string ip or nil if not connected
function NETSOCKET:getaddr() end

---Throttle data reception by placing a request to block the TCP receive function. net.socket:hold()
---@return nil
function NETSOCKET:hold() end

---Register callback functions for specific events.
---@param event string|'"connection"'|'"reconnection"'|'"disconnection"'|'"receive"'|'"sent"'
---@param fun nil|function|' function(net.socket, string?) end)'
-- callback function. Can be nil to remove callback.
---@return nil
function NETSOCKET:on(event, fun) end

---Sends data to remote peer.
---@param str string data in string which will be sent to server
---@param fun? function|' function(sent) end'
---@return nil
function NETSOCKET:send(str, fun) end

---Unblock TCP receiving data by revocation of a preceding hold().
---@return nil
function NETSOCKET:unhold() end

---Closes UDP socket.
---@return nil
function UDPSOCKET:close() end

---Listen on port from IP address.
---@param port? integer
---@param ip? string
---@return nil
function UDPSOCKET:listen(port, ip) end

---Register callback functions for specific events.
---@param event string|'"receive"'|'"sent"'|'"dns"'
---@param fun nil|function|' function(net.socket, string?) end)'
---@return nil
function UDPSOCKET:on(event, fun) end

---Sends data to specific remote peer.
---@param port integer remote socket port
---@param ip string remote socket IP
---@param data any the payload to send
---@return nil
function UDPSOCKET:send(port, ip, data) end

---Provides DNS resolution for a hostname.
---@param domain string domain name
---@param fun function|' function(net.socket, ip) end'
---@return nil
function UDPSOCKET:dns(domain, fun) end

---Retrieve local port and ip of socket.
---@return integer port or nil if not connected
---@return string ip or nil if not connected
function UDPSOCKET:getaddr() end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer|'0'|'1'
---@return string IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address.
---Doesn't require a socket like net.socket.dns().
---@param host string hostname to resolve
---@param fun function|' function(sk, ip) end'
---@return nil
function net.dns.resolve(host, fun) end

---Sets the IP of the DNS server used to resolve hostnames.
---@param dns_ip_addr string IP address of a DNS server
---@param dns_index integer|'0'|'1'
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end

--*** NODE ***
node = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode
---@return integer reason
---@return ...
function node.bootreason() end

---Returns the ESP chip ID.
---@return string id chip ID (string)
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as.
---@param filename string
---|'".lua"' #filename name of Lua text file
---@return nil
function node.compile(filename) end

---Enters deep sleep mode.
---@overload fun(options:number)
-- For compatibility, a number parameter usecs can be supplied instead of an options table, which is equivalent to node.dsleep({us = usecs}).
---@param options table
-- *options*, a table containing some of:
-- `secs`, a number of seconds to sleep. This permits longer sleep periods compared to using the us parameter.
-- `us`, a number of microseconds to sleep. If both secs and us are provided, the values are combined.
-- `gpio`, a single GPIO number or a list of GPIOs. These pins must all be RTC-capable otherwise an error is raised.
-- `level`. Whether to trigger when *any* of the GPIOs are high (level=1, which is the default if not specified), or when *all* the GPIOs are low (level=0).
-- `isolate`. A list of GPIOs to isolate. Isolating a GPIO disables input, output, pullup, pulldown, and enables hold feature for an RTC IO. Use this function if an RTC IO needs to be disconnected from internal circuits in deep sleep, to minimize leakage current.
-- `pull`, boolean, whether to keep powering previously-configured internal pullup/pulldown resistors. Default is false if not specified.
-- `touch`, boolean, whether to trigger wakeup from any previously-configured touchpads. Default is false if not specified.
function node.dsleep(options) end

---Returns the flash chip ID.
---@return number flash_ID
function node.flashid() end

---Returns the current available heap size in bytes.
---@return number heap system heap size left in bytes
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

---Submits a string to the Lua interpreter. Similar to pcall(loadstring(str)),
---but without the single-line limitation.
---@param str string Lua chunk
---@return nil
function node.input(str) end

---Redirects the Lua interpreter output to a callback function.
---Optionally also prints it to the serial console.
---@param fun function a function accept every output as str, and can send the output to a socket (or maybe a file). nil to unregister the previous function.
---@param serial_output integer
---|>' 1' #output also sent out the serial port.
---|' 0' #no serial output.
---@return nil
function node.output(fun, serial_output) end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults using the SDK function system_restore(),
---which doesn't document precisely what it erases/restores.
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ'
---@return number freq target CPU frequency
function node.setcpufreq(speed) end

---Controls the amount of debug information kept during node.compile(), and allows removal of debug information from already compiled Lua code.
---@param level? number
---|'1' #don't discard debug info
---|'2' #discard Local and Upvalue debug info
---|'3' #discard Local, Upvalue and line-number debug info
---@param fun? function
--- `fun` a compiled function to be stripped per setfenv except 0 is not permitted.
---@return integer|nil levl If invoked without arguments, returns the current level settings. Otherwise, nil is returned.
function node.stripdebug(level, fun) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean
function node.osprint(enabled) end

---Returns the value of the system counter,
---which counts in microseconds starting at 0 when the device is booted.
---@return number lowbits the time in microseconds since boot or the last time the counter wrapped
---@return number highbits the number of times the counter has wrapped
function node.uptime() end

---Sets the Emergency Garbage Collector mode.
---@param mode integer
---|'node.egc.NOT_ACTIVE' #EGC inactive, no collection cycle will be forced in low memory situations
---|'node.egc.ON_ALLOC_FAILURE' #Try to allocate a new block of memory, and run the garbage collector if the allocation fails.
---|'node.egc.ON_MEM_LIMIT' #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit.
---|'node.egc.ALWAYS' #Run the garbage collector before each memory allocation.
---@param level number in the case of node.egc.ON_MEM_LIMIT, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Enable a Lua callback or task to post another task request.
---@param task_priority? number
---|'node.task.LOW_PRIORITY' # = 0
---|>'node.task.MEDIUM_PRIORITY' # = 1
---|'node.task.HIGH_PRIORITY''0' # = 2
---@param fun function|' function() end'
--- `fun` a callback function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, fun) end

--*** OTA ***
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
---@param data string |any
---@return nil
function otaupgrade.write(data) end

---Finalises the upgrade, and optionally reboots into the new application firmware right away.
---@param reboot integer |nil
---@return nil
function otaupgrade.complete(reboot) end

---When the installed boot loader is built with rollback support,
---a new application image is by default only booted once.
---@return nil
function otaupgrade.accept() end

---A new firmware may decide that it is not performing as expected,
---and request an explicit rollback to the previous version.
function otaupgrade.rollback() end

--*** 1-WIRE ***
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
---@return string |nil
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

---Sets up the search to find the device type family_code.
---The search itself has to be initiated with a subsequent call to ow.search().
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

--* PULCECNT **--
pulsecnt = {}

---@class pulsecnt
local pulsecntObj = pulsecnt.create()

---Create the pulse counter object.
---@param unit integer ESP32 has 0 thru 7 units to count pulses on.
---@param callbackOnEvents? function Your Lua method to call on event.
---@return pulsecnt
function pulsecnt.create(unit, callbackOnEvents) end

---@alias pulse_mode1
---|' pulsecnt.PCNT_COUNT_DIS' #= 0 Counter mode: Inhibit counter
---|' pulsecnt.PCNT_COUNT_INC' #= 1 Counter mode: Increase counter value.
---|' pulsecnt.PCNT_COUNT_DEC' #= 2 Counter mode: Decrease counter value.
---@alias pulse_mode2
---|' pulsecnt.PCNT_MODE_KEEP' #= 0 Control mode: will not change counter mode.
---|' pulsecnt.PCNT_MODE_REVERSE' #= 1 Control mode: invert counter mode
---|' pulsecnt.PCNT_MODE_DISABLE' #= 2 Control mode: Inhibit counter
---Configure channel 0 of the pulse counter object you created from the create() method.
---@param pulse_gpio_num integer Any GPIO pin can be used.
---@param ctrl_gpio_num integer Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 Positive rising edge count mode
---@param neg_mode pulse_mode1 Negative falling edge count mode
---@param lctrl_mode pulse_mode2
---@param hctrl_mode pulse_mode2
---@param counter_l_lim integer Range -32768 to 32767. The lower limit counter.
---@param counter_h_lim integer Range -32768 to 32767. The high limit counter.
---@return nil
function pulsecntObj:chan0Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Configure channel 1 of the pulse counter object you created from the create() method.
---@param pulse_gpio_num integer Any GPIO pin can be used.
---@param ctrl_gpio_num integer Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 Positive rising edge count mode
---@param neg_mode pulse_mode1 Negative falling edge count mode
---@param lctrl_mode pulse_mode2
---@param hctrl_mode pulse_mode2
---@param counter_l_lim integer Range -32768 to 32767. The lower limit counter.
---@param counter_h_lim integer Range -32768 to 32767. The high limit counter.
---@return nil
function pulsecntObj:chan1Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Set the threshold values to establish watchpoints for getting callbacks on.
---@param thr0 integer Threshold 0 value. Range -32768 to 32767.
---@param thr1 integer Threshold 1 value. Range -32768 to 32767.
---@return nil
function pulsecntObj:setThres(thr0, thr1) end

---Set a filter to ignore pulses on the pulse_gpio_num pin and the ctrl_gpio_num to avoid short glitches.
---@param clkCycleCnt integer 0 to 1023 allowd.
---@return nil
function pulsecntObj:setFilter(clkCycleCnt) end

---Clear the counter. Sets it back to zero.
---@return nil
function pulsecntObj:clear() end

---Get the current pulse counter.
---@return integer
function pulsecntObj:getCnt() end

-- QRCODEGEN **--
qrcodegen = {}

---Generates a QR Code from a text string.
---@param text any The text or URL to encode. Should be UTF-8 or ASCII.
---@param options? table
---@return string|nil
function qrcodegen.encodeText(text, options) end

---@param qrcode string
---@return integer
function qrcodegen.getSize(qrcode) end

---Get the color of the pixel at the given coordinates of the QR Code.
---@param qrcode string
---@param x any
---@param y any
---@return boolean
function qrcodegen.getPixel(qrcode, x, y) end

--*** SDMMC ***
sdmmc = {}

---@class sdmmc
local card = sdmmc.init()

---Initialize the SDMMC and probe the attached SD card. SDMMC Mode.
---@param slot integer|'sdmmc.HS1'|'sdmmc.HS2'
---@param cfg? table
---@return sdmmc card Card object.
function sdmmc.init(slot, cfg) end

---Initialize the SDMMC and probe the attached SD card. SD SPI Mode.
---@param slot integer|'sdmmc.HSPI'|'sdmmc.VSPI'
---@param cfg table
---@return sdmmc card Card object.
function sdmmc.init(slot, cfg) end

---Retrieve information from the SD card.
---@return table
function card:get_info() end

---Mount filesystem on SD card.
---@param ldrv string|'"/SD0"'|'"/SD1"'
---@param slot? integer|'sdmmc.HS2'|'sdmmc.HS1'
---@return boolean
function card:mount(ldrv, slot) end

---Read one or more sectors.
---@param start_sec integer first sector to read from
---@param num_sec integer number of sectors to read (>= 1)
---@return string
function card:read(start_sec, num_sec) end

---Unmount filesystem.
---@return nil
function card:umount() end

---Write one or more sectors.
---@param start_sec integer first sector to write to
---@param data any string of data to write, must be multiple of sector size (512 bytes)
---@return nil
function card:write(start_sec, data) end

--******* SIGMA DELTA *--
sigma_delta = {}

---Reenables GPIO functionality at the related pin.
---@param channel integer 0~7, sigma-delta channel index
---@return nil
function sigma_delta.close(channel) end

---Sets the prescale value.
---@param channel integer  0~7, sigma-delta channel index
---@param value integer prescale 1 to 255
---@return nil
function sigma_delta.setprescale(channel, value) end

---Sets the duty value.
---@param channel integer 0~7, sigma-delta channel index
---@param value integer duty -128 to 127
---@return nil
function sigma_delta.setduty(channel, value) end

---Routes the sigma-delta channel to the specified pin.
---@param channel integer  0~7, sigma-delta channel index
---@param pin integer
---@return nil
function sigma_delta.setup(channel, pin) end

--*** SJSON ***
sjson = {}

---@class sjsonenc
local encoder = sjson.encoder()
---@class sjsondec
local decoder = sjson.decoder()

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table data to encode
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---@return sjsonenc obj A sjson.encoder object.
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer an optional value for the number of bytes to return. The default is 1024.
---@return string|nil A `string` of up to size bytes, or `nil` if the encoding is complete and all data has been returned.
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table
---@param opts? table
---@return string
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---`metatable` a table to use as the metatable for all the new tables in the returned object.
---@return sjsondec
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string the next piece of JSON encoded data
---@return any | nil The constructed Lua object or nil if the decode is not yet complete.
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string JSON string to decode
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---`metatable` a table to use as the metatable for all the new tables in the returned object.
function sjson.decode(str, opts) end

--** SODIUM ***
sodium = {}

---Returns a random integer between `0` and `0xFFFFFFFF` inclusive.
---@return integer
function sodium.random.random() end

---Returns a random integer 0 <= result < upper_bound
---@param upper_bound integer
---@return integer
function sodium.random.uniform(upper_bound) end

---Generates n bytes of random data.
---@param n number
---@return string
function sodium.random.buf(n) end

---Generates a new keypair.
---@return string public_key
---@return string secret_key
function sodium.crypto_box.keypair() end

---Encrypts a message using a public key.
---@param message string
---@param public_key any
---@return string|any
function sodium.crypto_box.seal(message, public_key) end

---Decrypts a message encrypted with crypto_box.seal().
---@param ciphertext any
---@param public_key any
---@param secret_key any
---@return any|nil
function sodium.crypto_box.seal_open(ciphertext, public_key, secret_key) end

--*** SPI ***
spi = {}

---@class spi
local busmaster = spi.master()
---@class spidev
local device = busmaster:device()

---Initializes a bus in master mode and returns a bus master object.
---@param host integer|'spi.VSPI'|'spi.HSPI'|'spi.SPI1'
---@param config? table
---@param dma? integer|'1'|'2'|'0'
---@return spi
function spi.master(host, config, dma) end

---Close the bus host. This fails if there are still devices registered on this bus.
---@return nil
function busmaster:close() end

---Adds a device on the given master bus. Up to three devices per bus are supported.
---@param config table
---@return spidev
function busmaster:device(config) end

---Removes a device from the related bus master.
---@return nil
function device:remove() end

---Initiate an SPI transaction.
---@param trans table
---@return string
function device:transfer(trans) end

---Initializes a bus in slave mode and returns a slave object. `Not yet supported.`
function spi.slave() end

--*** STRUCT ***
struct = {}

---Returns a string containing the values d1, d2, etc. packed according to the format string fmt.
---@param fmt string The format string
---@param d1 any The first data item to be packed
---@param d2 any The second data item to be packed etc.
---@return string s The packed string.
function struct.pack (fmt, d1, d2, ...) end

---Returns the values packed in string s according to the format string `fmt`.
---@param fmt string The format string
---@param s string  The string holding the data to be unpacked
---@param offset? integer The position to start in the string (default is 1)
---@return any d All the unpacked data.
function struct.unpack (fmt, s, offset) end

---Returns the size of a string formatted according to the format string `fmt`.
---@param fmt string The format string
---@return integer sz The size of the string that would be output in a pack operation with this format string.
function struct.size (fmt) end

--*** TIME ***
time = {}

---Converts calendar table to a timestamp in Unix epoch
---@param calendar table
-- `calendar` Table containing calendar info.
--- `year` 1970 ~ 2038
--- `mon` month 1 ~ 12 in current year
--- `day` day 1 ~ 31 in current month
--- `hour`
--- `min`
--- `sec`
---@return integer n number of seconds since the Epoch
function time.cal2epoch(calendar) end

---Converts timestamp in Unix epoch to calendar format
---@param time integer number of seconds since the Epoch
---@return table
-- A *table* containing the fields:
--- `year` 1970 ~ 2038
--- `mon` month 1 ~ 12 in current year
--- `day` day 1 ~ 31 in current month
--- `hour`
--- `min`
--- `sec`
--- `yday` day 1 ~ 366 in current year
--- `wday` day 1 ~ 7 in current weak (Sunday is 1)
--- `dst` day time adjustment:
--- 1 (DST in effect, i.e. daylight time)
--- 0 (DST not in effect, i.e. standard time)
--- -1 (Unknown DST status)
function time.epoch2cal(time) end

---Returns current system time in the Unix epoch (seconds from midnight 1970/01/01).
---@return integer sec seconds since the Unix epoch
---@return integer usec the microseconds part
function time.get() end

---Returns current system time adjusted for the locale in calendar format.
---@return table
-- A *table* containing the fields:
--- `year` 1970 ~ 2038
--- `mon` month 1 ~ 12 in current year
--- `day` day 1 ~ 31 in current month
--- `hour`
--- `min`
--- `sec`
--- `yday` day 1 ~ 366 in current year
--- `wday` day 1 ~ 7 in current weak (Sunday is 1)
--- `dst` day time adjustment:
-- 1 (DST in effect, i.e. daylight time)
-- 0 (DST not in effect, i.e. standard time)
-- -1 (Unknown DST status)
function time.getlocal() end

---Initializes and starts NTP client
---@param ntpAddr? string address of a NTP server, defaults to "pool.ntp.org" if none is specified
---@return nil
function time.initntp(ntpAddr) end

---Checks if NTP client is enabled.
---@return boolean b `true' if NTP client is enabled.
function time.ntpenabled() end

---Stops NTP client.
---@return nil
function time.ntpstop() end

---Sets system time to a given timestamp in the Unix epoch (seconds from midnight 1970/01/01).
---@param time integer number of seconds since the Epoch
---@return nil
function time.set(time) end

---Sets correct format for Time Zone locale
---@param timezone string a string representing timezone, can also include DST adjustment.
---@return nil
function time.settimezone(timezone) end

--*** TMR ***
tmr = {}

---@class tmr
local tObj = tmr.create()

---Creates a dynamic timer object.
---@return tmr
function tmr.create() end

---@alias t32
---|' tmr.ALARM_AUTO' #automatically repeating alarm
---|' tmr.ALARM_SINGLE' #a one-shot alarm (and no need to call tmr.unregister())
---|' tmr.ALARM_SEMI' #manually repeating alarm (call tmr.start() to restart)
---This is a convenience function combining tmr.obj:register() and tmr.obj:start() into a single call.
---@param interval integer
---@param mode t32
---@param foo function|" function(t) end"
---@return boolean
function tObj:alarm(interval, mode, foo) end

---Changes a registered timer's expiry interval.
---@param interval integer
---@return nil
function tObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval integer
---@param mode t32
---@param foo function|" function() end"
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

--*** TOUCH ***
touch ={}

---@class touch
local tp = touch.create()

---Create the touch sensor object.
---@param tbl table
---@return touch
function touch.create(tbl) end

---Read the touch sensor counter values for all pads configured in touch.create() method.
---@return table raw Lua table of touch sensor counter values per pad
---@return table
function tp:read() end

---Set touch sensor interrupt threshold per pad.
---@param padNum number One pad number can be specified here.
---@param thresVal number The threshold value to set for the pad interrupt trigger.
---@return nil
function tp:setThres(padNum, thresVal) end

---Set the trigger mode globally for all touch pads.
---@param mode integer|'touch.TOUCH_TRIGGER_BELOW'|'touch.TOUCH_TRIGGER_ABOVE'
---@return nil
function tp:setTriggerMode(mode) end

---Enable interrupt on the touch sensor hardware.
---@return nil
function tp:intrEnable() end

---Disable interrupt on the touch sensor hardware.
---@return nil
function tp:intrDisable() end

--*** U8G2 TODO ***
u8g2 = {}

--*** UART ***
uart = {}

---Sets the callback function to handle UART events.
---@param id? integer uart id, default value is uart num of the console.
---@param method string
---|' "data"' #"data", data has been received on the UART.
---|' "error"' #error occurred on the UART.
---@param number_end_char? number
--- `number/end_char` Only for event data.
--- if pass in a number n<255, the callback will called when n chars are received.
--- if n=0, will receive every char in buffer.
--- if pass in a one char string "c", the callback will called when "c" is encounterd, or max n=255 received.
---@param fun? function
---|' function(data) end' #for event "data"
---|' function(err) end' #for event "error" `err` could be one of "out_of_memory", "break", "rx_error".
---@param run_input? integer
---|'0' # input from UART will not go into Lua interpreter, can accept binary data.
---|'1' # input from UART will go into Lua interpreter, and run.
--- `run_input` Only for "data" event on console uart.
-- To unregister the callback, provide only the "data" parameter.
---@return nil
function uart.on(id, method, number_end_char, fun, run_input) end

---(Re-)configures the communication parameters of the UART.
---@param id integer uart id
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400'
---@param databits integer|' 8'|' 7'|' 6'|' 5'
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN'
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2'
---@param echo_or_pins integer|table
--- `echo_or_pins` for console uart, this should be a int. if 0, disable echo, otherwise enable echo
---for others, this is a table:
--- `tx` int. TX pin. Required
--- `rx` int. RX pin. Required
--- `cts` in. CTS pin. Optional
--- `rts` in. RTS pin. Optional
--- `tx_inverse` boolean. Inverse TX pin. Default: false
--- `rx_inverse` boolean. Inverse RX pin. Default: false
--- `cts_inverse` boolean. Inverse CTS pin. Default: false
--- `rts_inverse` boolean. Inverse RTS pin. Default: false
--- `flow_control` int. Combination of uart.FLOWCTRL_NONE, uart.FLOWCTRL_CTS, uart.FLOWCTRL_RTS. Default: uart.FLOWCTRL_NONE
---@return number n configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo_or_pins) end

---Returns the current configuration parameters of the UART.
---@param id integer|'0'|'1'
---@return integer baud
---@return integer databits
---@return integer parity
---@return integer stopbits
function uart.getconfig(id) end

---Start the UART.
---@param id integer uart id, except console uart
---@return boolean b true if uart is started.
function uart.start(id) end

---Stop the UART.
---@param id integer uart id, except console uart
---@return nil
function uart.stop(id) end

---Set UART controllers communication mode
---@param id integer uart id
---@param mode integer
---|>' uart.MODE_UART' #default UART mode, is set after uart.setup() call
---|' uart.MODE_RS485_COLLISION_DETECT' #receiver must be always enabled, transmitter is automatically switched using RTS pin, collision is detected by UART hardware (note: no event is generated on collision, limitation of esp-idf)
---|' uart.MODE_RS485_APP_CONTROL' #receiver/transmitter control is left to the application
---|' uart.MODE_RS485_HALF_DUPLEX' #receiver/transmitter are controlled by RTS pin
---|' uart.MODE_IRDA'
---@return nil
function uart.setmode(id, mode) end

---Write string or byte to the UART.
---@param id integer uart id
---@param data1 any ... string or byte to send via UART
---@return nil
function uart.write(id, data1, ...) end

--*** UCG TODO ***
ucg = {}

--*** WIFI ***
wifi = {}

---Gets the current WiFi channel.
---@return integer pch current WiFi channel (primary channel)
---@return integer sch HT20/HT40 information (secondary channel).
function wifi.getchannel() end

---Gets WiFi operation mode.
---@return integer mod The WiFi mode.
function wifi.getmode() end

---Configures the WiFi mode to use.
---@param mode integer
---|'wifi.STATION' #for when the device is connected to a WiFi router.
---|'wifi.SOFTAP'  #for when the device is acting only as an access point.
---|'wifi.STATIONAP' #is the combination of wifi.STATION and wifi.SOFTAP
---|'wifi.NULLMODE' # disables the WiFi interface(s).
---@param save? boolean choose whether or not to save wifi mode to flash
---@return any cm current mode after setup
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

---Connects to the configured AP in station mode.
---You only ever need to call this if auto-connect was disabled in wifi.sta.config().
---@return nil
function wifi.sta.connect() end

---Disconnects from AP in station mode.
---@return nil
function wifi.sta.disconnect() end

---Registers callbacks for WiFi station status events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"authmode_changed"'|'"got_ip"'
---@param callback function|' function(event, info) end'
---@return nil
function wifi.sta.on(event, callback) end

---Gets MAC address in station mode.
---@return string
function wifi.sta.getmac() end

---Scan for available networks.
---@param cfg table
---@param callback function|' function(ap_list) end'
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
---@param callback function|' function(event, info) end'
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

--** WS2812 TODO ***
ws2812 = {}

---@class ws2812
local buffer =  ws2812.newBuffer()

---Send data to up to 8 led strip using its native format.
---@param tbl table
---@return nil
function ws2812.write(tbl, ...) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer length of the led strip
---@param bytesPerLed integer  3 for RGB strips and 4 for RGBW strips
---@return ws2812
function ws2812.newBuffer(numberOfLeds, bytesPerLed) end

---Return the value at the given position
---@param index integer position in the buffer (1 for first led)
---@return number (color)
function buffer:get(index) end

---Set the value at the given position
---@param index integer position in the buffer (1 for the first led)
---@param color number|any payload of the color
---@return nil
function buffer:set(index, color) end

---Return the size of the buffer in number of leds
---@return integer
function buffer:size() end

---Fill the buffer with the given color.
---@param color any bytes of the color, you should pass as many arguments as `bytesPerLed`
---@return nil
function buffer:fill(color) end

---Returns the contents of the buffer (the pixel values) as a string.
---@return string A string containing the pixel values.
function buffer:dump() end

---Inserts a string (or a buffer) into another buffer with an offset.
---@param source string|any the pixel values to be set into the buffer.
---@param offset? integer the offset where the source is to be placed in the buffer.
---@return nil
function buffer:replace(source, offset) end

---This is a general method that loads data into a buffer.
---@param factor1 number This is the factor that the contents of buffer1 are multiplied by.
---@param buffer1 any This is the source buffer.
---@return nil
function buffer:mix(factor1, buffer1, ...) end

---Computes the total energy requirement for the buffer.
---@return integer sum An integer which is the sum of all the pixel values.
function buffer:power() end

---Fade in or out. Defaults to out
---@param value number value by which to divide or multiply each byte
---@param direction? integer|'ws2812.FADE_IN'|' ws2812.FADE_OUT'
---@return nil
function buffer:fade(value, direction) end

---Shift the content of (a piece of) the buffer in positive or negative direction.
---@param value number  number of pixels by which to rotate the buffer.
---@param mode? integer|'ws2812.SHIFT_LOGICAL'|'ws2812.SHIFT_CIRCULAR'
---@param i? integer is the first offset in the buffer to be affected.
---@param j? integer is the last offset in the buffer to be affected.
---@return nil
function buffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub.
---@param i integer This is the start of the extracted data.
---@param j? integer  this is the end of the extracted data.
---@return any buff A buffer containing the extracted piece.
function buffer:sub(i, j) end
