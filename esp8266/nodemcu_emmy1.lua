--*** BH1750 ***
bh1750 = {}

---Initializes the module and sets up I²C with hardcoded device address.
---@param sda number SDA pin number.
---@param scl number SCL pin number.
---@return nil
function bh1750.init(sda, scl) end

---Reads lux value from the sensor.
---@return number Lux value.
function bh1750.read() end

---Function used to return last read lux value.
---@return number val Last known lux value.
function bh1750.getlux() end

--*** cohelper Module is in nodemcu_emmy3.lua ***

--*** DS18B20 ***
---@class ds18b20
local ds18 = require("ds18b20")

---Enables debug output of the module.
---@return nil
function ds18:enable_debug() end

---Scans the bus for DS18B20 sensors (optional), starts a readout (conversion) for all sensors
---and calls a callback function when all temperatures are available.
---@param callback function that receives all results when all conversions finish.
---@param pin integer pin of the one-wire bus. If nil, GPIO0 (3) is used.
---@param unit number
---@param force_search number
---@param save_search number if not nil found sensors are saved to the file `ds18b20_save.lc`
---@return nil
function ds18:read_temp(callback, pin, unit, force_search, save_search) end

--*** DS3231 ***
ds3231 = {}

---Sets the current date and time.
---@param second number : 00-59
---@param minute number : 00-59
---@param hour number : 00-23
---@param day number : 1-7 (Sunday = 1, Saturday = 7)
---@param date number : 01-31
---@param month number : 01-12
---@param year number : 00-99
---@param disableOscillator? integer : (optional) 0-1, defaults to 0 if omitted
---@return nil
function ds3231.setTime(second, minute, hour, day, date, month, year, disableOscillator) end

---Get the current date and time.
---@return integer second: 00-59
---@return integer minute: 00-59
---@return integer hour: 00-23
---@return integer day: 1-7 (Sunday = 1, Saturday = 7)
---@return integer date: 01-31
---@return integer month: 01-12
---@return integer year: 00-99
function ds3231.getTime() end

---@alias ds3231_a1 integer
---|' ds3231.EVERYSECOND' works only with alarm1 and triggers every second;
---|' ds3231.EVERYMINUTE' works only with alarm2 and triggers every minute (at 00 seconds);
---|' ds3231.SECOND' triggers when time match given seconds parameter;
---|' ds3231.MINUTE' triggers when time match given seconds and minutes parameters;
---|' ds3231.HOUR' triggers when time match given seconds, minutes, and hours parameters;
---|' ds3231.DAY' triggers when time match given seconds, minutes, and hours on week day date/day parameters;
---|' ds3231.DATE' triggers when time match given seconds, minutes, and hours on date (day of the month) date/day parameters;
---Set an alarm to be triggered on SQW pin
---@param alarmId integer :1-2
---@param alarmType ds3231_a1 :1-7
---@param seconds integer :00-59
---@param minutes integer :00-59
---@param hours integer :00-23
---@param date_or_day integer :01-31 or 1-7 (Sunday = 1, Saturday = 7)
---@return nil
function ds3231.setAlarm(alarmId, alarmType, seconds, minutes, hours, date_or_day) end

---Reload an already triggered alarm.
---@return nil
function ds3231.reloadAlarms() end

---Enable an already setted alarm with the previous matching conditions.
---@param alarmId integer :1-2
---@return nil
function ds3231.enableAlarm(alarmId) end

---Disable an already set alarm with the previous matching conditions.
---@param alarmId integer :0-2
---@return nil
function ds3231.disableAlarm(alarmId) end

---Get bytes of control, for debug purpose, and status of DS3231.
---@return integer control 0-255
---@return integer status  0-143 (bit 6-5-4 unused)
function ds3231.getBytes() end

---@return nil
function ds3231.resetStopFlag() end

--*** FIFO Module is in nodemcu_emmy3.lua ***

--*** FTP server ***
---@class ftp
local FTP = require('ftpserver')

---Create the FTP server on the standard ports 20 and 21. The global variable FTP is set to the server object.
---@param user string Username for access to the server
---@param pass string Password for access to the server
---@param dbgFlag? boolean optional flag. If set true then internal debug output is printed
---@return nil
function FTP:createServer(user, pass, dbgFlag) end

---Wrapper to createServer() which also connects to the WiFi channel.
---@param user string Username for access to the server
---@param pass string Password for access to the server
---@param ssid string SSID for WiFi service
---@param wifipwd string password for WiFi service
---@param dbgFlag? boolean optional flag. If set true then internal debug output is printed
---@return nil
function FTP:open(user, pass, ssid, wifipwd, dbgFlag) end

---Close down server including any sockets and return all resources to Lua.
---@return nil
function FTP:close() end

--*** gossip Module is in nodemcu_emmy3.lua ***

--*** HDC1000 ***
---@class hdc1000
local HDC1000 = require('HDC1000')

---Function to setup the HDC1000 sensor.
---@param drdyn number DRDYn pin number.
---@return nil
function HDC1000.setup(drdyn) end

---Function to configure various options of HDC1000 sensor.
---@param address number I²C sensor address. Default value is 0x40.
---@param resolution number Temperature and humidity sensor resolution.
---@param heater number Heater setting. 0x20 to enable and 0x00 to disable.
---@return nil
function HDC1000.config(address, resolution, heater) end

---Reads the temperature from HDC1000 sensor.
---@return number Temperature in Celsius degrees.
function HDC1000.getTemp() end

---Reads the humidity value from HDC1000 sensor.
---@return number Humidity in percents.
function HDC1000.getHumi() end

---Function that checks if voltage of sensor power supply is bellow or above 2.8V.
---@return boolean bool true if battery voltage is bellow 2.8V, false otherwise.
function HDC1000.batteryDead() end

--*** HTTP server ***
httpserver = {}

---Function to start HTTP server.
---@param port integer  Port number for HTTP server. Most HTTP servers listen at port 80.
---@param handler function cb for when HTTP request was made. handler(req, res)
---@return any h net.server sub module.
function httpserver.createServer(port, handler) end

--*** IMAP ***
imap = {}

---Function used to check if IMAP command was processed.
---@return boolean proc The response process status of the last IMAP command sent.
function imap.response_processed() end

---Initiates the IMAP settings.
---@param username string IMAP username. For most e-mail providers e-mail address is used as username.
---@param password string IMAP password.
---@param tag any IMAP tag. With current implementation any tag like "t1" should work.
---@param dbug? boolean if set to true entire conversation between the ESP8266 and IMAP server will be shown. Default setting is false.
---@return nil
function imap.config(username, password, tag, dbug) end

---Logs into a new email session.
---@param socket any IMAP TCP socket object created using net.createConnection
---@return nil
function imap.login(socket) end

---Function to check the most recent email number. Should only be called after examine function.
---@return number n The most recent email number.
function imap.get_most_recent_num() end

---IMAP examines the given mailbox/folder. Sends the IMAP EXAMINE command.
---@param socket any IMAP TCP socket object created using net.createConnection
---@param mailbox string E-mail folder name to examine like example "INBOX"
---@return nil
function imap.examine(socket, mailbox) end

---Function that gets the last fetched header field.
---@return string field The last fetched header field.
function imap.get_header() end

---Fetches an e-mails header field e.g. SUBJECT, FROM, DATE.
---@param socket any IMAP TCP socket object created using net.createConnection
---@param msg_number number The email number to read e.g. 1 will read fetch the latest/newest email
---@param field string A header field such as SUBJECT, FROM, or DATE
---@return nil
function imap.fetch_header(socket, msg_number, field) end

---Function to get the last email read's body.
---@return any body The last email read's body.
function imap.get_body() end

---Sends the IMAP command to fetch a plain text version of the email's body.
---@param socket any IMAP TCP socket object created using net.createConnection
---@param msg_number number The email number to obtain e.g. 1 will obtain the latest email.
---@return nil
function imap.fetch_body_plain_text(socket, msg_number) end

---Sends the IMAP command to logout of the email session.
---@param socket any IMAP TCP socket object created using net.createConnection
---@return nil
function imap.logout(socket) end

--*** LiquidCrystal Module is in nodemcu_emmy3.lua ***

--*** LM92 ***
lm92 ={}

---Function used to setup the address for lm92.
---@param address number I²C address used by LM92.
---@return nil
function lm92.setup(address) end

---Returns the temperature register's content.
---@return number Temperature in degree Celsius.
function lm92.getTemperature() end

---Makes the chip enter the low power shutdown mode.
---@return nil
function lm92.shutdown() end

---Makes the chip exit the low power shutdown mode.
---@return nil
function lm92.wakeup() end

---Set hysteresis Temperature.
---@param htemp number : Hysteresis temperature from 130 to -55 in ºC
---@return nil
function lm92.setThyst(htemp) end

---Set Critical Temperature.
---@param ctemp number : Critical temperature from 130 to -55 in ºC
---@return nil
function lm92.setTcrit(ctemp) end

---Set Low Window Temperature.
---@param lwtemp number : Low window temperature from 130 to -55 in ºC
---@return nil
function lm92.setTlow(lwtemp) end

---Set High Window Temperature.
---@param hwtemp number : High window temperature from 130 to -55 in ºC
---@return nil
function lm92.setThigh(hwtemp) end

---Get hysteresis Temperature.
---@return number Hysteresis Temperature in degree Celsius.
function lm92.getThyst() end

---Get Critical Temperature.
---@return number Critical Temperature in degree Celsius.
function lm92.getTcrit() end

---Get Low Window Temperature.
---@return number Low Window Temperature in degree Celsius.
function lm92.getTlow() end

---Get High Window Temperature.
---@return number High Window Temperature in degree Celsius.
function lm92.getThigh() end

--*** MCP23008 ***
mcp23008 = {}

