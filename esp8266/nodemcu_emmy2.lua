--*** RTCMEM ***
rtcmem = {}

---Reads one or more 32bit values from RTC user memory.
---@param idx integer @zero-based index to start reading from
---@param num? number @(optional) number of slots to read (default 1)
---@return any @The value(s) read from RTC user memory.
function rtcmem.read32(idx , num) end

---Writes one or more values to RTC user memory, starting at index idx.
---@param idx integer @zero-based index to start writing to.
---@param val number @value to store (32bit)
---@vararg number @additional values to store (optional)
---@return nil
function rtcmem.write32(idx , val, ...) end

--*** RTCTIME ***
rtctime = {}

---Puts the ESP8266 into deep sleep mode, like node.dsleep().
---@param microseconds number @of microseconds to sleep for.
---@param option any @sleep option, see node.dsleep() for specifics.
function rtctime.dsleep(microseconds , option) end

---For applications where it is necessary to take samples with high regularity, this function is useful.
---@param aligned_us number @boundary interval in microseconds
---@param minsleep_us number @minimum time that will be slept, if necessary skipping an interval.
---@param option? any @(optional) as with dsleep(), the option sets the sleep option, if specified.
function rtctime.dsleep_aligned(aligned_us, minsleep_us , option) end

---Converts a Unix timestamp to calendar format.
---@param timestamp integer
---@return table rtctbl @containing the fields:
--- - **year** 1970 ~ 2038
--- - **mon** month 1 ~ 12 in current year
--- - **day** day 1 ~ 31 in current month
--- - **hour**
--- - **min**
--- - **sec**
--- - **yday** day 1 ~ 366 in current year
--- - **wday** day 1 ~ 7 in current weak (Sunday is 1)
function rtctime.epoch2cal(timestamp) end

---Returns the current time.
---@return number sec @seconds since the Unix epoch
---@return number usec @the microseconds part
---@return number rate @the current clock rate offset. This is an offset of rate / 2^32
function rtctime.get() end

---Sets the rtctime to a given timestamp in the Unix epoch.
---@param seconds? number @(optional) the seconds part, counted from the Unix epoch
---@param microseconds? number @(optional) the microseconds part
---@param rate? number @(optional) the rate in the same units as for rtctime.get()
---@return nil
function rtctime.set(seconds , microseconds, rate) end

---This takes a time interval in 'system clock microseconds'\
---based on the timestamps returned by tmr.
---@param microseconds number @a time interval measured in system clock microseconds.
---@return number @The same interval but measured in wall clock microseconds
function rtctime.adjust_delta(microseconds) end

--*** SI7021 ***
si7021 = {}

---Read the internal firmware revision of the Si7021 sensor.
---@return number @*0xFF*: Firmware version 1.0; *0x20*: Firmware version 2.0
function si7021.firmware() end

---`si7021.read()`
---@return number hum @humidity
---@return number temp @temperature
---@return number hum_dec @humidity decimal
---@return number temp_dec @temperature decimal
function si7021.read() end

---Read the individualized 64-bit electronic serial number of the Si7021 sensor.
---@return number @32-bit serial number part a
---@return number @32-bit serial number part b, upper byte contains the device identification
function si7021.serial() end

---@alias si7021_a1 number
---|>'si7021.RH12_TEMP14' #Relative Humidity 12 bit - Temperature 14 bit
---|'si7021.RH08_TEMP12' #Relative Humidity 8 bit - Temperature 12 bit
---|'si7021.RH10_TEMP13' #Relative Humidity 10 bit - Temperature 13 bit
---|'si7021.RH11_TEMP11' #Relative Humidity 11 bit - Temperature 11 bit

---@alias si7021_a2 integer
---|'si7021.HEATER_ENABLE' #On-chip Heater Enable
---|>'si7021.HEATER_DISABLE' #On-chip Heater Disable

---Settings for the sensors configuration register.
---@param RESOLUTION si7021_a1 @resolution
---@param HEATER? si7021_a2 @(optional)
---@param HEATER_SETTING? number @(optional) 0x00 - 0x0F 3.09 mA - 94.20 mA
---@return number resolution @0 - 4
---@return integer vdds @0 VDD OK (1.9V - 3.6V) | 1 VDD LOW (1.8V - 1.9V)
---@return integer heater @0 Disabled| 1 Enabled
---@return integer heater_setting @0 - 15
function si7021.setting(RESOLUTION, HEATER, HEATER_SETTING) end

---Initializes the device on\
---fixed I²C device address (0x40).
---@return nil
function si7021.setup() end

--*** SIGMA DELTA ***
sigma_delta = {}

---Stops signal generation and reenables GPIO\
---functionality at the specified pin.
---@param pin integer @1~12
---@return nil
function sigma_delta.close(pin) end

---Sets the prescale value.
---@param value integer @prescale 1 to 255
---@return nil
function sigma_delta.setprescale(value) end

---Operate the sigma-delta module in PWM-like mode\
---with fixed base frequency.
---@param ratio integer @0...255 for duty cycle 0...100%, 0 stops the signal at low
---@return nil
function sigma_delta.setpwmduty(ratio) end

---Sets the target value.
---@param value integer @target 0 to 255
---@return nil
function sigma_delta.settarget(value) end

---Stops the signal generator and routes it to the specified pin.
---@param pin integer @1~12
---@return nil
function sigma_delta.setup(pin) end

--*** SJSON ***
sjson = {}

---@class sjsonenc
local encoder = {}
---@class sjsondec
local decoder = {}

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table @data to encode
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** - the string value to treat as null.
---@return sjsonenc @A `sjson.encoder` object.
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer @an optional value for the number of bytes to return. The default is 1024.
---@return string|nil @A string of up to `size` bytes, or `nil` if the encoding is complete and all data has been returned.
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table @data to encode
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** - the string value to treat as null.
---@return string @JSON string
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table @an optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** - the string value to treat as null.
--- - **metatable** - a table to use as the metatable for all the new tables in the returned object.
---@return sjsondec @A `sjson.decoder` object
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string @the next piece of JSON encoded data
---@return any|nil obj @The constructed Lua object or `nil` if the decode is not yet complete.
function decoder:write(str) end

---This gets the decoded Lua object, or raises\
---an error if the decode is not yet complete.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string @JSON string to decode
---@param opts? table @n optional table of options. The possible entries are:
--- - **depth** - the maximum encoding depth needed to encode the table. The default is 20.
--- - **null** - the string value to treat as null.
--- - **metatable** - a table to use as the metatable for all the new tables in the returned object.
---@return table @Lua table representation of the JSON data
function sjson.decode(str, opts) end

--*** SNTP ***
sntp = {}

---Attempts to obtain time synchronization.
---@param server_ip? string|table @(optional) IP
---@param callback? function|' function (sec, usec, server, info) end' @(optional) if provided it will be invoked on a successful synchronization, with four parameters: seconds, microseconds, server and info.
---@param errcallback? function|' function()' @(optional) failure callback with two parameters: type of error &  string containing supplementary information.
---@param autorepeat? boolean @(optional) if this is non-nil, then the synchronization will happen every 1000 seconds and try and condition the clock if possible.
---@return nil
function sntp.sync(server_ip, callback, errcallback, autorepeat) end

---Sets the offset between the rtc clock and the NTP time.
---@param offset number @The offset between NTP time and the rtc time.
---@return nil
function sntp.setoffset(offset) end

---Gets the offset between the rtc clock and the NTP time.
---@return number offset @The current offset.
function sntp.getoffset() end

--*** SOFTUART ***
softuart = {}

---@class softuart
local s_uart = {}

---Creates new SoftUART instance.\
---Note that rx pin cannot be shared between instances but tx pin can.
---@param baudrate number @SoftUART baudrate. Maximum supported is 230400.
---@param txPin number @SoftUART tx pin. If set to `nil` `write` method will not be supported.
---@param rxPin number @SoftUART rx pin. If set to `nil` `on("data")` method will not be supported.
---@return softuart @softuart instance.
function softuart.setup(baudrate, txPin, rxPin) end

---Sets up the callback function to receive data.
---@param event string|"data" @Event name. Currently only `data` is supported.
---@param trigger number @Can be a character or a number.
--- - If **character** @is set, the callback function will only be run when that character gets received.
--- - When a **number** @is set, the callback function will only be run when buffer will have as many characters as number.
---@param callback function @function. the data parameter is software UART receiving buffer.
---@return nil
function s_uart:on(event, trigger, callback) end

---Transmits a byte or sequence of them.
---@param data number|string @Can be a number or string.
--- - When a **number** is passed, only one byte will be sent.
--- - When a **string** is passed, whole sequence will be transmitted.
---@return nil
function s_uart:write(data) end

--*** SOMFY ***
somfy = {}

