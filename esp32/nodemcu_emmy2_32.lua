--*** OTA ***
otaupgrade = {}

---The boot info and application state and version info can be queried with this function.
---@return string --the name of the partition of the running application
---@return string --the name of the partition currently marked for boot next
---@return table --a table whose keys are the names of OTA partitions and corresponding values are tables containing:
--**state** one of *new, testing, valid, invalid, aborted* or possibly *undefined*
--**name** the application name, typically "NodeMCU"
--**date** the build date
--**time** the build time
--**version** the build version, as set by the *PROJECT_VER* variable during build
--**secure_version** the secure version number, if secure boot is enabled
--**idf_version** the IDF version
function otaupgrade.info() end

---Wipes the spare application partition and prepares to receive the new application firmware.
---@return nil --`nil`. A Lua error may be raised if the OTA upgrade cannot be commenced for some reason (such as due to incorrect partition setup).
function otaupgrade.commence() end

---Write a chunk of application firmware data to the correct partition and location. Data must be streamed sequentially, the IDF does not support out-of-order data as would be the case from e.g. bittorrent.
---@param data string a string of binary data
---@return nil --`nil`. A Lua error may be raised if the data can not be written, e.g. due to the data not being a valid OTA image (the IDF performs some checks in this regard).
function otaupgrade.write(data) end

---Finalises the upgrade, and optionally reboots into the new application firmware right away.
---@param reboot integer|nil `1` to reboot into the new firmware immediately, `nil` to keep running
---@return nil --`nil`. A Lua error may be raised if the image does not pass validation, or no data has been written to the image at all.
function otaupgrade.complete(reboot) end

---When the installed boot loader is built with rollback support, a new application image is by default only booted once. During this "test run" it can perform whatever checks is appropriate (like testing whether it can still reach the update server), and if satisfied can mark itself as valid. Without being marked valid, upon the next reboot the system would "roll back" to the previous version instead.
---@return nil
function otaupgrade.accept() end

---A new firmware may decide that it is not performing as expected, and request an explicit rollback to the previous version. If the call to this function succeeds, the system will reboot without returning from the call.
--Note that it is also possible to roll back to a previous firmware version even after the new version has called `otaupgrade.accept()`.
function otaupgrade.rollback() end

--*** 1-WIRE ***
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string string value, data to be calculated check sum in string
---@param inverted_crc0 number LSB of received CRC
---@param inverted_crc1 number MSB of received CRC
---@param crc? number CRC starting value (optional)
---@return boolean --`true` if the CRC matches, `false` otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf number string value, data to be calculated check sum in string
---@param crc? number CRC starting value (optional)
---@return number --the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used in the ROM and scratchpad registers.
---@param buf string string value, data to be calculated check sum in string
---@return number --CRC result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus. You only need to do this if you used the 'power' flag to ow.write() or used a ow.write_bytes() and aren't about to do another read or write.
---@param pin integer IO index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer IO index
---@return integer --byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer IO index,
---@param size number number of bytes to be read from slave device (up to 256)
---@return string --bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer IO index
---@return integer
---|'1' #if a device responds with a presence pulse
---|'0' #if there is no device or the bus is shorted or otherwise held low for more than 250 µS
function ow.reset(pin) end

---Clears the search state so that it will start from the beginning again.
---@param pin integer IO index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer IO index
---@return string|nil --`rom_code` string with length of 8 upon success. It contains the rom code of slave device. Returns `nil` if search was unsuccessful.
function ow.search(pin) end

---Issues a 1-Wire rom select command. Make sure you do the `ow.reset(pin)` first.
---@param pin integer IO index
---@param rom string string value, len 8, rom code of the slave device
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer IO index
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command, to address all on bus.
---@param pin integer IO index
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code. The search itself has to be initiated with a subsequent call to `ow.search()`.
---@param pin integer IO index
---@param family_code integer byte for family code
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end for parasitically powered devices. You are responsible for eventually depowering it by calling ow.depower() or doing another read or write.
---@param pin integer IO index
---@param v integer byte to be written to slave device
---@param power integer 1 for wire being held high for parasitically powered devices
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end for parasitically powered devices. You are responsible for eventually depowering it by calling ow.depower() or doing another read or write.
---@param pin integer IO index
---@param buf string string to be written to slave device
---@param power integer 1 for wire being held high for parasitically powered devices
---@return nil
function ow.write_bytes(pin, buf, power) end