---Sets the MCP23008 device address's last three bits.
---@param address number The 3 least significant bits (LSB) of the address
---@param pinSDA number The pin to use for SDA
---@param pinSCL number The pin to use for SCL
---@param speed number The speed of the I2C signal
---@return nil
function mcp23008.begin(address, pinSDA, pinSCL, speed) end

---Writes a byte of data to the GPIO register.
---@param dataByte number The byte of data to write
---@return nil
function mcp23008.writeGPIO(dataByte) end

---Reads a byte of data from the GPIO register
---@return number byte One byte of data
function mcp23008.readGPIO() end

---Writes one byte of data to the IODIR register.
---@param dataByte number The byte of data to write
---@return nil
function mcp23008.writeIODIR(dataByte) end

---Writes one byte of data to the IODIR register.
---@return number byte The byte of data in IODIR
function mcp23008.readIODIR() end

---Writes a byte of data to the GPPU (Pull-UP resistors register)
---@param dataByte number the value to write to the GPPU register. Each bit in this byte is assigned to an individual GPIO pin
---@return nil
function mcp23008.writeGPPU(dataByte) end

---Reads the GPPU (Pull-UP resistors register) byte
---@return number byte The GPPU byte i.e. state of all internal pull-up resistors
function mcp23008.readGPPU() end

--*** MCP23017 ***
---@class mcp23017
local mcp17 = require('mcp23017')

---Configures the address of the module and tests the connection to the i2c bus.
---@param address number address for MCP23017, default: 0x20 (should be between 0x20 and 0x27)
---@param i2c_id number  id for the i2c bus connection (remember to call i2c.setup before)
---@return boolean found true if device found, otherwise false.
function mcp17:setup(address, i2c_id) end

---Set the mode of a single channel. This can be OUTPUT or INPUT.
---@param register number the side of channels (GPA or GPB)
---@param pin number the number to be set for the channel (0-15)
---@param mode number the mode for the channel. This can be mcp23017.INPUT or mcp23017.OUTPUT
---@return boolean r true, in case of error nil.
function mcp17:setMode(register, pin, mode) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number the side of channels (GPA or GPB)
---@param pin number the number to be set for the channel (0-15)
---@param state number the state for the channel. This can be mcp23017.HIGH or mcp23017.LOW
---@return boolean r true, in case of error nil.
function mcp17:setPin(register, pin, state) end

---Set the state of a single channel. This can be HIGH or LOW.
---@param register number the side of channels (GPA or GPB)
---@param pin number the number to be set for the channel (0-15)
---@return boolean b true for HIGH, false for LOW, in case of error nil.
function mcp17:getPinState(register, pin) end

---By calling this function, a safe state is established. All channels are set to input.
function mcp17:reset() end

---Enable or disable the internal pullup resistors.
---@param register number the side of channels (GPA or GPB)
---@param byte number byte to set the pullup resistors
function mcp17:setInternalPullUp(register, byte) end

---Setup the mode of the channels with a whole byte.
---@param register number the side of channels (GPA or GPB)
---@param byte number byte to set the mode for all channels for this register
function mcp17:writeIODIR(register, byte) end

---Setup the output state of the channels with a whole byte.
---@param register number the side of channels (GPA or GPB)
---@param byte number byte to set the state for all channels for this register
function mcp17:writeGPIO(register, byte) end

---Read the input states of the channels with a whole byte.
---@param register number the side of channels (GPA or GPB)
---@return number byte with states
function mcp17:readGPIO(register) end

--*** REDIS ***
redis = {}

---@class redis
local rds = {}

---Function used to connect to Redis server.
---@param host any Redis host name or address
---@param port any Redis database port. Default value is 6379.
---@return redis rdsObj Object with rest of the functions.
function redis.connect(host, port) end

---Subscribe to a Redis channel.
---@param channel any Channel name
---@param handler function Handler function that will be called on new message in subscribed channel
---@return nil
function rds:subscribe(channel, handler) end

---Publish a message to a Redis channel.
---@param channel any Channel name
---@param message any Message to publish
---@return nil
function rds:publish(channel, message) end

---Unsubscribes from a channel.
---@param channel any Channel name to unsubscribe from
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
---@return any IP address of api.yeelink.net, if not obtained then false
function yeelink.init(device, sensor, apikey) end

---Function to check DNS resolution of api.yeelink.net status.
---@return any IP address of api.yeelink.net or nil when name resolution failed.
function yeelink.getDNS() end

---Send data to Yeelink Sever.
---@param datapoint any Data to send to Yeelink API
---@return nil
function yeelink.update(datapoint) end

--*** ADC  ***
adc = {}

---Checks and if necessary reconfigures the ADC `mode` setting in the ESP init data block.
---@param mode_value integer|'adc.INIT_ADC'|'adc.INIT_VDD33'
---@return boolean b True if the function had to change the mode, false if the mode was already configured.
function adc.force_init_mode(mode_value) end

---Samples the ADC.
---@param channel integer
---|'0' #always 0 on the ESP8266
---@return number
function adc.read(channel) end

---Reads the system voltage.
---@return number v system voltage in millivolts
function adc.readvdd33() end

--*** ADS1115 ***
ads1115 ={}

---@class ads1115
local ads1x15

---Registers ADS1115 (ADS1113, ADS1114) device.
---@param I2C_ID number - always 0
---`ADDRESS` - I²C address of a device
---@param I2C_ADDR number
---|' ads1115.ADDR_GND'
---|' ads1115.ADDR_VDD'
---|' ads1115.ADDR_SDA'
---|' ads1115.ADDR_SCL'
---@return ads1115 obj Registered device object
function ads1115.ads1115(I2C_ID, I2C_ADDR) end

---Registers ADS1015 (ADS1013, ADS1014) device.
---@param I2C_ID number - always 0
---`ADDRESS` - I²C address of a device
---@param I2C_ADDR number
---|' ads1115.ADDR_GND'
---|' ads1115.ADDR_VDD'
---|' ads1115.ADDR_SDA'
---|' ads1115.ADDR_SCL'
---@return ads1115 obj Registered device object
function ads1115.ads1015(I2C_ID, I2C_ADDR) end

---Reset all devices connected to I²C interface.
---@return nil
function ads1115.reset() end

---Gets the result stored in the register of a previously issued conversion, e.g. in continuous mode or with a conversion ready interrupt.
---@return number volt voltage in mV
---@return number volt_dec voltage decimal in uV
---@return number adc raw adc register value
---@return number|nil sign sign of the result
function ads1x15:read() end

---Configuration settings for the ADC.
---@param GAIN number
---|'ads1115.GAIN_6_144V' #2/3x Gain
---|'ads1115.GAIN_4_096V' #1x Gain
---|'ads1115.GAIN_2_048V' #2x Gain
---|'ads1115.GAIN_1_024V' #4x Gain
---|'ads1115.GAIN_0_512V' #8x Gain
---|'ads1115.GAIN_0_256V' #16x Gain
---`GAIN` Programmable gain amplifier
---@param SAMPLES number
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
---`SAMPLES` Data rate in samples per second
---@param CHANNEL number
---|' ads1115.SINGLE_0' #channel 0 to GND
---|' ads1115.SINGLE_1' #channel 1 to GND
---|' ads1115.SINGLE_2' #channel 2 to GND
---|' ads1115.SINGLE_3' #channel 3 to GND
---|' ads1115.DIFF_0_1' #channel 0 to 1
---|' ads1115.DIFF_0_3' #channel 0 to 3
---|' ads1115.DIFF_1_3' #channel 1 to 3
---|' ads1115.DIFF_2_3' #channel 2 to 3
---`CHANNEL` Input multiplexer for single-ended or differential measurement
---@param MODE number
---|' ads1115.SINGLE_SHOT' #single-shot mode
---|' ads1115.CONTINUOUS' #continuous mode
---`MODE` Device operating mode
---@param CONVERSION_RDY? number
---|' ads1115.CONV_RDY_1'
---|' ads1115.CONV_RDY_2'
---|' ads1115.CONV_RDY_4'
---`CONVERSION_RDY` Number of conversions after conversion ready asserts
---@param COMPARATOR? number
---|' ads1115.COMP_1CONV'
---|' ads1115.COMP_2CONV'
---|' ads1115.COMP_4CONV'
---`COMPARATOR` Number of conversions after comparator asserts
---@param THRESHOLD_LOW number
---`THRESHOLD_LOW`
---`0` - `+ GAIN_MAX` in mV for single-ended inputs
---`- GAIN_MAX` - `+ GAIN_MAX` in mV for differential inputs
---@param THRESHOLD_HI number
---`THRESHOLD_HI`
---`0` - `+ GAIN_MAX` in mV for single-ended inputs
---`- GAIN_MAX` - `+ GAIN_MAX` in mV for differential inputs
---@param COMP_MODE? number
---|' ads1115.CMODE_TRAD' #traditional comparator mode (with hysteresis)
---|' ads1115.CMODE_WINDOW' #window comparator mode
---COMP_MODE Comparator mode
---@return nil
function ads1x15:setting(GAIN, SAMPLES, CHANNEL, MODE, CONVERSION_RDY, COMPARATOR, THRESHOLD_LOW, THRESHOLD_HI,COMP_MODE) end

---Starts the ADC reading for single-shot mode and after the conversion is done it will invoke an optional callback function in which the ADC conversion result can be obtained.
---@param CALLBACK function
---|'function(volt, volt_dec, adc, sign) end'
---callback function which will be invoked after the adc conversion is done
---@return nil
function ads1x15:startread(CALLBACK) end

--*** ADXL345 ***
adxl345 = {}

---Samples the sensor and returns X,Y and Z data from the accelerometer.
---@return integer x data
---@return integer y data
---@return integer z data
function adxl345.read() end

---Initializes the module.
---@return nil
function adxl345.setup() end