---Builds an frame defined by Somfy protocol and sends it to the RF transmitter.
---@param pin integer @GPIO pin the RF transmitter is connected to.
---@param remote_address number @address of the remote control. The device to be controlled is programmed with the addresses of the remote controls it should listen to.
---@param command integer|' somfy.SOMFY_UP'|' somfy.SOMFY_DOWN'|' somfy.SOMFY_PROG'|' somfy.SOMFY_STOP' @somfy command
---@param rolling_code number @The rolling code is increased every time a button is pressed.
---@param repeat_count integer @how many times the command is repeated
---@param callback function @to be called after the command is transmitted.
---@return nil
function somfy.sendcommand(pin, remote_address, command, rolling_code, repeat_count, callback) end

---Using RF receiver listens to Somfy commands and triggers a callback when command is identified.
---@param pin integer @GPIO pin the RF receiver is connected to.
---@param callback function|' function(address, command, rc, frame) end' @`function(address, command, rc, frame)` a function called when a Somfy command is identified. Use `nil` to stop listening.
--- - **address** - of the remote controller sending the command
--- - **command** -  sent by the remote controller. A number between *0* and *0xf*. Can be somfy.SOMFY_UP, somfy.SOMFY_DOWN, somfy.SOMFY_PROG, somfy.SOMFY_STOP.
--- - **rc** - rolling code
--- - **frame** - String of 10 characters with the full captured data frame.
function somfy.listen(pin, callback) end

--*** SPI ***
spi = {}

---Receive data from SPI.
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param size number @number of data items to be read
---@param default_data? any @(optional) default data being sent on MOSI (all-1 if omitted)
---@return string @String containing the bytes read from SPI.
function spi.recv(id, size, default_data) end

---Send data via SPI in half-duplex mode.\
---Send & receive data in full-duplex mode.
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param data1 string|table|integer @data
---@return number @number of written bytes
---@return any @received data when configured with spi.FULLDUPLEX
function spi.send(id, data1, ...) end

---Set up the SPI configuration.
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param mode integer|' spi.MASTER'|' spi.SLAVE' @select master or slave mode. Slave not supported currently
---@param cpol integer|' spi.CPOL_LOW'|' spi.CPOL_HIGH' @clock polarity selection
---@param cpha integer|' spi.CPHA_LOW'|' spi.CPHA_HIGH' @clock phase selection
---@param databits number @number of bits per data item 1 - 32
---@param clock_div number @SPI clock divider
---@param duplex_mode? integer|'spi.HALFDUPLEX'|'spi.FULLDUPLEX' @(optional) HALFDUPLEX - default when omitted
---@return number
function spi.setup(id, mode, cpol, cpha, databits, clock_div, duplex_mode) end

---Set the SPI clock divider.
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param clock_div number @SPI clock divider
---@return number @Old clock divider
function spi.set_clock_div(id, clock_div) end

---Extract data items from MISO buffer after spi.transaction().
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param offset integer @bit offset into MISO buffer for first data item
---@param bitlen integer @bit length of a single data item
---@param num number @of data items to retrieve
---@return number|string
function spi.get_miso(id, offset, bitlen, num) end

---Insert data items into MOSI buffer for spi.transaction().
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param offset integer @bit offset into MOSI buffer
---@param bitlen integer @bit length of data1, data2, ...
---@param data1 any @data items
---@return nil
function spi.set_mosi(id, offset, bitlen, data1, ...) end

---Insert data items into MOSI buffer for spi.transaction().
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param str string @send data to be copied into MOSI buffer at offset 0, bit length 8
---@return nil
function spi.set_mosi(id, str) end

---Start an SPI transaction
---@param id integer @SPI ID number: 0 for SPI, 1 for HSPI
---@param cmd_bitlen integer @bit length of the command phase (0 - 16)
---@param cmd_data any @data for command phase
---@param addr_bitlen integer @bit length for address phase (0 - 32)
---@param addr_data any @data for command phase
---@param mosi_bitlen integer @bit length of the MOSI phase (0 - 512)
---@param dummy_bitlen integer @bit length of the dummy phase (0 - 256)
---@param miso_bitlen integer  @bit length of the MISO phase (0 - 512) for half-duplex.
---@return nil
function spi.transaction(id, cmd_bitlen, cmd_data, addr_bitlen, addr_data, mosi_bitlen, dummy_bitlen, miso_bitlen) end

--*** STRUCT ***
struct = {}

---Returns a string containing the values d1, d2, etc. packed according to the format string fmt.
---@param fmt string @The format string
---@param d1 any @The first data item to be packed
---@param d2 any @The second data item to be packed etc.
---@return string @The packed string.
function struct.pack (fmt, d1, d2, ...) end

---Returns the values packed in string s according to the format string `fmt`.
---@param fmt string @The format string
---@param s string @The string holding the data to be unpacked
---@param offset? integer @(optional) The position to start in the string (default is 1)
---@return any @All the unpacked data.
function struct.unpack (fmt, s, offset) end

---Returns the size of a string formatted according to the format string `fmt`.
---@param fmt string @The format string
---@return integer @The size of the string that would be output in a pack operation with this format string.
function struct.size (fmt) end

--*** SWITEC ***
switec = {}

---Initialize the nodemcu to talk to a switec X.27 or compatible instrument stepper motor.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
---@param pin1 integer @This is a GPIO number and connects to pin 1 on the stepper.
---@param pin2 integer @This is a GPIO number and connects to pin 2 on the stepper.
---@param pin3 integer @This is a GPIO number and connects to pin 3 on the stepper.
---@param pin4 integer @This is a GPIO number and connects to pin 4 on the stepper.
---@param maxDegPerSec? number @(optional) This can set to limit the maximum slew rate. The default is 400 degrees per second.
--- If the arguments are in error, or the operation cannot be completed, then an error is thrown.
function switec.setup(channel, pin1, pin2, pin3, pin4, maxDegPerSec) end

---Starts the needle moving to the specified position.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
---@param position number @The position (number of steps clockwise) to move the needle. Typically in the range 0 to around 1000.
---@param stoppedCallback? function @(optional)
--- The channel must have been setup, otherwise an error is thrown.
function switec.moveto(channel, position, stoppedCallback) end

---This sets the current position of the needle as being zero. The needle must be stationary.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
--- The channel must have been setup and the needle must not be moving, otherwise an error is thrown.
function switec.reset(channel) end

---Gets the current position of the needle and whether it is moving.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
---@return number position @the current position of the needle
---@return integer moving @0 if the needle is stationary. 1 for clockwise, -1 for anti-clockwise.
function switec.getpos(channel) end

---Releases the resources associated with the stepper.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
--- The needle must not be moving, otherwise an error is thrown.
function switec.close(channel) end

--*** TCS34725 TODO ***
tcs34725 ={}

---Initialization via this call is mandatory before values can be read.
---@return integer @0 if setup has failed (no sensor connected?), 1 if sensor is TCS34725
function tcs34725.setup() end

---Enables the sensor. Can be used to wake up after a disable.
---@param foo function @called when the sensor has finished initialising.
---@return nil
function tcs34725.enable(foo) end

---Disables the sensor.\
---Enables a low-power sleep mode.
---@return nil
function tcs34725.disable() end

---Reads the clear, red, green and blue\
---values from the sensor.
---@return integer clear @in uint16_t.
---@return integer red @in uint16_t.
---@return integer green @in uint16_t.
---@return integer blue @in uint16_t.
function tcs34725.raw() end

---Sets the gain of the sensor.\
---Must be called after the sensor is enabled.
---@param gain number @gain
---@return nil
function tcs34725.setGain(gain) end

---Sets the integration time of the sensor.\
---Must be called after the sensor is enabled.
---@param time number @time
---@return nil
function tcs34725.setIntegrationTime(time) end

--*** TLS TODO ***
tls = {}

---@class tls
local TLS = {}

---Creates TLS connection.
---@return tls tls.socket @sub module
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

---Throttle data reception by placing\
---a request to block the TCP receive function.
---@return nil
function TLS:hold() end