--*** PULSECNT ***
pulsecnt = {}

---@class pulsecnt
local pulsecntObj = {}

---Create the pulse counter object.
---@param unit integer ESP32 has 0 thru 7 units to count pulses on.
---@param callbackOnEvents? function Your Lua method to call on `event.myfunction(unit, isThr0, isThr1, isLLim, isHLim, isZero)` will be called.
--Event will be
--    PCNT_EVT_THRES_0 (Threshold 0 hit),
--    PCNT_EVT_THRES_1 (Threshold 1 hit),
--    PCNT_EVT_L_LIM (Minimum counter value),
--    PCNT_EVT_H_LIM (Maximum counter value),
--    PCNT_EVT_ZERO (counter value zero event)
---@return pulsecnt --pulsecnt object
function pulsecnt.create(unit, callbackOnEvents) end

---@alias pulse_mode1
---|' pulsecnt.PCNT_COUNT_DIS' #= 0 Counter mode: Inhibit counter  (counter value will not change in this condition).
---|' pulsecnt.PCNT_COUNT_INC' #= 1 Counter mode: Increase counter value.
---|' pulsecnt.PCNT_COUNT_DEC' #= 2 Counter mode: Decrease counter value.

---@alias pulse_mode2
---|' pulsecnt.PCNT_MODE_KEEP' #= 0 Control mode: will not change counter mode.
---|' pulsecnt.PCNT_MODE_REVERSE' #= 1 Control mode: invert counter mode (increase -> decrease, decrease -> increase).
---|' pulsecnt.PCNT_MODE_DISABLE' #= 2 Control mode: Inhibit counter (counter value will not change in this condition).

---Configure channel 0 of the pulse counter object you created from the create() method.
---@param pulse_gpio_num integer Any GPIO pin can be used.
---@param ctrl_gpio_num integer Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 Positive rising edge count mode, i.e. count the pulse when the rising edge occurs.
---@param neg_mode pulse_mode1 Negative falling edge count mode, i.e. count the pulse when the falling edge occurs.
---@param lctrl_mode pulse_mode2 Required. When ctrl_gpio_num is low how should the counter be influenced.
---@param hctrl_mode pulse_mode2 Required. When ctrl_gpio_num is high how should the counter be influenced.
---@param counter_l_lim integer Range -32768 to 32767. The lower limit counter. You get a callback at this count and the counter is reset to zero after this lower limit is hit.
---@param counter_h_lim integer Range -32768 to 32767. The high limit counter.You get a callback at this count and the counter is reset to zero after this high limit is hit.
---@return nil
function pulsecntObj:chan0Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Configure channel 1 of the pulse counter object you created from the `create()` method.
---@param pulse_gpio_num integer Any GPIO pin can be used.
---@param ctrl_gpio_num integer Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 Positive rising edge count mode, i.e. count the pulse when the rising edge occurs.
---@param neg_mode pulse_mode1 Negative falling edge count mode, i.e. count the pulse when the falling edge occurs.
---@param lctrl_mode pulse_mode2  Required. When ctrl_gpio_num is low how should the counter be influenced.
---@param hctrl_mode pulse_mode2 Required. When ctrl_gpio_num is high how should the counter be influenced.
---@param counter_l_lim integer Range -32768 to 32767. The lower limit counter. You get a callback at this count and the counter is reset to zero after this lower limit is hit.
---@param counter_h_lim integer Range -32768 to 32767. The high limit counter. You get a callback at this count and the counter is reset to zero after this high limit is hit.
---@return nil
function pulsecntObj:chan1Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Set the threshold values to establish watchpoints for getting callbacks on.
---@param thr0 integer Threshold 0 value. Range -32768 to 32767. This is a watchpoint value to get a callback with isThr0 set to true on this count being reached.
---@param thr1 integer Threshold 1 value. Range -32768 to 32767. This is a watchpoint value to get a callback with isThr1 set to true on this count being reached.
---@return nil
function pulsecntObj:setThres(thr0, thr1) end

