--*** BH1750 ***
bh1750 = {}

---Initializes the module and sets up I²C with hardcoded device address.
---@param sda number @SDA pin number.
---@param scl number @SCL pin number.
---@return nil
function bh1750.init(sda, scl) end

---Reads lux value from the sensor.
---@return number Lux @value.
function bh1750.read() end

---Function used to return last read lux value.
---@return number @Last known lux value.
function bh1750.getlux() end

--*** DS18B20 ***
---@class ds18b20
---@field K string @Kelvin
---@field C string @Celsius
---@field F string @Fahrenheit
---@field sens table @A table with sensors present on the bus. It includes its address (8 bytes) and information whether the sensor is parasite-powered (9-th byte, 0 or 1).
---@field temp table @A table with readout values (also passed as a parameter to callback function). It is addressed by sensor addresses.
ds18b20 = {}

---Enables debug output of the module.
---@return nil
function ds18b20:enable_debug() end

---Scans the bus for DS18B20 sensors (optional), starts a readout (conversion) for all sensors and calls a callback function when all temperatures are available.
---@param callback function @that receives all results when all conversions finish. The callback function has one parameter - an array addressed by sensor addresses and a value of the temperature (string for integer version).
---@param pin integer @pin of the one-wire bus. If nil, GPIO0 (3) is used.
---@param unit string @unit can be Celsius ("C" or `ds18b20.C`), Kelvin ("K" or `ds18b20.K`) or Fahrenheit ("F" or `ds18b20.F`). If not specified (`nil`) latest used unit is used.
---@param force_search number @if not `nil` a bus search for devices is performed before readout. If `nil` the existing list of sensors in memory is used. If the bus has not been searched yet the search performed as well.
---@param save_search number @if not `nil` found sensors are saved to the file `ds18b20_save.lc`. When `read_temp` is called, list of sensors in memory is empty and file `ds18b20_save.lc` is present then sensor addresses are loaded from file - useful when running from batteries & deepsleep - immediate readout is performed (no bus scan).
---@return nil
function ds18b20:read_temp(callback, pin, unit, force_search, save_search) end

--*** DS3231 ***
ds3231 = {}

---Sets the current date and time.
---@param second number @00-59
---@param minute number @00-59
---@param hour number @00-23
---@param day number @1-7 (Sunday = 1, Saturday = 7)
---@param date number @01-31
---@param month number @01-12
---@param year number @00-99
---@param disableOscillator? integer @(optional) 0-1, defaults to 0 if omitted
---@return nil
function ds3231.setTime(second, minute, hour, day, date, month, year, disableOscillator) end

---Get the current date and time.
---@return integer second @00-59
---@return integer minute @00-59
---@return integer hour @00-23
---@return integer day @1-7 (Sunday = 1, Saturday = 7)
---@return integer date @01-31
---@return integer month @01-12
---@return integer year @00-99
function ds3231.getTime() end

---@alias ds3231_a1 integer
---|' ds3231.EVERYSECOND' #works only with alarm1 and triggers every second;
---|' ds3231.EVERYMINUTE' #works only with alarm2 and triggers every minute (at 00 seconds);
---|' ds3231.SECOND' #triggers when time match given seconds parameter;
---|' ds3231.MINUTE' #triggers when time match given seconds and minutes parameters;
---|' ds3231.HOUR' #triggers when time match given seconds, minutes, and hours parameters;
---|' ds3231.DAY' #triggers when time match given seconds, minutes, and hours on week day date/day parameters;
---|' ds3231.DATE' #triggers when time match given seconds, minutes, and hours on date (day of the month) date/day parameters;
---Set an alarm to be triggered on SQW pin
---@param alarmId integer @1-2
---@param alarmType ds3231_a1 @1-7
---@param seconds integer @00-59
---@param minutes integer @00-59
---@param hours integer @00-23
---@param date_or_day integer @01-31 or 1-7 (Sunday = 1, Saturday = 7)
---@return nil
function ds3231.setAlarm(alarmId, alarmType, seconds, minutes, hours, date_or_day) end

---Reload an already triggered alarm.
---@return nil
function ds3231.reloadAlarms() end

---Enable an already setted alarm with the previous matching conditions.
---@param alarmId integer @1-2
---@return nil
function ds3231.enableAlarm(alarmId) end

---Disable an already set alarm with the previous matching conditions.
---@param alarmId integer @0-2
---@return nil
function ds3231.disableAlarm(alarmId) end

---Get bytes of control, for debug purpose,\
---and status of DS3231.
---@return integer control @0-255
---@return integer status @0-143 (bit 6-5-4 unused)
function ds3231.getBytes() end

---@return nil
function ds3231.resetStopFlag() end

--*** FTP server ***
FTP = {}

---Create the FTP server on the standard ports 20 and 21.\
---The global variable FTP is set to the server object.
---@param user string @Username for access to the server
---@param pass string @Password for access to the server
---@param dbgFlag? boolean @optional flag. If set `true` then internal debug output is printed
---@return nil
function FTP:createServer(user, pass, dbgFlag) end

---Wrapper to `createServer()` which also connects to the WiFi channel.
---@param user string @Username for access to the server
---@param pass string @Password for access to the server
---@param ssid string @SSID for WiFi service
---@param wifipwd string @password for WiFi service
---@param dbgFlag? boolean @optional flag. If set `true` then internal debug output is printed
---@return nil
function FTP:open(user, pass, ssid, wifipwd, dbgFlag) end

---Close down server including any sockets\
---and return all resources to Lua.
---@return nil
function FTP:close() end

--*** HDC1000 ***
---@class hdc1000
local HDC1000 = require('HDC1000')

---Function to setup the HDC1000 sensor.
---@param drdyn number @DRDYn pin number.
---@return nil
function HDC1000.setup(drdyn) end

---Function to configure various options of HDC1000 sensor.
---@param address number @I²C sensor address. Default value is 0x40.
---@param resolution number @Temperature and humidity sensor resolution.
---@param heater number @Heater setting. 0x20 to enable and 0x00 to disable.
---@return nil
function HDC1000.config(address, resolution, heater) end

---Reads the temperature from HDC1000 sensor.
---@return number Temperature @in Celsius degrees.
function HDC1000.getTemp() end

---Reads the humidity value from HDC1000 sensor.
---@return number Humidity @in percents.
function HDC1000.getHumi() end

---Function that checks if voltage of sensor power supply\
---is bellow or above 2.8V.
---@return boolean @`true` if battery voltage is bellow 2.8V, `false` otherwise.
function HDC1000.batteryDead() end

--*** HTTP server ***
httpserver = {}

---Function to start HTTP server.
---@param port integer @Port number for HTTP server. Most HTTP servers listen at port 80.
---@param handler function @cb for when HTTP request was made. handler(req, res)
---@return any @net.server sub module.
function httpserver.createServer(port, handler) end