---Register callback functions for specific events.
---@param event string|'"dns"'|'"connection"'|'"reconnection"'|'"disconnection"'|'"receive"'|'"sent"' @event
---@param callback function|'function(tls.socket, string?) end' @function. The first parameter is the socket.
--- - If event is *"receive"*, the second parameter is the received data as string.
--- - If event is *"reconnection"*, the second parameter is the reason of connection error (string).
--- - If event is *"dns"*, the second parameter will be either `nil` or a string rendering of the resolved address.
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
---@param enable boolean @A boolean which indicates whether verification should be enabled or not. The default at boot is false.
---@return boolean|any @`true` if it worked. Can throw a number of errors if invalid data is supplied.
function tls.cert.verify(enable) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param pemdata string @A string containing the CA certificate to use for verification. There can be several of these.
---@param pemdata1? string @(optional)
---@return boolean|any
function tls.cert.verify(pemdata, pemdata1) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param callback function @A Lua function which returns TLS keys and certificates for use with connections.
---@return boolean|any
function tls.cert.verify(callback) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param enable boolean @A boolean, specifying whether subsequent TLS connections will present a client certificate. The default at boot is false.
---@return boolean|any
function tls.cert.auth(enable) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param pemdata string @Two strings, the first containing the PEM-encoded client's certificate and the second containing the PEM-encoded client's private key.
---@param pemdata1? string @(optional)
---@return boolean|any
function tls.cert.auth(pemdata, pemdata1) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param callback function @A Lua function which returns TLS keys and certificates for use with connections.
---@return boolean|any
function tls.cert.auth(callback) end

--*** TM1829 ***
tm1829 = {}

---Send data to a led strip using native chip format.
---@param str string @payload to be sent to one or more TM1829 leds.
---@return nil
function tm1829.write(str) end

--*** TMR ***
tmr = {}

---@class tmr
local tObj = {}

---Busyloops the processor for\
---a specified number of microseconds.
---@param us number @us microseconds to busyloop for
---@return nil
function tmr.delay(us) end

---Returns the system counter, which counts\
---in microseconds. Limited to 31 bits,\
---after that it wraps around back to zero.
---@return number @the current value of the system counter
function tmr.now() end

---Provides a simple software watchdog,\
---which needs to be re-armed or disabled\
---before it expires, or the system will be restarted.
---@param timeout_s number @watchdog timeout, in seconds.
---To disable the watchdog, use -1 (or any other negative value).
---@return nil
function tmr.softwd(timeout_s) end

---Returns the system uptime, in seconds.\
---Limited to 31 bits, after that it wraps around back to zero.
---@return number @the system uptime, in seconds, possibly wrapped around
function tmr.time() end

---Feed the system watchdog.
---@return nil
function tmr.wdclr() end

---Get value of CPU CCOUNT register which contains CPU ticks.\
---The register is 32-bit and rolls over. Converting\
---the register's CPU ticks to us is done by dividing it to 80\
---or 160 (CPU80/CPU160) i.e. `tmr.ccount() / node.getcpufreq()`.\
---Register arithmetic works without need to account for roll over,\
---unlike `tmr.now()`. Because of same reason when CCOUNT is having\
--- its 32nd bit set, it appears in Lua as negative number.
---@return number @The current value of CCOUNT register.
function tmr.ccount() end

---Creates a dynamic timer object
---@return tmr TimerObject @timer object
function tmr.create() end

---@alias tmr_m integer
---|' tmr.ALARM_SINGLE' #a one-shot alarm (and no need to call unregister())
---|' tmr.ALARM_SEMI' #manually repeating alarm
---|' tmr.ALARM_AUTO' #automatically repeating alarm (call start() to restart)

---This is a convenience function combining `tobj:register()` and `tobj:start()` into a single call.
---@param interval number @timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode tmr_m @timer mode
---@param callback function|" function(t) end" @function which is invoked with the timer object as an argument
---@return boolean @`true` if the timer was started, `false` on error
function tObj:alarm(interval, mode, callback) end

---Changes a registered timer's expiry interval.
---@param interval_ms integer @new timer interval in milliseconds.
---Maximum value is 6870947 (1:54:30.947).
---@return nil
function tObj:interval(interval_ms) end

---Configures a timer and registers the callback function to call on expiry. Note that registering does not start the alarm.
---@param interval_ms integer @new timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode tmr_m @timer mode
---@param callback function|" function() end" @function which is invoked with the timer object as an argument
---@return nil
function tObj:register(interval_ms, mode, callback) end

---Starts or restarts a previously configured timer. If the timer is running the timer is restarted\
---only when restart parameter is `true`. Otherwise `false` is returned signaling error.
---@param restart? boolean @optional boolean parameter forcing to restart already running timer
---@return boolean @true if the timer was (re)started, false on error
function tObj:start(restart) end

---Checks the state of a timer.
---@return boolean|integer|nil @If the specified timer is registered,
---returns whether it is currently started and its mode.\
---If the timer is not registered, `nil` is returned.
function tObj:state() end

---Stops a running timer, but does *not* unregister it.\
---A stopped timer can be restarted with `tobj:start()`.
---@return boolean @`true` if the timer was stopped, `false` on error
function tObj:stop() end

---Stops the timer (if running) and\
---unregisters the associated callback.
---@return nil
function tObj:unregister() end

--*** TSL2561 ***
tsl2561 = {}

---Reads sensor values from the device and returns calculated lux value.
---@return number lux @the calculated illuminance in lux (lx)
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.getlux() end

---Reads the device's 2 sensors and returns their values.
---@return number ch0 @value of the broad spectrum sensor
---@return number ch1 @value of the IR sensor
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.getrawchannels() end

---@alias tsl2561_a1 number
---|' tsl2561.ADDRESS_GND'
---|>' tsl2561.ADDRESS_FLOAT'
---|' tsl2561.ADDRESS_VDD'

---@alias tsl2561_a2 number
---|' tsl2561.PACKAGE_CS'
---|>' tsl2561.PACKAGE_T_FN_CL'

---Initializes the device on pins sdapin & sclpin.
---@param sdapin number @pin number of the device's I²C sda connection
---@param sclpin number @pin number of the device's I²C scl connection
---@param address? tsl2561_a1 @optional address of the device on the I²C bus
---@param pckg? tsl2561_a2 @optional device's package type (slight difference in lux calculation)
---@return number
function tsl2561.init(sdapin, sclpin, address, pckg) end

---Sets the integration time and gain settings of the device.
---@param integration number|'tsl2561.INTEGRATIONTIME_13MS'|'tsl2561.INTEGRATIONTIME_101MS'|'tsl2561.INTEGRATIONTIME_402MS' @integration
---@param gain number|' tsl2561.GAIN_1X'|' tsl2561.GAIN_16X' @gain
---@return number status @value indicating success or failure as explained below:
--- - tsl2561.TSL2561_OK
--- - tsl2561.TSL2561_ERROR_I2CINIT - can't initialize I²C bus
--- - tsl2561.TSL2561_ERROR_I2CBUSY - I²C bus busy
--- - tsl2561.TSL2561_ERROR_NOINIT - initialize I²C bus before calling function
--- - tsl2561.TSL2561_ERROR_LAST
function tsl2561.settiming(integration, gain) end

--*** UART ***
uart = {}

---Change UART pin assignment.
---@param on integer @0 or 1
--- - **0** for standard pins
--- - **1** to use alternate pins GPIO13 and GPIO15
---@return nil
function uart.alt(on) end

---Sets the callback function to handle UART events. To unregister the callback, provide only the `"data"` parameter.
---@param method string|'"data"' @`"data"`, data has been received on the UART.
---@param number_or_endChar? any @(optional) number or end char
--- - **number** if n=0, will receive every char in buffer
--- - **number** if n<255, the callback is called when n chars are received
--- - **end_char** if one char "c", the callback will be called when "c" is encountered, or max n=255 received
---@param callback? function|' function(data) end' @(optional) function, event `"data"` has a callback like this: `function(data) end`
---@param run_input? integer @(optional) 0 or 1.
--- - **0** input from UART will not go into Lua interpreter, and this can accept binary data.
--- - **1** input from UART is treated as a text stream with the DEL, BS, CR and LF characters processed as normal. Completed lines will be passed to the Lua interpreter for execution.
---@return nil
function uart.on(method, number_or_endChar, callback, run_input) end

---(Re-)configures the communication parameters of the UART.
---@param id integer @UART id (0 or 1).
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400' @300 - 3686400
---@param databits integer|' 8'|' 7'|' 6'|' 5' @5 - 8
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN' @none |  even | odd
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2' @1 | 1.5 | 2
---@param echo? integer @(optional) 0 - disable echo, 1 - enable echo (default if omitted)
---@return number baudrate @configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo) end

---Returns the current configuration parameters of the UART.
---@param id integer @UART id (0 or 1).
---@return number baud @one of 300, ..., 3686400
---@return number databits @one of 5, 6, 7, 8
---@return number parity @uart.PARITY_NONE | uart.PARITY_ODD | uart.PARITY_EVEN
---@return number stopbits @uart.STOPBITS_1 | uart.STOPBITS_1_5 | uart.STOPBITS_2
function uart.getconfig(id) end

---Write string or byte to the UART.
---@param id integer @UART id (0 or 1).
---@param data1 string|number @... string or byte to send via UART
---@vararg string|number
---@return nil
function uart.write(id, data1, ...) end