---Set a filter to ignore pulses on the pulse_gpio_num pin and the ctrl_gpio_num to avoid short glitches. Any pulses lasting shorter than this will be ignored.
---@param clkCycleCnt integer 0 to 1023 allowed. Any pulses lasting shorter than this will be ignored. A pulse needs to be high or low for longer than this filter clock cycle. Clock is 80Mhz APB clock, so one cycle is 1000/80,000,000 = 0.0000125 ms. The longest value of 1023 cycles = 0.0127875 ms.
---@return nil
function pulsecntObj:setFilter(clkCycleCnt) end

---Clear the counter. Sets it back to zero.
---@return nil
function pulsecntObj:clear() end

---Get the current pulse counter.
---@return integer
function pulsecntObj:getCnt() end

--*** QRCODEGEN ***
qrcodegen = {}

---Generates a QR Code from a text string.
---@param text any The text or URL to encode. Should be UTF-8 or ASCII.
---@param options? table An optional table, containing any of:
--**minver** the minimum version according to the QR Code Model 2 standard. If not specified, defaults to 1.
--**maxver** the maximum version according to the QR Code Model 2 standard. If not specified, defaults to 40. Specifying a lower maximum version reduces the amount of temporary memory the function requires, so it can be worthwhile to specify a smaller value if you know the text will fit in a lower-version QR Code.
--**ecl** the error correction level in a QR Code symbol. Higher error correction produces a larger QR Code. One of:
--    qrcodegen.LOW (default if not specified)
--    qrcodegen.MEDIUM
--    qrcodegen.QUARTILE
--    qrcodegen.HIGH
--**mask** the mask pattern used in a QR Code symbol. An integer 0-7, or qrcodegen.AUTO (the default).
--**boostecl** defaults to false.
---@return string|nil --The QR Code, encoded as a string. Use `qrcodegen.getSize()` and `qrcodegen.getPixel()` to extract data from the result. If the text cannot be represented within the given version range (for example it is too long) then `nil` is returned.
function qrcodegen.encodeText(text, options) end

---@param qrcode string a QR Code string, as returned by `qrcodegen.encodeText()`.
---@return integer --Returns the side length in pixels of the given QR Code. The result is in the range [21, 177].
function qrcodegen.getSize(qrcode) end

---Get the color of the pixel at the given coordinates of the QR Code. `x` and `y` must be between 0 and the value returned by `qrcodegen.getSize()`.
---@param qrcode string a QR Code string, as returned by `qrcodegen.encodeText()`.
---@param x number coordinate
---@param y number coordinate
---@return boolean --`true` if the given pixel is black, `false` if it is white.
function qrcodegen.getPixel(qrcode, x, y) end

--*** SDMMC ***
sdmmc = {}

---@class sdmmc
local card = {}

---SDMMC Mode. Initialize the SDMMC and probe the attached SD card.
---@param slot integer SDMMC slot, one of `sdmmc.HS1` | `sdmmc.HS2`
---@param cfg? table
--`cfg` optional table containing slot configuration:
--**cd_pin** card detect pin, none if omitted
--**wp_pin** write-protcet pin, none if omitted
--**fmax** maximum communication frequency, defaults to 20  if omitted
--**width** bis width, defaults to sdmmc.W1BIT if omitted, one of:
--        sdmmc.W1BIT
--        sdmmc.W4BIT
--        sdmmc.W8BIT, not supported yet
---@return sdmmc cardObj Card object. Error is thrown for invalid parameters or if SDMMC hardware or card cannot be initialized.
function sdmmc.init(slot, cfg) end

---SD SPI Mode. Initialize the SDMMC and probe the attached SD card.
---@param slot integer SD SPI slot, one of `sdmmc.HSPI` | `sdmmc.VSPI`
---@param cfg table
--`cfg` mandatory table containing slot configuration:
--**sck_pin** SPI SCK pin, mandatory
--**mosi_pin**, SPI MOSI pin, mandatory
--**miso_pin**, SPI MISO pin, mandatory
--**cs_pin**, SPI CS pin, mandatory
--**cd_pin** card detect pin, none if omitted
--**wp_pin** write-protcet pin, none if omitted
--**fmax** maximum communication frequency, defaults to 20  if omitted
---@return sdmmc cardObj Card object. Error is thrown for invalid parameters or if SDMMC hardware or card cannot be initialized.
function sdmmc.init(slot, cfg) end