--*** IMAP ***
imap = {}

---Function used to check if IMAP command was processed.
---@return boolean @The response process status of the last IMAP command sent.
function imap.response_processed() end

---Initiates the IMAP settings.
---@param username string @IMAP username. For most e-mail providers e-mail address is used as username.
---@param password string @IMAP password.
---@param tag any @IMAP tag. With current implementation any tag like "t1" should work.
---@param dbug? boolean @(optional) if set to true entire conversation between the ESP8266 and IMAP server will be shown. Default setting is false.
---@return nil
function imap.config(username, password, tag, dbug) end

---Logs into a new email session.
---@param socket any @IMAP TCP socket object created using net.createConnection
---@return nil
function imap.login(socket) end

---Function to check the most recent email number.\
---Should only be called after examine function.
---@return number @The most recent email number.
function imap.get_most_recent_num() end

---IMAP examines the given mailbox/folder. Sends the IMAP EXAMINE command.
---@param socket any @IMAP TCP socket object created using net.createConnection
---@param mailbox string @E-mail folder name to examine like example "INBOX"
---@return nil
function imap.examine(socket, mailbox) end

---Function that gets the last fetched header field.
---@return string @The last fetched header field.
function imap.get_header() end

---Fetches an e-mails header field e.g. SUBJECT, FROM, DATE.
---@param socket any @IMAP TCP socket object created using net.createConnection
---@param msg_number number @The email number to read e.g. 1 will read fetch the latest/newest email
---@param field string @A header field such as SUBJECT, FROM, or DATE
---@return nil
function imap.fetch_header(socket, msg_number, field) end

---Function to get the last email read's body.
---@return any @The last email read's body.
function imap.get_body() end

---Sends the IMAP command to fetch a plain text version of the email's body.
---@param socket any @IMAP TCP socket object created using `net.createConnection`
---@param msg_number number @The email number to obtain e.g. **1** will obtain the latest email.
---@return nil
function imap.fetch_body_plain_text(socket, msg_number) end

---Sends the IMAP command to logout of the email session.
---@param socket any @IMAP TCP socket object created using `net.createConnection`
---@return nil
function imap.logout(socket) end

--*** LM92 ***
lm92 ={}

---Function used to setup the address for lm92.
---@param address number @I²C address used by LM92.
---@return nil
function lm92.setup(address) end

---Returns the temperature register's content.
---@return number Temperature @in degree Celsius.
function lm92.getTemperature() end

---Makes the chip enter the low power shutdown mode.
---@return nil
function lm92.shutdown() end

---Makes the chip exit the low power shutdown mode.
---@return nil
function lm92.wakeup() end

---Set hysteresis Temperature.
---@param htemp number @Hysteresis temperature from 130 to -55 in ºC
---@return nil
function lm92.setThyst(htemp) end

---Set Critical Temperature.
---@param ctemp number @Critical temperature from 130 to -55 in ºC
---@return nil
function lm92.setTcrit(ctemp) end

---Set Low Window Temperature.
---@param lwtemp number @Low window temperature from 130 to -55 in ºC
---@return nil
function lm92.setTlow(lwtemp) end

---Set High Window Temperature.
---@param hwtemp number @High window temperature from 130 to -55 in ºC
---@return nil
function lm92.setThigh(hwtemp) end

---Get hysteresis Temperature.
---@return number @Hysteresis Temperature in degree Celsius.
function lm92.getThyst() end

---Get Critical Temperature.
---@return number @Critical Temperature in degree Celsius.
function lm92.getTcrit() end

---Get Low Window Temperature.
---@return number @Low Window Temperature in degree Celsius.
function lm92.getTlow() end

---Get High Window Temperature.
---@return number @High Window Temperature in degree Celsius.
function lm92.getThigh() end

--*** MCP23008 ***
mcp23008 = {}

---Sets the MCP23008 device address's last three bits.
---@param address number @The 3 least significant bits (LSB) of the address
---@param pinSDA number @The pin to use for SDA
---@param pinSCL number @The pin to use for SCL
---@param speed number @The speed of the I2C signal
---@return nil
function mcp23008.begin(address, pinSDA, pinSCL, speed) end

---Writes a byte of data to the GPIO register.
---@param dataByte number @The byte of data to write
---@return nil
function mcp23008.writeGPIO(dataByte) end

---Reads a byte of data from the GPIO register
---@return number @One byte of data
function mcp23008.readGPIO() end

---Writes one byte of data to the IODIR register.
---@param dataByte number @The byte of data to write
---@return nil
function mcp23008.writeIODIR(dataByte) end

---Writes one byte of data to the IODIR register.
---@return number @The byte of data in IODIR
function mcp23008.readIODIR() end

---Writes a byte of data to the GPPU (Pull-UP resistors register)
---@param dataByte number @the value to write to the GPPU register. Each bit in this byte is assigned to an individual GPIO pin
---@return nil
function mcp23008.writeGPPU(dataByte) end

---Reads the GPPU (Pull-UP resistors register) byte
---@return number @The GPPU byte i.e. state of all internal pull-up resistors
function mcp23008.readGPPU() end

--*** MCP23017 ***
---@class mcp23017
---@field INPUT boolean
---@field OUTPUT boolean
---@field GPA boolean
---@field GPB boolean
---@field HIGH boolean
---@field LOW boolean
local mcp17 = {}

---Configures the address of the module and tests the connection to the i2c bus.
---@param address number @address for MCP23017, default: 0x20 (should be between 0x20 and 0x27)
---@param i2c_id number @id for the i2c bus connection (remember to call i2c.setup before)
---@return boolean @`true` if device found, otherwise `false`.
---@return mcp23017 @instance for mcp23017
function mcp23017(address, i2c_id) end

---Set the mode of a single channel. This can be OUTPUT or INPUT.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@param mode number @the mode for the channel. This can be mcp23017.INPUT or mcp23017.OUTPUT
---@return boolean @`true`, in case of error `nil`.
function mcp17:setMode(register, pin, mode) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@param state number @the state for the channel. This can be mcp23017.HIGH or mcp23017.LOW
---@return boolean @`true`, in case of error `nil`.
function mcp17:setPin(register, pin, state) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number @the side of channels (GPA or GPB)
---@param pin number @the number to be set for the channel (0-15)
---@return boolean @`true` for HIGH, `false` for LOW, in case of error `nil`.
function mcp17:getPinState(register, pin) end

---By calling this function, a safe state is established.\
---All channels are set to input.
function mcp17:reset() end

---Enable or disable the internal pullup resistors.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the pullup resistors
function mcp17:setInternalPullUp(register, byte) end

---Setup the mode of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the mode for all channels for this register
function mcp17:writeIODIR(register, byte) end

---Setup the output state of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@param byte number @byte to set the state for all channels for this register
function mcp17:writeGPIO(register, byte) end