---Report the depth, in bytes, of TX or RX hardware queues associated with the UART.
---@param id integer @UART id (0 or 1).
---@param direction integer|' uart.DIR_RX'|' uart.DIR_TX' @Rx | Tx
---@return integer @The number of bytes in the selected FIFO.
function uart.fifodepth(id, direction) end

--*** WEBSOCKET ***
websocket = {}

---@class websocket
local ws = {}

---Creates a new websocket client. This client should be stored in a variable\
---and will provide all the functions to handle a connection.\
---When the connection becomes closed, the same client can still be reused -\
---the callback functions are kept - and you can connect again to any server.\
---Before disposing the client, make sure to call `ws:close()`.
---@return websocket websocketclient
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
---@param params WsCfg @with configuration parameters.Following keys are recognized:
---**headers** - table of extra request headers affecting every request
---@return nil
function ws:config(params) end

---Attempts to establish a websocket connection to the given URL.
---@param url string @the URL for the websocket.
---@return nil @`nil`. If it fails, an error will be delivered via `websocket:on("close", handler)`.
function ws:connect(url) end

---Registers the callback function to handle websockets events\
---(there can be only one handler function registered per event type).
---@param eventName integer|'connection'|'receive'|'close' @the type of websocket event to register the callback function
---@param callback function|' funtion(ws, ...) end' @function. The function first parameter is always the **websocketclient**. Other arguments are required depending on the event type. If `nil`, any previously configured callback is unregistered.
---@return nil
function websocket:on(eventName, callback) end

---Sends a message through the websocket connection.
---@param message any @the data to send.
---@param opcode integer @optionally set the opcode (default: 1, text message)
---@return nil @'nil', or an error if socket is not connected
function websocket:send(message, opcode) end

--*** WIEGAND ***
wiegand = {}

---@class wiegand
local wiegandobj = {}

---Creates a dynamic wiegand object that receives a callback when data is received.
---@param pinD0 number @This is a GPIO number (excluding 0) and connects to the D0 data line
---@param pinD1 number @This is a GPIO number (excluding 0) and connects to the D1 data line
---@param callback function @This is a function that will invoked when a full card or keypress is read.
---@return wiegand wiegandObject @If the arguments are in error, or the operation cannot be completed, then an error is thrown.
function wiegand.create(pinD0, pinD1, callback) end

---Releases the resources\
---associated with the card reader.
---@return nil
function wiegandobj:close() end

--*** WIFI ***
wifi = {}

---Gets the current WiFi channel.
---@return integer @current WiFi channel
function wifi.getchannel() end

---Get the current country info.
---@return table @`country_info` this table contains the current country info configuration
---  - **country** Country code, 2 character string.
---  - **start_ch** Starting channel.
---  - **end_ch** Ending channel.
---  - **policy** The policy parameter determines which country info configuration to use, country info given to station by AP or local configuration.
---    - **0** - Country policy is auto, NodeMCU will use the country info provided by AP that the station is connected to.
---    - **1** - Country policy is manual, NodeMCU will use locally configured country info.
function wifi.getcountry() end

---Gets default WiFi operation mode.
---@return integer @**wifi.STATION, wifi.SOFTAP, wifi.STATIONAP** or **wifi.NULLMODE** constants.
function wifi.getdefaultmode() end

---Gets WiFi operation mode.
---@return integer @**wifi.STATION, wifi.SOFTAP, wifi.STATIONAP** or **wifi.NULLMODE** constants.
function wifi.getmode() end

---Gets WiFi physical mode.
---@return integer @**wifi.PHYMODE_B, wifi.PHYMODE_G** or **wifi.PHYMODE_N**.
function wifi.getphymode() end

---Configures whether or not WiFi automatically goes to sleep in *NULL_MODE*.\
---Enabled by default.
---@param enable? boolean @(optional) WiFi auto sleep in NULL_MODE
---|>'true' #Enable WiFi auto sleep in NULL_MODE.
---|'false' #Disable WiFi auto sleep in NULL_MODE.
---@return any @sleep_enabled Current/New *NULL_MODE* sleep setting.
--- - If `wifi.nullmodesleep()` is called with no arguments, current setting is returned.
--- - If `wifi.nullmodesleep()` is called with enable argument, confirmation of new setting is returned.
function wifi.nullmodesleep(enable) end

---Wake up WiFi from suspended state or cancel pending wifi suspension.
---@param resume_cb? function|'function() end' @(optional) Callback to execute when WiFi wakes from suspension. Any previously provided callbacks will be replaced!
---@return nil
function wifi.resume(resume_cb) end

---@class SetCountry
---@field country string
---@field start_ch integer
---@field end_ch integer
---@field policy integer

---Set the current country info.
---@param country_info SetCountry @This table contains the country info configuration. (If a blank table is passed to this function, default values will be configured.)
---  - **country** Country code, 2 character string containing the country code. (Default:"CN")
---  - **start_ch** Starting channel (range:1-14). (Default:1)
---  - **end_ch** Ending channel, must not be less than starting channel (range:1-14). (Default:13)
---  - **policy** The policy parameter determines which country info configuration to use, country info given to station by AP or local configuration. (default: *wifi.COUNTRY_AUTO*)
---    - wifi.COUNTRY_AUTO - Country policy is auto, NodeMCU will use the country info provided by AP that the station is connected to. While in stationAP mode, beacon/probe respose will reflect the country info of the AP that the station is connected to.
---    - wifi.COUNTRY_MANUAL - Country policy is manual, NodeMCU will use locally configured country info.
---@return boolean @`true` if configuration was sucessful.
function wifi.setcountry(country_info) end

---Configures the WiFi mode to use. NodeMCU can run in one of four WiFi modes.
---@param mode integer @Station | Access point (AP) | Station + AP | WiFi off
---|'wifi.STATION' #for when the device is connected to a WiFi router.
---|'wifi.SOFTAP'  #for when the device is acting only as an access point.
---|'wifi.STATIONAP' #is the combination of wifi.STATION and wifi.SOFTAP
---|'wifi.NULLMODE' #changing WiFi mode to NULL_MODE will put wifi into a low power state similar to MODEM_SLEEP, provided *wifi.nullmodesleep(false)* has not been called.
---@param save? boolean @(optional) choose whether or not to save wifi mode to flash
---|>' true' #WiFi mode configuration will be retained through power cycle.
---|' false' #WiFi mode configuration will not be retained through power cycle.
---@return integer @current mode after setup
function wifi.setmode(mode, save) end

---Sets WiFi physical mode.
---@param mode integer @b | g | n
---|'wifi.PHYMODE_B' #802.11b, more range, low Transfer rate, more current draw
---|'wifi.PHYMODE_G' #802.11g, medium range, medium transfer rate, medium current draw
---|'wifi.PHYMODE_N' #802.11n, least range, fast transfer rate, least current draw (STATION ONLY)
---@return integer @physical mode after setup
function wifi.setphymode(mode) end

---Sets WiFi maximum TX power.\
---The default value, 82, corresponds to maximum TX power.
---@param max_tpw number @maximum value of RF Tx Power, unit: 0.25 dBm, range [0, 82].
---@return nil
function wifi.setmaxtxpower(max_tpw) end

---Starts to auto configuration, if success set up SSID and password automatically.\
---Only usable in *wifi.STATION* mode.
---@param type integer @**0** for ESP_TOUCH, **1** for AIR_KISS
---@param callback function|' function() end' @a callback function of the form `function(ssid, password)` end which gets called after configuration.
---@return nil
function wifi.startsmart(type, callback) end

---Stops the smart configuring process.
---@return nil
function wifi.stopsmart() end

---@class SuspendCfg
---@field duration number
---@field suspend_cb function
---@field resume_cb function
---@field preserve_mode boolean

---Suspend Wifi to reduce current consumption.
---@param tbl SuspendCfg @>
--- - **duration** number Suspend duration in microseconds(μs).
--- - **suspend_cb?** function Callback to execute when WiFi is suspended.
--- - **resume_cb?** function Callback to execute when WiFi wakes from suspension.
--- - **preserve_mode?** boolean preserve current WiFi mode through node sleep.
---   - If `true`, Station and StationAP modes will automatically reconnect to previously configured Access Point when NodeMCU resumes.
---   - If `false`, discard WiFi mode and leave NodeMCU in *wifi.NULL_MODE*. WiFi mode will be restored to original mode on restart.
---@return integer suspend_state @>
--- - **suspend_state** if no parameters are provided, current WiFi suspension state will be returned. States:
---   - 0 - WiFi is awake.
---   - 1 - WiFi suspension is pending. (Waiting for idle task)
---   - 2 - WiFi is suspended.
function wifi.suspend(tbl) end

---Auto connects to AP in station mode.
---@param auto integer @**0** to disable auto connecting, **1** to enable auto connecting
---@return nil
function wifi.sta.autoconnect(auto) end

