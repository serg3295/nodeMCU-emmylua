--*** 1-wire ***
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string value, data to be calculated check sum in string
---@param inverted_crc0 number LSB of received CRC
---@param inverted_crc1 number MSB of received CRC
---@param crc? number CRC starting value
---@return boolean b true if the CRC matches, false otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf string value, data to be calculated check sum in string
---@param crc? number CRC starting value
---@return number n the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used in the ROM and scratchpad registers.
---@param buf string value, data to be calculated check sum in string
---@return number CRC result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus.
---@param pin integer  1~12, I/O index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer 1~12, I/O index
---@return integer byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer 1~12, I/O index
---@param size number of bytes to be read from slave device (up to 256)
---@return string bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer 1~12, I/O index
---@return integer is
---`1` if a device responds with a presence pulse
---`0` if there is no device or the bus is shorted or otherwise held low for more than 250 µS
function ow.reset(pin) end

---Clears the search state so that it will start from the beginning again.
---@param pin integer 1~12, I/O index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer 1~12, I/O index
---@return string|nil rom_code string with length of 8 upon success. It contains the rom code of slave device. Returns nil if search was unsuccessful.
function ow.search(pin) end

---Issues a 1-Wire rom select command. Make sure you do the ow.reset(pin) first.
---@param pin integer 1~12, I/O index
---@param rom string string value, len 8, rom code of the slave device
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer 1~12, I/O index
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command, to address all on bus.
---@param pin integer 1~12, I/O index
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code.
---The search itself has to be initiated with a subsequent call to ow.search().
---@param pin integer 1~12, I/O index
---@param family_code integer byte for family code
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end for parasitically powered devices.
---@param pin integer 1~12, I/O index
---@param v integer byte to be written to slave device
---@param power integer 1 for wire being held high for parasitically powered devices
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end for parasitically powered devices.
---@param pin integer 1~12, I/O index
---@param buf string string to be written to slave device
---@param power integer 1 for wire being held high for parasitically powered devices
---@return nil
function ow.write_bytes(pin, buf, power) end

--*** PCM ***
pcm ={}

---@class pcm
local pcmdrv = pcm.new()

---Initializes the audio driver.
---@param pcm_SD any pcm.SD use sigma-delta hardware
---@param pin integer pin 1~10, IO index
---@return pcm obj Audio driver object.
function pcm.new(pcm_SD, pin) end

---Stops playback and releases the audio hardware.
---@return nil
function pcmdrv:close() end

---Register callback functions for events.
---@param event string
---|'"data"' #callback function is supposed to return a string containing the next chunk of data.
---|'"drained"' #playback was stopped due to lack of data. The last 2 invocations of the data callback didn't provide new chunks in time (intentionally or unintentionally) and the internal buffers were fully consumed.
---|'"paused"' #playback was paused by pcm.drv:pause().
---|'"stopped"' #playback was stopped by pcm.drv:stop().
---|'"vu"' #new peak data, cb_fn is triggered freq times per second (1 to 200 Hz).
---`event` identifier, one of:
---@param cb_fn? function callback function for the specified event. Unregisters previous function if omitted. First parameter is drv, followed by peak data for vu callback.
---@param freq? number
---@return nil
function pcmdrv:on(event, cb_fn, freq) end

---Starts playback.
---@param rate integer|'pcm.RATE_1K'|'pcm.RATE_2K'|'pcm.RATE_4K'|'pcm.RATE_5K'|'pcm.RATE_8K'|'pcm.RATE_10K'|'pcm.RATE_12K'|'pcm.RATE_16K'
---@return nil
function pcmdrv:play(rate) end

---Pauses playback. A call to drv:play() will resume from the last position.
---@return nil
function pcmdrv:pause() end

---Stops playback and releases buffered chunks.
---@return nil
function pcmdrv:stop() end

--*** PERF ***
perf = {}

---Starts a performance monitoring session.
---@param start? number The lowest PC address for the histogram. Default is 0x40000000.
---@param endaddr? number The highest address for the histogram. Default is the end of the used space in the flash memory.
---@param nbins? number The number of bins in the histogram. Keep this reasonable otherwise you will run out of memory. Default is 1024.
---@return nil
function perf.start(start, endaddr, nbins) end

---Terminates a performance monitoring session and returns the histogram.
---@return number total The total number of samples captured in this run
---@return number outside The number of samples that were outside the histogram range
---@return number histogram The histogram represented as a table indexed by address where the value is the number of samples.
---@return number binsize The number of bytes per histogram bin.
function perf.stop() end

--*** PIPE ***
pipe = {}

---@class pipe
pobj = pipe.create()

---Create a pipe.
---@param CB_function? function optional reader callback which is called through the *node.task.post()* when the pipe is written to.
---@param task_priority? integer
---|'node.task.LOW_PRIORITY' #0
---|'node.task.MEDIUM_PRIORITY' #1
---|'node.task.HIGH_PRIORITY' #2
---@return pipe obj A pipe resource.
function pipe.create(CB_function,task_priority) end