---Read the input states of the channels with a whole byte.
---@param register number @the side of channels (GPA or GPB)
---@return number @byte with states
function mcp17:readGPIO(register) end

--*** REDIS ***
redis = {}

---@class redis
local rds = {}

---Function used to connect to Redis server.
---@param host string @Redis host name or address
---@param port integer @Redis database port. Default value is 6379.
---@return redis rdsObj @Object with rest of the functions.
function redis.connect(host, port) end

---Subscribe to a Redis channel.
---@param channel any @Channel name
---@param handler function @Handler function that will be called on new message in subscribed channel
---@return nil
function rds:subscribe(channel, handler) end

---Publish a message to a Redis channel.
---@param channel any @Channel name
---@param message any @Message to publish
---@return nil
function rds:publish(channel, message) end

---Unsubscribes from a channel.
---@param channel any @Channel name to unsubscribe from
---@return nil
function rds:unsubscribe(channel) end

---Function to close connection to Redis server.
---@return nil
function rds:close() end

--*** Telnet server ***
---@class telnet
local TELNET = require('telnet')

---Open a telnet server based on the provided parameters.
---@param ssid string|'""'
---@param pwd string|' ""'
---@param port integer|' 2323'
---@return nil
function TELNET:open(ssid, pwd, port) end

---Close a telnet server and release all resources.
---@return nil
function TELNET:close() end

--*** YEELINK ***
yeelink = {}

---Initializes Yeelink client.
---@param device number
---@param sensor number
---@param apikey string
---@return string @IP address of api.yeelink.net, if not obtained then false
function yeelink.init(device, sensor, apikey) end

---Function to check DNS resolution\
---of api.yeelink.net status.
---@return string @IP address of api.yeelink.net
---or `nil` when name resolution failed.
function yeelink.getDNS() end

---Send data to Yeelink Sever.
---@param datapoint any @Data to send to Yeelink API
---@return nil
function yeelink.update(datapoint) end

--*** ADC ***
adc = {}

---Checks and if necessary reconfigures the ADC `mode` setting in the ESP init data block.
---@param mode_value integer|'adc.INIT_ADC'|'adc.INIT_VDD33' @mode
---@return boolean @`true` if the function had to change the mode, `false` if the mode was already configured.
function adc.force_init_mode(mode_value) end

---Samples the ADC.
---@param channel integer|'0' @always 0 on the ESP8266
---@return number @the sampled value
function adc.read(channel) end

---Reads the system voltage.
---@return number @system voltage in millivolts
function adc.readvdd33() end

--*** ADS1115 ***
ads1115 ={}

---@class ads1115
local ads1x15

---Registers ADS1115 (ADS1113, ADS1114) device.
---@param I2C_ID number @always 0
---@param I2C_ADDR number|' ads1115.ADDR_GND'|' ads1115.ADDR_VDD'|' ads1115.ADDR_SDA'|' ads1115.ADDR_SCL' @I²C address of a device
---@return ads1115 obj @Registered device object
function ads1115.ads1115(I2C_ID, I2C_ADDR) end

---Registers ADS1015 (ADS1013, ADS1014) device.
---@param I2C_ID number @always 0
---@param I2C_ADDR number|' ads1115.ADDR_GND'|' ads1115.ADDR_VDD'|' ads1115.ADDR_SDA'|' ads1115.ADDR_SCL' @I²C address of a device
---@return ads1115 obj @Registered device object
function ads1115.ads1015(I2C_ID, I2C_ADDR) end

---Reset all devices connected to I²C interface.
---@return nil
function ads1115.reset() end

---Gets the result stored in the register of\
---a previously issued conversion, e.g. in continuous\
---mode or with a conversion ready interrupt.
---@return number volt @voltage in mV
---@return number volt_dec @voltage decimal in uV
---@return number adc @raw adc register value
---@return number|nil sign @sign of the result
function ads1x15:read() end

---Configuration settings for the ADC.
---@param GAIN number @Programmable gain amplifier
---|'ads1115.GAIN_6_144V' #2/3x Gain
---|'ads1115.GAIN_4_096V' #1x Gain
---|'ads1115.GAIN_2_048V' #2x Gain
---|'ads1115.GAIN_1_024V' #4x Gain
---|'ads1115.GAIN_0_512V' #8x Gain
---|'ads1115.GAIN_0_256V' #16x Gain
---@param SAMPLES number @Data rate in samples per second
---|' ads1115.DR_8SPS' #ADS1115 only
---|' ads1115.DR_16SPS' #ADS1115 only
---|' ads1115.DR_32SPS' #ADS1115 only
---|' ads1115.DR_64SPS' #ADS1115 only
---|' ads1115.DR_128SPS'
---|' ads1115.DR_250SPS'
---|' ads1115.DR_475SPS' #ADS1115 only
---|' ads1115.DR_490SPS' #ADS1015 only
---|' ads1115.DR_860SPS' #ADS1115 only
---|' ads1115.DR_920SPS' #ADS1015 only
---|' ads1115.DR_1600SPS' #ADS1015 only
---|' ads1115.DR_2400SPS' #ADS1015 only
---|' ads1115.DR_3300SPS' #ADS1015 only
---@param CHANNEL number @Input multiplexer for single-ended or differential measurement
---|' ads1115.SINGLE_0' #channel 0 to GND
---|' ads1115.SINGLE_1' #channel 1 to GND
---|' ads1115.SINGLE_2' #channel 2 to GND
---|' ads1115.SINGLE_3' #channel 3 to GND
---|' ads1115.DIFF_0_1' #channel 0 to 1
---|' ads1115.DIFF_0_3' #channel 0 to 3
---|' ads1115.DIFF_1_3' #channel 1 to 3
---|' ads1115.DIFF_2_3' #channel 2 to 3
---@param MODE number @Device operating mode
---|' ads1115.SINGLE_SHOT' #single-shot mode
---|' ads1115.CONTINUOUS' #continuous mode
---@param CONVERSION_RDY? number|' ads1115.CONV_RDY_1'|' ads1115.CONV_RDY_2'|' ads1115.CONV_RDY_4' @(optional) Number of conversions after conversion ready asserts
---@param COMPARATOR? number|' ads1115.COMP_1CONV'|' ads1115.COMP_2CONV'|' ads1115.COMP_4CONV' @(optional) Number of conversions after comparator asserts
---@param THRESHOLD_LOW number @>
--- - **0** - **+ GAIN_MAX** in mV for single-ended inputs
--- - **- GAIN_MAX** - **+ GAIN_MAX** in mV for differential inputs
---@param THRESHOLD_HI number @>
--- - **0** - **+ GAIN_MAX** in mV for single-ended inputs
--- - **- GAIN_MAX** - **+ GAIN_MAX** in mV for differential inputs
---@param COMP_MODE? number @(optional) Comparator mode
---|' ads1115.CMODE_TRAD' #traditional comparator mode (with hysteresis)
---|' ads1115.CMODE_WINDOW' #window comparator mode
---@return nil
function ads1x15:setting(GAIN, SAMPLES, CHANNEL, MODE, CONVERSION_RDY, COMPARATOR, THRESHOLD_LOW, THRESHOLD_HI,COMP_MODE) end