---Select Access Point from list returned by `wifi.sta.getapinfo()`
---@param ap_index integer @Index of Access Point you would like to change to. (Range:1-5)
---Corresponds to index used by `wifi.sta.getapinfo()` and `wifi.sta.getapindex()`
---@return boolean
function wifi.sta.changeap(ap_index) end

---Clears the currently saved\
---WiFi station configuration,\
---erasing it from the flash.
---@return boolean
function wifi.sta.clearconfig() end

---@class StaStationConfig
---@field ssid string
---@field pwd string
---@field auto boolean
---@field bssid string
---@field save boolean
---@field connect_cb function
---@field disconnect_cb function
---@field authmode_change_cb function
---@field got_ip_cb function
---@field dhcp_timeout_cb function

---Sets the WiFi station configuration.
---@param station_config StaStationConfig @table containing configuration data for station
--- - **ssid** string which is less than 32 bytes.
--- - **pwd** string which is 0-64. Empty string indicates an open WiFi access point.
--- - **auto**
---   - `true` (default) to enable auto connect and connect to access point, hence with auto=true there's no need to call `wifi.sta.connect()`
---   - `false` to disable auto connect and remain disconnected from access point
--- - **bssid** string that contains the MAC address of the access point (optional). The following formats are valid:
---   - "DE:C1:A5:51:F1:ED"
---   - "AC-1D-1C-B1-0B-22"
---   - "DE AD BE EF 7A C0"
--- - **save** Save station configuration to flash.
---   - `true` configuration will be retained through power cycle. (Default).
---   - `false` configuration will not be retained through power cycle.
--- - **Event callbacks** will only be available if WIFI_SDK_EVENT_MONITOR_ENABLE is uncommented in user_config.h:
---   - *connect_cb*: Callback to execute when station is connected to an access point. (Optional). Items returned in table:
---     - SSID: SSID of access point. (format: string)
---     - BSSID: BSSID of access point. (format: string)
---     - channel: The channel the access point is on. (format: number)
--- - *disconnect_cb*: Callback to execute when station is disconnected from an access point. (Optional) Items returned in table:
---   - SSID: SSID of access point. (format: string)
---   - BSSID: BSSID of access point. (format: string)
---   - reason: See wifi.eventmon.reason. (format: number)
--- - *authmode_change_cb*: Callback to execute when the access point has changed authorization mode. (Optional) Items returned in tabl:
---   - old_auth_mode: Old wifi authorization mode. (format: number)
---   - new_auth_mode: New wifi authorization mode. (format: number)
--- - *got_ip_cb*: Callback to execute when the station received an IP address from the access point. (Optional) Items returned in table:
---   - IP: The IP address assigned to the station. (format: string)
---   - netmask: Subnet mask. (format: string)
---   - gateway: The IP address of the access point the station is connected to. (format: string)
--- - *dhcp_timeout_cb*: Station DHCP request has timed out. (Optional)
---   - Blank table is returned.
---@return boolean
function wifi.sta.config(station_config) end

---Connects to the configured AP in station mode.\
---You only ever need to call this if auto-connect was disabled in `wifi.sta.config()`.
---@param connected_cb? function @(optional) Callback to execute when station is connected to an access point. Items returned in table:
--- - **SSID**: SSID of access point. (format: string)
--- - **BSSID**: BSSID of access point. (format: string)
--- - **channel**: The channel the access point is on. (format: number)
---@return nil
function wifi.sta.connect(connected_cb) end

---Disconnects from AP in station mode.
---@param disconnected_cb? function @(optional) Callback to execute when station is disconnected from an access point. Items returned in table:
--- - **SSID**: SSID of access point. (format: string)
--- - **BSSID**: BSSID of access point. (format: string)
--- - **reason**: See wifi.eventmon.reason. (format: number)
---@return nil
function wifi.sta.disconnect(disconnected_cb) end

---@class StaGetap
---@field ssid string
---@field bssid string
---@field channel integer
---@field show_hidden integer

---Scans AP list as a Lua table into callback function.
---@param cfg? StaGetap @(optional) table that contains scan configuration:
--- - **ssid** SSID == nil, don't filter SSID
--- - **bssid** BSSID == nil, don't filter BSSID
--- - **channel** channel == 0, scan all channels, otherwise scan set channel (default is 0)
--- - **show_hidden** show_hidden == 1, get info for router with hidden SSID (default is 0)
---@param format? integer @(optional) select output table format, defaults to 0
--- - **0** - old format (SSID : Authmode, RSSI, BSSID, Channel), any duplicate SSIDs will be discarded
--- - **1** - new format (BSSID : SSID, RSSI, auth mode, Channel)
---@param callback function @function to receive the AP table when the scan is done. This function receives a table, the key is the BSSID, the value is other info in format: **SSID, RSSID, auth mode, channel**.
---@return nil
function wifi.sta.getap(cfg, format, callback) end

---Get index of current Access Point stored in AP cache.
---@return integer current_index @index of currently selected Access Point. (Range:1-5)
function wifi.sta.getapindex() end

---Get information of APs cached by ESP8266 station.
---@return table @table `ap_info`:
--- - **qty** quantity of APs returned
--- - **1-5** index of AP. (the index corresponds to index used by `wifi.sta.changeap()` and `wifi.sta.getapindex()`)
--- - **ssid** ssid of Access Point
--- - **pwd** password for Access Point, nil if no password was configured
--- - **bssid** MAC address of Access Point. `nil` will be returned if no MAC address was configured during station configuration.
function wifi.sta.getapinfo() end

---Gets the broadcast address in station mode.
---@return string|nil @broadcast address as string, for example "192.168.0.255",
---returns `nil` if IP address = "0.0.0.0".
function wifi.sta.getbroadcast() end

---Gets the WiFi station configuration.
---@param return_table boolean @`true`: returns data in a table; `false`: returns data in the old format (default)
---@return table|string @>
--- - If `return_table` is true -> *config_table*:
---   - **ssid** ssid of Access Point.
---   - **pwd** password to Access Point, nil if no password was configured
---   - **bssid_set** will return true if the station was configured specifically to connect to the AP with the matching bssid.
---   - **bssid** If a connection has been made to the configured AP this field will contain the AP's MAC address. Otherwise "ff:ff:ff:ff:ff:ff" will be returned.
--- - If `return_table` is false:
---   - **ssid, password, bssid_set, bssid**, if bssid_set is equal to 0 then bssid is irrelevant
function wifi.sta.getconfig(return_table) end

---Gets the default WiFi station configuration stored in flash.
---@param return_table boolean @`true` returns data in a table; `false` returns data in the old format (default)
---@return table|string @>
--- - If `return_table` is true -> *config_table*:
---   - **ssid** - ssid of Access Point.
---   - **pwd** - password to Access Point, nil if no password was configured
---   - **bssid_set** - will return true if the station was configured specifically to connect to the AP with the matching bssid.
---   - **bssid** - If a connection has been made to the configured AP this field will contain the AP's MAC address. Otherwise "ff:ff:ff:ff:ff:ff" will be returned.
--- - If `return_table` is false:
---   - **ssid, password, bssid_set, bssid**, if bssid_set is equal to 0 then bssid is irrelevant
function wifi.sta.getdefaultconfig(return_table) end

---Gets current station hostname.
---@return string hostname @currently configured hostname
function wifi.sta.gethostname() end

---Gets IP address, netmask, and gateway address in station mode.
---@return string IP_address @as string, for example "192.168.0.111". Returns `nil` if IP = "0.0.0.0".
---@return string netmask
---@return string gateway_address Returns `nil` if IP = "0.0.0.0".
function wifi.sta.getip() end

---Gets MAC address in station mode.
---@return string MAC @address as string e.g. "18:fe:34:a2:d7:34"
function wifi.sta.getmac() end

---Get RSSI (Received Signal Strength Indicator)\
---of the Access Point which ESP8266 station connected to.
---@return number|nil @>
--- - If station is connected to an access point, `rssi` is returned.
--- - If station is not connected to an access point, `nil` is returned.
function wifi.sta.getrssi() end

---Set Maximum number of Access Points to store in flash.\
---This value is written to flash
---@param qty integer @Quantity of Access Points to store in flash.
---Range: 1-5 (Default: 1)
---@return boolean
function wifi.sta.setaplimit(qty) end

---Sets station hostname.
---@param hostname string @must only contain letters, numbers and hyphens('-')
---and be 32 characters or less with first and last character being alphanumeric.
---@return boolean
function wifi.sta.sethostname(hostname) end

---@class WifiCfgTbl
---@field ip string IP address
---@field netmask string netmask
---@field gateway string gateway