---Read a record from a pipe object.
---@param size_end_char? number|string
-- `size/end_char`
-- If numeric then a string of size length will be returned from the pipe.
-- If a string then this is a single character delimiter, followed by an optional "+" flag. The delimiter is used as an end-of-record to split the character stream into separate records. If the flag "+" is specified then the delimiter is also returned at the end of the record, otherwise it is discarded.
-- If omitted, then this defaults to "\n+"
---@return string|nil
function pobj:read(size_end_char) end

---Returns a Lua iterator function for a pipe object.
---@param size_end_char? number|string
-- `size/end_char`
-- If numeric then a string of size length will be returned from the pipe.
-- If a string then this is a single character delimiter, followed by an optional "+" flag. The delimiter is used as an end-of-record to split the character stream into separate records. If the flag "+" is specified then the delimiter is also returned at the end of the record, otherwise it is discarded.
-- If omitted, then this defaults to "\n+"
---@return any myFunc iterator function
function pobj:reader(size_end_char) end

---Write a string to the head of a pipe object. This can be used to back-out a previous read.
---@param s string Any input string. Note that with all Lua strings, these may contain all character values including "\0".
function pobj:unread(s) end

---Write a string to a pipe object.
---@param s string Any input string. Note that with all Lua strings, these may contain all character values including "\0".
function pobj:write(s) end

--*** PWM ***
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

--*** PWM2 ***
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

---Starts PWM for all setup pins. At this moment GPIO pins are marked as output and TIMER1 is being reserved for this module.
---@return boolean b true if PWM started ok, false of TIMER1 is reserved by another module.
function pwm2.start() end

---Stops PWM for all pins. All GPIO pins and TIMER1 are being released.
---@return nil
function pwm2.stop() end

---Sets duty cycle for one or more a pins.
---@param pin integer 1~12, IO index
---@param duty number 0~period, pwm duty cycle
---@param pinN? integer 1~12, IO index
---@param dutyN? number 0~period, pwm duty cycle
---@return nil
function pwm2.set_duty(pin, duty, pinN, dutyN) end

---Releases given pin from previously done setup.
---@param pin integer 1~12, IO index
---@return nil
function pwm2.release_pin(pin) end

---Prints internal data structures related to the timer.
---@return boolean isStarted if true PWM2 has been started
---@return integer interruptTimerCPUTicks int, desired timer interrupt period in CPU ticks
---@return integer interruptTimerTicks int, actual timer interrupt period in timer ticks
function pwm2.get_timer_data() end

---Prints internal data structures related to given GPIO pin.
---@param pin integer 1~12, IO index
---@return boolean isPinSetup bool, if 1 pin is setup
---@return integer duty int, assigned duty
---@return integer pulseResolutions int, assigned pulse periods
---@return integer divisableFrequency int, assigned frequency
---@return integer frequencyDivisor int, assigned frequency divisor
---@return integer resolutionCPUTicks int, calculated one pulse period in CPU ticks
---@return integer resolutionInterruptCounterMultiplier int, how many timer interrupts constitute one pulse period
function pwm2.get_pin_data(pin) end

--*** RFSWITCH ***
rfswitch = {}

---Transmit data using the radio module.
---@param protocol_id integer positive integer value, from 1-6
---@param pulse_length integer length of one pulse in microseconds, usually from 100 to 650
---@param repeat_val integer repeat value, usually from 1 to 5. This is a synchronous task.
---@param pin integer I/O index of pin, example 6 is for GPIO12
---@param value integer positive integer value, this is the primary data which will be sent
---@param length integer bit length of value, if value length is 3 bytes, then length is 24
---@return nil
function rfswitch.send(protocol_id, pulse_length, repeat_val, pin, value, length) end

--*** ROTARY TODO ***

--*** RTCFIFO TODO ***
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

--*** RTCMEM  ***
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

--*** RTCTIME ***
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

--*** SI7021 ***
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

--*** SIGMA DELTA ***
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

--*** SJSON ***
sjson = {}

---@class sjsonenc
local encoder = sjson.encoder()
---@class sjsondec
local decoder = sjson.decoder()

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table  data to encode
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---@return sjsonenc obj A sjson.encoder object.
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer an optional value for the number of bytes to return. The default is 1024.
---@return string | nil A string of up to size bytes, or nil if the encoding is complete and all data has been returned.
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table data to encode
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---@return string s JSON string
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object.
---@param opts? table
---*opts* an optional table of options. The possible entries are:
---`depth` the maximum encoding depth needed to encode the table. The default is 20.
---`null` the string value to treat as null.
---`metatable` a table to use as the metatable for all the new tables in the returned object.
---@return sjsondec obj A sjson.decoder object
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string the next piece of JSON encoded data
---@return any|nil The constructed Lua object or nil if the decode is not yet complete.
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