---Starts the ADC reading for single-shot mode and after the conversion is done it will invoke\
---an optional callback function in which the ADC conversion result can be obtained.
---@param callback function|'function(volt, volt_dec, adc, sign) end' @function which will be invoked after the adc conversion is done
---@return nil
function ads1x15:startread(callback) end

--*** ADXL345 ***
adxl345 = {}

---Samples the sensor and returns\
---X,Y and Z data from the accelerometer.
---@return integer x @data
---@return integer y @data
---@return integer z @data
function adxl345.read() end

---Initializes the module.
---@return nil
function adxl345.setup() end

--*** AM2320 ***
am2320 = {}

---Samples the sensor and returns the relative humidity in %\
---and temperature in celsius, as an integer multiplied with 10.
---@return integer RH @relative humidity percentage multiplied with 10
---@return integer T @temperature in celcius multiplied with 10
function am2320.read() end

---Initializes the module.
---@return number model @16 bits number of model
---@return number version @8 bits version number
---@return number serial @32 bits serial number
function am2320.setup() end

--*** APA102 ***
apa102 = {}

---Send ABGR data in 8 bits to a APA102 chain.
---@param data_pin integer @any GPIO pin 0, 1, 2, ...
---@param clock_pin integer @any GPIO pin 0, 1, 2, ...
---@param str string @payload to be sent to one or more APA102 LEDs.
---It should be composed from a ABGR quadruplet per element.
--- - A1 - the first pixel's Intensity channel (0-31)
--- - B1 - the first pixel's Blue channel (0-255)
--- - G1 - the first pixel's Green channel (0-255)
--- - R1 - the first pixel's Red channel (0-255) ... You can connect a lot of APA102 ...\
---A2, B2, G2, R2 are the next APA102s Intensity,\
---Blue, Green and Red channel parameters
---@return nil
function apa102.write(data_pin, clock_pin, str) end

--*** BIT ***
bit = {}

---Arithmetic right shift a number equivalent to `value >> shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted right (arithmetically)
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1 & val2 & ... & valn` in C.
---@param val1 integer @first *AND* argument
---@param val2 integer @second *AND* argument
---@vararg integer
---@return integer @the bitwise *AND* of all the arguments
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation).\
---Equivalent to `1 << position` in C.
---@param position number @position of the bit that will be set to 1
---@return number @a number with only one 1 bit at position (the rest are set to 0)
function bit.bit(position) end