---Sets IP address, netmask, gateway address in station mode.
---@param cfg WifiCfgTbl @table contain IP address, netmask, and gateway
---```
---{    ip = "192.168.0.111",
---netmask = "255.255.255.0",
---gateway = "192.168.0.1" }
---```
---@return boolean
function wifi.sta.setip(cfg) end

---Sets MAC address in station mode.
---@param mac string @address in string e.g. "DE:AD:BE:EF:7A:C0"
---@return boolean
function wifi.sta.setmac(mac) end

---Configures the WiFi modem sleep type to be used while station is connected to an Access Point.\
---Does not apply to *wifi.SOFTAP*, *wifi.STATIONAP* or *wifi.NULLMODE*.
---@param type_wanted integer @none | light | modem sleep
---|'wifi.NONE_SLEEP' #to keep the modem on at all times
---|'wifi.LIGHT_SLEEP' #to allow the CPU to power down under some circumstances
---|'wifi.MODEM_SLEEP' #to power down the modem as much as possible
---@return number @The actual sleep mode set, as one of *wifi.NONE_SLEEP, wifi.LIGHT_SLEEP* or *wifi.MODEM_SLEEP*.
function wifi.sta.sleeptype(type_wanted) end

---Gets the current status in station mode.
---@return integer state @The current state which can be one of the following:
--- - wifi.STA_IDLE
--- - wifi.STA_CONNECTING
--- - wifi.STA_WRONGPWD
--- - wifi.STA_APNOTFOUND
--- - wifi.STA_FAIL
--- - wifi.STA_GOTIP
function wifi.sta.status() end

---@class APConfig
---@field ssid string
---@field pwd string
---@field auth integer
---@field channel integer
---@field hidden boolean
---@field max integer
---@field beacon integer
---@field save boolean

---Sets SSID and password in AP mode.
---@param cfg APConfig @table to hold configuration
--- - **ssid** - SSID chars 1-32
--- - **pwd** - password chars 8-64
--- - **auth** - authentication method, one of *wifi.OPEN* (default), *wifi.WPA_PSK, wifi.WPA2_PSK, wifi.WPA_WPA2_PSK*
--- - **channel** - channel number 1-14 default = 6
--- - **hidden** - false = not hidden, true = hidden, default = false
--- - **max** - maximum number of connections 1-4 default=4
--- - **beacon** - beacon interval time in range 100-60000, default = 100
--- - **save** - save configuration to flash.
---   - `true` - configuration will be retained through power cycle. (Default)
---   - `false` - configuration will not be retained through power cycle.
---Event callbacks will only be available if WIFI_SDK_EVENT_MONITOR_ENABLE is uncommented in user_config.h
--- - *staconnected_cb*: Callback executed when a new client has connected to the access point. (Optional). Items returned in table :
---   - MAC: MAC address of client that has connected.
---   - AID: SDK provides no details concerning this return value.
--- - *stadisconnected_cb*: Callback executed when a client has disconnected from the access point. (Optional). Items returned in table :
---   - MAC: MAC address of client that has disconnected.
---   - AID: SDK provides no details concerning this return value.
--- - *probereq_cb*: Callback executed when a probe request was received. (Optional). Items returned in table :
---   - MAC: MAC address of the client that is probing the access point.
---   - RSSI: Received Signal Strength Indicator of client.
---@return boolean
function wifi.ap.config(cfg) end

---Deauths (forcibly removes) a client from the ESP access point.
---@param MAC? string @(optional) MAC address of station to be deauthed.
---@return boolean @Returns `true` unless called while the ESP is in the STATION opmode
function wifi.ap.deauth(MAC) end

---Gets broadcast address in AP mode.
---@return string|nil @broadcast address in string,
---for example "192.168.0.255",\
---returns `nil` if IP address = "0.0.0.0".
function wifi.ap.getbroadcast() end

---Gets table of clients\
---connected to device in AP mode.
---@return table @table of connected clients
function wifi.ap.getclient() end

---Gets the current SoftAP configuration.
---@param return_table boolean @`true`: returns data in a table; `false`: returns data in the old format (default)
---@return table|string @>
--- - If `return_table` is `true` -> *config_table*
---   - **ssid** - Network name
---   - **pwd** - Password, nil if no password was configured
---   - **auth** - Authentication Method (wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK or wifi.WPA_WPA2_PSK)
---   - **channel** - Channel number
---   - **hidden** - `false` = not hidden, `true` = hidden
---   - **max** - Maximum number of client connections
---   - **beacon** - Beacon interval
--- - If `return_table` is `false`:
---   - **ssid, password**, if bssid_set is equal to 0 then bssid is irrelevant
function wifi.ap.getconfig(return_table) end

---Gets the default SoftAP configuration stored in flash.
---@param return_table boolean @`true`: returns data in a table; `false`: returns data in the old format (default)
---@return table|string @>
--- - If `return_table` is `true` -> *config_table*
---   - **ssid** - Network name
---   - **pwd** - Password, `nil` if no password was configured - auth Authentication Method (wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK or wifi.WPA_WPA2_PSK)
---   - **channel** - Channel number
---   - **hidden** - `false` = not hidden, `true` = hidden
---   - **max** - Maximum number of client connections
---   - **beacon** - Beacon interval
--- - If return_table is false:
---   - **ssid, password**, if bssid_set is equal to 0 then bssid is irrelevant
function wifi.ap.getdefaultconfig(return_table) end

---Gets IP address, netmask and gateway in AP mode.
---@return string @IP address, netmask, gateway address as string, for example "192.168.0.111", returns `nil` if IP address = "0.0.0.0".
function wifi.ap.getip() end

---Gets MAC address in AP mode.
---@return string @MAC address as string,
---for example "1A-33-44-FE-55-BB"
function wifi.ap.getmac() end

---Sets IP address, netmask and gateway address in AP mode.
---@param cfg WifiCfgTbl @table contain IP address, netmask, and gateway
---```
---{      ip = "192.168.1.1",
---  netmask = "255.255.255.0",
---  gateway = "192.168.1.1" }
---```
---@return boolean
function wifi.ap.setip(cfg) end

---Sets MAC address in AP mode.
---@param mac string @MAC address in byte string,
---for example "AC-1D-1C-B1-0B-22"
---@return boolean
function wifi.ap.setmac(mac) end

---Configure the dhcp service. Currently only supports setting\
---the start address of the dhcp address pool.
---@param dhcp_config table @table containing the start-IP of the DHCP address pool, eg. "192.168.1.100"
---@return string @pool_startip, pool_endip
function wifi.ap.dhcp.config(dhcp_config) end

---Starts the DHCP service.
---@return boolean @boolean indicating success
function wifi.ap.dhcp.start() end

---Stops the DHCP service.
---@return boolean @boolean indicating success
function wifi.ap.dhcp.stop() end

---Register callbacks for WiFi event monitor.
---@param Event integer|'wifi.eventmon.STA_CONNECTED'|'wifi.eventmon.STA_DISCONNECTED'|'wifi.eventmon.STA_AUTHMODE_CHANGE'|'wifi.eventmon.STA_GOT_IP'|'wifi.eventmon.STA_DHCP_TIMEOUT'|'wifi.eventmon.AP_STACONNECTED'|'wifi.eventmon.AP_STADISCONNECTED'|'wifi.eventmon.AP_PROBEREQRECVED' @WiFi event you would like to set a callback for.
---@param callback? function @(optional) function(T)
---@return nil
---Callback: T: Table returned by event.
--- - *wifi.eventmon.STA_CONNECTED* Station is connected to access point.
---   - **SSID**: SSID of access point.
---   - **BSSID**: BSSID of access point.
---   - **channel**: The channel the access point is on.
--- - *wifi.eventmon.STA_DISCONNECTED*: Station was disconnected from access point.
---   - **SSID**: SSID of access point.
---   - **BSSID**: BSSID of access point.
---   - **reason**: See wifi.eventmon.reason.
--- - *wifi.eventmon.STA_AUTHMODE_CHANGE*: Access point has changed authorization mode.
---   - **old_auth_mode**: Old wifi authorization mode.
---   - **new_auth_mode**: New wifi authorization mode.
--- - *wifi.eventmon.STA_GOT_IP*: Station got an IP address.
---   - **IP**: The IP address assigned to the station.
---   - **netmask**: Subnet mask.
---   - **gateway**: The IP address of the access point the station is connected to.
--- - *wifi.eventmon.STA_DHCP_TIMEOUT*: Station DHCP request has timed out.
---   - Blank table is returned.
--- - *wifi.eventmon.AP_STACONNECTED*: A new client has connected to the access point.
---   - **MAC**: MAC address of client that has connected.
---   - **AID**: SDK provides no details concerning this return value.
--- - *wifi.eventmon.AP_STADISCONNECTED*: A client has disconnected from the access point.
---   - **MAC**: MAC address of client that has disconnected.
---   - **AID**: SDK provides no details concerning this return value.
--- - *wifi.eventmon.AP_PROBEREQRECVED*: A probe request was received.
---   - **MAC**: MAC address of the client that is probing the access point.
---   - **RSSI**: Received Signal Strength Indicator of client.
--- - *wifi.eventmon.WIFI_MODE_CHANGE*: WiFi mode has changed.
---   - **old_auth_mode**: Old WiFi mode.
---   - **new_auth_mode**: New WiFi mode.
function wifi.eventmon.register(Event, callback) end