--*** AM2320 ***
am2320 = {}

---Samples the sensor and returns the relative humidity in % and temperature in celsius, as an integer multiplied with 10.
---@return integer rh relative humidity percentage multiplied with 10
---@return integer t temperature in celcius multiplied with 10
function am2320.read() end

---Initializes the module.
---@return number model 16 bits number of model
---@return number version 8 bits version number
---@return number serial 32 bits serial number
function am2320.setup() end

--*** APA102 ***
apa102 = {}

---Send ABGR data in 8 bits to a APA102 chain.
---@param data_pin integer any GPIO pin 0, 1, 2, ...
---@param clock_pin integer any GPIO pin 0, 1, 2, ...
---@param str string payload to be sent to one or more APA102 LEDs. It should be composed from a ABGR quadruplet per element.
---A1 the first pixel's Intensity channel (0-31)
---B1 the first pixel's Blue channel (0-255)
---G1 the first pixel's Green channel (0-255)
---R1 the first pixel's Red channel (0-255) ... You can connect a lot of APA102 ...
---A2, B2, G2, R2 are the next APA102s Intensity, Blue, Green and Red channel parameters
---@return nil
function apa102.write(data_pin, clock_pin, str) end

--*** BIT ***
bit = {}

---Arithmetic right shift a number equivalent to `value` >> `shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer n the number shifted right (arithmetically)
function bit.arshift(value, shift) end

---Bitwise *AND*, equivalent to `val1` & `val2` & ... & `valn` in C.
---@param val1 integer first AND argument
---@param val2 integer second AND argument
---@return integer n the bitwise AND of all the arguments
function bit.band(val1, val2, ...) end

---Generate a number with a 1 bit (used for mask generation). Equivalent to 1 << position in C.
---@param position number position of the bit that will be set to 1
---@return number n a number with only one 1 bit at position (the rest are set to 0)
function bit.bit(position) end

---Bitwise negation, equivalent to ~value in C.
---@param value number the number to negate
---@return number the bitwise negated value of the number
function bit.bnot(value) end

---Bitwise *OR*, equivalent to `val1` | `val2` | ... | `valn` in C.
---@param val1 integer first OR argument.
---@param val2 integer second OR argument.
---@return integer n the bitwise OR of all the arguments
function bit.bor(val1, val2, ...) end

---Bitwise *XOR*, equivalent to `val1` ^ `val2` ^ ... ^ `valn` in C.
---@param val1 integer first XOR argument
---@param val2 integer second XOR argument
---@return integer n the bitwise XOR of all the arguments
function bit.xor(val1, val2, ...) end

---Clear bits in a number.
---@param value integer the base number
---@param pos1 integer position of the first bit to clear
---@return integer n the number with the bit(s) cleared in the given position(s)
function bit.clear(value, pos1, ...) end

---Test if a given bit is cleared.
---@param value integer the value to test
---@param position integer bit position to test
---@return boolean b true if the bit at the given position is 0, false otherwise
function bit.isclear(value, position) end

---Test if a given bit is set.
---@param value number the value to test
---@param position integer bit position to test
---@return boolean b true if the bit at the given position is 1, false otherwise
function bit.isset(value, position) end

---Left-shift a number, equivalent to `value` << `shift` in C.
---@param value integer the value to shift
---@param shift integer positions to shift
---@return integer n the number shifted left
function bit.lshift(value, shift) end

---Logical right shift a number, equivalent to ( unsigned )`value` >> `shift` in C.
---@param value integer the value to shift.
---@param shift integer positions to shift.
---@return integer n the number shifted right (logically)
function bit.rshift(value, shift) end

---Set bits in a number.
---@param value integer the base number.
---@param pos1 integer position of the first bit to set.
---@return integer b the number with the bit(s) set in the given position(s)
function bit.set(value, pos1, ...) end

--*** BLOOM ***
bloom = {}

---@class bloom
local filter = {}

---Create a filter object.
---@param elements number elements The largest number of elements to be added to the filter.
---@param errorrate number errorrate The error rate (the false positive rate).
---@return bloom objfilter A filter object.
function bloom.create(elements, errorrate) end

---Adds a string to the set and returns an indication of whether the string was already present.
---@param str string string The string to be added to the filter set.
---@return boolean b true if the string was already present in the filter. false otherwise.
function filter:add(str) end

---Checks to see if a string is present in the filter set.
---@param str string string The string to be checked for membership in the set.
---@return boolean b true if the string was already present in the filter. false otherwise.
function filter:check(str) end

---Empties the filter.
function filter:reset() end

---Get some status information on the filter.
---@return number bits The number of bits in the filter.
---@return number fns The number of hash functions in use.
---@return number occupancy The number of bits set in the filter.
---@return number fprate The approximate chance that the next check will return true when it should return false
function filter:info() end

--*** BME280 Lua module ***
bme280 = {}

---@class bme280
local sobj = require('bme280')

---Creates bme280sensor object and initializes module.
---@param id number - I2C bus number
---@param address? number (optional) address - BME280 sensor address. 1 for BME280_I2C_ADDRESS1 = 0x76, 2 for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number (optional) temp_oss - Controls oversampling of temperature data.
---@param press_oss? number (optional) press_oss - Controls oversampling of pressure data
---@param humi_oss? number (optional) humi_oss - Controls oversampling of humidity data.
---@param power_mode? number (optional) sensor_mode - Controls the sensor mode of the device.
---@param inactive_duration? number (optional) inactive_duration - Controls inactive duration in normal mode.
---@param IIR_filter? number (optional) IIR_filter - Controls the time constant of the IIR filter.
-- (optional) cold_start - If 0 then the BME280 chip is not initialised.
---@return bme280 sobj - BME280 Sensor Object (nil if initialization has failed)
function bme280.setup(id, address, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---Re-initializes the sensor.
---@param id number - I2C bus number
---@param address? number (optional) address - BME280 sensor address. 1 for BME280_I2C_ADDRESS1 = 0x76, 2 for BME280_I2C_ADDRESS2 = 0x77. Default sensor address is BME280_I2C_ADDRESS1.
---@param temp_oss? number (optional) temp_oss - Controls oversampling of temperature data.
---@param press_oss? number (optional) press_oss - Controls oversampling of pressure data
---@param humi_oss? number (optional) humi_oss - Controls oversampling of humidity data.
---@param power_mode? number (optional) sensor_mode - Controls the sensor mode of the device.
---@param inactive_duration? number (optional) inactive_duration - Controls inactive duration in normal mode.
---@param IIR_filter? number (optional) IIR_filter - Controls the time constant of the IIR filter.
-- (optional) cold_start - If 0 then the BME280 chip is not initialised.
---@return bme280 sobj - BME280 Sensor Object (nil if initialization has failed)
function sobj:setup(id, address, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---For given air pressure (called QFE in aviation - see wiki QNH article) and sea level air pressure returns the altitude in meters, i.e. altimeter function.
---@param P number measured pressure
---@param QNH number current sea level pressure
---@return number alt altitude in meters of measurement point
function sobj:altitude(P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param H number relative humidity in percent (100 means 100%)
---@param T number temperate in celsius
---@return number dwp dew point in celsisus
function sobj:dewpoint(H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param P number measured pressure
---@param altitude number altitude in meters of measurement point
---@return number P sea level pressure
function sobj:qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity and see level pressure when altitude is specified.
---@param altitude? number (optional) altitude- altitude in meters of measurement point.
---@return number T temperature in celsius
---@return number P air pressure in hectopascals
---@return number H relative humidity in percent
---@return number QNH (optional) QNH air pressure in hectopascals (when altitude is specified)
-- Returns nil if the readout is not successful.
function sobj:read(altitude) end

---Starts readout (turns the sensor into forced mode).
---@param delay number sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds.
---@param callback function if provided it will be invoked after given delay. Callback parameters are identical to sobj:read results.
---@param altitude number altitude in meters of measurement point
---@return nil
function sobj:startreadout(delay, callback, altitude) end

--*** BME280 C module***

-- Warning, deprecated API! bme280. It will be removed soon. Use bme280math and bme280 Lua module instead. See documentation for details.
---Initializes module. Initialization is mandatory before read values.
---@param temp_oss? number Controls oversampling of temperature data.
---@param press_oss? number Controls oversampling of pressure data.
---@param humi_oss? number Controls oversampling of humidity data.
---@param power_mode? number Controls the sensor mode of the device.
---@param inactive_duration? number Controls inactive duration in normal mode.
---@param IIR_filter? number Controls the time constant of the IIR filter.
---@return nil|integer rslt nil if initialization has failed (no sensor connected?), 2 if sensor is BME280, 1 if sensor is BMP280
function bme280.setup(temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---For given air pressure and sea level air pressure returns the altitude in meters
---as an integer multiplied with 100, i.e. altimeter function.
---@param P number measured pressure
---@param QNH number current sea level pressure
---@return number alt altitude in meters of measurement point
function bme280.altitude(P, QNH) end

---Reads the sensor and returns the air pressure in hectopascals as an integer multiplied with 1000 or nil when readout is not successful.
---@return number P air pressure in hectopascals multiplied by 1000
---@return number T temperature in celsius as an integer multiplied with 100
function bme280.baro() end

---For given temperature and relative humidity returns the dew point in celsius
---as an integer multiplied with 100.
---@param H number relative humidity in percent multiplied by 1000.
---@param T number temperate in celsius multiplied by 100.
---@return number dewp dew point in celsisus
function bme280.dewpoint(H, T) end

---Reads the sensor and returns the air relative humidity
---@return number H last relative humidity reading in % times 1000
---@return number T temperature in celsius as an integer multiplied with 100
function bme280.humi() end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number measured pressure
---@param altitude number altitude in meters of measurement point
---@return number P sea level pressure
function bme280.qfe2qnh(P, altitude) end

---Reads the sensor
---@param altitude? number
---@return number T temperature in celsius as an integer multiplied with 100
---@return number P air pressure in hectopascals multiplied by 1000
---@return number H relative humidity in percent multiplied by 1000
---@return number QNH air pressure in hectopascals multiplied by 1000 converted to sea level
function bme280.read(altitude) end

---Starts readout (turns the sensor into forced mode).
---@param delay number sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds.
---@param callback function if provided it will be invoked after given delay.
---@return nil
function bme280.startreadout(delay, callback) end

---Reads the sensor and returns the temperature in celsius as an integer multiplied with 100.
---@return integer T temperature in celsius as an integer multiplied with 100 or nil when readout is not successful
---@return integer t_fine temperature measure used in pressure and humidity compensation formulas (generally no need to use this value)
function bme280.temp() end

--*** BME280_MATH ***
bme280_math = {}

---For given air pressure and sea level air pressure returns the altitude in meters
---@param self? userdata|table (optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param P number measured pressure
---@param QNH number current sea level pressure
---@return number alt altitude in meters of measurement point
function bme280_math.altitude(self, P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param self? userdata|table (optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param  H number relative humidity in percent (100 means 100%)
---@param  T number temperate in celsius
---@return number dewp dew point in celsisus
function bme280_math.dewpoint(self, H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param self? userdata|table (optional) self userdata or table structure so that the function can be directly called as object method, parameter is ignored in the calculation
---@param P number measured pressure
---@param altitude number altitude in meters of measurement point
---@return number p sea level pressure
function bme280_math.qfe2qnh(self, P, altitude) end

---Reads the sensor
---@param bme280sensor userdata BME280 sensor user data returned by bme280_math.setup()
---@param registers string string of 8 bytes (chars) registers read from BME280_REGISTER_PRESS
---@param altitude? number altitude in meters of measurement point.
---@return number T temperature in celsius
---@return number P air pressure in hectopascals
---@return number H relative humidity in percent
---@return number QNH (optional) air pressure in hectopascals
function bme280_math.read(bme280sensor, registers, altitude) end

---Initializes module. Initialization is mandatory before read values.
---@param registers string String of configuration registers read from the BME280 sensor.
---@param temp_oss? number  Controls oversampling of temperature data.
---@param press_oss? number Controls oversampling of pressure data.
---@param humi_oss? number Controls oversampling of humidity data.
---@param power_mode? number Controls the sensor mode of the device.
---@param inactive_duration? number Controls inactive duration in normal mode.
---@param IIR_filter? number Controls the time constant of the IIR filter.
---@return userdata|nil ud bme280sensor user data (nil if initialization has failed)
---@return table tbl config 3 (2 for BME280) field table with configuration parameters to be written to registers *BME280_REGISTER_CONFIG*, *BME280_REGISTER_CONTROL_HUM*, *BME280_REGISTER_CONTROL* consecutively
function bme280_math.setup(registers, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

--*** BME680 ***
bme680 = {}

---For given air pressure and sea level air pressure returns
---the altitude in meters as an integer multiplied with 100.
---@param P number measured pressure
---@param QNH number current sea level pressure
---@return number alt altitude in meters of measurement point
function bme680.altitude(P, QNH) end

---For given temperature and relative humidity returns the dew point in Celsius as an integer multiplied with 100.
---@param H number relative humidity in percent multiplied by 1000.
---@param T number temperate in Celsius multiplied by 100.
---@return number dew point in Celsius
function bme680.dewpoint(H, T) end

---For given altitude converts the air pressure to sea level air pressure.
---@param P number measured pressure
---@param altitude number altitude in meters of measurement point
---@return number p sea level pressure
function bme680.qfe2qnh(P, altitude) end

---Reads the sensor and returns the temperature, the air pressure, the air relative humidity
---@param altitude? number altitude in meters of measurement point.
---@return number T temperature in Celsius as an integer multiplied with 100
---@return number P air pressure in hectopascals multiplied by 100
---@return number H relative humidity in percent multiplied by 1000
---@return number G gas resistance
---@return number QNH air pressure in hectopascals multiplied by 100 converted to sea level
function bme680.read(altitude) end

---Starts readout (turns the sensor into forced mode).
---@param delay number sets sensor to forced mode and calls the callback (if provided) after given number of milliseconds.
---@param callback function
---@return nil
function bme680.startreadout(delay, callback) end

---Initializes module. Initialization is mandatory before read values.
---@param temp_oss? number Controls oversampling of temperature data.
---@param press_oss? number Controls oversampling of pressure data.
---@param humi_oss? number Controls oversampling of humidity data.
---@param heater_temp? number
---@param heater_duration? number
---@param IIR_filter? number Controls the time constant of the IIR filter.
---@param cold_start? number If 0 then the bme680 chip is not initialised.
---@return nil
function bme680.setup(temp_oss, press_oss, humi_oss, heater_temp, heater_duration, IIR_filter, cold_start) end

--*** BMP085 ***
bmp085 = {}

---Initializes the module.
---@return nil
function bmp085.setup() end

---Samples the sensor and returns the temperature in celsius as an integer multiplied with 10.
---@return integer t temperature multiplied with 10 (integer)
function bmp085.temperature() end

---Samples the sensor and returns the pressure in pascal as an integer.
---@param oversampling_setting integer that can be 0, 1, 2 or 3
---@return integer p pressure in pascals
function bmp085.pressure(oversampling_setting) end

---Samples the sensor and returns the raw pressure in internal units.
---@param oversampling_setting integer that can be 0, 1, 2 or 3
---@return integer p raw pressure sampling value (integer)
function bmp085.pressure_raw(oversampling_setting) end

--*** CoAP ***
coap = {}

---@class coapClnt
local coap_client = {}
---@class coapSrv
local coap_server = {}

---Creates a CoAP client.
---@return coapClnt CoAP client
function coap.Client() end

---Creates a CoAP server.
---@return coapSrv CoAP server
function coap.Server() end

---Issues a GET request to the server.
---@param type number|'coap.CON'|'coap.NON'
---`type` defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
---@param payload? any optional, the payload will be put in the payload section of the request.
---@return nil
function coap_client:get(type, uri, payload) end

---Issues a PUT request to the server.
---@param type number|'coap.CON'|'coap.NON'
---`type` defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
---@param payload? any optional, the payload will be put in the payload section of the request.
---@return nil
function coap_client:put(type, uri, payload) end

---Issues a POST request to the server.
---@param type number|'coap.CON'|'coap.NON'
---`type` defaults to CON. when type is CON, and request failed, the request will retry another 4 times before giving up.
---@param uri string the uri such as coap://192.168.18.103:5683/v1/v/myvar, only IP is supported.
---@param payload? any optional, the payload will be put in the payload section of the request.
---@return nil
function coap_client:post(type, uri, payload) end

---Issues a DELETE request to the server.
---@param type number|'coap.CON'|'coap.NON'
---`type` defaults to CON. If the type is CON and request fails, the library retries four more times before giving up.
---@param uri string the URI such as "coap://192.168.18.103:5683/v1/v/myvar", only IP addresses are supported i.e. no hostname resoltion.
---@param payload? any optional, the payload will be put in the payload section of the request.
---@return nil
function coap_client:delete(type, uri, payload) end

---Starts the CoAP server on the given port.
---@param port number server port
---@param ip? any optional IP address
---@return nil
function coap_server:listen(port, ip) end

---Closes the CoAP server.
---@return nil
function coap_server:close() end

---Registers a Lua variable as an endpoint in the server.
---@param name string the Lua variable's name
---@param content_type? any optional, defaults to coap.TEXT_PLAIN
---@return nil
function coap_server:var(name, content_type) end

---Registers a Lua function as an endpoint in the server.
---@param name string the Lua function's name
---@param content_type? any optional, defaults to coap.TEXT_PLAIN
---@return nil
function coap_server:func(name, content_type) end

--*** COLOR UTILS ***
color_utils = {}

---Convert HSV color to GRB color.
---@param hue number value, between 0 and 360
---@param saturation number value, between 0 and 255
---@param value number value, between 0 and 255
---@return number green as values between 0 and 255
---@return number red
---@return number blue
function color_utils.hsv2grb(hue, saturation, value) end

---Convert HSV color to GRB color and explicitly return a white value.
---@param hue number value, between 0 and 360
---@param saturation number value, between 0 and 255
---@param value number value, between 0 and 255
---@return number green as values between 0 and 255
---@return number red
---@return number blue
---@return number white
function color_utils.hsv2grbw(hue, saturation, value) end

---Convert GRB color to HSV color.
---@param green number is the green value, between 0 and 255
---@param red number is the red value, between 0 and 255
---@param blue number is the blue value, between 0 and 255
---@return number hue as values between 0 and 360, respective 0 and 255
---@return number saturation
---@return number value
function color_utils.grb2hsv(green, red, blue) end

---makes use of the HSV color space and calculates colors based on the color circle.
---@param angle number is the angle on the color circle, between 0 and 359
---@return number green as values between 0 and 255
---@return number red
---@return number blue
function color_utils.colorWheel(angle) end

--*** CRON ***
cron = {}

---@class cron
local CRON = {}

---Creates a new schedule entry.
---@param mask string | '"* * * * *"'
---@param callback function | ' function(e) end'
---@return cron cron.entry sub module
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

--*** crypto TODO ***
crypto = {}

---Encrypts Lua strings.
---@param algo string the name of a supported encryption algorithm to use
---@param key string the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param plain string the string to encrypt; it will be automatically zero-padded to a 16-byte boundary if necessary
---@param iv? any the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any The encrypted data as a binary string. For AES this is always a multiple of 16 bytes in length.
function crypto.encrypt(algo, key, plain , iv) end

---Decrypts previously encrypted data.
---@param algo string the name of a supported encryption algorithm to use
---@param key string the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param cipher any the cipher text to decrypt (as obtained from crypto.encrypt())
---@param iv? any the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any str The decrypted string.
function crypto.decrypt(algo, key, cipher , iv) end

---Compute a cryptographic hash of a a file.
---@param algo any the hash algorithm to use, case insensitive string
---@param filename string the path to the file to hash
---@return any s A binary string containing the message digest. To obtain the textual version (ASCII hex characters), please use encoder.toHex().
function crypto.fhash(algo, filename)	end

---Compute a cryptographic hash of a Lua string.
---@param algo any the hash algorithm to use, case insensitive string
---@param str string to hash contents of
---@return any A binary string containing the message digest. To obtain the textual version (ASCII hex characters), please use encoder.toHex().
function crypto.hash(algo, str) end

---Create a digest/hash object that can have any number of strings. Object has update and finalize functions.added to it.
---@param algo any the hash algorithm to use, case insensitive string
---@return any uObj Userdata object with update and finalize functions available.
function crypto.new_hash(algo) end

---	Compute a HMAC (Hashed Message Authentication Code) signature for a Lua string.
---@param algo string hash algorithm to use, case insensitive string
---@param str string data to calculate the hash for
---@param key any key to use for signing, may be a binary string
---@return any bStr A binary string containing the HMAC signature. Use encoder.toHex() to obtain the textual version.
function crypto.hmac(algo, str, key) end

---Create a hmac object that can have any number of strings added to it. Object has update and finalize functions.
---@param algo string he hash algorithm to use, case insensitive string
---@param key any  the key to use (may be a binary string)
---@return any uObj Userdata object with update and finalize functions available.
function crypto.new_hmac(algo, key) end

---Applies an XOR mask to a Lua string.
---@param message any message to mask
---@param mask any the mask to apply, repeated if shorter than the message
---@return any msg The masked message, as a binary string. Use encoder.toHex() to get a textual representation of it.
function crypto.mask(message, mask) end

--*** DCC ***
dcc = {}

---Initializes the dcc module and links callback functions.
---@param DCC_command function  DCC_command(cmd, params) calllback function that is called when a DCC command is decoded. cmd parameters is one of the following values.
---`params` contains a collection of parameters specific to given command.
---    dcc.DCC_RESET no additional parameters, params is nil.
---    dcc.DCC_IDLE no additional parameters, params is nil.
---    dcc.DCC_SPEED parameters collection members are Addr, AddrType, Speed,Dir, SpeedSteps.
---    dcc.DCC_SPEED_RAW parameters collection members are Addr, AddrType, Raw.
---    dcc.DCC_FUNC parameters collection members are Addr, AddrType, FuncGrp,FuncState.
---    dcc.DCC_TURNOUT parameters collection members are BoardAddr, OutputPair, Direction,OutputPower or Addr, Direction,OutputPower.
---    dcc.DCC_ACCESSORY parameters collection has one member BoardAddr or Addr or State.
---    dcc.DCC_RAW parameters collection member are Size, PreambleBits, Data1 to Data6.
---    dcc.DCC_SERVICEMODE parameters collection has one member InServiceMode.
---@param ManufacturerId number Manufacturer ID returned in CV 8. Commonly dcc.MAN_ID_DIY.
---@param VersionId any Version ID returned in CV 7.
---@param Flags any one of or combination (OR operator) of
---    dcc.FLAGS_MY_ADDRESS_ONLYOnly process packets with My Address.
---    dcc.FLAGS_DCC_ACCESSORY_DECODER Decoder is an accessory decode.
---    dcc.FLAGS_OUTPUT_ADDRESS_MODE This flag applies to accessory decoders only. Accessory decoders normally have 4 paired outputs and a single address refers to all 4 outputs. Setting this flag causes each address to refer to a single output.
---    dcc.FLAGS_AUTO_FACTORY_DEFAULT Call DCC command callback with dcc.CV_RESET command if CV 7 & 8 == 255.
---@param OpsModeAddressBaseCV any Ops Mode base address. Set it to 0?
---@param CV_callback function CV_callback(operation, param) callback function that is called when any manipulation with CV (Configuarion Variable) is requested.
---    dcc.CV_VALIDto determine if a given CV is valid. This callback must determine if a CV is valid and return the appropriate value. param collection has members CV and Value.
---    dcc.CV_READ to read a CV. This callback must return the value of the CV. param collection has one member CV determing the CV number to be read.
---    dcc.CV_WRITE to write a value to a CV. This callback must write the Value to the CV and return the value of the CV. param collection has members CV and Value.
---    dcc.CV_RESET Called when CVs must be reset to their factory defaults.
---@return nil
function dcc.setup(DCC_command, ManufacturerId, VersionId, Flags, OpsModeAddressBaseCV, CV_callback) end

---Stops the dcc module.
---@return nil
function dcc.close() end

--*** DHT ***
dht = {}

---Read all kinds of DHT sensors, including DHT11, 21, 22, 33, 44 humidity temperature combo sensor.
---@param pin number pin number of DHT sensor (can't be 0)
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal
---@return number humi_dec  humidity decimal
function dht.read(pin) end

---Read DHT11 humidity temperature combo sensor.
---@param pin number pin number of DHT11 sensor (can't be 0)
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal
---@return number humi_dec  humidity decimal
function dht.read11(pin) end

---Read all kinds of DHT sensors, except DHT11.
---@param pin number pin number of DHT11 sensor (can't be 0)
---@return integer status as defined in Constants
---@return number temp temperature
---@return number humi humidity
---@return number temp_dec temperature decimal
---@return number humi_dec  humidity decimal
function dht.readxx(pin) end

--*** ENCODER ***
encoder = {}

---Provides a Base64 representation of a (binary) Lua string.
---@param binary string input string to Base64 encode
---@return string str A Base64 encoded string.
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string back into the original string. An error is thrown if the string is not a valid base64 encoding.
---@param b64 string Base64 encoded input string
---@return string str The decoded Lua (binary) string.
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string. Each byte in the input string is represented as two hex characters in the output.
---@param binary string input string to get hex representation for
---@return string str An ASCII hex string.
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string. Each byte in the output string is represented as two hex characters in the input. An error is thrown if the string is not a valid base64 encoding.
---@param hexstr string An ASCII hex string.
---@return string str Decoded string of hex representation.
function encoder.fromHex(hexstr) end

--*** WiFi Manager ***
enduser_setup = {}

---Controls whether manual AP configuration is used.
---@param on_off? boolean value indicating whether to use manual mode; if not given, the function only returns the current setting.
---@return boolean b The current setting, true if manual mode is enabled, false if it is not.
function enduser_setup.manual(on_off) end

---Starts the captive portal.
---@param AP_SSID? any the SSID to use for the AP. This defaults to NodeMCU_<device id>.
---@param onConnected? function callback will be fired when an IP-address has been obtained, just before the enduser_setup module will terminate itself
---@param onError? function callback will be fired if an error is encountered. err_num is a number describing the error, and string contains a description of the error.
---@param onDebug? function callback is disabled by default (controlled by #define ENDUSER_SETUP_DEBUG_ENABLE in enduser_setup.c).
---@return nil
function enduser_setup.start(AP_SSID, onConnected, onError, onDebug) end

---Stops the captive portal.
---@return nil
function enduser_setup.stop() end

--*** FILE  ***
file = {}

---@class file
local fObj = {}

---Change current directory (and drive). This will be used when no drive/directory is prepended to filenames.
---@param dir string|'"/FLASH"'|'"/SD0"'|'"/SD1"' #directory name
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string|'""' #file to check
---@return boolean b true of the file exists (even if 0 bytes in size), and false if it does not exist
function file.exists(filename) end

---Format the file system. Completely erases any existing file system and writes a new one. Function is not supported for SD cards.
---@return nil
function file.format() end

---Returns the flash address and physical size of the file system area, in bytes. Function is not supported for SD cards.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system. The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Open and read the contents of a file.
---@param filename string|'""' #file to be opened and read
---@return any|nil any file contents if the file exists. *nil* if the file does not exist.
function file.getcontents(filename) end

---Lists all files in the file system.
---@return table tbl a Lua table which contains all *{file name: file size}* pairs, if no pattern given. If a pattern is given, only those file names matching the pattern (interpreted as a traditional Lua pattern, not, say, a UNIX shell glob) will be included in the resulting table. file.list will throw any errors encountered during pattern matching.
function file.list(pattern) end

---Mounts a FatFs volume on SD card. Function is only available when FatFS support is compiled into the firmware and it is not supported for internal flash.
---@param ldrv string|'"/SD0"'|'"/SD1"' #name of the logical drive, /SD0, /SD1, etc.
---@param pin? integer 1~12, IO index for SS/CS, defaults to 8 if omitted.
---@return any obj Volume object
function file.mount(ldrv, pin) end

---Registers callback functions.
---@param event string
---|'"rtc"' #Trigger events are: `rtc` deliver current date & time to the file system. Function is expected to return a table containing the fields year, mon, day, hour, min, sec of current date and time. Not supported for internal flash.
---@param foo? function
---|' function() end' #callback function. Unregisters the callback if function() is omitted or nil.
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
---@param filename string|'""' #`filename` file to be opened
---@param mode mode_f
---@return file fileobject if file opened ok. nil if file not opened, or not exists (read modes).
function file.open(filename, mode) end

---Remove a file from the file system. The file must not be currently open.
---@param filename string|'""' #file to remove
---@return nil
function file.remove(filename) end

---Open and write the contents of a file.
---@param filename string|'""' #file to be created
---@param contents any contents to be written to the file
---@return boolean|nil b true if the write is ok, nil on error
function file.putcontents(filename, contents) end

---Renames a file.
---@param oldname string|'""' #old file name
---@param newname string|' ""' #new file name
---@return boolean
function file.rename(oldname, newname) end

---Get attribtues of a file or directory in a table.
---@param filename string|'""'
---@return table tbl table containing file attributes. Elements of the table are:
--`size` file size in bytes
--`name` file name
--`time` table with time stamp information. Default is 1970-01-01 00:00:00 in case time stamps are not supported (on SPIFFS).
--    year    mon    day    hour    min    sec
--`is_dir` flag true if item is a directory, otherwise false
--`is_rdonly` flag true if item is read-only, otherwise false
--`is_hidden` flag true if item is hidden, otherwise false
--`is_sys` flag true if item is system, otherwise false
--`is_arch` flag true if item is archive, otherwise false
function file.stat(filename) end

---Closes the open file, if any.
---@return nil
function file.close() end

---Closes the open file, if any.
---@return nil
function fObj:close() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart.Closing the open file using file.close() / fd:close() performs an implicit flush as well.
---@return nil
function file.flush() end

---Flushes any pending writes to the file system, ensuring no data is lost on a restart.Closing the open file using file.close() / fd:close() performs an implicit flush as well.
---@return nil
function fObj:flush() end

---Read content from the open file.
---@param n_or_char integer :
---if nothing passed in, then read up to FILE_READ_CHUNK bytes or the entire file (whichever is smaller).
---if passed a number n, then read up to n bytes or the entire file (whichever is smaller).
---if passed a string containing the single character char, then read until char appears next in the file, FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil
function file.read(n_or_char) end

---Read content from the open file.
---@param n_or_char integer :
--if nothing passed in, then read up to FILE_READ_CHUNK bytes or the entire file (whichever is smaller).
--  if passed a number n, then read up to n bytes or the entire file (whichever is smaller).
--  if passed a string containing the single character char, then read until char appears next in the file, FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil content File content as a string, or nil when EOF
function fObj:read(n_or_char) end

---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte. If the next line is longer than 1024, this function only returns the first 1024 bytes.
---@return string|nil content File content in string, line by line, including EOL('\n'). Return *nil* when EOF.
function file.readline() end

---Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte. If the next line is longer than 1024, this function only returns the first 1024 bytes.
---@return string|nil content File content in string, line by line, including EOL('\n'). Return *nil* when EOF.
function fObj:readline() end

---@alias seekwhence_f
---| '"set"' # Base is position 0 (beginning of the file)
---|>'"cur"' # Base is current position
---| '"end"' # Base is end of file

---Sets and gets the file position, measured from the beginning of the file, to the position given by `offset` plus a base specified by the string whence.
---@param whence? seekwhence_f
---@param offset? integer default 0
---@return integer|nil offset the resulting file position, or nil on error
function file.seek(whence , offset) end

---Sets and gets the file position, measured from the beginning of the file, to the position given by `offset` plus a base specified by the string whence.
---@param whence? seekwhence_f
---@param offset? integer default 0
---@return integer|nil offset the resulting file position, or nil on error
function fObj:seek(whence , offset) end

---Write a string to the open file.
---@param str string|'""' #content to be write to file
---@return boolean|nil
function file.write(str) end

---Write a string to the open file.
---@param str string|'""' #content to be write to file
---@return boolean|nil
function fObj:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string|'""' #content to be write to file
---@return boolean|nil
function file.writeline(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string|'""' #content to be write to file
---@return boolean|nil
function fObj:writeline(str) end

--*** gdbstub Module is in nodemcu_emmy3.lua ***

--*** GPIO  ***
gpio = {}

---@class gpio
local pulser = {}

---Initialize pin to GPIO mode, set the pin in/out direction, and optional internal weak pull-up.
---@param pin integer
---@param mode integer|' gpio.OUTPUT'|' gpio.INPUT'|' gpio.OPENDRAIN'|' gpio.INT'
---@param pullup? string|' gpio.PULLUP'|' gpio.FLOAT'
---@return nil
function gpio.mode(pin, mode , pullup) end

---Read digital GPIO pin value.
---@param pin integer
---@return number
function gpio.read(pin) end

---Serialize output based on a sequence of delay-times in µs.
---@param pin integer
---@param start_level string|' gpio.HIGH'|' gpio.LOW'
---@param delay_times table
---@param cycle_num? integer
---@param callback? function|' function() end'
---@return nil
function gpio.serout(pin, start_level, delay_times , cycle_num, callback) end

---Establish or clear a callback function to run on interrupt for a pin.
---@param pin integer 1-12, pin to trigger on, IO index.
---@param type? string
---|' "up"'     #rising edge
---|' "down"'   #falling edge
---|' "both"'   #both edges
---|' "low"'    #low level
---|' "high"'   #high level
---@param callback_function? function
---@return nil
function gpio.trig(pin, type , callback_function) end

---Set digital GPIO pin value.
---@param pin integer
---@param level integer|' gpio.HIGH'|' gpio.LOW'
---@return nil
function gpio.write(pin, level) end

---This builds the gpio.
---@param tbl table
---@return gpio obj gpio.pulse object.
function gpio.pulse.build(tbl) end

---This starts the output operations.
---@param adjust? number This is the number of microseconds to add to the next adjustable period.
---@param callback function | ' function() end'
---@return nil
function pulser:start(adjust,  callback) end

---This returns the current state.
---@return integer position is the index of the currently active state.
---@return integer steps is the number of states that have been executed (including the current one).
---@return number offset is the time (in microseconds) until the next state transition.
---@return number now is the value of the tmr.now() function at the instant when the offset was calculated.
function pulser:getstate() end

---This stops the output operation at some future time.
---@param position? integer is the index to stop at. The stopping happens on entry to this state.
---@param callback? function | ' function() end'
---@return boolean
function pulser:stop(position , callback) end

---This stops the output operation immediately.
---@return integer position is the index of the currently active state.
---@return integer steps is the number of states that have been executed (including the current one).
---@return number offset is the time (in microseconds) until the next state transition.
---@return number now is the value of the tmr.now() function at the instant when the offset was calculated.
function pulser:cancel() end

---This adds (or subtracts) time that will get used in the min / max delay case.
---@param offset number
---@return integer position
---@return integer steps
---@return number offset
---@return number now
function pulser:adjust(offset) end

---This can change the contents of a particular step in the output program.
---@param entrynum number is the number of the entry in the original pulse sequence definition.
---@param entrytable table is a table containing the same keys as for gpio.pulse.build
function pulser:update(entrynum, entrytable) end

--*** HDC1080 ***
hdc1080 = {}

---Samples the sensor then returns temperature and humidity value.
---@return number TH Temperature data in centigrade and humidity data in percentage (0-100)
function hdc1080.read() end

---Initializes the module.
---@return nil
function hdc1080.setup() end

--*** HMC5883L ***
hmc5883l = {}

---Samples the sensor and returns X,Y and Z data.
---@return integer x measurements temperature multiplied with 10
---@return integer y measurements temperature multiplied with 10
---@return integer z measurements temperature multiplied with 10
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
---|' ""' #Optional additional headers to append, including \r\n; may be nil
---@alias bodyHTTP string
---|' ""' #The body to post; must already be encoded in the appropriate format, but may be empty
---@alias callbackHTTP
---|' function(code, data) end' # The callback function to be invoked when the response has been received or an error occurred; it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1.

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
---@param clk integer pin the hx711 clock signal is connected to
---@param data integer pin the hx711 data signal is connected to
---@return nil
function hx711.init(clk, data) end

---@alias hx711_a1 integer
---|'0' channel A, gain 128
---|'1' channel B, gain 32
---|'2' channel A, gain 64
---Read digital loadcell ADC value.
---@param mode hx711_a1 ADC mode. This parameter specifies which input and the gain to apply to that input.
---@return number val 24 bit signed ADC value extended to the machine int size
function hx711.read(mode) end

---Starts to read multiple samples from the ADC.
---@param mode hx711_a1
---@param samples number The number of samples before the callback is invoked.
---@param callback function The callback is invoked with three arguments
---'s' A string which contains samples packed 24 bit values.
---'t' The time in microseconds of the reception of the last sample in the buffer.
---'d' The number of samples dropped before the start of this buffer
---@return nil
function hx711.start(mode, samples, callback) end

---Stops a previously started set of reads.
---@return nil
function hx711.stop() end

--*** I2C ***
i2c = {}

---Setup I²C address and read/write mode for the next transfer.
---@param id integer bus number
---@param device_addr number 7-bit device address.
---@param direction integer|' i2c.TRANSMITTER'|' i2c.RECEIVER'
---@return boolean b true if ack received, false if no ack received.
function i2c.address(id, device_addr, direction) end

---Read data for variable number of bytes.
---@param id integer bus number
---@param len number number of data bytes
---@return string string of received data
function i2c.read(id, len) end

---Initialize the I²C bus with the selected bus number, pins and speed.
---@param id integer 0~9, bus number
---@param pinSDA integer 1~12, IO index
---@param pinSCL integer 0~12, IO index
---@param speed integer|' i2c.SLOW'|' i2c.FAST'|' i2c.FASTPLUS'
---@return integer s speed the selected speed, 0 if bus initialization error.
function i2c.setup(id, pinSDA, pinSCL, speed) end

---Send an I²C start condition.
---@param id integer bus number
---@return nil
function i2c.start(id) end

---Send an I²C stop condition.
---@param id integer bus number
---@return nil
function i2c.stop(id) end

---Write data to I²C bus. Data items can be multiple numbers, strings or lua tables.
---@param id integer bus number
---@param data1 string|table|number
---@return number number of bytes written
function i2c.write(id, data1, ...) end

--*** L3G4200D ***
l3g4200d = {}

---Samples the sensor and returns the gyroscope output.
---@return number X gyroscope output
---@return number Y gyroscope output
---@return number Z gyroscope output
function l3g4200d.read() end

---Initializes the module.
---@return nil
function l3g4200d.setup() end

--*** MCP4725 ***
mcp4725 = {}

---Gets contents of the dac register and EEPROM.
---@param tbl table
---tbl:  {[a0], [a1], [a2]}
---A0 Address bit 0. This bit is user configurable via MCP4725 pin 6(A0). (valid states: 0 or 1) (default: 0)
---A1 Address bit 1. This bit is hard-wired during manufacture. (valid states: 0 or 1) (default: 0)
---A2 Address bit 2. This bit is hard-wired during manufacture. (valid states: 0 or 1) (default: 0)
---@return number cur_pwrdn Current power down configuration value.
---@return number cur_val Current value stored in dac register.
---@return number eeprom_pwrdn Power down configuration stored in EEPROM.
---@return number eeprom_val DAC value stored in EEPROM.
---@return number eeprom_state EEPROM write status
--- 0 EEPROM write is incomplete.
--- 1 EEPROM write has completed
---@return number por_state Power-On-Reset status;
--- 0 The MCP4725 is performing reset and is not ready.
--- 1 The MCP4725 has successfully performed reset.
function mcp4725.read(tbl) end

---Write configuration to dac register or dac register and eeprom.
---@param tbl table
--- tbl:  {[a0], [a1], [a2], value, [pwrdn], [save]}
---A0 Address bit 0. This bit is user configurable via MCP4725 pin 6(A0). (valid states: 0 or 1) (default: 0)
---A1 Address bit 1. This bit is hard-wired during manufacture. (valid states: 0 or 1) (default: 0)
---A2 Address bit 2. This bit is hard-wired during manufacture. (valid states: 0 or 1) (default: 0)
---value The value to be used to configure DAC (and EEPROM). (Range: 0 - 4095)
---pwrdn Set power down bits.
--- mcp4725.PWRDN_NONE MCP4725 output enabled. (Default)
--- mcp4725.PWRDN_1K MCP4725 output disabled, output pulled to ground via 1K restistor.
--- mcp4725.PWRDN_100K MCP4725 output disabled, output pulled to ground via 100K restistor.
--- mcp4725.PWRDN_500K MCP4725 output disabled, output pulled to ground via 500K restistor.
---save Save pwrdn and dac values to EEPROM. (Values are loaded on power-up or during reset.)
--- true Save configuration to EEPROM.
--- false Do not save configuration to EEPROM. (Default)
---@return nil
function mcp4725.write(tbl) end

--*** MDNS ***
mdns ={}

---Register a hostname and start the mDNS service.
---@param hostname string The hostname for this device. Alphanumeric characters are best.
---@param attributes? table A optional table of options. The keys must all be strings.
---@return nil
function mdns.register(hostname , attributes) end

---Shut down the mDNS service. This is not normally needed.
---@return nil
function mdns.close() end

--*** MQTT ***
mqtt = {}

---@class mqtt
local MQTT = {}

---Creates a MQTT client.
---@param clientid string client ID
---@param keepalive integer keepalive seconds
---@param username? string user name
---@param password? string user password
---@param cleansession? integer 0/1 for false/true. Default is 1 (true).
---@param max_message_length? integer how large messages to accept. Default is 1024.
---@return mqtt MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Closes connection to the broker.
---@return boolean
function MQTT:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string host, domain or IP
---@param port? integer broker port (number), default 1883
---@param secure? boolean if true, use TLS.
---@param conn_est? function|' function(client) end'
---@param conn_notest? function|' function(client, reason) end'
---@return nil
function MQTT:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string the topic to publish to (string)
---@param message string the message to publish, (buffer or string)
---@param qos? integer|' 0'|' 1'|' 2'
---@param retain? integer|' 0'|' 1'
---@return nil
function MQTT:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"connfail"'|'"suback"'|'"unsuback"'|'"puback"'|'"message"'|'"overflow"'|'"offline"'
---@param handler function|' function(client, topic?, message?) end'
---`client` - callback function. The first parameter is always the client object itself.
---If event is `"message"`, the 2nd and 3rd parameters are received topic and message, respectively, as Lua strings.
---If the event is `"overflow"`, the parameters are as with "message",
---  save that the message string is truncated to the maximum message size.
---If the event is `"connfail"`, the 2nd parameter will be the connection failure code;
---@return nil
function MQTT:on(event, handler) end

---Publishes a message.
---@param topic string the topic to publish to (topic string)
---@param payload string the message to publish, (buffer or string)
---@param qos integer|' 0'|' 1'|' 2'
---@param retain integer|' 0'|' 1'
---@param fpuback? function|' function(client) end'
---@return boolean
function MQTT:publish(topic, payload, qos, retain, fpuback) end

---Subscribes to one or several topics.
---@param topic string a topic string
---@param qos integer|' 0'|' 1'|' 2'
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:subscribe(topic, qos, f_client) end

---Subscribes to one or several topics.
---@param tbl table array of 'topic, qos' pairs to subscribe to
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:subscribe(tbl, f_client) end

---Unsubscribes from one or several topics.
---@param topic string a topic string
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:unsubscribe(topic, f_client) end

---Unsubscribes from one or several topics.
---@param tbl table array of 'topic, anything' pairs to unsubscribe from
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:unsubscribe(tbl, f_client) end

--*** NET ***
net = {}

---@class netsocket
local NETSOCKET = {}
---@class netsrv
local NETSRV = {}
---@class udpsocket
local UDPSOCKET = {}

---Creates a TCP client.
---@return netsocket submodule net.socket
function net.createConnection() end

---Creates a TCP listening socket (a server).
---@param timeout integer seconds until disconnecting an inactive client; 1~28'800 seconds, 30 sec by default.
---@return netsrv submodule net.server
function net.createServer(timeout) end

---Creates an UDP socket.
---@return udpsocket submodule net.udpsocket
function net.createUDPSocket() end

---Return information about a network interface, specified by index.
---@param if_index integer the interface index; on ESP8266, 0 is the wifi client (STA) and 1 is the wifi AP.
---@return nil|table
function net.ifinfo(if_index) end

---Join multicast group.
---@param if_ip string string containing the interface ip to join the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string string of the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string  string containing the interface ip to leave the multicast group. "any" or "" affects all interfaces.
---@param multicast_ip string string of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server. net.server.close()
---@return nil
function NETSRV.close() end

---Listen on port from IP address.
---@param port? integer port number, can be omitted (random port will be chosen)
---@param ip? string IP address string, can be omitted
---@param fun function |'function(net.socket) end'
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
---@param ip_domain string IP address or domain name string
---@return nil
function NETSOCKET:connect(port, ip_domain) end

---Provides DNS resolution for a hostname.
---@param domain string domain name
---@param fun function|' function(net.socket, ip) end'
---@return nil
function NETSOCKET:dns(domain, fun) end

---Retrieve port and ip of remote peer.
---@return integer port |nil
---@return string ip |nil
function NETSOCKET:getpeer() end

---Retrieve local port and ip of socket.
---@return integer port or nil if not connected
---@return string ip or nil if not connected
function NETSOCKET:getaddr() end

---Throttle data reception by placing a request to block the TCP receive function. net.socket:hold()
---@return nil
function NETSOCKET:hold() end

---Register callback functions for specific events.
---@param event string|' "connection"'|' "reconnection"'|' "disconnection"'|' "receive"'|'  "sent"'
---@param fun nil|function|' function(net.socket, string?) end)' -- callback function. Can be nil to remove callback.
---@return nil
function NETSOCKET:on(event, fun) end

---Sends data to remote peer.
---@param str string data in string which will be sent to server
---@param fun? function|' function(sent) end'
--- callback function for sending string
---@return nil
function NETSOCKET:send(str, fun) end

---Changes or retrieves Time-To-Live value on socket.
---@param ttl? integer (optional) new time-to-live value
---@return integer ttl current / new ttl value
function NETSOCKET:ttl(ttl) end

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
---@param event string|' "receive"'|' "sent"'|' "dns"'
---@param fun nil|function|' function(net.socket, string?) end)'
---@return nil
function UDPSOCKET:on(event, fun) end

---Sends data to specific remote peer.
---@param port integer remote socket port
---@param ip string  remote socket IP
---@param data any the payload to send
---@return nil
function UDPSOCKET:send(port, ip, data) end

---Provides DNS resolution for a hostname.
---@param domain string
---@param fun function|'function(net.socket, ip) end'
---@return nil
function UDPSOCKET:dns(domain, fun) end

---Retrieve local port and ip of socket.
---@return integer port |nil
---@return string ip |nil
function UDPSOCKET:getaddr() end

---Changes or retrieves Time-To-Live value on socket.
---@param ttl integer
---@return integer
function UDPSOCKET:ttl(ttl) end

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer which DNS server to get (range 0~1)
---@return string IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address.
---Doesn't require a socket like net.socket.dns().
---@param host string hostname to resolve
---@param fun function|' function(sk, ip) end'
---callback called when the name was resolved. sk is always nil
---@return nil|string IP address.
function net.dns.resolve(host, fun) end

---Sets the IP of the DNS server used to resolve hostnames.
---@param dns_ip_addr string IP address of a DNS server
---@param dns_index integer which DNS server to set (range 0~1).
---@return nil
function net.dns.setdnsserver(dns_ip_addr, dns_index) end

---Pings a server. A callback function is called when response is or is not received.
---@param domain string destination domain or IP address
---@param count? number number of ping packets to be sent (default value is 4)
---@param callback_received function function(bytes, ipaddr, seqno, rtt) callback function which is invoked when response is received
---@param callback_sent? function function(ipaddr, total_count, timeout_count, total_bytes, total_time) callback function which is invoked when response is received
---`ipaddrstr` destination server IP address
---`total_count` total number of packets sent
---`timeout_count` total number of packets lost (not received)
---`total_bytes` total number of bytes received from destination server
---`total_time` total time to perform ping
---@return nil
function net.ping(domain, count, callback_received, callback_sent) end

--*** NODE ***
node = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode #The first value returned is the raw code, not the new "reset info" code which was introduced in recent SDKs. Values are:
--1, power-on
--2, reset (software?)
--3, hardware reset via reset pin
--4, WDT reset (watchdog timeout)
---@return integer reason #The second value returned is the extended reset cause. Values are:
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
---@return number
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as.
---@param filename string|'".lua"' #name of Lua text file
---@return nil
function node.compile(filename) end

---Enters deep sleep mode, wakes up when timed out.
---@param us integer number (integer) or nil, sleep time in micro second. If us == 0, it will sleep forever. If us == nil, will not set sleep time.
---@param option integer number (integer) or nil. If nil, it will use last alive setting as default option.
--    0, init data byte 108 is valuable
--    > 0, init data byte 108 is valueless
--    0, RF_CAL or not after deep-sleep wake up, depends on init data byte 108
--    1, RF_CAL after deep-sleep wake up, there will be large current
--    2, no RF_CAL after deep-sleep wake up, there will only be small current
--    4, disable RF after deep-sleep wake up, just like modem sleep, there will be the smallest current
---@param instant integer number (integer) or nil. If present and non-zero, the chip will enter Deep-sleep immediately and will not wait for the Wi-Fi core to be shutdown.
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

---Get the current LFS and SPIFFS partition information./
---@return table tbl An array containing entries for lfs_addr, lfs_size, spiffs_addr and spiffs_size. The address values are offsets relative to the start of the Flash memory.
function node.getpartitiontable() end

---Returns the current available heap size in bytes.
---@return number heap system heap size left in bytes
function node.heap() end

---Returns information about hardware, software version and build configuration.
--- `group` - A designator for a group of properties. May be one of
---@param group string|'"hw"'|'"sw_version"'|'"build_config"'
---@return any
--If a group is given the return value will be a table containing the following elements:
--for group = "hw"
--        chip_id (number)
--        flash_id (number)
--        flash_size (number)
--        flash_mode (number) 0 = QIO, 1 = QOUT, 2 = DIO, 15 = DOUT.
--        flash_speed (number)
--for group = "lfs"
--        lfs_base (number) Flash offset of selected LFS region
--        lfs_mapped (number) Mapped memory address of selected LFS region
--        lfs_size (number) size of selected LFS region
--        lfs_used (number) actual size used by current LFS image
--for group = "sw_version"
--        git_branch (string)
--        git_commit_id (string)
--        git_release (string) release name +additional commits e.g. "2.0.0-master_20170202 +403"
--        git_commit_dts (string) commit timestamp in an ordering format. e.g. "201908111200"
--        node_version_major (number)
--        node_version_minor (number)
--        node_version_revision (number)
--for group = "build_config"
--        ssl (boolean)
--        lfs_size (number) as defined at build time
--        modules (string) comma separated list
--        number_type (string) integer or float
function node.info(group) end

---Submits a string to the Lua interpreter. Similar to pcall(loadstring(str)), but without the single-line limitation.
---@param str any Lua chunk
---@return nil
function node.input(str) end

---Returns the function reference for a function in LFS.
---@param modulename string|'""' #The name of the module to be loaded.
---@return string|nil
--If the LFS is loaded and the modulename is a string that is the name of a valid module in the LFS, then the function is returned in the same way the load() and the other Lua load functions do
--Otherwise nil is returned.
function node.LFS.get(modulename) end

---List the modules in LFS.
---@return any|nil
--If no LFS image IS LOADED then nil is returned.
--Otherwise an sorted array of the name of modules in LFS is returned.
function node.LFS.list() end

---Reload LFS with the flash image provided.
---@param imageName string|'""' #The name of a image file in the filesystem to be loaded into the LFS.
---@return any|nil
--In the case when the imagename is a valid LFS image, this is expanded and loaded into flash, and the ESP is then immediately rebooted, so control is not returned to the calling Lua application in the case of a successful reload.
--The reload process internally makes multiple passes through the LFS image file. The first pass validates the file and header formats and detects many errors. If any is detected then an error string is returned.
function node.LFS.reload(imageName) end

---Redirects the Lua interpreter to a stdout pipe when a CB function is specified (See pipe module) and resets output to normal otherwise. Optionally also prints to the serial console.
---@param fun function|'function(pipe) end' #`output_fn(pipe)` a function accept every output as str, and can send the output to a socket (or maybe a file). Note that this function must conform to the fules for a pipe reader callback.
---@param serial_debug integer
---|'1' #output also show in serial.
---|'0' #no serial output.
---@return nil
function node.output(fun, serial_debug) end

---@return nil
function node.restart() end

---Restores system configuration to defaults using the SDK function system_restore()
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ'
---@return number f target CPU frequency
function node.setcpufreq(speed) end

---Sets the current LFS and / or SPIFFS partition information.
---@param partition_info table
--An array containing one or more of the following enties. The address values are byte offsets relative to the start of the Flash memory. The size values are in bytes. Note that these parameters must be a multiple of 8Kb to align to Flash page boundaries.
--    lfs_addr. The base address of the LFS region.
--    lfs_size. The size of the LFS region.
--    spiffs_addr. The base address of the SPIFFS region.
--    spiffs_size. The size of the SPIFFS region.
function node.setpartitiontable(partition_info) end

---@alias node_a1 number
---| 'node.INT_UP'   #Rising edge
---| 'node.INT_DOWN' #Falling edge
---| 'node.INT_BOTH' #Both edges
---|>'node.INT_LOW'  #Low level
---| 'node.INT_HIGH' #High level

---Put NodeMCU in light sleep mode to reduce current consumption.
---@param wake_pin integer 1-12, pin to attach wake interrupt to. Note that pin 0(GPIO 16) does not support interrupts.
---@param int_type? node_a1 #type of interrupt that you would like to wake on.
---@param resume_cb? function|' function() end' #Callback to execute when WiFi wakes from suspension.
---@param preserve_mode? boolean #preserve current WiFi mode through node sleep.
---|'true' #Station and StationAP modes will automatically reconnect to previously configured Access Point when NodeMCU resumes.
---|'false' #discard WiFi mode and leave NodeMCU in wifi.NULL_MODE. WiFi mode will be restored to original mode on restart.
---@return nil
function node.sleep(wake_pin, int_type, resume_cb, preserve_mode) end

---Query the performance of system startup.
---@param marker? any If present, this will add another entry into the startup counts
---@return table array An array of tables which indicate how many CPU cycles had been consumed at each step of platform boot.
function node.startupcounts(marker) end

---Get/set options that control the startup process. This interface will grow over time.
---@param tbl? table #If the argument is omitted, then no change is made to the current set of startup options. If the argument is the empty table {} then all options are reset to their default values. `table` one or more options:
--**banner** - set to true or false to indicate whether the startup banner should be displayed or not. (default: true)
--**frequency** - set to node.CPU80MHZ or node.CPU160MHZ to indicate the initial CPU speed. (default: node.CPU80MHZ)
--**delay_mount** - set to true or false to indicate whether the SPIFFS filesystem mount is delayed until it is first needed or not. (default: false)
--**command** - set to a string which is the initial command that is run. This is the same string as in the node.startupcommand.
---@return table tbl This is the complete set of options in the state that will take effect on the next boot. Note that the command key may be missing -- in which case the default value will be used.
function node.startup(tbl) end

---@alias level_n
---| '1' #don't discard debug info
---| '2' #discard Local and Upvalue debug info
---| '3' #discard Local, Upvalue and line-number debug info

---Controls the amount of debug information kept during node.compile(),and allows removal of debug information from already compiled Lua code.
---@param level? level_n
---@param fun? function a compiled function to be stripped per setfenv except 0 is not permitted.
---@return integer|nil --If invoked without arguments, returns the current level settings. Otherwise, nil is returned.
function node.stripdebug(level, fun) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean This is either true to enable printing, or false to disable it. The default is false.
function node.osprint(enabled) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
---@param l number the lower bound of the range
---@param u number the upper bound of the range
---@return number num The random number in the appropriate range.
function node.random(l, u) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
---@param n? integer the number of distinct integer values that can be returned -- in the (inclusive) range 1 .. n
---@return number num The random number in the appropriate range.
function node.random(n) end

---Sets the Emergency Garbage Collector mode.
---@param mode integer
---|'node.egc.NOT_ACTIVE' #EGC inactive, no collection cycle will be forced in low memory situations
---|'node.egc.ON_ALLOC_FAILURE' #ry to allocate a new block of memory, and run the garbage collector if the allocation fails. If the allocation fails even after running the garbage collector, the allocator will return with error.
---|'node.egc.ON_MEM_LIMIT' #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit. If the upper limit can't be satisfied even after running the garbage collector, the allocator will return with error. If the given limit is negative, it is interpreted as the desired amount of heap which should be left available. Whenever the free heap (as reported by node.heap() falls below the requested limit, the garbage collector will be run.
---|'node.egc.ALWAYS' #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error. This mode is very efficient with regards to memory savings, but it's also the slowest.
---@param level number in the case of node.egc.ON_MEM_LIMIT, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Returns memory usage information for the Lua runtime.
---@return number total_allocated The total number of bytes allocated by the Lua runtime. This is the number which is relevant when using the node.egc.ON_MEM_LIMIT option with positive limit values.
---@return number estimated_used This value shows the estimated usage of the allocated memory.
function node.egc.meminfo() end

---Enable a Lua callback or task to post another task request.
---@param task_priority? integer
---| 'node.task.LOW_PRIORITY' #=0
---|>'node.task.MEDIUM_PRIORITY' #=1
---| 'node.task.HIGH_PRIORITY' #=2
---@param fun function|' function() end' #a callback function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, fun) end
