--*********** BH1750 *************--
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

--*********** Lua module BME280 TODO *************--

--*********** COHELPER TODO *************--
cohelper = {}

--*********** DS18B20 *************--
ds18b20 = {}

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

--*********** DS3231 *************--
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

--*********** FIFO TODO *************--
fifo = {}

--********* FTP server ****************--
---@class ftp
local FTP = node.LFS.ftpserver()

---Create the FTP server on the standard ports 20 and 21.
---@param user string|'""'
---@param pass string|' ""'
---@param dbgFlag? boolean
---@return nil
function FTP:createServer(user, pass, dbgFlag) end

---Wrapper to createServer() which also connects to the WiFi channel.
---@param user string|'""'
---@param pass string|' ""'
---@param ssid string|' ""'
---@param wifipwd string|' ""'
---@param dbgFlag? boolean
---@return nil
function FTP:open(user, pass, ssid, wifipwd, dbgFlag) end

---Close down server including any sockets and return all resources to Lua.
---@return nil
function FTP:close() end

--*********** GOSSIP TODO *************--
gossip = {}

--*********** HDC1000 *************--
hdc1000 = {}

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

--*********** HTTP server *************--
httpserver = {}

---Function to start HTTP server.
---@param port integer  Port number for HTTP server. Most HTTP servers listen at port 80.
---@param handler function cb for when HTTP request was made. handler(req, res)
---@return any h net.server sub module.
function httpserver.createServer(port, handler) end

--*********** IMAP TODO *************--
imap = {}

--*********** LIQUID CRYSTAL TODO *************--
liquidcrystal = {}

--*********** LM92 TODO *************--
lm92 ={}

--*********** MCP23008 TODO *************--
mcp23008 = {}

--*********** MCP23017 *************--
mcp23017 = {}

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

--*********** REDIS *************--
redis = {}

---@class redis
local rds = redis.connect()

---Function used to connect to Redis server.
---@param host any Redis host name or address
---@param port any Redis database port. Default value is 6379.
---@return any rdsObj Object with rest of the functions.
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

--********* Telnet server *************--
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

--*********** YEELINK *************--
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

--************ ADC  ********************--
adc = {}

---Checks and if necessary reconfigures the ADC `mode` setting in the ESP init data block.
---@param mode_value integer|'adc.INIT_ADC'|'adc.INIT_VDD33'
---@return boolean
function adc.force_init_mode(mode_value) end

---Samples the ADC.
---@param channel integer|'0' always 0 on the ESP8266
---@return number
function adc.read(channel) end

---Reads the system voltage.
---@return number
function adc.readvdd33() end

--*********** ADS1115 TODO *************--
ads1115 ={}

--*********** ADXL345  TODO *************--
adxl345 = {}

--*********** AM2320  TODO *************--
am2320 = {}

--*********** APA102  TODO *************--
apa102 = {}

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

--*********** BLOOM TODO *************--
bloom = {}

--*********** BME280 *************--
bme280 = {}

---For given air pressure and sea level air pressure returns the altitude in meters
---as an integer multiplied with 100, i.e. altimeter function.
---@param P number
---@param QNH number
---@return number
function bme280.altitude(P, QNH) end

---Reads the sensor and returns the air pressure in hectopascals as an integer
---multiplied with 1000 or nil when readout is not successful.
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
---@param delay any
---@param callback function
---@return nil
function bme280.startreadout(delay, callback) end