---Retrieve information from the SD card.
---@return table --Table containing the card's OCR, CID, CSD, SCR, and RCA with elements:
--**ocr** Operation Conditions Register
--**cid** Card IDentification:
--*date* - manufacturing date
--*mfg_id* - manufacturer ID
--*name* - product name
--*oem_id* - OEM/product ID
--*revision* - product revision
--*serial* - product serial number
--**csd** Card-Specific Data:
--*capacity* - total number of sectors
--*card_command_class* - card command class for SD
--*csd_ver* - CSD structure format
--*mmc_ver* - MMC version (for CID format)
--*read_block_len* - block length for reads
--*sector_size* - sector size in bytes
--*tr_speed* - maximum transfer speed
--**scr**:
--*sd_spec*-  SD physical layer specification version, reported by card
--*bus_width* - bus widths supported by card
--**rca** Relative Card Address
function card:get_info() end

---Mount filesystem on SD card.
---@param ldrv string|'"/SD0"'|'"/SD1"' name of logical drive
---@param slot? integer|'sdmmc.HS2'|'sdmmc.HS1'
---@return boolean
function card:mount(ldrv, slot) end

---Read one or more sectors.
---@param start_sec integer first sector to read from
---@param num_sec integer number of sectors to read (>= 1)
---@return string --String containing the sector data. Error is thrown for invalid parameters or if sector(s) cannot be read.
function card:read(start_sec, num_sec) end

---Unmount filesystem.
---@return nil --`nil`. Error is thrown if filesystem is not mounted or if it cannot be unmounted.
function card:umount() end

---Write one or more sectors.
---@param start_sec integer first sector to write to
---@param data any string of data to write, must be multiple of sector size (512 bytes)
---@return nil --`nil`. Error is thrown for invalid parameters or if sector(s) cannot be written.
function card:write(start_sec, data) end

--*** SIGMA DELTA ***
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

---Routes the sigma-delta channel to the specified pin. Target prescale and duty values should be applied prior to enabling the output with this command.
---@param channel integer  0~7, sigma-delta channel index
---@param pin integer IO index
---@return nil
function sigma_delta.setup(channel, pin) end

--*** SJSON ***
sjson = {}

---@class sjsonenc
local encoder = {}
---@class sjsondec
local decoder = {}

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table data to encode
---@param opts? table an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
---@return sjsonenc --A sjson.encoder object.
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer an optional value for the number of bytes to return. The default is 1024.
---@return string|nil --A `string` of up to size bytes, or `nil` if the encoding is complete and all data has been returned.
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table data to encode
---@param opts? table an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20 which should be enough for nearly all situations.
--**null** the string value to treat as null.
---@return string --JSON string
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object. A metatable can be specified for all the newly created Lua tables. This allows you to handle each value as it is inserted into each table (by implementing the __newindex method).
---@param opts? table an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
--**metatable** a table to use as the metatable for all the new tables in the returned object.
---@return sjsondec --A `sjson.decoder` object
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string the next piece of JSON encoded data
---@return any|nil --The constructed Lua object or `nil` if the decode is not yet complete. If a parse error occurrs during this decode, then an error is thrown and the parse is aborted. The object cannot be used again.
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete. This can be called multiple times and will return the same object each time. If the decode is not complete, then an error is thrown.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string JSON string to decode
---@param opts? table an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
--**metatable** a table to use as the metatable for all the new tables in the returned object.
---@return table --Lua table representation of the JSON data. If the string is not valid JSON, then an error is thrown.
function sjson.decode(str, opts) end

--*** SODIUM ***
sodium = {}

---Returns a random integer between `0` and `0xFFFFFFFF` inclusive.
---@return integer --A uniformly-distributed random integer between 0 and 0xFFFFFFFF inclusive.
function sodium.random.random() end