---Unregister callbacks for WiFi event monitor
---@param Event integer|'wifi.eventmon.STA_CONNECTED'|'wifi.eventmon.STA_DISCONNECTED'|'wifi.eventmon.STA_AUTHMODE_CHANGE'|'wifi.eventmon.STA_GOT_IP'|'wifi.eventmon.STA_DHCP_TIMEOUT'|'wifi.eventmon.AP_STACONNECTED'|'wifi.eventmon.AP_STADISCONNECTED'|'wifi.eventmon.AP_PROBEREQRECVED'|'wifi.eventmon.WIFI_MODE_CHANGED' @WiFi event you would like to set a callback for.
---@return nil
function wifi.eventmon.unregister(Event) end

--*** WiFi MONITOR TODO ***

---This registers a callback function to be called whenever a management frame is received.
---@param filter_parameters? number @(optional) This is a byte offset (1 based) into the underlying data structure, a value to match against, and an optional mask to use for matching.
---@param mgmt_frame_callback function @is a function which is invoked with a single argument which is a *wifi.packet* object which has many methods and attributes.
function wifi.monitor.start(filter_parameters, mgmt_frame_callback) end

---This disables the monitor mode and returns to normal operation.
function wifi.monitor.stop() end

---This sets the channel number to monitor.
---@param channel number @sets the channel number in the range 1 to 15.
function wifi.monitor.channel(channel) end

---wifi.packet object. This object provides access to the raw packet data and also many methods to extract data from the packet in a simple way.
local packet = {}

---This is like the string.byte method,\
---except that it gives access to the bytes of the radio header.
---@param n number @the byte number (1 based) to get from the radio header portion of the packet
---@return integer @0-255 as the value of the byte nothing if the offset is not within the radio header.
function packet:radio_byte(n) end

---This is like the string.byte method,\
---except that it gives access to the bytes of the received frame.
---@param n number @the byte number (1 based) to get from the received frame.
---@return integer @0-255 as the value of the byte nothing if the offset is not within the received frame.
function packet:frame_byte(n) end

---This is like the string.sub method,\
---except that it gives access to the bytes of the radio header.
---@param start any @Same rules as for string.sub except that it operates on the radio header.
---@param end_sub any
---@return string @A string according to the `string.sub` rules.
function packet:radio_sub(start, end_sub) end

---This is like the string.sub method,\
---except that it gives access to the bytes of the received frame.
---@param start any @Same rules as for string.sub except that it operates on the received frame.
---@param end_sub any
---@return string @A string according to the `string.sub` rules.
function packet:frame_sub(start, end_sub) end

---This is like the string.sub method, except that it gives access to the bytes of the radio header.\
---It also converts them into hex efficiently.
---@param start any @Same rules as for string.sub except that it operates on the radio header
---@param end_sub any
---@param seperator? string @is an optional sting which is placed between the individual hex pairs returned.
---@return string @A string according to the `string.sub` rules, converted into hex with possible inserted spacers.
function packet:radio_subhex(start, end_sub, seperator) end

---This is like the string.sub method, except that it gives access to the bytes of the received frame.
---@param start any @Same rules as for string.sub except that it operates on the received frame.
---@param end_sub any
---@param seperator? string @is an optional sting which is placed between the individual hex pairs returned.
---@return string @A string according to the `string.sub` rules, converted into hex with possible inserted spacers.
function packet:frame_subhex(start, end_sub, seperator) end

---This returns a table of the information elements\
---from the management frame. The table keys values\
---are the information element numbers (0 - 255).
---@return table @A table with all the information elements in it.
function packet:ie_table() end

--*** WPS ***
wps ={}

---Disable WiFi WPS function.
---@return nil
function wps.disable() end

---Enable WiFi WPS function.
---@return nil
function wps.enable() end

---Start WiFi WPS function. WPS must be enabled prior calling this function.
---@param callback? function @(optional) `function(status)` for when the WPS function ends.
---@return nil
function wps.start(callback) end

--*** WS2801 ***
ws2801 = {}

---Initializes the module and sets the pin configuration.
---@param pin_clk integer @pin for the clock. Supported are GPIO 0, 2, 4, 5.
---@param pin_data integer @pin for the data. Supported are GPIO 0, 2, 4, 5.
---@return nil
function ws2801.init(pin_clk, pin_data) end

---Sends a string of RGB Data in 24 bits to WS2801.
---@param str string @payload to be sent to one or more WS2801.
---@return nil
function ws2801.write(str) end

--*** WS2812 ***
ws2812 = {}

---@class ws2812
local buffer = {}

---Initialize UART1 and GPIO2, should be called once and before write().\
---Initialize UART0 (TXD0) too if ws2812.MODE_DUAL is set.
---@param mode? integer @(optional) single | dual
---|>'ws2812.MODE_SINGLE'
---|'ws2812.MODE_DUAL' #you will be able to handle two strips in parallel
---@return nil
function ws2812.init(mode) end

---Send data to one or two led strip using its native format which is generally Green,Red,Blue\
---for RGB strips and Green,Red,Blue,White for RGBW strips.
---@param data1 string|nil @payload to be sent to one or more WS2812 like leds through GPIO2
---@param data2? string|nil @(optional) payload to be sent to one or more WS2812 like leds through TXD0 (ws2812.MODE_DUAL mode required)
---@return nil
function ws2812.write(data1, data2) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer @length of the led strip
---@param bytesPerLed integer @3 for RGB strips and 4 for RGBW strips
---@return ws2812 ws2812.buffer
function ws2812.newBuffer(numberOfLeds, bytesPerLed) end

---Return the value at the given position
---@param index integer @position in the buffer (1 for first led)
---@return number @(color)
function buffer:get(index) end

---Set the value at the given position
---@param index integer @position in the buffer (1 for the first led)
---@param color number|any @payload of the color. Payload could be:
--- - **number, number, ...** you should pass as many arguments as bytesPerLed
--- - **table** should contains bytesPerLed numbers
--- - **string** should contains bytesPerLed bytes
---@return nil
function buffer:set(index, color) end

---Return the size of the buffer in number of leds
---@return integer
function buffer:size() end

---Fill the buffer with the given color. The number of given bytes\
---must match the number of bytesPerLed of the buffer
---@param color any @bytes of the color, you should pass as many arguments as bytesPerLed
---@return nil
function buffer:fill(color) end

---Returns the contents of the buffer\
---(the pixel values) as a string.
---@return string @A string containing the pixel values.
function buffer:dump() end

---Inserts a string (or a buffer) into another buffer with an offset.
---@param source string|any @the pixel values to be set into the buffer. This is either a string or a buffer.
---@param offset? integer @(optional) the offset where the source is to be placed in the buffer. Default is 1. Negative values can be used.
---@return nil
function buffer:replace(source, offset) end

---This is a general method that loads data into a buffer that is a linear combination of data from other buffers.
---@param factor1 number @This is the factor that the contents of buffer1 are multiplied by. This factor is scaled by a factor of 256. Thus factor1 value of 256 is a factor of 1.0.
---@param buffer1 any @This is the source buffer. It must be of the same shape as the destination buffer.
---@return nil
function buffer:mix(factor1, buffer1, ...) end

---Computes the total energy requirement for the buffer.
---@return integer @An integer which is the sum of all the pixel values.
function buffer:power() end

---Fade in or out. Defaults to out
---@param value number @value by which to divide or multiply each byte
---@param direction? integer|' ws2812.FADE_IN'|' ws2812.FADE_OUT' @(optional) Defaults to ws2812.FADE_OUT
---@return nil
function buffer:fade(value, direction) end

---Shift the content of (a piece of) the buffer in positive or negative direction.
---@param value number @number of pixels by which to rotate the buffer. Positive values rotate forwards, negative values backwards.
---@param mode? integer @(optional) is the shift mode to use.
---|>' ws2812.SHIFT_LOGICAL' #the freed pixels are set to 0 (off).
---|' ws2812.SHIFT_CIRCULAR' #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end
---@param i? integer @(optional) is the first offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is 1.
---@param j? integer @(optional) is the last offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is -1.
---@return nil
function buffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub.
---@param i integer @This is the start of the extracted data. Negative values can be used.
---@param j? integer @(optional) this is the end of the extracted data. Negative values can be used. The default is -1.
---@return ws2812 buff @A buffer containing the extracted piece.
function buffer:sub(i, j) end