---Initializes module. Initialization is mandatory before read values.
---@param temp_oss? any Controls oversampling of temperature data.
---@param press_oss? any Controls oversampling of pressure data.
---@param humi_oss? any Controls oversampling of humidity data.
---@param power_mode? any Controls the sensor mode of the device.
---@param inactive_duration? any Controls inactive duration in normal mode.
---@param IIR_filter? any Controls the time constant of the IIR filter.
---@return nil|integer
function bme280.setup(temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

---Reads the sensor and returns the temperature in celsius
---as an integer multiplied with 100.
---@return integer T temperature in celsius as an integer multiplied with 100 or nil when readout is not successful
---@return integer t_fine temperature measure used in pressure and humidity compensation formulas
function bme280.temp() end

--*********** BME280_MATH TODO *************--
bme280_math = {}

---For given air pressure and sea level air pressure returns the altitude in meters
---@param self? userdata|table
---@param P number measured pressure
---@param QNH number current sea level pressure
---@return number alt altitude in meters of measurement point
function bme280_math.altitude(self, P, QNH) end

---For given temperature and relative humidity returns the dew point in celsius.
---@param self? userdata|table
---@param  H number relative humidity in percent (100 means 100%)
---@param  T number temperate in celsius
---@return number dewp dew point in celsisus
function bme280_math.dewpoint(self, H, T) end

---For given altitude converts the air pressure to sea level air pressure (QNH).
---@param self? userdata|table
---@param P number measured pressure
---@param altitude number altitude in meters of measurement point
---@return number p sea level pressure
function bme280_math.qfe2qnh(self, P, altitude) end

---Reads the sensor
---@param bme280sensor userdata BME280 sensor user data returned by bme280_math.setup()
---@param registers string string of 8 bytes (chars) registers read from BME280_REGISTER_PRESS
---@param altitude? number  altitude in meters of measurement point.
---@return number T temperature in celsius
---@return number P air pressure in hectopascals
---@return number H relative humidity in percent
---@return number QNH air pressure in hectopascals
function bme280_math.read(bme280sensor, registers, altitude) end

---Initializes module. Initialization is mandatory before read values.
---@param registers string String of configuration registers read from the BME280 sensor.
---@param temp_oss? number  Controls oversampling of temperature data.
---@param press_oss? number Controls oversampling of pressure data.
---@param humi_oss? number Controls oversampling of humidity data.
---@param power_mode? number Controls the sensor mode of the device.
---@param inactive_duration? number Controls inactive duration in normal mode.
---@param IIR_filter? number Controls the time constant of the IIR filter.
---@return userdata|nil
---@return table
function bme280_math.setup(registers, temp_oss, press_oss, humi_oss, power_mode, inactive_duration, IIR_filter) end

--*********** BME680 *************--
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

--*********** BMP085 *************--
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

--*********** CoAP TODO *************--
coap = {}

--*********** COLOR UTILS *************--
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

--*********** DCC  TODO *************--
dcc = {}

--*********** DHT *************--
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

--*********** WiFi Manager TODO *************--
enduser_setup = {}

---Controls whether manual AP configuration is used.
---@param on_off boolean value indicating whether to use manual mode;
---@return boolean b The current setting, true if manual mode is enabled, false if it is not.
function enduser_setup.manual(on_off) end

---Starts the captive portal.
---@param AP_SSID? any the SSID to use for the AP.
---@param onConnected? function
---@param onError? function onError(err_num, string)
---@param onDebug? function onDebug (string)
---@return nil
function enduser_setup.start(AP_SSID, onConnected, onError, onDebug) end

---Stops the captive portal.
---@return nil
function enduser_setup.stop() end

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
---Sets and gets the file position, measured from the beginning of the file,
---to the position given by `offset` plus a base specified by the string whence.
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

--*********** GDBSTUB TODO *************--
gdbstub = {}

--*********** GPIO  *************--
gpio = {}

---@class gpio
local pulser = gpio.pulse.build()

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

---@alias trigger_mod
---|' "up"'     #rising edge
---|' "down"'   #falling edge
---|' "both"'   #both edges
---|' "low"'    #low level
---|' "high"'   #high level
---Establish or clear a callback function to run on interrupt for a pin.
---@param pin integer 1-12, pin to trigger on, IO index.
---@param type? trigger_mod
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
---@return any
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

--*********** HDC1080 TODO *************--
hdc1080 = {}

--*********** HMC5883L TODO *************--
hmc5883l = {}

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

--*********** HX711 TODO *************--

--*********** I2C *************--
i2c = {}

---Setup I²C address and read/write mode for the next transfer.
---@param id integer bus number
---@param device_addr number 7-bit device address.
---@param direction integer|'i2c.TRANSMITTER'|'i2c.RECEIVER'
---@return boolean
function i2c.address(id, device_addr, direction) end

---Read data for variable number of bytes.
---@param id integer bus number
---@param len number number of data bytes
---@return string string of received data
function i2c.read(id, len) end

---Initialize the I²C bus with the selected bus number, pins and speed.
---@param id integer  0~9, bus number
---@param pinSDA integer 1~12, IO index
---@param pinSCL integer 0~12, IO index
---@param speed integer|'i2c.SLOW'|'i2c.FAST'|'i2c.FASTPLUS'
---@return integer
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

--*********** L3G4200D TODO *************--

--*********** MCP4725 TODO *************--

--*********** MDNS TODO *************--

--*********** MQTT **************--
mqtt = {}

---@class mqtt
local MQTT = mqtt.Client()

---Creates a MQTT client.
---@param clientid string client ID
---@param keepalive integer  keepalive seconds
---@param username? string
---@param password? string
---@param cleansession? integer|' 1'|' 0'
---@param max_message_length? integer how large messages to accept. Default is 1024.
---@return any
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Closes connection to the broker.
---@return boolean
function MQTT:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string|'""'
---@param port? integer|' 1883'
---@param secure? boolean if true, use TLS.
---@param conn_est? function|' function(client) end'
---@param conn_notest? function|' function(client, reason) end'
---@return nil
function MQTT:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament.
---@param topic string|'""'
---@param message string
---@param qos? integer|' 0'|' 1'|' 2'
---@param retain? integer|' 0'|' 1'
---@return nil
function MQTT:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"connfail"'|'"suback"'|'"unsuback"'|'"puback"'|'"message"'|'"overflow"'|'"offline"'
---@param handler function|' function(client, topic?, message?) end'
---@return nil
function MQTT:on(event, handler) end

---Publishes a message.
---@param topic string|'""'
---@param payload string
---@param qos integer|' 0'|' 1'|' 2'
---@param retain integer|' 0'|' 1'
---@param fpuback? function|' function(client) end'
---@return boolean
function MQTT:publish(topic, payload, qos, retain, fpuback) end

---Subscribes to one or several topics.
---@param topic string|'""'
---@param qos integer|' 0'|' 1'|' 2'
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:subscribe(topic, qos, f_client) end

---Subscribes to one or several topics.
---@param tbl table
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:subscribe(tbl, f_client) end

---Unsubscribes from one or several topics.
---@param topic string|'""'
---@param f_client? function|' function(client) end'
---@return boolean
function MQTT:unsubscribe(topic, f_client) end

---Unsubscribes from one or several topics.
---@param tbl table
---@param f_client? function|' function(client) end'
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
---@param fun function|' function(net.socket, ip) end'
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
---@param fun nil|function|' function(net.socket, string?) end)'
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
---@param fun nil|function|' function(net.socket, string?) end)'
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
---@param fun function|'function(net.socket, ip) end'
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

---Resolve a hostname to an IP address. net.dns.resolve()
---Doesn't require a socket like net.socket.dns().
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

---Redirects the Lua interpreter to a stdout pipe when a CB function is specified
---(See pipe module) and resets output to normal otherwise.
---@param fun function|'function(pipe) end'
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

---@alias node_a1
---| 'node.INT_UP'   #Rising edge
---| 'node.INT_DOWN' #Falling edge
---| 'node.INT_BOTH' #Both edges
---|>'node.INT_LOW'  #Low level
---| 'node.INT_HIGH' #High level
---Put NodeMCU in light sleep mode to reduce current consumption.
---@param wake_pin integer
---@param int_type? node_a1
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
---Controls the amount of debug information kept during node.compile(),
---and allows removal of debug information from already compiled Lua code.
---@param level? level_n
---@param fun? function a compiled function to be stripped per setfenv except 0 is not permitted.
---@return integer|nil
function node.stripdebug(level, fun) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean
function node.osprint(enabled) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware.
---It returns uniformly distributed numbers in the required range.
---@param l number
---@param u number
---@return number
function node.random(l, u) end

---This behaves like math.random except that it uses true random numbers derived from the ESP8266 hardware.
---It returns uniformly distributed numbers in the required range.
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

---@alias node_a2
---| '0' #node.task.LOW_PRIORITY
---|>'1' #node.task.MEDIUM_PRIORITY
---| '2' #node.task.HIGH_PRIORITY
---Enable a Lua callback or task to post another task request.
---@param task_priority? node_a2
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

--*********** PCM TODO *************--

--*********** PERF TODO *************--

--*********** PIPE TODO *************--

--*********** PWM *************--
pwm = {}

---Quit PWM mode for the specified GPIO pin.
---@param pin integer 1~12, IO index
---@return nil
function pwm.close(pin) end

---Get selected PWM frequency of pin.
---@param pin integer 1~12, IO index
---@return number F PWM frequency of pin
function pwm.getclock(pin) end

---Get selected duty cycle of pin.
---@param pin integer 1~12, IO index
---@return number dc duty cycle, max 1023
function pwm.getduty(pin) end

---Set PWM frequency.
---@param pin integer 1~12, IO index
---@param clock integer 1~1000, PWM frequency
---@return nil
function pwm.setclock(pin, clock) end

---Set duty cycle for a pin.
---@param pin integer 1~12, IO index
---@param duty integer 0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setduty(pin, duty) end

---Set pin to PWM mode. Only 6 pins can be set to PWM mode at the most.
---@param pin integer 1~12, IO index
---@param clock integer 1~1000, PWM frequency
---@param duty integer 0~1023, pwm duty cycle, max 1023 (10bit)
---@return nil
function pwm.setup(pin, clock, duty) end

---PWM starts, the waveform is applied to the GPIO pin.
---@param pin integer 1~12, IO index
---@return nil
function pwm.start(pin) end

---Pause the output of the PWM waveform.
---@param pin integer 1~12, IO index
---@return nil
function pwm.stop(pin) end

--*********** PWM2 TODO *************--
pwm2 = {}

---Assigns PWM frequency expressed as Hz to given pin.
---@param pin integer 1-12
---@param frequencyAsHz number desired frequency in Hz, for example 1000 for 1KHz
---@param pulsePeriod number discreet steps in single PWM pulse, for example 100
---@param initialDuty number initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_hz(pin,frequencyAsHz,pulsePeriod,initialDuty ,frequencyDivisor) end

---Assigns PWM frequency expressed as one impulse per second(s) to given pin.
---@param pin integer 1-12
---@param frequencyAsSec number desired frequency as one impulse for given seconds,
---@param pulsePeriod number  discreet steps in single PWM pulse, for example 100
---@param initialDuty number initial duty in pulse period steps i.e. 50 for 50% pulse of 100 resolution
---@param frequencyDivisor? number an integer to divide product of frequency and pulsePeriod.
---@return nil
function pwm2.setup_pin_sec(pin,frequencyAsSec,pulsePeriod,initialDuty ,frequencyDivisor) end

---Starts PWM for all setup pins.
---@return nil
function pwm2.start() end

---Stops PWM for all pins.
---@return nil
function pwm2.stop() end

---Sets duty cycle for one or more a pins.
---@param pin any
---@param duty any
---@return nil
function pwm2.set_duty(pin, duty) end

---Releases given pin from previously done setup.
---@param pin any
---@return nil
function pwm2.release_pin(pin) end

---Prints internal data structures related to the timer.
---@return nil
function pwm2.get_timer_data() end

---Prints internal data structures related to given GPIO pin.
---@param pin any
---@return nil
function pwm2.get_pin_data(pin) end

--*********** RFSWITCH TODO *************--

--*********** ROTARY TODO *************--

--*********** RTCFIFO TODO *************--
rtcfifo = {}

---@param minsleep_us number minimum sleep time, in microseconds
---@return nil
function rtcfifo.dsleep_until_sample(minsleep_us) end

---Reads a sample from the rtcfifo.
---@param offset number Peek at sample at position `offset` in the fifo.
---@return number timestamp  timestamp in seconds
---@return number value the value
---@return number neg_e scaling factor
---@return any name sensor name
function rtcfifo.peek(offset) end

---Reads the first sample from the rtcfifo, and removes it from there.
---@return number timestamp  timestamp in seconds
---@return number value the value
---@return number neg_e scaling factor
---@return any name sensor name
function rtcfifo.pop() end

---Initializes the rtcfifo module for use.
---@param tbl? table
---@return nil
function rtcfifo.prepare(tbl) end

---Puts a sample into the rtcfifo.
---@param timestamp number Timestamp in seconds.
---@param value any The value to store.
---@param neg_e any The effective value stored is valueEneg_e
---@param name any Name of the sensor. Only the first four (ASCII) characters of name are used.
---@return nil
function rtcfifo.put(timestamp, value, neg_e, name) end

---Returns non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
---@return number Non-zero if the rtcfifo has been prepared and is ready for use, zero if not.
function rtcfifo.ready() end

--*********** RTCMEM  *************--
rtcmem = {}

---Reads one or more 32bit values from RTC user memory.
---@param idx integer zero-based index to start reading from
---@param num? number number of slots to read (default 1)
---@return any v The value(s) read from RTC user memory.
function rtcmem.read32(idx , num) end

---Writes one or more values to RTC user memory, starting at index idx.
---@param idx integer zero-based index to start writing to.
---@param val number value to store (32bit)
---@vararg number additional values to store (optional)
---@return nil
function rtcmem.write32(idx , val, ...) end

--*********** RTCTIME *************--
rtctime = {}

---Puts the ESP8266 into deep sleep mode, like node.dsleep().
---@param microseconds number of microseconds to sleep for.
---@param option any sleep option, see node.dsleep() for specifics.
function rtctime.dsleep(microseconds , option) end

---For applications where it is necessary to take samples with high regularity, this function is useful.
---@param aligned_us number boundary interval in microseconds
---@param minsleep_us number  minimum time that will be slept, if necessary skipping an interval.
---@param option? any as with dsleep(), the option sets the sleep option, if specified.
function rtctime.dsleep_aligned(aligned_us, minsleep_us , option) end

---Converts a Unix timestamp to calendar format.
---@param timestamp integer
---@return table rtctbl containing the fields:
---year 1970 ~ 2038
---mon month 1 ~ 12 in current year
---day day 1 ~ 31 in current month
---hour
---min
---sec
---yday day 1 ~ 366 in current year
---wday day 1 ~ 7 in current weak (Sunday is 1)
function rtctime.epoch2cal(timestamp) end

---Returns the current time.
---@return number sec seconds since the Unix epoch
---@return number usec the microseconds part
---@return number rate the current clock rate offset. This is an offset of rate / 2^32
function rtctime.get() end

---Sets the rtctime to a given timestamp in the Unix epoch.
---@param seconds? number the seconds part, counted from the Unix epoch
---@param microseconds? number the microseconds part
---@param rate? number the rate in the same units as for rtctime.get()
---@return nil
function rtctime.set(seconds , microseconds, rate) end

---This takes a time interval in 'system clock microseconds' based on the timestamps returned by tmr.
---@param microseconds number a time interval measured in system clock microseconds.
---@return number i The same interval but measured in wall clock microseconds
function rtctime.adjust_delta(microseconds) end

--*********** SI7021 *************--
si7021 = {}

---Read the internal firmware revision of the Si7021 sensor.
---@return number fwrev Firmware version * 0xFF Firmware version 1.0 * 0x20 Firmware version 2.0
function si7021.firmware() end

---@return number hum humidity
---@return number temp temperature
---@return number hum_dec humidity decimal
---@return number temp_dec temperature decimal
function si7021.read() end

---Read the individualized 64-bit electronic serial number of the Si7021 sensor.
---@return number sna 32-bit serial number part a
---@return number snb 32-bit serial number part b, upper byte contains the device identification
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
---@param RESOLUTION si7021_a1
---@param HEATER? si7021_a2
---@param HEATER_SETTING? number 0x00 - 0x0F 3.09 mA - 94.20 mA
---@return number resolution 0 - 4
---@return integer vdds 0 VDD OK (1.9V - 3.6V) | 1 VDD LOW (1.8V - 1.9V)
---@return integer heater 0 Disabled| 1 Enabled
---@return integer heater_setting  0 - 15
function si7021.setting(RESOLUTION, HEATER, HEATER_SETTING) end

---Initializes the device on fixed I²C device address (0x40).
---@return nil
function si7021.setup() end

--*********** SIGMA DELTA *************--
sigma_delta = {}

---Stops signal generation and reenables GPIO functionality at the specified pin.
---@param pin integer 1~12
---@return nil
function sigma_delta.close(pin) end

---Sets the prescale value.
---@param value integer prescale 1 to 255
---@return nil
function sigma_delta.setprescale(value) end

---Operate the sigma-delta module in PWM-like mode with fixed base frequency.
---@param ratio integer 0...255 for duty cycle 0...100%, 0 stops the signal at low
---@return nil
function sigma_delta.setpwmduty(ratio) end

---Sets the target value.
---@param value integer target 0 to 255
---@return nil
function sigma_delta.settarget(value) end

---Stops the signal generator and routes it to the specified pin.
---@param pin integer 1~12
---@return nil
function sigma_delta.setup(pin) end

--*********** SJSON  *************--
sjson = {}

---@class sjson
local encoder = sjson.encoder()
local decoder = sjson.decoder()

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table  data to encode
---@param opts? table
---@return any A sjson.encoder object.
function sjson.encoder(tbl , opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer an optional value for the number of bytes to return.
---@return string | nil
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table data to encode
---@param opts? table
---@return string
function sjson.encode(tbl , opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string the next piece of JSON encoded data
---@return any | nil
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string JSON string to decode
---@param opts? table
function sjson.decode(str, opts) end

--*********** SNTP *************--
sntp = {}

---Attempts to obtain time synchronization.
---@param server_ip string
---@param callback function|' function (sec, usec, server, info) end'
---@param errcallback function|' function()'
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

--*********** SOFTUART *************--
softuart = {}

---@class softuart
softuart.port = softuart.setup()

---Creates new SoftUART instance.
---@param baudrate number :SoftUART baudrate. Maximum supported is 230400.
---@param txPin number :SoftUART tx pin. If set to nil write method will not be supported.
---@param rxPin number :SoftUART rx pin. If set to nil on("data") method will not be supported.
---@return any swp softuart instance.
function softuart.setup(baudrate, txPin, rxPin) end

---Sets up the callback function to receive data.
---@param event string|"data"
---@param trigger number Can be a character or a number.
---@param fun function
---@return nil
function softuart.port:on(event, trigger, fun) end

---Transmits a byte or sequence of them.
---@param data number|string
---@return nil
function softuart.port:write(data) end

--*********** SOMFY *************--
somfy = {}

---Builds an frame defined by Somfy protocol and sends it to the RF transmitter.
---@param pin integer GPIO pin the RF transmitter is connected to.
---@param remote_address number address of the remote control.
---@param command integer|' somfy.SOMFY_UP'|' somfy.SOMFY_DOWN'|' somfy.SOMFY_PROG'|' somfy.SOMFY_STOP'
---@param rolling_code number The rolling code is increased every time a button is pressed.
---@param repeat_count integer how many times the command is repeated
---@param call_back function to be called after the command is transmitted.
---@return nil
function somfy.sendcommand(pin, remote_address, command, rolling_code, repeat_count, call_back) end

--************ SPI ********************--
spi = {}

---Receive data from SPI.
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param size number number of data items to be read
---@param default_data? any  default data being sent on MOSI (all-1 if omitted)
---@return string String containing the bytes read from SPI.
function spi.recv(id, size, default_data) end

---Send data via SPI in half-duplex mode. Send & receive data in full-duplex mode.
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param data1 string|table|integer
---@return number wrote number of written bytes
---@return any rdata received data when configured with spi.FULLDUPLEX
function spi.send(id, data1, ...) end

---Set up the SPI configuration.
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param mode integer|' spi.MASTER'|' spi.SLAVE'
---@param cpol integer|' spi.CPOL_LOW'|' spi.CPOL_HIGH'
---@param cpha integer|' spi.CPHA_LOW'|' spi.CPHA_HIGH'
---@param databits number number of bits per data item 1 - 32
---@param clock_div number SPI clock divider
---@param duplex_mode? integer|'spi.HALFDUPLEX'|'spi.FULLDUPLEX'
---@return number
function spi.setup(id, mode, cpol, cpha, databits, clock_div, duplex_mode) end

---Set the SPI clock divider.
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param clock_div number SPI clock divider
---@return number num Old clock divider
function spi.set_clock_div(id, clock_div) end

---Extract data items from MISO buffer after spi.transaction().
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param  offset integer bit offset into MISO buffer for first data item
---@param bitlen integer bit length of a single data item
---@param num number of data items to retrieve
---@return number|string
function spi.get_miso(id, offset, bitlen, num) end

---Insert data items into MOSI buffer for spi.transaction().
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param offset integer bit offset into MOSI buffer
---@param bitlen integer bit length of data1, data2, ...
---@param data1 any data items
---@return nil
function spi.set_mosi(id, offset, bitlen, data1, ...) end

---Insert data items into MOSI buffer for spi.transaction().
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param str string send data to be copied into MOSI buffer at offset 0, bit length 8
---@return nil
function spi.set_mosi(id, str) end

---Start an SPI transaction
---@param id integer SPI ID number: 0 for SPI, 1 for HSPI
---@param cmd_bitlen integer bit length of the command phase (0 - 16)
---@param cmd_data any data for command phase
---@param addr_bitlen integer bit length for address phase (0 - 32)
---@param addr_data any data for command phase
---@param mosi_bitlen integer bit length of the MOSI phase (0 - 512)
---@param dummy_bitlen integer bit length of the dummy phase (0 - 256)
---@param miso_bitlen integer  bit length of the MISO phase (0 - 512) for half-duplex.
---@return nil
function spi.transaction(id, cmd_bitlen, cmd_data, addr_bitlen, addr_data, mosi_bitlen, dummy_bitlen, miso_bitlen) end

--*********** STRUCT *************--
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

--*********** SWITEC TODO *************--
switec = {}

--*********** TCS34725  TODO *************--
tcs34725 ={}

---Initialization via this call is mandatory before values can be read.
---@return integer i 0 if setup has failed (no sensor connected?), 1 if sensor is TCS34725
function tcs34725.setup() end

---Enables the sensor. Can be used to wake up after a disable.
---@param fun function called when the sensor has finished initialising.
---@return nil
function tcs34725.enable(fun) end

---Disables the sensor. Enables a low-power sleep mode.
---@return nil
function tcs34725.disable() end

---Reads the clear, red, green and blue values from the sensor.
---@return integer clear in uint16_t.
---@return integer red in uint16_t.
---@return integer green in uint16_t.
---@return integer blue in uint16_t.
function tcs34725.raw() end

---Sets the gain of the sensor. Must be called after the sensor is enabled.
---@param gain number
---@return nil
function tcs34725.setGain(gain) end

---Sets the integration time of the sensor. Must be called after the sensor is enabled.
---@param time number
---@return nil
function tcs34725.setIntegrationTime(time) end

--************ TLS TODO ********************--
tls = {}

---@class tls
local TLS = tls.createConnection()

---Creates TLS connection.
---@return any
function tls.createConnection() end

---Closes socket.
---@return nil
function TLS:close() end

---Connect to a remote server.
---@param port number port number
---@param ip_domain any IP address or domain name string
---@return nil
function TLS:connect(port, ip_domain) end

---Retrieve port and ip of peer.
---@return number ip
---@return number peer
function TLS:getpeer() end

---Throttle data reception by placing a request to block the TCP receive function.
---@return nil
function TLS:hold() end

---Register callback functions for specific events.
---@param event string|'"dns"'|'"connection"'|'"reconnection"'|'"disconnection"'|'"receive"'|'"sent"'
---@param fun function|'function(tls.socket, string?) end'
---@return nil
function TLS:on(event, fun) end

---Sends data to remote peer.
---@param string string data in string which will be sent to server
---@return nil
function TLS:send(string) end

---Unblock TCP receiving data by revocation of a preceding hold().
---@return nil
function TLS:unhold() end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param enable boolean
---@return boolean|any
function tls.cert.verify(enable) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param pemdata string
---@param pemdata1? string
---@return boolean|any
function tls.cert.verify(pemdata, pemdata1) end

---Controls the certificate verification process when the NodeMCU makes a secure connection.
---@param callback function
---@return boolean|any
function tls.cert.verify(callback) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param enable boolean
---@return boolean|any
function tls.cert.auth(enable) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param pemdata string
---@param pemdata1? string
---@return boolean|any
function tls.cert.auth(pemdata, pemdata1) end

---Controls the client key and certificate used when the ESP creates a TLS connection
---@param callback function
---@return boolean|any
function tls.cert.auth(callback) end

--************ TM1829 ********************--
tm1829 = {}

---Send data to a led strip using native chip format.
---@param str string
---@return nil
function tm1829.write(str) end

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

---Provides a simple software watchdog, which needs to be re-armed or disabled before it expires,
---or the system will be restarted.
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
---|' tmr.ALARM_AUTO' #automatically repeating alarm
---|' tmr.ALARM_SINGLE' #a one-shot alarm
---|' tmr.ALARM_SEMI' #manually repeating alarm
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

--*********** TSL2561 *************--
tsl2561 = {}

---Reads sensor values from the device and returns calculated lux value.
---@return number lux the calculated illuminance in lux (lx)
---@return number status value indicating success or failure as explained below:
---tsl2561.TSL2561_OK
---tsl2561.TSL2561_ERROR_I2CINIT can't initialize I²C bus
---tsl2561.TSL2561_ERROR_I2CBUSY I²C bus busy
---tsl2561.TSL2561_ERROR_NOINIT initialize I²C bus before calling function
---tsl2561.TSL2561_ERROR_LAST
function tsl2561.getlux() end

---Reads the device's 2 sensors and returns their values.
---@return number ch0 value of the broad spectrum sensor
---@return number ch1 value of the IR sensor
---@return number status value indicating success or failure as explained below:
---tsl2561.TSL2561_OK
---tsl2561.TSL2561_ERROR_I2CINIT can't initialize I²C bus
---tsl2561.TSL2561_ERROR_I2CBUSY I²C bus busy
---tsl2561.TSL2561_ERROR_NOINIT initialize I²C bus before calling function
---tsl2561.TSL2561_ERROR_LAST
function tsl2561.getrawchannels() end

---@alias tsl2561_a1 number
---|' tsl2561.ADDRESS_GND'
---|>' tsl2561.ADDRESS_FLOAT'
---|' tsl2561.ADDRESS_VDD'
---@alias tsl2561_a2 number
---|' tsl2561.PACKAGE_CS'
---|>' tsl2561.PACKAGE_T_FN_CL'
---Initializes the device on pins sdapin & sclpin.
---@param sdapin number pin number of the device's I²C sda connection
---@param sclpin number pin number of the device's I²C scl connection
---@param address? tsl2561_a1 optional address of the device on the I²C bus
---@param pckg? tsl2561_a2 optional device's package type (slight difference in lux calculation)
---@return number
function tsl2561.init(sdapin, sclpin, address, pckg) end

---Sets the integration time and gain settings of the device.
---@param integration number|'tsl2561.INTEGRATIONTIME_13MS'|'tsl2561.INTEGRATIONTIME_101MS'|'tsl2561.INTEGRATIONTIME_402MS'
---@param gain number|' tsl2561.GAIN_1X'|' tsl2561.GAIN_16X'
---@return number status value indicating success or failure as explained below:
---tsl2561.TSL2561_OK
---tsl2561.TSL2561_ERROR_I2CINIT can't initialize I²C bus
---tsl2561.TSL2561_ERROR_I2CBUSY I²C bus busy
---tsl2561.TSL2561_ERROR_NOINIT initialize I²C bus before calling function
---tsl2561.TSL2561_ERROR_LAST
function tsl2561.settiming(integration, gain) end

--*********** U8G2 TODO *************--
u8g2 = {}

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

--*********** UCG TODO *************--
ucg ={}

--*********** WEBSOCKET *************--
websocket = {}

---@class websocket
local ws = websocket.createClient()

---Creates a new websocket client.
---@return any
function websocket.createClient() end

---Closes a websocket connection.
---@return nil
function ws:close() end

---Configures websocket client instance.
---@param params table with configuration parameters.
---@return nil
function ws:config(params) end

---Attempts to establish a websocket connection to the given URL.
---@param url any  the URL for the websocket.
---@return nil
function ws:connect(url) end

---Registers the callback function to handle websockets events
---@param eventName integer|'connection'|'receive'|'close'
---@param fun function|' funtion(ws, ...) end'
---@return nil
function websocket:on(eventName, fun) end

---Sends a message through the websocket connection.
---@param message any the data to send.
---@param opcode integer optionally set the opcode (default: 1, text message)
---@return nil
function websocket:send(message, opcode) end

--*********** WIEGANG *************--
wiegand = {}

---@class wiegang
wiegandobj = wiegand.create()

---Creates a dynamic wiegand object that receives a callback when data is received.
---@param pinD0 number This is a GPIO number (excluding 0) and connects to the D0 data line
---@param pinD1 number This is a GPIO number (excluding 0) and connects to the D1 data line
---@param callback function This is a function that will invoked when a full card or keypress is read.
---@return any wiegandobj If the arguments are in error, or the operation cannot be completed, then an error is thrown.
function wiegand.create(pinD0, pinD1, callback) end

---Releases the resources associated with the card reader.
---@return nil
function wiegandobj:close() end

--*********** WIFI *************--
wifi = {}

---Gets the current WiFi channel.
---@return integer ch current WiFi channel
function wifi.getchannel() end

---Get the current country info.
---@return table
function wifi.getcountry() end

---Gets default WiFi operation mode.
---@return integer
function wifi.getdefaultmode() end

---Gets WiFi operation mode.
---@return integer
function wifi.getmode() end

---Gets WiFi physical mode.
---@return integer
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

---@alias wifi_a1 integer
---|'wifi.STATION' #for when the device is connected to a WiFi router.
---|'wifi.SOFTAP'  #for when the device is acting only as an access point.
---|'wifi.STATIONAP' #is the combination of wifi.STATION and wifi.SOFTAP
---|'wifi.NULLMODE' # disables the WiFi interface(s).
---Configures the WiFi mode to use. NodeMCU can run in one of four WiFi modes.
---@param mode wifi_a1
---@param save? boolean choose whether or not to save wifi mode to flash
---@return any mod current mode after setup
function wifi.setmode(mode, save) end

---Sets WiFi physical mode.
---@param mode integer|'wifi.PHYMODE_B'|'wifi.PHYMODE_G'|'wifi.PHYMODE_N'
---@return any mod physical mode after setup
function wifi.setphymode(mode) end

---Sets WiFi maximum TX power.
---@param max_tpw number maximum value of RF Tx Power, unit: 0.25 dBm, range [0, 82].
---@return nil
function wifi.setmaxtxpower(max_tpw) end

---Starts to auto configuration, if success set up SSID and password automatically.
---@param type integer|'0'|'1'
---@param callback function|' function() end'
---@return nil
function wifi.startsmart(type, callback) end

---Stops the smart configuring process.
---@return nil
function wifi.stopsmart() end

---duration number Suspend duration in microseconds(μs).
---suspend_cb? function Callback to execute when WiFi is suspended.
---resume_cb? function Callback to execute when WiFi wakes from suspension.
---preserve_mode? boolean preserve current WiFi mode through node sleep.
---
---Suspend Wifi to reduce current consumption.
---@param tbl table
---@return integer
function wifi.suspend(tbl) end

---Auto connects to AP in station mode.
---@param auto integer 0 to disable auto connecting, 1 to enable auto connecting
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

---connected_cb function. Items returned in table :
---SSID: SSID of access point. (format: string)
---BSSID: BSSID of access point. (format: string)
---channel: The channel the access point is on. (format: number)
---Connects to the configured AP in station mode.
---@param connected_cb? function Callback to execute when station is connected to an access point.
---@return nil
function wifi.sta.connect(connected_cb) end

---disconnected_cb function. Items returned in table :
---SSID: SSID of access point. (format: string)
---BSSID: BSSID of access point. (format: string)
---reason: See wifi.eventmon.reason below. (format: number)
---Disconnects from AP in station mode.
---@param disconnected_cb? function Callback to execute when station is disconnected from an access point.
---@return nil
function wifi.sta.disconnect(disconnected_cb) end

---CFG TABLE contains scan configuration:
---`ssid` SSID == nil, don't filter SSID
---`bssid` BSSID == nil, don't filter BSSID
---`channel` channel == 0, scan all channels, otherwise scan set channel (default is 0)
---`show_hidden` show_hidden == 1, get info for router with hidden SSID (default is 0)
---Scans AP list as a Lua table into callback function.
---@param cfg? table that contains scan configuration
---@param format? integer|'1'|'0'
---@param callback function to receive the AP table when the scan is done.
---@return nil
function wifi.sta.getap(cfg, format, callback) end

---Get index of current Access Point stored in AP cache.
---@return integer current_index index of currently selected Access Point. (Range:1-5)
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
---@param fun function
---@return nil
function wifi.eventmon.register(Event, fun) end

---Unregister callbacks for WiFi event monitor
---@param Event integer|'wifi.eventmon.STA_CONNECTED'|'wifi.eventmon.STA_DISCONNECTED'|'wifi.eventmon.STA_AUTHMODE_CHANGE'|'wifi.eventmon.STA_GOT_IP'|'wifi.eventmon.STA_DHCP_TIMEOUT'|'wifi.eventmon.AP_STACONNECTED'|'wifi.eventmon.AP_STADISCONNECTED'|'wifi.eventmon.AP_PROBEREQRECVED'|'wifi.eventmon.WIFI_MODE_CHANGED'
---@return nil
function wifi.eventmon.unregister(Event) end

--*********** WiFi MONITOR TODO *************--
wifi.monitor = {}

--*********** WPS *************--
wps ={}

---Disable WiFi WPS function.
---@return nil
function wps.disable() end

---Enable WiFi WPS function.
---@return nil
function wps.enable() end

---Start WiFi WPS function. WPS must be enabled prior calling this function.
---@param foo? function callback `function(status)` for when the WPS function ends.
---@return nil
function wps.start(foo) end

--*********** WS2801 *************--
ws2801 = {}

---Initializes the module and sets the pin configuration.
---@param pin_clk integer pin for the clock. Supported are GPIO 0, 2, 4, 5.
---@param pin_data integer pin for the data. Supported are GPIO 0, 2, 4, 5.
---@return nil
function ws2801.init(pin_clk, pin_data) end

---Sends a string of RGB Data in 24 bits to WS2801.
---@param str string payload to be sent to one or more WS2801.
---@return nil
function ws2801.write(str) end

--*********** WS2812 *************--
ws2812 = {}

---@class ws2812
local buffer =  ws2812.newBuffer()

---Initialize UART1 and GPIO2, should be called once and before write().
---@param mode? integer|'ws2812.MODE_SINGLE'|'ws2812.MODE_DUAL'
---@return nil
function ws2812.init(mode) end

---Send data to one or two led strip using its native format.
---@param data1 string|nil payload to be sent to one or more WS2812 like leds through GPIO2
---@param data2? string|nil payload to be sent to one or more WS2812 like leds through TXD0
---@return nil
function ws2812.write(data1, data2) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer
---@param bytesPerLed integer  3 for RGB strips and 4 for RGBW strips
---@return any
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
---@param color any bytes of the color, you should pass as many arguments as bytesPerLed
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

--*********** WS2812-EFFECTS *************--
ws2812_effects = {}

---Initialize the effects library with the provided buffer for the connected LED strip.
---@param buffer any is a ws2812.buffer for the connected strip.
---@return nil
function ws2812_effects.init(buffer) end

---Start the animation effect.
---@return nil
function ws2812_effects.start() end

---Stop the animation effect.
---@return nil
function ws2812_effects.stop() end

---Set the brightness.
---@param brightness integer brightness between 0 and 255
---@return nil
function ws2812_effects.set_brightness(brightness) end

---Set the color.
---@param g integer is the green value between 0 and 255
---@param r integer is the red value between 0 and 255
---@param b integer is the blue value between 0 and 255
---@param w? integer is the white value between 0 and 255
---@return nil
function ws2812_effects.set_color(g, r, b, w) end

---Set the speed.
---@param speed integer speed between 0 and 255
---@return nil
function ws2812_effects.set_speed(speed) end

---Get current speed.
---@return integer speed between 0 and 255
function ws2812_effects.get_speed() end

---Set the delay between two effect steps in milliseconds.
---@param delay number is the delay in milliseconds, minimum 10ms
---@return nil
function ws2812_effects.set_delay(delay) end

---Get current delay.
---@return number delay is the current effect delay in milliseconds
function ws2812_effects.get_delay() end

---Set the active effect mode.
---@param mode string|'"static"'|'"blink"'|'"gradient"'|'"gradient_rgb"'|'"random_color"'|'"rainbow"'|'"rainbow_cycle"'|'"flicker"'|'"fire"'|'"fire_soft"'|'"fire_intense"'|'"halloween"'|'"circus_combustus"'|'"larson_scanner"'|'"color_wipe"'|'"random_dot"'|'"cycle"'
---@param effect_param? integer|string
---@return nil
function ws2812_effects.set_mode(mode, effect_param) end

--*********** XPT2046 *************--
xpt2046 = {}

---Initiates the XPT2046 module to read touch values from the display.
---@param cs_pin integer GPIO pin for cs
---@param irq_pin integer GPIO pin for irq
---@param height integer display height in pixel
---@param width integer display width in pixel
---@return nil
function xpt2046.init(cs_pin, irq_pin, height, width) end

---Sets the calibration of the display.
---@param x1 integer raw x value at top left
---@param y1 integer raw y value at top left
---@param x2 integer raw x value at bottom right
---@param y2 integer raw y value at bottom right
---@return nil
function xpt2046.setCalibration(x1, y1, x2, y2) end

---Checks if the touch panel is touched.
---@return boolean touch true if the display is touched, else false
function xpt2046.isTouched() end

---Returns the position the display is touched using the calibration values and given width and height.
---@return integer posX
---@return integer posY
function xpt2046.getPosition() end

---reads the position three times and averages the two positions with the least distance.
---@return integer posX
---@return integer posY
function xpt2046.getPositionAvg() end

---Reads the raw value from the display.
---@return integer rawX position X as a raw value.
---@return integer rawY position Y as a raw value.
function xpt2046.getRaw() end