---Returns a random integer 0 <= result < upper_bound
---@param upper_bound integer must be an integer *<= 0xFFFFFFFF*.
---@return integer --An integer *>= 0* and *< upper_bound*
function sodium.random.uniform(upper_bound) end

---Generates *n* bytes of random data. Wifi must be started, by calling `wifi.start()`, before calling this function.
---@param n number number of bytes to return.
---@return string --A string of *n* random bytes.
function sodium.random.buf(n) end

---Generates a new keypair. Wifi must be started, by calling `wifi.start()`, before calling this function.
---@return string public_key
---@return string secret_key
function sodium.crypto_box.keypair() end

---Encrypts a message using a public key.
---@param message string the string to encrypt.
---@param public_key string the public key to encrypt with.
---@return string|any --The encrypted message, as a string. Errors if public_key is not a valid public key as returned by sodium.crypto_box.keypair() or if the message could not be encrypted.
function sodium.crypto_box.seal(message, public_key) end

---Decrypts a message encrypted with `crypto_box.seal()`.
---@param ciphertext any the encrypted message.
---@param public_key string the public key the message was encrypted with.
---@param secret_key string the secret key corresponding to the specified public key.
---@return any|nil --The decrypted plain text of the message. Returns `nil` if the *ciphertext* could not be decrypted.
function sodium.crypto_box.seal_open(ciphertext, public_key, secret_key) end

--*** SPI ***
spi = {}

---@class spi
local busmaster = {}
---@class spidev
local device = {}

---Initializes a bus in master mode and returns a bus master object.
---@param host integer|'spi.VSPI'|'spi.HSPI'|'spi.SPI1' id
---@param config? table table listing the assigned GPIOs. All signal assignment are optional. **sclk, mosi, miso, quadwp, quadhd**
---@param dma? integer|'1'|'2'|'0' set DMA channel (1 or 2) or disable DMA (0), defaults to 1 if omitted.
---@return spi --SPI bus master object
function spi.master(host, config, dma) end

---Close the bus host. This fails if there are still devices registered on this bus.
---@return nil
function busmaster:close() end

---Adds a device on the given master bus. Up to three devices per bus are supported.
---@param config table table describing the device parameters:
--**cs** GPIO connected to device's chip-select pin, optional
--**mode** SPI mode used for this device (0-3), mandatory
--**freq** clock frequency used for this device [Hz], mandatory
--**command_bits** amount of bits in command phase (0-16), defaults to 0 if omitted
--**address_bits** amount of bits in address phase (0-64), defaults to 0 if omitted
--**dummy_bits** amount of dummy bits to insert address and data phase, defaults to 0 if omitted
--**cs_ena_pretrans**, optional
--**cs_ena_posttrans**, optional
--**duty_cycle_pos**, optional
--**tx_lsb_first** transmit command/address/data LSB first if true, MSB first otherwise (or if omitted)
--**rx_lsb_first** receive data LSB first if true, MSB first otherwise (or if omitted)
--**wire3** use spiq for both transmit and receive if true, use mosi and miso otherwise (or if omitted)
--**positive_cs** chip-select is active high during a transaction if true, cs is active low otherwise (or if omitted)
--**halfduplex** transmit data before receiving data if true, transmit and receive simultaneously otherwise (or if omitted)
--**clk_as_cs** output clock on cs line when cs is active if true, defaults to false if omitted
---@return spidev --SPI device object
function busmaster:device(config) end

---Removes a device from the related bus master.
---@return nil
function device:remove() end

---Initiate an SPI transaction.
--*txdata* string of data to be sent to the device
---@overload fun(txdata:string):string
---@param trans table table containing the elements of the transaction:
--**command** data for command phase, amount of bits was defined during device creation, optional
--**address** data for address phase, amount of bits was defined during device creation, optional
--**txdata** string of data to be sent to the device, optional
--**rxlen** number of bytes to be received, optional
--**mode** optional, one of
--    sio transmit in SIO mode, default if omitted
--    dio transmit in DIO mode
--    qio transmit in QIO mode
--**addr_mode** transmit address also in selected mode if true, transmit address in SIO otherwise.
---@return string --String of rxlen length, or #txdata length if rxlen is omitted.
function device:transfer(trans) end