--*** SNTP ***
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

--*** SOFTUART ***
softuart = {}

---@class softuart
local s_uart = softuart.setup()

---Creates new SoftUART instance.
---@param baudrate number :SoftUART baudrate. Maximum supported is 230400.
---@param txPin number :SoftUART tx pin. If set to nil write method will not be supported.
---@param rxPin number :SoftUART rx pin. If set to nil on("data") method will not be supported.
---@return softuart swp softuart instance.
function softuart.setup(baudrate, txPin, rxPin) end

---Sets up the callback function to receive data.
---@param event string|"data"
---@param trigger number Can be a character or a number.
---@param fun function
---@return nil
function s_uart:on(event, trigger, fun) end

---Transmits a byte or sequence of them.
---@param data number|string
---@return nil
function s_uart:write(data) end

--*** SOMFY ***
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

--*** SPI ***
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

--*** SWITEC TODO ***
switec = {}

--*** TCS34725  TODO ***
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

--*** TLS TODO ***
tls = {}

---@class tls
local TLS = tls.createConnection()

---Creates TLS connection.
---@return tls tls.socket sub module
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

--*** TM1829 ***
tm1829 = {}

---Send data to a led strip using native chip format.
---@param str string
---@return nil
function tm1829.write(str) end

--*** TMR ***
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
---@return tmr
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

--*** TSL2561 ***
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

--*** U8G2 TODO ***
u8g2 = {}

--*** UART ***
uart = {}

---Change UART pin assignment.
---@param on integer
---`0` for standard pins
---`1` to use alternate pins GPIO13 and GPIO15
---@return nil
function uart.alt(on) end

---Sets the callback function to handle UART events.
---@param method string|'"data"'
---`"data"`, data has been received on the UART. To unregister the callback, provide only the "data" parameter.
---@param number_end_char? any
---`number` if n=0, will receive every char in buffer
---`number` if n<255, the callback is called when n chars are received
---`end_char` if one char "c", the callback will be called when "c" is encountered, or max n=255 received
---@param fun? function|' function(data) end'
---@param run_input? integer|' 0'|' 1'
---@return nil
function uart.on(method, number_end_char, fun, run_input) end

---(Re-)configures the communication parameters of the UART.
---@param id integer UART id (0 or 1).
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400'
---@param databits integer|' 8'|' 7'|' 6'|' 5'
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN'
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2'
---@param echo integer 0 - disable echo, 1 - enable echo (default if omitted)
---@return number br configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo) end

---Returns the current configuration parameters of the UART.
---@param id integer UART id (0 or 1).
---@return number baud one of 300, ..., 3686400
---@return number databits one of 5, 6, 7, 8
---@return number parity uart.PARITY_NONE | uart.PARITY_ODD | or uart.PARITY_EVEN
---@return number stopbits uart.STOPBITS_1 | uart.STOPBITS_1_5 | or uart.STOPBITS_2
function uart.getconfig(id) end

---Write string or byte to the UART.
---@param id integer UART id (0 or 1).
---@param data1 string|number ... string or byte to send via UART
---@vararg string|number
---@return nil
function uart.write(id, data1, ...) end

---Report the depth, in bytes, of TX or RX hardware queues associated with the UART.
---@param id integer UART id (0 or 1).
---@param dir integer|' uart.DIR_RX'|' uart.DIR_TX'
---@return integer num The number of bytes in the selected FIFO.
function uart.fifodepth(id, dir) end

--*** UCG TODO ***
ucg ={}

--*** WEBSOCKET ***
websocket = {}

---@class websocket
local ws = websocket.createClient()

---Creates a new websocket client.
---@return websocket websocketclient
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

--*** WIEGANG ***
wiegand = {}

---@class wiegand
local wiegandobj = wiegand.create()

---Creates a dynamic wiegand object that receives a callback when data is received.
---@param pinD0 number This is a GPIO number (excluding 0) and connects to the D0 data line
---@param pinD1 number This is a GPIO number (excluding 0) and connects to the D1 data line
---@param callback function This is a function that will invoked when a full card or keypress is read.
---@return wiegand wiegand object. If the arguments are in error, or the operation cannot be completed, then an error is thrown.
function wiegand.create(pinD0, pinD1, callback) end

---Releases the resources associated with the card reader.
---@return nil
function wiegandobj:close() end

--*** WIFI ***
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

--*** WiFi MONITOR TODO ***
wifi.monitor = {}

--*** WPS ***
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

--*** WS2801 ***
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

--*** WS2812 ***
ws2812 = {}

---@class ws2812
local buffer = ws2812.newBuffer()

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

--*** WS2812-EFFECTS ***
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

--*** XPT2046 ***
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
