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

--*********** LM92 *************--
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

--*********** MCP23008 *************--
mcp23008 = {}

---Sets the MCP23008 device address's last three bits.
---@param address number : The 3 least significant bits (LSB) of the address
---@param pinSDA number : The pin to use for SDA
---@param pinSCL number : The pin to use for SCL
---@param speed number : The speed of the I2C signal
---@return nil
function mcp23008.begin(address, pinSDA, pinSCL, speed) end

---Writes a byte of data to the GPIO register.
---@param dataByte number : The byte of data to write
---@return nil
function mcp23008.writeGPIO(dataByte) end

---Reads a byte of data from the GPIO register
---@return number byte One byte of data
function mcp23008.readGPIO() end

---Writes one byte of data to the IODIR register.
---@param dataByte number : The byte of data to write
---@return nil
function mcp23008.writeIODIR(dataByte) end

---Writes one byte of data to the IODIR register.
---@return number byte The byte of data in IODIR
function mcp23008.readIODIR() end

---Writes a byte of data to the GPPU (Pull-UP resistors register)
---@param dataByte number : the value to write to the GPPU register.
---@return nil
function mcp23008.writeIODIR(dataByte) end

---Reads the GPPU (Pull-UP resistors register) byte
---@return number byte The GPPU byte i.e. state of all internal pull-up resistors
function mcp23008.readGPPU() end

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

--*********** HX711 *************--
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

--*********** L3G4200D *************--
l3g4200d = {}

---Samples the sensor and returns the gyroscope output.
---@return number X gyroscope output
---@return number Y gyroscope output
---@return number Z gyroscope output
function l3g4200d.read() end

---Initializes the module.
---@return nil
function l3g4200d.setup() end

--*********** MCP4725 *************--
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

--*********** MDNS *************--
mdns ={}

---Register a hostname and start the mDNS service.
---@param hostname string The hostname for this device. Alphanumeric characters are best.
---@param attributes? table A optional table of options. The keys must all be strings.
---@return nil
function mdns.register(hostname , attributes) end

---Shut down the mDNS service. This is not normally needed.
---@return nil
function mdns.close() end

--*********** MQTT **************--
mqtt = {}

---@class mqtt
local MQTT = mqtt.Client()

---Creates a MQTT client.
---@param clientid string client ID
---@param keepalive integer keepalive seconds
---@param username? string user name
---@param password? string user password
---@param cleansession? integer 0/1 for false/true. Default is 1 (true).
---@param max_message_length? integer how large messages to accept. Default is 1024.
---@return any
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
---@param timeout integer seconds until disconnecting an inactive client
---@return any net.server sub module
function net.createServer(timeout) end

---Creates an UDP socket.
function net.createUDPSocket() end

---Return information about a network interface, specified by index.
---@param if_index integer the interface index; on ESP8266, 0 is the wifi client (STA) and 1 is the wifi AP.
---@return nil|table
function net.ifinfo(if_index) end

---Join multicast group.
---@param if_ip string
---@param multicast_ip stringof the group to join
---@return nil
function net.multicastJoin(if_ip, multicast_ip) end

---Leave multicast group.
---@param if_ip string
---@param multicast_ip string of the group to leave
---@return nil
function net.multicastLeave(if_ip, multicast_ip) end

---Closes the server. net.server.close()
---@return nil
function NETSRV.close() end

---Listen on port from IP address. net.server.listen()
---@param port? integer port number, can be omitted (random port will be chosen)
---@param ip? string IP address string, can be omitted
---@param fun function |'function(net.socket) end'
---@return nil
function NETSRV.listen(port, ip, fun) end

---Returns server local address/port. net.server.getaddr()
---@return integer port|nil
---@return string ip|nil
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
---@param str string data in string which will be sent to server
---@param fun function|' function(sent) end'
---@return nil
function NETSOCKET:send(str, fun) end

---Changes or retrieves Time-To-Live value on socket. net.socket:ttl()
---@param ttl? integer (optional) new time-to-live value
---@return integer ttl current / new ttl value
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

---Sends data to specific remote peer.
---@param port integer remote socket port
---@param ip string  remote socket IP
---@param data any the payload to send
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

---Gets the IP address of the DNS server used to resolve hostnames.
---@param dns_index integer which DNS server to get (range 0~1)
---@return string IP address (string) of DNS server
function net.dns.getdnsserver(dns_index) end

---Resolve a hostname to an IP address. net.dns.resolve()
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
---@return nil
function net.ping(domain, count, callback_received, callback_sent) end

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