---Initializes a bus in slave mode and returns a slave object. `Not yet supported.`
function spi.slave() end

--*** STRUCT ***
struct = {}

---Returns a string containing the values d1, d2, etc. packed according to the format string fmt.
---@param fmt string The format string
---@param d1 any The first data item to be packed
---@param d2 any The second data item to be packed etc.
---@return string --The packed string.
function struct.pack (fmt, d1, d2, ...) end

---Returns the values packed in string s according to the format string `fmt`.
---@param fmt string The format string
---@param s string  The string holding the data to be unpacked
---@param offset? integer The position to start in the string (default is 1)
---@return any --All the unpacked data.
function struct.unpack (fmt, s, offset) end

---Returns the size of a string formatted according to the format string `fmt`.
---@param fmt string The format string
---@return integer --The size of the string that would be output in a pack operation with this format string.
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
---@return integer --number of seconds since the Epoch
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
---@return boolean --`true' if NTP client is enabled.
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
local tObj = {}

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
local tp = {}

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
---@return number --configured baud rate
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
---@return boolean --`true` if uart is started.
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
---@return integer sch HT20/HT40 information (secondary channel). One of the constants: wifi.HT20, wifi.HT40_ABOVE, wifi.HT40_BELOW
function wifi.getchannel() end

---Gets WiFi operation mode.
---@return integer --The WiFi mode, as one of the wifi.STATION, wifi.SOFTAP, wifi.STATIONAP or wifi.NULLMODE constants.
function wifi.getmode() end

---Configures the WiFi mode to use.
---@param mode integer
---|'wifi.STATION' #for when the device is connected to a WiFi router.
---|'wifi.SOFTAP'  #for when the device is acting only as an access point.
---|'wifi.STATIONAP' #is the combination of wifi.STATION and wifi.SOFTAP
---|'wifi.NULLMODE' #disables the WiFi interface(s).
---@param save? boolean
---|>' true' #WiFi mode configuration will be retained through power cycle.
---|' false' #WiFi mode configuration will not be retained through power cycle.
-- choose whether or not to save wifi mode to flash
---@return any --current mode after setup
function wifi.mode(mode, save) end

---Starts the WiFi interface(s).
---@return nil
function wifi.start() end

---Shuts down the WiFi interface(s).
---@return nil
function wifi.stop() end

---Sets the WiFi station configuration. The WiFi mode must be set to wifi.STATION or wifi.STATIONAP before this function can be used.
---@param station_config table table containing configuration data for station
---`ssid` string which is less than 32 bytes.
---`pwd` string which is 8-64 or 0 bytes. Empty string indicates an open WiFi access point.
---`auto` defaults to true
---**true** to enable auto connect and connect to access point, hence with auto=true there's no need to call wifi.sta.connect()
---**false** to disable auto connect and remain disconnected from access point
---`bssid` string that contains the MAC address of the access point (optional)
-- You can set BSSID if you have multiple access points with the same SSID.
-- Note: if you set BSSID for a specific SSID and would like to configure station to connect to the same SSID only without the BSSID requirement, you MUST first configure to station to a different SSID first, then connect to the desired SSID
-- The following formats are valid:
-- "DE:C1:A5:51:F1:ED"
-- "AC-1D-1C-B1-0B-22"
-- "DE AD BE EF 7A C0"
-- "AcDc0123c0DE"
---@param save boolean
---|' true' #configuration will be retained through power cycle.
---|>' false' #configuration will not be retained through power cycle.
-- Save station configuration to flash.
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
---@param callback function|' function(event, info) end'
---callback function(event, info) to perform when event occurs, or `nil` to unregister the callback for the event. The info argument given to the callback is a table containing additional information about the event.
-- Event information provided for each event is as follows:
--`start`: no additional info
--`stop`: no additional info
--`connected`: information about network/AP that was connected to:
--**ssid**: the SSID of the network
--**bssid**: the BSSID of the AP
--**channel**: the primary channel of the network
--**auth** authentication method, one of wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK (default), wifi.WPA_WPA2_PSK
--`disconnected`: information about the network/AP that was disconnected from:
--**ssid**: the SSID of the network
--**bssid**: the BSSID of the AP
--**reason**: an integer code for the reason (see table below for mapping)
--`authmode_changed`: authentication mode information:
--**old_mode**: the previous auth mode used
--**new_mode**: the new auth mode used
--`got_ip`: IP network information:
--**ip**: the IP address assigned
--**netmask**: the IP netmask
--**gw**: the gateway ("0.0.0.0" if no gateway)
---@return nil
function wifi.sta.on(event, callback) end

---Gets MAC address in station mode.
---@return string
function wifi.sta.getmac() end

---Scan for available networks.
---@param cfg table cfg table that contains scan configuration:
---`ssid` SSID == nil, don't filter SSID
---`bssid` BSSID == nil, don't filter BSSID
---`channel` channel == 0, scan all channels, otherwise scan set channel (default is 0)
---`hidden` hidden == 1, get info for router with hidden SSID (default is 0)
---@param callback function
---|' function(ap_list) end'
--- callback(ap_list) a callback function to receive the list of APs when the scan is done. Each entry in the returned array follows the format used for wifi.sta.config(), with some additional fields.
-- The following fields are provided for each scanned AP:
--`ssid`: the network SSID
--`bssid`: the BSSID of the AP
--`channel`: primary WiFi channel of the AP
--`rssi`: Received Signal Strength Indicator value
--`auth` authentication method, one of wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK (default), wifi.WPA_WPA2_PSK
--`bandwidth`: one of the following constants: **wifi.HT20**, **wifi.HT40_ABOVE**, **wifi.HT40_BELOW**
---@return nil
function wifi.sta.scan(cfg, callback) end

---Sets IP address, netmask, gateway, dns address in station mode.
---@param cfg table cfg table to hold configuration:
---`ip` device ip address.
---`netmask` network netmask.
---`gateway` gateway address.
---`dns name` server address.
---@return nil
function wifi.sta.setip(cfg) end

---Sets station hostname. Must be called before wifi.sta.connect(). Options set by this function are not saved to flash.
---@param hostname string hostname must only contain letters, numbers and hyphens('-') and be 32 characters or less with first and last character being alphanumeric
---@return boolean
function wifi.sta.sethostname(hostname) end

---Configures the AP. The WiFi mode must be set to wifi.SOFTAP or wifi.STATIONAP before this function can be used.
---@param cfg table cfg table to hold configuration:
---`ssid` SSID chars 1-32
---`pwd` password chars 8-64
---`auth` authentication method, one of wifi.AUTH_OPEN, wifi.AUTH_WPA_PSK, wifi.AUTH_WPA2_PSK (default), wifi.AUTH_WPA_WPA2_PSK
---`channel` channel number 1-14 default = 11
---`hidden` false = not hidden, true = hidden, default = false
---`max` maximum number of connections 1-4 default=4
---`beacon` beacon interval time in range 100-60000, default = 100
---@param save boolean
---|>' true' #configuration will be retained through power cycle.
---|' false' #configuration will not be retained through power cycle.
-- save configuration to flash.
---@return nil
function wifi.ap.config(cfg, save) end

---Registers callbacks for WiFi AP events.
---@param event string|'"start"'|'"stop"'|'"sta_connected"'|'"sta_disconnected"'|'"probe_req"'
---@param callback function|' function(event, info) end'
--callback function(event, info) to perform when event occurs, or nil to unregister the callback for the event. The info argument given to the callback is a table containing additional information about the event.
-- Event information provided for each event is as follows:
--`start`: no additional info
--`stop`: no additional info
--`sta_connected`: information about the client that connected:
--**mac**: the MAC address
--**id**: assigned station id (AID)
--`disconnected`: information about disconnecting client
--**mac**: the MAC address
--**id**: assigned station id (AID)
--`probe_req`: information about the probing client
--**from**: MAC address of the probing client
--**rssi**: Received Signal Strength Indicator value
function wifi.ap.on(event, callback) end

---Gets MAC address in access point mode.
---@return string MAC address as string e.g. "18:fe:34:a2:d7:34"
function wifi.ap.getmac() end

---Sets IP address, netmask, gateway, dns address in AccessPoint mode.
---@param cfg table table to hold configuration:
---`ip` device ip address.
---`netmask` network netmask.
---`gateway` gateway address.
---`dns` name server address, which will be provided to clients over DHCP. (Optional)
---@return nil
function wifi.ap.setip(cfg) end

---Sets AccessPoint hostname.
---@param hostname string must only contain letters, numbers and hyphens('-') and be 32 characters or less with first and last character being alphanumeric
---@return boolean
function wifi.ap.sethostname(hostname) end

--*** WS2812 ***
ws2812 = {}

---@class ws2812
local buffer =  {}

---Send data to up to 8 led strip using its native format which is generally Green,Red,Blue for RGB strips and Green,Red,Blue,White for RGBW strips.
---@param tbl table
--Variable number of tables, each describing a single strip. Required elements are:
--**pin** IO index, see GPIO Overview
--**data** payload to be sent to one or more WS2812 like leds through GPIO2
--Payload type could be:
--**string** representing bytes to send
--**ws2812.buffer** see Buffer module
---@return nil
function ws2812.write(tbl, ...) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer length of the led strip
---@param bytesPerLed integer 3 for RGB strips and 4 for RGBW strips
---@return ws2812
function ws2812.newBuffer(numberOfLeds, bytesPerLed) end

---Return the value at the given position
---@param index integer position in the buffer (1 for first led)
---@return number (color)
function buffer:get(index) end

---Set the value at the given position
---@param index integer position in the buffer (1 for the first led)
---@param color number|any payload of the color
-- `number, number, ...` you should pass as many arguments as *bytesPerLed*
-- `table` should contains *bytesPerLed* numbers
-- `string` should contains *bytesPerLed* bytes
---@return nil
function buffer:set(index, color) end

---Return the size of the buffer in number of leds
---@return integer
function buffer:size() end

---Fill the buffer with the given color. The number of given bytes must match the number of *bytesPerLed* of the buffer
---@param color number bytes of the color, you should pass as many arguments as *bytesPerLed*
---@return nil
function buffer:fill(color) end

---Returns the contents of the buffer (the pixel values) as a string. This can then be saved to a file or sent over a network.
---@return string str A string containing the pixel values.
function buffer:dump() end

---Inserts a string (or a buffer) into another buffer with an offset.  The buffer must have the same number of colors per led or an error will be thrown.
---@param source string|any the pixel values to be set into the buffer. This is either a string or a buffer.
---@param offset? integer the offset where the source is to be placed in the buffer. Default is 1. Negative values can be used.
---@return nil
function buffer:replace(source, offset) end

---This is a general method that loads data into a buffer that is a linear combination of data from other buffers.
---@param factor1 number This is the factor that the contents of buffer1 are multiplied by. This factor is scaled by a factor of 256. Thus factor1 value of 256 is a factor of 1.0.
---@param buffer1 any This is the source buffer. It must be of the same shape as the destination buffer.
---@return nil
function buffer:mix(factor1, buffer1, ...) end

---Computes the total energy requirement for the buffer.
---@return integer sum An integer which is the sum of all the pixel values.
function buffer:power() end

---Fade in or out. Defaults to out. Multiply or divide each byte of each led with/by the given value. Useful for a fading effect.
---@param value number value by which to divide or multiply each byte
---@param direction? integer|' ws2812.FADE_IN'|' ws2812.FADE_OUT'
---@return nil
function buffer:fade(value, direction) end

---Shift the content of (a piece of) the buffer in positive or negative direction.
---@param value number number of pixels by which to rotate the buffer. Positive values rotate forwards, negative values backwards.
---@param mode? integer
---|>' ws2812.SHIFT_LOGICAL' #the freed pixels are set to 0 (off).
---|' ws2812.SHIFT_CIRCULAR' #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end.
---@param i? integer is the first offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is 1.
---@param j? integer is the last offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is -1.
---@return nil
function buffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub. The indexes are in leds and all the same rules apply.
---@param i integer This is the start of the extracted data. Negative values can be used.
---@param j? integer this is the end of the extracted data. Negative values can be used. The default is -1.
---@return any --A buffer containing the extracted piece.
function buffer:sub(i, j) end