--*** WS2812 EFFECTS ***
ws2812_effects = {}

---Initialize the effects library with the provided buffer\
---for the connected LED strip.
---@param buffer ws2812 @is a ws2812.buffer for the connected strip.
---@return nil
function ws2812_effects.init(buffer) end

---Start the animation effect.
---@return nil
function ws2812_effects.start() end

---Stop the animation effect.
---@return nil
function ws2812_effects.stop() end

---Set the brightness.
---@param brightness integer @brightness between 0 and 255
---@return nil
function ws2812_effects.set_brightness(brightness) end

---Set the color.
---@param g integer @is the green value between 0 and 255
---@param r integer @is the red value between 0 and 255
---@param b integer @is the blue value between 0 and 255
---@param w? integer @(optional) is the white value between 0 and 255
---@return nil
function ws2812_effects.set_color(g, r, b, w) end

---Set the speed.
---@param speed integer @speed between 0 and 255
---@return nil
function ws2812_effects.set_speed(speed) end

---Get current speed.
---@return integer speed @between 0 and 255
function ws2812_effects.get_speed() end

---Set the delay between two effect steps in milliseconds.
---@param delay number @is the delay in milliseconds, minimum 10ms
---@return nil
function ws2812_effects.set_delay(delay) end

---Get current delay.
---@return number delay @is the current effect delay in milliseconds
function ws2812_effects.get_delay() end

---Set the active effect mode.
---@param mode string|'"static"'|'"blink"'|'"gradient"'|'"gradient_rgb"'|'"random_color"'|'"rainbow"'|'"rainbow_cycle"'|'"flicker"'|'"fire"'|'"fire_soft"'|'"fire_intense"'|'"halloween"'|'"circus_combustus"'|'"larson_scanner"'|'"color_wipe"'|'"random_dot"'|'"cycle"' @is the effect mode as a string
---@param effect_param? integer|string @is an optional effect parameter.
---@return nil
function ws2812_effects.set_mode(mode, effect_param) end

--*** XPT2046 ***
xpt2046 = {}

---Initiates the XPT2046 module to read touch values from the display.
---@param cs_pin integer @GPIO pin for cs
---@param irq_pin integer @GPIO pin for irq
---@param height integer @display height in pixel
---@param width integer @display width in pixel
---@return nil
function xpt2046.init(cs_pin, irq_pin, height, width) end

---Sets the calibration of the display.
---@param x1 integer @raw x value at top left
---@param y1 integer @raw y value at top left
---@param x2 integer @raw x value at bottom right
---@param y2 integer @raw y value at bottom right
---@return nil
function xpt2046.setCalibration(x1, y1, x2, y2) end

---Checks if the touch panel is touched.
---@return boolean touch @`true` if the display is touched, else `false`
function xpt2046.isTouched() end

---Returns the position the display is touched\
---using the calibration values and given\
---width and height.
---@return integer posX
---@return integer posY
function xpt2046.getPosition() end

---reads the position three times and averages\
---the two positions with the least distance.
---@return integer posX
---@return integer posY
function xpt2046.getPositionAvg() end

---Reads the raw value from the display.
---@return integer rawX @position X as a raw value.
---@return integer rawY @position Y as a raw value.
function xpt2046.getRaw() end

--*** PIXBUF ***
pixbuf = {}

---@class pixbuffer
local pixbuffer = {}

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer @length of the led strip (in pixels)
---@param numberOfChannels integer @the channel count (bytes per pixel)
---@return pixbuffer @pixbuf.buffer object
function pixbuf.newBuffer(numberOfLeds, numberOfChannels) end

---Return the value at the given position,\
---in native strip color order.
---@param index integer @position in the buffer (1 for first led)
---@return number @(color)
function pixbuffer:get(index) end

---Set the value at the given position, in native strip color order.
---@param index integer @position in the buffer (1 for the first led)
---@param color number|any @payload of the color. Payload could be:
--- - **number, number, ...** passing as many colors as required by the array type
--- - **table** should contain one value per color required by the array type
--- - **string** with a natural multiple of the colors required by the array type. **string** inputs may be used to set multiple consecutive pixels!
---@return nil
function pixbuffer:set(index, color) end

---Return the size of the buffer in number of LEDs
---@return integer
function pixbuffer:size() end

---Return the buffer's channel count.
---@return integer
function pixbuffer:channels() end

---Fill the buffer with the given color.\
---The number of given bytes must match\
---the channel count of the buffer.
---@param color any @bytes for each channel
---@return nil
function pixbuffer:fill(color) end

---Returns the contents of the buffer\
---(the pixel values) as a string.\
---This can then be saved to a file or\
---sent over a network and\
---may be fed back to` pixbuf.buffer:set()`.
---@return string @A string containing the pixel values.
function pixbuffer:dump() end

---Inserts a string (or a pixbuf) into another buffer with an offset.\
---The buffer must be of the same type or an error will be thrown.
---@param source string|any @he pixel values to be set into the buffer. This is either a string or a pixbuf.
---@param offset? integer @(optional) the offset where the source is to be placed in the buffer. Default is 1. Negative values can be used.
---@return nil
function pixbuffer:replace(source, offset) end

---This is a general method that loads data into a buffer that is a linear combination of data from other buffers.
---@param factor1 number @This is the factor that the contents of buffer1 are multiplied by. This factor is scaled by a factor of 256. Thus factor1 value of 256 is a factor of 1.0.
---@param buffer1 any @This is the source buffer. It must be of the same shape as the destination buffer.
---@return nil
function pixbuffer:mix(factor1, buffer1, ...) end

---Like pixbuf.buffer:mix() but treats the first channel\
---as a scaling, 5-bit intensity value.\
---The buffers must all have four channels.
function pixbuffer:mix4I5() end

---Computes the total energy requirement for the buffer.
---@return integer @An integer which is the sum of all the pixel values.
function pixbuffer:power() end

---Like `pixbuf.buffer:power()`\
---but treats the first channel as\
---a scaling intensity value.
function pixbuffer:powerI() end

---Fade in or out. Defaults to out. Multiply or divide each byte of each led with/by the given value.
---@param value number @value by which to divide or multiply each byte
---@param direction? integer|' pixbuf.FADE_IN'|' pixbuf.FADE_OUT' @(optional) Defaults to pixbuf.FADE_OUT
---@return nil
function pixbuffer:fade(value, direction) end

---Like `pixbuf.buffer:fade()`\
---but treats the first channel as\
---a scaling intensity value.
function pixbuffer:fadeI() end

---Shift the content of (a piece of) the buffer in positive or negative direction. This allows simple animation effects.\
---A slice of the buffer can be specified by using the standard start and end offset Lua notation.\
---Negative values count backwards from the end of the buffer.
---@param value number @number of pixels by which to rotate the buffer. Positive values rotate forwards, negative values backwards.
---@param mode? integer @(optional) is the shift mode to use.
---|>' pixbuf.SHIFT_LOGICAL' #the freed pixels are set to 0 (off).
---|' pixbuf.SHIFT_CIRCULAR' #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end
---@param i? integer @(optional) is the first offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is 1.
---@param j? integer @(optional) is the last offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is -1.
---@return nil
function pixbuffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub.\
---The indexes are in leds and all the same rules apply.
---@param i integer @This is the start of the extracted data. Negative values can be used.
---@param j? integer @(optional) This is the end of the extracted data. Negative values can be used. The default is -1.
---@return pixbuffer @A buffer containing the extracted piece.
function pixbuffer:sub(i, j) end

---Map a function across each pixel of one, or zip a function along two, pixbuf(s), storing into the buffer on which it is called.
---@param f function @This is the mapping function; it is applied for each pixel to all channels of buffer1 and all channels of `buffer2`, if given. It must return a value for each channel of the output buffer, `buffer0`.
---@param buffer1? any @(optional) The first source buffer. Defaults to `buffer0`.
---@param start1? integer @(optional) This is the start of the mapped range of `buffer1`. Negative values can be used and will be interpreted as before the end of `buffer1`. The default is 1.
---@param end1? integer @(optional) This is the end of the mapped range. Negative values can be used. The default is -1 (i.e., the end of `buffer1`).
---@param buffer2? any @(optional) is a second buffer, for zip operations
---@param start2? integer @(optional) This is the start of the mapped range within `buffer2`. Negative values can be used and will be interpreted as before the end of `buffer2`. The default is 1.
---@return pixbuffer buffer0 @buffer0
function pixbuffer:map(f, buffer1, start1, end1, buffer2, start2) end