---Bitwise negation, equivalent to `~value` in C.
---@param value number @the number to negate
---@return number @the bitwise negated value of the number
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1 | val2 | ... | valn` in C.
---@param val1 integer @first *OR* argument.
---@param val2 integer @second *OR* argument.
---@vararg integer
---@return integer @the bitwise *OR* of all the arguments
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1 ^ val2 ^ ... ^ valn` in C.
---@param val1 integer @first *XOR* argument
---@param val2 integer @second *XOR* argument
---@vararg integer
---@return integer @the bitwise *XOR* of all the arguments
function bit.xor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer @the base number
---@param pos1 integer @position of the first bit to clear
---@vararg integer
---@return integer @the number with the bit(s) cleared in the given position(s)
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 0, `false` otherwise
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value number @the value to test
---@param position integer @bit position to test
---@return boolean @`true` if the bit at the given position is 1, `false` otherwise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value << shift` in C.
---@param value integer @the value to shift
---@param shift integer @positions to shift
---@return integer @the number shifted left
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to\
---`( unsigned )value >> shift` in C.
---@param value integer @the value to shift.
---@param shift integer @positions to shift.
---@return integer @the number shifted right (logically)
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer @the base number.
---@param pos1 integer @position of the first bit to set.
---@vararg integer
---@return integer @the number with the bit(s) set in the given position(s)
function bit.set(value, pos1, ...) end

--*** BLOOM ***
bloom = {}

---@class bloom
local filter = {}

---Create a filter object.
---@param elements number @The largest number of elements to be added to the filter.
---@param errorrate number @The error rate (the false positive rate).
---@return bloom objfilter @A filter object.
function bloom.create(elements, errorrate) end

---Adds a string to the set and returns an indication of whether\
---the string was already present.
---@param str string @The string to be added to the filter set.
---@return boolean @`true` if the string was already present in the filter. `false` otherwise.
function filter:add(str) end

---Checks to see if a string is present in the filter set.
---@param str string @The string to be checked for membership in the set.
---@return boolean @`true` if the string was already present in the filter. `false` otherwise.
function filter:check(str) end

---Empties the filter.
function filter:reset() end

---Get some status information on the filter.
---@return number @The number of bits in the filter.
---@return number @The number of hash functions in use.
---@return number @The number of bits set in the filter.
---@return number @The approximate chance that the next check
---will return true when it should return false
function filter:info() end

--*** BME280 C module ***

---For given air pressure and sea level air pressure returns the altitude\
---in meters as an integer multiplied with 100, i.e. altimeter function.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
function bme280.altitude(P, QNH) end

---Reads the sensor and returns the air pressure in hectopascals as an integer multiplied with 1000\
---or nil when readout is not successful. Current temperature is needed to calculate the air pressure\
---so temperature reading is performed prior reading pressure data.\
---Second returned variable is therefore current air temperature.
---@return number P @air pressure in hectopascals multiplied by 1000
---@return number T @temperature in celsius as an integer multiplied with 100
function bme280.baro() end

---For given temperature and relative humidity returns the dew point\
---in celsius as an integer multiplied with 100.
---@param H number @relative humidity in percent multiplied by 1000.
---@param T number @temperate in celsius multiplied by 100.
---@return number dewpoint @dew point in celsisus
function bme280.dewpoint(H, T) end

---Reads the sensor and returns the air relative humidity in percents as an integer multiplied with 100\
---or `nil` when readout is not successful. Current temperature is needed to calculate the relative humidity\
---so temperature reading is performed prior reading pressure data.\
---Second returned variable is therefore current temperature.
---@return number H @last relative humidity reading in % times 1000
---@return number T @temperature in celsius as an integer multiplied with 100
function bme280.humi() end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
function bme280.qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity and
---@param altitude? number @(optional) altitude in meters of measurement point. If provided also the air pressure converted to sea level air pressure is returned.
---@return number T @temperature in celsius as an integer multiplied with 100
---@return number P @air pressure in hectopascals multiplied by 1000
---@return number H @relative humidity in percent multiplied by 1000
---@return number QNH @air pressure in hectopascals multiplied by 1000 converted to sea level
function bme280.read(altitude) end

---Starts readout (turns the sensor into forced mode). After the readout the sensor turns to sleep mode.
---@param delay number @sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds.
---@param callback function @if provided it will be invoked after given delay. The sensor reading should be finalized by then so.
---@return nil
function bme280.startreadout(delay, callback) end

---@deprecated
---Warning, deprecated API! bme280. It will be removed soon. Use bme280math and bme280 Lua module instead.\
---Initializes the module. Initialization is mandatory before reading values.
---@param temp_oss? number @(optional) Controls oversampling of temperature data.
---@param press_oss? number @(optional) Controls oversampling of pressure data.
---@param humi_oss? number @(optional) Controls oversampling of humidity data.
---@param power_mode? number @(optional) Controls the sensor mode of the device.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter.
---@return integer|nil @`nil` if initialization has failed (no sensor connected?), **2** if sensor is BME280, **1** if sensor is BMP280
function bme280.setup(temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---Reads the sensor and returns the temperature in celsius as an integer multiplied with 100.
---@return integer T @temperature in celsius as an integer multiplied with 100 or nil when readout is not successful
---@return integer t_fine @temperature measure used in pressure and humidity compensation formulas (generally no need to use this value)
function bme280.temp() end

--*** BME280 Lua module ***
bme280 = {}

---@class bme280
local sobj = {}

---Creates bme280sensor object and initializes the module. Initialization is mandatory before reading values.\
---Note that there has to be a delay between some tens to hundreds of milliseconds between calling `setup()` and reading measurements.
---@param id number @I2C bus number
---@param address? number @(optional) BME280 sensor address. **1** for BME280_I2C_ADDRESS1 = 0x76, **2** for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@param cold_start? number @(optional) If **0** then the BME280 chip is not initialised.
---@return bme280 @BME280 Sensor Object (`nil` if initialization has failed)
function bme280.setup(id, address, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter, cold_start) end

---Re-initializes the sensor.
---@param id number @I2C bus number
---@param address? number @(optional) BME280 sensor address. **1** for BME280_I2C_ADDRESS1 = 0x76, **2** for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@param cold_start? number @(optional) If **0** then the BME280 chip is not initialised.
---@return bme280 @BME280 Sensor Object (`nil` if initialization has failed)
function sobj:setup(id, address, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter, cold_start) end

---For given air pressure (called QFE in aviation) and sea level air pressure\
---returns the altitude in meters, i.e. altimeter function.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
function sobj:altitude(P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param H number @relative humidity in percent (100 means 100%)
---@param T number @temperate in celsius
---@return number dewpoint @dew point in celsisus
function sobj:dewpoint(H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
function sobj:qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure,\
---the air relative humidity and see level pressure when `altitude` is specified.
---@param altitude? number @(optional) altitude in meters of measurement point. If provided also the air pressure converted to sea level air pressure is returned.
---@return number T @temperature in celsius
---@return number P @air pressure in hectopascals
---@return number H @relative humidity in percent
---@return number QNH @(optional) QNH air pressure in hectopascals (when `altitude` is specified)
--- Returns `nil` if the readout is not successful.
function sobj:read(altitude) end

---Starts readout (turns the sensor into forced mode). After the readout the sensor turns to sleep mode.\
---Callback function is called with readout results.
---@param callback? function @(optional) if provided it will be invoked after given delay. Callback parameters are:
--- - T - temperature in celsius (number)
--- - P - air pressure in hectopascals (number)
--- - H - relative humidity in percent (number)
---@param delay? number @(optional) sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds. For **0** the default delay is set to 113ms.
---@param altitude number @in meters of measurement point (QNH is returned when specified)
---@return nil
function sobj:startreadout(callback, delay, altitude) end

--*** BME280_MATH ***
bme280_math = {}

---For given air pressure and sea level air pressure returns the altitude in meters
---@param self? userdata|table @(optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
function bme280_math.altitude(self, P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param self? userdata|table @(optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param H number @relative humidity in percent (100 means 100%)
---@param T number @temperate in celsius
---@return number dewpoint @dew point in celsisus
function bme280_math.dewpoint(self, H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param self? userdata|table @(optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param P number @measured pressure
---@param altitude number @in meters of measurement point
---@return number P @sea level pressure
function bme280_math.qfe2qnh(self, P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity\
---and see level air pressure when **altitude** is specified.
---@param bme280sensor userdata @BME280 sensor user data returned by `bme280_math.setup()`
---@param registers string @string of 8 bytes (chars) registers read from BME280_REGISTER_PRESS
---@param altitude? number @(optional) in meters of measurement point. If provided also the air pressure converted to sea level air pressure is returned.
---@return number T @temperature in celsius
---@return number P @air pressure in hectopascals
---@return number H @relative humidity in percent
---@return number QNH @(optional) air pressure in hectopascals. Returns `nil` if the conversion is not successful.
function bme280_math.read(bme280sensor, registers, altitude) end

---Initializes the module. Initialization is mandatory before reading values.
---@param registers string @String of configuration registers read from the BME280 sensor. It consists of 6 bytes (chars) of BME280_REGISTER_DIG_T, 18 bytes (chars) BME280_REGISTER_DIG_P and optional (not present for BMP280 sensor) 8 bytes (chars) of BME280_REGISTER_DIG_H1 (1 byte) and BME280_REGISTER_DIG_H2 (7 bytes)
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 16x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 16x.
---@param power_mode? number @(optional) Controls the sensor mode of the device. Default sensor more is normal.
---@param inactive_duration? number @(optional) Controls inactive duration in normal mode. Default inactive duration is 20ms.
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 16.
---@return userdata|nil @bme280sensor user data (`nil` if initialization has failed)
---@return table @config 3 (2 for BME280) field table with configuration parameters to be written to registers
--- - BME280_REGISTER_CONFIG,
--- - BME280_REGISTER_CONTROL_HUM,
--- - BME280_REGISTER_CONTROL consecutively
function bme280_math.setup(registers, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

--*** BME680 ***
bme680 = {}

---For given air pressure and sea level air pressure returns\
---the altitude in meters as an integer multiplied with 100.
---@param P number @measured pressure
---@param QNH number @current sea level pressure
---@return number altitude @in meters of measurement point
function bme680.altitude(P, QNH) end

---For given temperature and relative humidity returns\
---the dew point in Celsius as an integer multiplied with 100.
---@param H number @relative humidity in percent multiplied by 1000.
---@param T number @temperate in Celsius multiplied by 100.
---@return number dewpoint @dew point in Celsius
function bme680.dewpoint(H, T) end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number @measured pressure
---@param altitude number @altitude in meters of measurement point
---@return number P @sea level pressure
function bme680.qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature,\
---the air pressure, the air relative humidity
---@param altitude? number @(optional) altitude in meters of measurement point.
---@return number T @temperature in Celsius as an integer multiplied with 100
---@return number P @air pressure in hectopascals multiplied by 100
---@return number H @relative humidity in percent multiplied by 1000
---@return number G @gas resistance
---@return number QNH @air pressure in hectopascals multiplied by 100 converted to sea level
---Any of these variables is `nil` if the readout of given measure was not successful.
function bme680.read(altitude) end

---Starts readout (turns the sensor into forced mode).
---@param delay number @sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds.
---@param callback function @if provided it will be invoked after given delay. The sensor reading should be finalized by then so.
---@return nil
function bme680.startreadout(delay, callback) end

---Initializes module. Initialization is mandatory before read values.
---@param temp_oss? number @(optional) Controls oversampling of temperature data. Default oversampling is 2x.
---@param press_oss? number @(optional) Controls oversampling of pressure data. Default oversampling is 16x.
---@param humi_oss? number @(optional) Controls oversampling of humidity data. Default oversampling is 1x.
---@param heater_temp? number @(optional) heater temp
---@param heater_duration? number @(optional) heater duration
---@param IIR_filter? number @(optional) Controls the time constant of the IIR filter. Default filter coefficient is 31.
---@param cold_start? number @(optional) If 0 then the bme680 chip is not initialised.
---@return nil @`nil` if initialization has failed (no sensor connected?)
function bme680.setup(temp_oss, press_oss, humi_oss, heater_temp, heater_duration, IIR_filter, cold_start) end

--*** BMP085 ***
bmp085 = {}

---Initializes the module.
---@return nil
function bmp085.setup() end

---Samples the sensor and returns the temperature\
---in celsius as an integer multiplied with 10.
---@return integer T @temperature multiplied with 10 (integer)
function bmp085.temperature() end

---Samples the sensor and returns the pressure in pascal as an integer.
---@param oversampling_setting integer @that can be 0, 1, 2 or 3
---@return integer P @pressure in pascals
function bmp085.pressure(oversampling_setting) end

---Samples the sensor and returns the raw pressure in internal units.
---@param oversampling_setting integer @that can be 0, 1, 2 or 3
---@return integer P @raw pressure sampling value (integer)
function bmp085.pressure_raw(oversampling_setting) end

--*** CoAP ***
coap = {}

---@class coapClnt
local coap_client = {}
---@class coapSrv
local coap_server = {}

---Creates a CoAP client.
---@return coapClnt CoAP @client
function coap.Client() end

---Creates a CoAP server.
---@return coapSrv CoAP @server
function coap.Server() end

---Issues a GET request to the server.
---@param type number|'coap.CON'|'coap.NON' @defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string @the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:get(type, uri, payload) end

---Issues a PUT request to the server.
---@param type number|'coap.CON'|'coap.NON' @defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string @the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:put(type, uri, payload) end

---Issues a POST request to the server.
---@param type number|'coap.CON'|'coap.NON' @defaults to CON. when type is CON, and request failed, the request will retry another 4 times before giving up.
---@param uri string @the uri such as coap://192.168.18.103:5683/v1/v/myvar, only IP is supported.
---@param payload? any @(optional) the payload will be put in the payload section of the request.
---@return nil
function coap_client:post(type, uri, payload) end

---Issues a DELETE request to the server.
---@param type number|'coap.CON'|'coap.NON' @defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string @the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
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

--*** COLOR UTILS ***
color_utils = {}

---Convert HSV color to GRB color.
---@param hue number @value, between 0 and 360
---@param saturation number @value, between 0 and 255
---@param value number @value, between 0 and 255
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
function color_utils.hsv2grb(hue, saturation, value) end

---Convert HSV color to GRB color and explicitly return a white value.
---@param hue number @value, between 0 and 360
---@param saturation number @value, between 0 and 255
---@param value number @value, between 0 and 255
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
---@return number white
function color_utils.hsv2grbw(hue, saturation, value) end

---Convert GRB color to HSV color.
---@param green number @is the green value, between 0 and 255
---@param red number @is the red value, between 0 and 255
---@param blue number @is the blue value, between 0 and 255
---@return number hue @as values between 0 and 360, respective 0 and 255
---@return number saturation
---@return number value
function color_utils.grb2hsv(green, red, blue) end

---makes use of the HSV color space\
---and calculates colors based on the color circle.
---@param angle number @is the angle on the color circle, between 0 and 359
---@return number green @as values between 0 and 255
---@return number red
---@return number blue
function color_utils.colorWheel(angle) end

--*** CRON ***
cron = {}

---@class cron
local CRON = {}

---Creates a new schedule entry.
---@param mask string|'"* * * * *"' @crontab-like string mask for schedule
---@param callback function|' function(e) end' @`function(entry)` that is executed at the scheduled time
---@return cron cron.entry @sub module
function cron.schedule(mask, callback) end

---Removes all scheduled entries.
---@return nil
function cron.reset() end

---Sets a new handler for entry.
---@param callback function|'function(e) end' @`function(entry)` that is executed at the scheduled time
---@return nil
function CRON:handler(callback) end

---Sets a new schedule mask.
---@param mask string|'"* * * * *"' @crontab-like string mask for schedule
function CRON:schedule(mask) end

---Disables schedule. Disabled schedules may be enabled again by calling `:schedule(mask)`.
---@return nil
function CRON:unschedule() end

--*** CRYPTO TODO ***
crypto = {}

---Encrypts Lua strings.
---@param algo string @the name of a supported encryption algorithm to use
---@param key string @the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param plain string @the string to encrypt; it will be automatically zero-padded to a 16-byte boundary if necessary
---@param iv? any @(optional) the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any @The encrypted data as a binary string. For AES this is always a multiple of 16 bytes in length.
function crypto.encrypt(algo, key, plain , iv) end

---Decrypts previously encrypted data.
---@param algo string @the name of a supported encryption algorithm to use
---@param key string @the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param cipher any @the cipher text to decrypt (as obtained from `crypto.encrypt()`)
---@param iv? any @(optional) the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any @The decrypted string.
function crypto.decrypt(algo, key, cipher , iv) end

---Compute a cryptographic hash of a a file.
---@param algo string @the hash algorithm to use, case insensitive string
---@param filename string @the path to the file to hash
---@return any @A binary string containing the message digest.
---To obtain the textual version (ASCII hex characters), please use `encoder.toHex()`.
function crypto.fhash(algo, filename)	end

---Compute a cryptographic hash of a Lua string.
---@param algo string @the hash algorithm to use, case insensitive string
---@param str string @to hash contents of
---@return any @A binary string containing the message digest.
---To obtain the textual version (ASCII hex characters), please use `encoder.toHex()`.
function crypto.hash(algo, str) end

---Create a digest/hash object that can have any number of strings.\
---Object has update and finalize functions.added to it.
---@param algo string @the hash algorithm to use, case insensitive string
---@return any @Userdata object with update and finalize functions available.
function crypto.new_hash(algo) end

---Compute a HMAC (Hashed Message Authentication Code) signature for a Lua string.
---@param algo string @hash algorithm to use, case insensitive string
---@param str string @data to calculate the hash for
---@param key any @key to use for signing, may be a binary string
---@return any @A binary string containing the HMAC signature.
---Use `encoder.toHex()` to obtain the textual version.
function crypto.hmac(algo, str, key) end

---Create a hmac object that can have any number of strings added to it.\
---Object has update and finalize functions.
---@param algo string @he hash algorithm to use, case insensitive string
---@param key any @the key to use (may be a binary string)
---@return any @Userdata object with `update` and `finalize` functions available.
function crypto.new_hmac(algo, key) end

---Applies an XOR mask to a Lua string.
---@param message any @message to mask
---@param mask any @the mask to apply, repeated if shorter than the message
---@return any @The masked message, as a binary string.
---Use `encoder.toHex()` to get a textual representation of it.
function crypto.mask(message, mask) end

--*** DCC ***
dcc = {}

---Initializes the dcc module and links callback functions.
---@param DCC_command function @`DCC_command(cmd, params)` calllback function that is called when a DCC command is decoded. **cmd** parameters is one of the following values. **params** contains a collection of parameters specific to given command.
--- - dcc.DCC_RESET no additional parameters, params is `nil`.
--- - dcc.DCC_IDLE no additional parameters, params is `nil`.
--- - dcc.DCC_SPEED parameters collection members are *Addr, AddrType, Speed, Dir, SpeedSteps*.
--- - dcc.DCC_SPEED_RAW parameters collection members are *Addr, AddrType, Raw*.
--- - dcc.DCC_FUNC parameters collection members are *Addr, AddrType, FuncGrp, FuncState*.
--- - dcc.DCC_TURNOUT parameters collection members are *BoardAddr, OutputPair, Direction,OutputPower or Addr, Direction, OutputPower*.
--- - dcc.DCC_ACCESSORY parameters collection has one member *BoardAddr* or *Addr* or *State*.
--- - dcc.DCC_RAW parameters collection member are *Size*, *PreambleBits*, *Data1* to *Data6*.
--- - dcc.DCC_SERVICEMODE parameters collection has one member *InServiceMode*.
---@param ManufacturerId number @Manufacturer ID returned in CV 8. Commonly dcc.MAN_ID_DIY.
---@param VersionId any @Version ID returned in CV 7.
---@param Flags any @one of or combination (OR operator) of
--- - dcc.FLAGS_MY_ADDRESS_ONLY Only process packets with My Address.
--- - dcc.FLAGS_DCC_ACCESSORY_DECODER Decoder is an accessory decode.
--- - dcc.FLAGS_OUTPUT_ADDRESS_MODE This flag applies to accessory decoders only. Accessory decoders normally have 4 paired outputs and a single address refers to all 4 outputs. Setting this flag causes each address to refer to a single output.
--- - dcc.FLAGS_AUTO_FACTORY_DEFAULT Call DCC command callback with `dcc.CV_RESET` command if CV 7 & 8 == 255.
---@param OpsModeAddressBaseCV any @Ops Mode base address. Set it to 0?
---@param CV_callback function @`CV_callback(operation, param)` callback function that is called when any manipulation with CV (Configuarion Variable) is requested.
--- - dcc.CV_VALID to determine if a given CV is valid. This callback must determine if a CV is valid and return the appropriate value. The `param` collection has members `CV` and Value.
--- - dcc.CV_READ to read a CV. This callback must return the value of the CV. param collection has one member CV determing the CV number to be read.
--- - dcc.CV_WRITE to write a value to a CV. This callback must write the Value to the CV and return the value of the CV. The `param` collection has members `CV` and `Value`.
--- - dcc.CV_RESET Called when CVs must be reset to their factory defaults.
---@return nil
function dcc.setup(DCC_command, ManufacturerId, VersionId, Flags, OpsModeAddressBaseCV, CV_callback) end

---Stops the dcc module.
---@return nil
function dcc.close() end

--*** DHT ***
dht = {}

---Read all kinds of DHT sensors, including\
---DHT11, 21, 22, 33, 44 humidity temperature combo sensor.
---@param pin number @pin number of DHT sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.read(pin) end

---Read DHT11 humidity temperature combo sensor.
---@param pin number @pin number of DHT11 sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.read11(pin) end

---Read all kinds of DHT sensors, except DHT11.
---@param pin number @pin number of DHT11 sensor (can't be 0)
---@return integer status @as defined in Constants
---@return number temp @temperature
---@return number humi @humidity
---@return number temp_dec @temperature decimal
---@return number humi_dec @humidity decimal
function dht.readxx(pin) end

--*** ENCODER ***
encoder = {}

---Provides a Base64 representation of a (binary) Lua string.
---@param binary string @input string to Base64 encode
---@return string @A Base64 encoded string.
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string\
---back into the original string. An error is thrown\
---if the string is not a valid base64 encoding.
---@param b64 string @Base64 encoded input string
---@return string @The decoded Lua (binary) string.
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string.\
---Each byte in the input string is represented\
---as two hex characters in the output.
---@param binary string @input string to get hex representation for
---@return string @An ASCII hex string.
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string.\
---Each byte in the output string is represented as\
---two hex characters in the input. An error is thrown\
---if the string is not a valid base64 encoding.
---@param hexstr string @An ASCII hex string.
---@return string @Decoded string of hex representation.
function encoder.fromHex(hexstr) end

--*** ENDUSER SETUP ***
enduser_setup = {}

---Controls whether manual AP configuration is used.
---@param on_off? boolean @(optional) value indicating whether to use manual mode; if not given, the function only returns the current setting.
---@return boolean @The current setting, `true` if manual mode is enabled, `false` if it is not.
function enduser_setup.manual(on_off) end

---Starts the captive portal.
---@param AP_SSID? string @(optional) the SSID to use for the AP. This defaults to NodeMCU_<device id>.
---@param onConnected? function @(optional) callback will be fired when an IP-address has been obtained, just before the enduser_setup module will terminate itself
---@param onError? function @(optional) callback will be fired if an error is encountered. *err_num* is a number describing the error, and string contains a description of the error.
---@param onDebug? function @(optional) callback is disabled by default (controlled by #define ENDUSER_SETUP_DEBUG_ENABLE in enduser_setup.c).
---@return nil
function enduser_setup.start(AP_SSID, onConnected, onError, onDebug) end

---Stops the captive portal.
---@return nil
function enduser_setup.stop() end

--*** FILE ***
file = {}

---@class file
local fObj = {}

---Change current directory (and drive).\
---This will be used when no drive/directory is prepended to filenames.
---@param dir string|'"/FLASH"'|'"/SD0"'|'"/SD1"' @directory name
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string|'""' @file to check
---@return boolean @`true` of the file exists (even if 0 bytes in size), and `false` if it does not exist
function file.exists(filename) end

---Format the file system. Completely erases\
---any existing file system and writes a new one.\
---Function is not supported for SD cards.
---@return nil
function file.format() end

---Returns the flash address and physical size\
---of the file system area, in bytes.\
---Function is not supported for SD cards.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system.\
---The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Open and read the contents of a file.
---@param filename string|'""' @file to be opened and read
---@return any|nil @file contents if the file exists. `nil` if the file does not exist.
function file.getcontents(filename) end

---Lists all files in the file system.
---@param pattern string @interpreted as a traditional Lua pattern, not, say, a UNIX shell glob
---@return table @a Lua table which contains all *{file name: file size}* pairs, if no pattern given.
---If a pattern is given, only those file names matching the pattern will be included in\
---the resulting table. `file.list` will throw any errors encountered during pattern matching.
function file.list(pattern) end

---Mounts a FatFs volume on SD card. Function is only available when FatFS\
---support is compiled into the firmware and it is not supported for internal flash.
---@param ldrv string|'"/SD0"'|'"/SD1"' @name of the logical drive, /SD0, /SD1, etc.
---@param pin? integer @(optional) 1~12, IO index for SS/CS, defaults to 8 if omitted.
---@return any obj @Volume object
function file.mount(ldrv, pin) end

---Registers callback functions.
---@param event string|'"rtc"' @Trigger events are: `rtc` deliver current *date & time* to the file system. Function is expected to return a table containing the fields **year, mon, day, hour, min, sec** of current date and time. Not supported for internal flash.
---@param callback? function|' function() end' @(optional) function. Unregisters the callback if function() is omitted or `nil`.
---@return nil
function file.on(event, callback) end

---Opens a file for access, potentially creating it (for write modes).
---@param filename string|'""' @file to be opened
---@param mode string @r | w | a | r+ | w+ | a+
---|>' "r"' #read mode
---| ' "w"' #write mode
---| ' "a"' #append mode
---| ' "r+"' #update mode, all previous data is preserved
---| ' "w+"' #update mode, all previous data is erased
---| ' "a+"' #append update mode, previous data is preserved, writing is only allowed at the end of file
---@return file fileobject @if file opened ok. `nil` if file not opened, or not exists (read modes).
function file.open(filename, mode) end

---Remove a file from the file system.\
---The file must not be currently open.
---@param filename string|'""' @file to remove
---@return nil
function file.remove(filename) end

---Open and write the contents of a file.
---@param filename string|'""' @file to be created
---@param contents any @to be written to the file
---@return boolean|nil @`true` if the write is ok, `nil` on error
function file.putcontents(filename, contents) end

---Renames a file.
---@param oldname string|'""' @old file name
---@param newname string|' ""' @new file name
---@return boolean @`true` on success, `false` on error.
function file.rename(oldname, newname) end

---Get attribtues of a file or directory in a table.
---@param filename string|'""' @file name
---@return table @table containing file attributes. Elements of the table are:
--- - **size** - file size in bytes
--- - **name** - file name
--- - **time** - table with time stamp information. Default is\
---1970-01-01 00:00:00 in case time stamps are not supported (on SPIFFS).
---   -    year mon day hour min sec
--- - **is_dir** - flag true if item is a directory, otherwise false
--- - **is_rdonly** - flag true if item is read-only, otherwise false
--- - **is_hidden** - flag true if item is hidden, otherwise false
--- - **is_sys** - flag true if item is system, otherwise false
--- - **is_arch** - flag true if item is archive, otherwise false
function file.stat(filename) end

---Closes the open file, if any.
---@return nil
function file.close() end

---Closes the open file, if any.
---@return nil
function fObj:close() end

---Flushes any pending writes to the file system,\
---ensuring no data is lost on a restart. Closing\
---the open file using `file.close()/fd:close()`\
---performs an implicit flush as well.
---@return nil
function file.flush() end

---Flushes any pending writes to the file system,\
---ensuring no data is lost on a restart. Closing\
---the open file using `file.close()/fd:close()`\
---performs an implicit flush as well.
---@return nil
function fObj:flush() end

---Read content from the open file.
---@param n_or_char? integer @(optional) >
--- - if nothing passed in, then read up to FILE_READ_CHUNK bytes\
---or the entire file (whichever is smaller).
--- - if passed a number **n**, then read up to **n** bytes\
---or the entire file (whichever is smaller).
--- - if passed a string containing the single character **char**,\
---then read until char appears next in the file,\
---FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil
function file.read(n_or_char) end

---Read content from the open file.
---@param n_or_char integer @>
--- - if nothing passed in, then read up to FILE_READ_CHUNK bytes\
---or the entire file (whichever is smaller).
--- - if passed a number **n**, then read up to **n** bytes\
---or the entire file (whichever is smaller).
--- - if passed a string containing the single character **char**,\
---then read until char appears next in the file,\
---FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil @File content as a string, or `nil` when EOF
function fObj:read(n_or_char) end

---Read the next line from the open file.\
---Lines are defined as zero or more bytes ending with a EOL ('\n') byte.\
---If the next line is longer than 1024, this function only returns the first 1024 bytes.
---@return string|nil @File content in string, line by line, including EOL('\n'). Return `nil` when EOF.
function file.readline() end

---Read the next line from the open file.\
---Lines are defined as zero or more bytes ending with a EOL ('\n') byte.\
---If the next line is longer than 1024, this function only returns the first 1024 bytes.
---@return string|nil @File content in string, line by line, including EOL('\n'). Return `nil` when EOF.
function fObj:readline() end

---@alias seekwhence_f string
---| '"set"' #Base is position 0 (beginning of the file)
---|>'"cur"' #Base is current position
---| '"end"' #Base is end of file

---Sets and gets the file position, measured from the beginning of the file, to the position\
---given by `offset` plus a base specified by the string whence. If no parameters are given,\
---the function simply returns the current file offset.
---@param whence? seekwhence_f @(optional) set | cur | end
---@param offset? integer @(optional) default 0
---@return integer|nil @the resulting file position, or nil on error
function file.seek(whence , offset) end

---Sets and gets the file position, measured from the beginning of the file, to the position\
---given by `offset` plus a base specified by the string whence. If no parameters are given,\
---the function simply returns the current file offset.
---@param whence? seekwhence_f @(optional) set | cur | end
---@param offset? integer @(optional) default 0
---@return integer|nil @the resulting file position, or `nil` on error
function fObj:seek(whence , offset) end

---Write a string to the open file.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function file.write(str) end

---Write a string to the open file.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function fObj:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function file.writeline(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function fObj:writeline(str) end
