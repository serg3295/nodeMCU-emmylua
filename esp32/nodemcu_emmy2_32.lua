--*** OTA ***
otaupgrade = {}

---The boot info and application state and version info can be queried with this function.
---@return string #the name of the partition of the running application
---@return string #the name of the partition currently marked for boot next
---@return table #a table whose keys are the names of OTA partitions and corresponding values are tables containing:
--**state** one of *new, testing, valid, invalid, aborted* or possibly *undefined*
--**name** the application name, typically "NodeMCU"
--**date** the build date
--**time** the build time
--**version** the build version, as set by the *PROJECT_VER* variable during build
--**secure_version** the secure version number, if secure boot is enabled
--**idf_version** the IDF version
function otaupgrade.info() end

---Wipes the spare application partition and prepares to receive the new application firmware.
---@return nil #`nil`. A Lua error may be raised if the OTA upgrade cannot be commenced for some reason (such as due to incorrect partition setup).
function otaupgrade.commence() end

---Write a chunk of application firmware data to the correct partition and location. Data must be streamed sequentially, the IDF does not support out-of-order data as would be the case from e.g. bittorrent.
---@param data string a string of binary data
---@return nil #`nil`. A Lua error may be raised if the data can not be written, e.g. due to the data not being a valid OTA image (the IDF performs some checks in this regard).
function otaupgrade.write(data) end

---Finalises the upgrade, and optionally reboots into the new application firmware right away.
---@param reboot integer|nil `1` to reboot into the new firmware immediately, `nil` to keep running
---@return nil #`nil`. A Lua error may be raised if the image does not pass validation, or no data has been written to the image at all.
function otaupgrade.complete(reboot) end

---When the installed boot loader is built with rollback support, a new application image is by default only booted once. During this "test run" it can perform whatever checks is appropriate (like testing whether it can still reach the update server), and if satisfied can mark itself as valid. Without being marked valid, upon the next reboot the system would "roll back" to the previous version instead.
---@return nil
function otaupgrade.accept() end

---A new firmware may decide that it is not performing as expected, and request an explicit rollback to the previous version. If the call to this function succeeds, the system will reboot without returning from the call.
--Note that it is also possible to roll back to a previous firmware version even after the new version has called `otaupgrade.accept()`.
function otaupgrade.rollback() end

--*** OW ***
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string string value, data to be calculated check sum in string
---@param inverted_crc0 number LSB of received CRC
---@param inverted_crc1 number MSB of received CRC
---@param crc? number CRC starting value (optional)
---@return boolean #`true` if the CRC matches, `false` otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf number string value, data to be calculated check sum in string
---@param crc? number CRC starting value (optional)
---@return number #the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used in the ROM and scratchpad registers.
---@param buf string string value, data to be calculated check sum in string
---@return number #CRC result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus. You only need to do this if you used the **power** flag to `ow.write()` or used a `ow.write_bytes()` and aren't about to do another read or write.
---@param pin integer IO index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer IO index
---@return integer #byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer IO index,
---@param size number number of bytes to be read from slave device (up to 256)
---@return string #bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer IO index
---@return integer #**1** if a device responds with a presence pulse; **0** if there is no device or the bus is shorted or otherwise held low for more than 250 µS
function ow.reset(pin) end

---Clears the search state so that it will start from the beginning again.
---@param pin integer IO index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer IO index
---@return string|nil #**rom_code** string with length of 8 upon success. It contains the rom code of slave device. Returns `nil` if search was unsuccessful.
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

---Writes a byte. If power is 1 then the wire is held high at the end for parasitically powered devices. You are responsible for eventually depowering it by calling `ow.depower()` or doing another read or write.
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
-- - PCNT_EVT_THRES_0 (Threshold 0 hit),
-- - PCNT_EVT_THRES_1 (Threshold 1 hit),
-- - PCNT_EVT_L_LIM (Minimum counter value),
-- - PCNT_EVT_H_LIM (Maximum counter value),
-- - PCNT_EVT_ZERO (counter value zero event)
---@return pulsecnt #pulsecnt object
function pulsecnt.create(unit, callbackOnEvents) end

---@alias pulse_mode1 integer
---|' pulsecnt.PCNT_COUNT_DIS' #= 0 Counter mode: Inhibit counter (counter value will not change in this condition).
---|' pulsecnt.PCNT_COUNT_INC' #= 1 Counter mode: Increase counter value.
---|' pulsecnt.PCNT_COUNT_DEC' #= 2 Counter mode: Decrease counter value.

---@alias pulse_mode2 integer
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

---@class QRcodeCfg
---@field minver integer
---@field maxver integer
---@field ecl integer
---@field mask integer
---@field boostecl boolean

---Generates a QR Code from a text string.
---@param text any The text or URL to encode. Should be UTF-8 or ASCII.
---@param options? QRcodeCfg An optional table, containing any of:
--**minver** the minimum version according to the QR Code Model 2 standard. If not specified, defaults to 1.
--**maxver** the maximum version according to the QR Code Model 2 standard. If not specified, defaults to 40. Specifying a lower maximum version reduces the amount of temporary memory the function requires, so it can be worthwhile to specify a smaller value if you know the text will fit in a lower-version QR Code.
--**ecl** the error correction level in a QR Code symbol. Higher error correction produces a larger QR Code. One of:
-- - qrcodegen.LOW (default if not specified)
-- - qrcodegen.MEDIUM
-- - qrcodegen.QUARTILE
-- - qrcodegen.HIGH
--**mask** the mask pattern used in a QR Code symbol. An integer 0-7, or qrcodegen.AUTO (the default).
--**boostecl** defaults to false.
---@return string|nil #The QR Code, encoded as a string. Use `qrcodegen.getSize()` and `qrcodegen.getPixel()` to extract data from the result. If the text cannot be represented within the given version range (for example it is too long) then `nil` is returned.
function qrcodegen.encodeText(text, options) end

---@param qrcode string a QR Code string, as returned by `qrcodegen.encodeText()`.
---@return integer #Returns the side length in pixels of the given QR Code. The result is in the range [21, 177].
function qrcodegen.getSize(qrcode) end

---Get the color of the pixel at the given coordinates of the QR Code. `x` and `y` must be between 0 and the value returned by `qrcodegen.getSize()`.
---@param qrcode string a QR Code string, as returned by `qrcodegen.encodeText()`.
---@param x number coordinate
---@param y number coordinate
---@return boolean #`true` if the given pixel is black, `false` if it is white.
function qrcodegen.getPixel(qrcode, x, y) end

--*** SDMMC ***
sdmmc = {}

---@class sdmmc
local card = {}

---@class SDmmcCfg
---@field cd_pin integer
---@field wp_pin integer
---@field fmax integer
---@field width  integer

---SDMMC Mode. Initialize the SDMMC and probe the attached SD card.
---@param slot integer|'sdmmc.HS1'|'sdmmc.HS2' SDMMC slot
---@param cfg? SDmmcCfg optional table containing slot configuration:
--**cd_pin** card detect pin, none if omitted
--**wp_pin** write-protcet pin, none if omitted
--**fmax** maximum communication frequency, defaults to 20  if omitted
--**width** bis width, defaults to sdmmc.W1BIT if omitted, one of:
-- - sdmmc.W1BIT
-- - sdmmc.W4BIT
-- - sdmmc.W8BIT, not supported yet
---@return sdmmc cardObj Card object. Error is thrown for invalid parameters or if SDMMC hardware or card cannot be initialized.
function sdmmc.init(slot, cfg) end

---@class SDspiCfg
---@field sck_pin integer
---@field mosi_pin integer
---@field miso_pin integer
---@field cs_pin integer
---@field cd_pin integer
---@field wp_pin integer
---@field fmax integer

---SD SPI Mode. Initialize the SDMMC and probe the attached SD card.
---@param slot integer|'sdmmc.HSPI'|'sdmmc.VSPI' SD SPI slot
---@param cfg SDspiCfg mandatory table containing slot configuration:
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
---@return table #Table containing the card's OCR, CID, CSD, SCR, and RCA with elements:
--**ocr** Operation Conditions Register
--**cid** Card IDentification:
-- - date - manufacturing date
-- - mfg_id - manufacturer ID
-- - name - product name
-- - oem_id - OEM/product ID
-- - revision - product revision
-- - serial - product serial number
--**csd** Card-Specific Data:
-- - capacity - total number of sectors
-- - card_command_class - card command class for SD
-- - csd_ver - CSD structure format
-- - mmc_ver - MMC version (for CID format)
-- - read_block_len - block length for reads
-- - sector_size - sector size in bytes
-- - tr_speed - maximum transfer speed
--**scr**:
-- - sd_spec-  SD physical layer specification version, reported by card
-- - bus_width - bus widths supported by card
--**rca** Relative Card Address
function card:get_info() end

---Mount filesystem on SD card.
---@param ldrv string|'"/SD0"'|'"/SD1"' name of logical drive
---@param slot? integer|' sdmmc.HS2'|' sdmmc.HS1' defaults to sdmmc.HS2 if omitted
---@return boolean
function card:mount(ldrv, slot) end

---Read one or more sectors.
---@param start_sec integer first sector to read from
---@param num_sec integer number of sectors to read (>= 1)
---@return string #String containing the sector data. Error is thrown for invalid parameters or if sector(s) cannot be read.
function card:read(start_sec, num_sec) end

---Unmount filesystem.
---@return nil #`nil`. Error is thrown if filesystem is not mounted or if it cannot be unmounted.
function card:umount() end

---Write one or more sectors.
---@param start_sec integer first sector to write to
---@param data any string of data to write, must be multiple of sector size (512 bytes)
---@return nil #`nil`. Error is thrown for invalid parameters or if sector(s) cannot be written.
function card:write(start_sec, data) end

--*** SIGMA DELTA ***
sigma_delta = {}

---Reenables GPIO functionality at the related pin.
---@param channel integer 0~7, sigma-delta channel index
---@return nil
function sigma_delta.close(channel) end

---Sets the prescale value.
---@param channel integer 0~7, sigma-delta channel index
---@param value integer prescale 1 to 255
---@return nil
function sigma_delta.setprescale(channel, value) end

---Sets the duty value.
---@param channel integer 0~7, sigma-delta channel index
---@param value integer duty -128 to 127
---@return nil
function sigma_delta.setduty(channel, value) end

---Routes the sigma-delta channel to the specified pin. Target prescale and duty values should be applied prior to enabling the output with this command.
---@param channel integer 0~7, sigma-delta channel index
---@param pin integer IO index
---@return nil
function sigma_delta.setup(channel, pin) end

--*** SJSON ***
sjson = {}

---@class sjsonenc
local encoder = {}
---@class sjsondec
local decoder = {}

---@class SjsonCfg1
---@field depth integer
---@field null string

---@class SjsonCfg2
---@field depth integer
---@field null string
---@field metatable table

---This creates an encoder object that can convert a Lua object into a JSON encoded string.
---@param tbl table data to encode
---@param opts? SjsonCfg1 an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
---@return sjsonenc #A sjson.encoder object.
function sjson.encoder(tbl, opts) end

---This gets a chunk of JSON encoded data.
---@param size? integer an optional value for the number of bytes to return. The default is 1024.
---@return string|nil #A `string` of up to size bytes, or `nil` if the encoding is complete and all data has been returned.
function encoder:read(size) end

---Encode a Lua table to a JSON string.
---@param tbl table data to encode
---@param opts? SjsonCfg1 an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20 which should be enough for nearly all situations.
--**null** the string value to treat as null.
---@return string #JSON string
function sjson.encode(tbl, opts) end

---This makes a decoder object that can parse a JSON encoded string into a Lua object. A metatable can be specified for all the newly created Lua tables. This allows you to handle each value as it is inserted into each table (by implementing the __newindex method).
---@param opts? SjsonCfg2 an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
--**metatable** a table to use as the metatable for all the new tables in the returned object.
---@return sjsondec #A `sjson.decoder` object
function sjson.decoder(opts) end

---This provides more data to be parsed into the Lua object.
---@param str string the next piece of JSON encoded data
---@return any|nil #The constructed Lua object or `nil` if the decode is not yet complete. If a parse error occurrs during this decode, then an error is thrown and the parse is aborted. The object cannot be used again.
function decoder:write(str) end

---This gets the decoded Lua object, or raises an error if the decode is not yet complete. This can be called multiple times and will return the same object each time. If the decode is not complete, then an error is thrown.
function decoder:result() end

---Decode a JSON string to a Lua table.
---@param str string JSON string to decode
---@param opts? SjsonCfg2 an optional table of options. The possible entries are:
--**depth** the maximum encoding depth needed to encode the table. The default is 20.
--**null** the string value to treat as null.
--**metatable** a table to use as the metatable for all the new tables in the returned object.
---@return table #Lua table representation of the JSON data. If the string is not valid JSON, then an error is thrown.
function sjson.decode(str, opts) end

--*** SODIUM ***
sodium = {}

---Returns a random integer between `0` and `0xFFFFFFFF` inclusive.
---@return integer #A uniformly-distributed random integer between 0 and 0xFFFFFFFF inclusive.
function sodium.random.random() end

---Returns a random integer 0 <= result < upper_bound
---@param upper_bound integer must be an integer *<= 0xFFFFFFFF*.
---@return integer #An integer *>= 0* and *< upper_bound*
function sodium.random.uniform(upper_bound) end

---Generates *n* bytes of random data. Wifi must be started, by calling `wifi.start()`, before calling this function.
---@param n number number of bytes to return.
---@return string #A string of *n* random bytes.
function sodium.random.buf(n) end

---Generates a new keypair. Wifi must be started, by calling `wifi.start()`, before calling this function.
---@return string public_key
---@return string secret_key
function sodium.crypto_box.keypair() end

---Encrypts a message using a public key.
---@param message string the string to encrypt.
---@param public_key string the public key to encrypt with.
---@return string|any #The encrypted message, as a string. Errors if public_key is not a valid public key as returned by sodium.crypto_box.keypair() or if the message could not be encrypted.
function sodium.crypto_box.seal(message, public_key) end

---Decrypts a message encrypted with `crypto_box.seal()`.
---@param ciphertext any the encrypted message.
---@param public_key string the public key the message was encrypted with.
---@param secret_key string the secret key corresponding to the specified public key.
---@return any|nil #The decrypted plain text of the message. Returns `nil` if the *ciphertext* could not be decrypted.
function sodium.crypto_box.seal_open(ciphertext, public_key, secret_key) end

--*** SPI ***
spi = {}

---@class spi
local busmaster = {}
---@class spidev
local device = {}

---@class SpiMaster
---@field sclk integer
---@field mosi integer
---@field miso integer
---@field quadwp integer
---@field quadhd integer

---Initializes a bus in master mode and returns a bus master object.
---@param host integer|'spi.VSPI'|'spi.HSPI'|'spi.SPI1' id
---@param config? SpiMaster table listing the assigned GPIOs. All signal assignment are optional. **sclk, mosi, miso, quadwp, quadhd**
---@param dma? integer|' 1'|' 2'|' 0' set DMA channel (1 or 2) or disable DMA (0), defaults to 1 if omitted.
---@return spi #SPI bus master object
function spi.master(host, config, dma) end

---Close the bus host. This fails if there are still devices registered on this bus.
---@return nil
function busmaster:close() end

---@class BusMaster
---@field cs integer
---@field mode integer
---@field freq integer
---@field command_bits integer
---@field address_bits integer
---@field dummy_bits integer
---@field cs_ena_pretrans integer
---@field cs_ena_posttrans integer
---@field duty_cycle_pos integer
---@field tx_lsb_first boolean
---@field rx_lsb_first boolean
---@field wire3 boolean
---@field positive_cs boolean
---@field halfduplex boolean
---@field clk_as_cs boolean

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
---@return spidev #SPI device object
function busmaster:device(config) end

---Removes a device from the related bus master.
---@return nil
function device:remove() end

---@class SpiTransfer
---@field command any
---@field address any
---@field txdata string
---@field rxlen integer
---@field mode integer
---@field addr_mode number

---Initiate an SPI transaction.
--*txdata* string of data to be sent to the device
---@overload fun(txdata:string):string
---@param trans SpiTransfer table containing the elements of the transaction:
--**command** data for command phase, amount of bits was defined during device creation, optional
--**address** data for address phase, amount of bits was defined during device creation, optional
--**txdata** string of data to be sent to the device, optional
--**rxlen** number of bytes to be received, optional
--**mode** optional, one of:
-- - sio transmit in SIO mode, default if omitted
-- - dio transmit in DIO mode
-- - qio transmit in QIO mode
--**addr_mode** transmit address also in selected mode if true, transmit address in SIO otherwise.
---@return string #String of rxlen length, or #txdata length if rxlen is omitted.
function device:transfer(trans) end

---Initializes a bus in slave mode and returns a slave object. `Not yet supported.`
function spi.slave() end

--*** STRUCT ***
struct = {}

---Returns a string containing the values `d1, d2`, etc. packed according to the format string `fmt`.
---@param fmt string The format string
---@param d1 any The first data item to be packed
---@param d2 any The second data item to be packed etc.
---@return string #The packed string.
function struct.pack (fmt, d1, d2, ...) end

---Returns the values packed in string s according to the format string `fmt`. An optional i marks where in s to start reading (default is 1). After the read values, this function also returns the index in `s` where it stopped reading, which is also where you should start to read the rest of the string.
---@param fmt string The format string
---@param s string The string holding the data to be unpacked
---@param offset? integer The position to start in the string (default is 1)
---@return any #All the unpacked data.
function struct.unpack (fmt, s, offset) end

---Returns the size of a string formatted according to the format string `fmt`. The format string should contain neither the option `s` nor the option `c0`.
---@param fmt string The format string
---@return integer #The size of the string that would be output in a pack operation with this format string.
function struct.size (fmt) end

--*** TIME ***
time = {}

---@class CalendarTable
---@field year integer
---@field mon integer
---@field day integer
---@field hour integer
---@field min integer
---@field sec integer

---Converts calendar table to a timestamp in Unix epoch
---@param calendar CalendarTable Table containing calendar info.
--**year** 1970 ~ 2038
--**mon** month 1 ~ 12 in current year
--**day** day 1 ~ 31 in current month
--**hour**
--**min**
--**sec**
---@return integer #number of seconds since the Epoch
function time.cal2epoch(calendar) end

---Converts timestamp in Unix epoch to calendar format
---@param time integer number of seconds since the Epoch
---@return table #A table containing the fields:
--**year** 1970 ~ 2038
--**mon** month 1 ~ 12 in current year
--**day** day 1 ~ 31 in current month
--**hour**
--**min**
--**sec**
--**yday** day 1 ~ 366 in current year
--**wday** day 1 ~ 7 in current weak (Sunday is 1)
--**dst** day time adjustment:
-- - 1, (DST in effect, i.e. daylight time)
-- - 0, (DST not in effect, i.e. standard time)
-- - -1, (Unknown DST status)
function time.epoch2cal(time) end

---Returns current system time in the Unix epoch (seconds from midnight 1970/01/01).
---@return integer sec seconds since the Unix epoch
---@return integer usec the microseconds part
function time.get() end

---Returns current system time adjusted for the locale in calendar format.
---@return table #A table containing the fields:
--**year** 1970 ~ 2038
--**mon** month 1 ~ 12 in current year
--**day** day 1 ~ 31 in current month
--**hour**
--**min**
--**sec**
--**yday** day 1 ~ 366 in current year
--**wday** day 1 ~ 7 in current weak (Sunday is 1)
--**dst** day time adjustment:
-- - 1, (DST in effect, i.e. daylight time)
-- - 0, (DST not in effect, i.e. standard time)
-- - -1, (Unknown DST status)
function time.getlocal() end

---Initializes and starts NTP client
---@param ntpAddr? string address of a NTP server, defaults to "pool.ntp.org" if none is specified
---@return nil
function time.initntp(ntpAddr) end

---Checks if NTP client is enabled.
---@return boolean #`true' if NTP client is enabled.
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
---@return tmr #timer object
function tmr.create() end

---@alias t32 integer
---|' tmr.ALARM_AUTO' #automatically repeating alarm
---|' tmr.ALARM_SINGLE' #a one-shot alarm (and no need to call tmr.unregister())
---|' tmr.ALARM_SEMI' #manually repeating alarm (call tmr.start() to restart)

---This is a convenience function combining `tmr.obj:register()` and `tmr.obj:start()` into a single call.
---@param interval integer timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 timer mode
---@param callback function|" function(t) end" function which is invoked with the timer object as an argument
---@return boolean
function tObj:alarm(interval, mode, callback) end

---Changes a registered timer's expiry interval.
---@param interval integer new timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@return nil
function tObj:interval(interval) end

---Configures a timer and registers the callback function to call on expiry.
---@param interval integer timer interval in milliseconds. Maximum value is 6870947 (1:54:30.947).
---@param mode t32 timer mode
---@param callback function|" function() end" function which is invoked with the timer object as an argument
---@return nil
function tObj:register(interval, mode, callback) end

---Starts or restarts a previously configured timer.
---@return boolean
function tObj:start() end

---Checks the state of a timer.
---@return boolean|nil #If the specified timer is registered, returns whether it is currently started
---@return integer|nil #and its mode. If the timer is not registered, `nil` is returned.
function tObj:state() end

---Stops a running timer, but does not unregister it. A stopped timer can be restarted with `tmr.obj:start()`.
---@return boolean
function tObj:stop() end

---Stops the timer (if running) and unregisters the associated callback. This isn't necessary for one-shot timers (*tmr.ALARM_SINGLE*), as those automatically unregister themselves when fired.
---@return nil
function tObj:unregister() end

--*** TOUCH ***
touch ={}

---@class touch
local tp = {}

---Create the touch sensor object.
---@param tbl table
---@return touch #touch object
function touch.create(tbl) end

---Read the touch sensor counter values for all pads configured in touch.create() method.
---@return table raw Lua table of touch sensor counter values per pad
---@return table
function tp:read() end

---Set touch sensor interrupt threshold per pad.
---@param padNum number One pad number can be specified here. If you did multiple pads you must call this per pad.
---@param thresVal number The threshold value to set for the pad interrupt trigger.
---@return nil
function tp:setThres(padNum, thresVal) end

---Set the trigger mode globally for all touch pads.
---@param mode integer|'touch.TOUCH_TRIGGER_BELOW'|'touch.TOUCH_TRIGGER_ABOVE' mode
---@return nil
function tp:setTriggerMode(mode) end

---Enable interrupt on the touch sensor hardware.
---@return nil
function tp:intrEnable() end

---Disable interrupt on the touch sensor hardware.
---@return nil
function tp:intrDisable() end

--*** U8G2 ***
---@class u8g2
-- I²C Display Drivers
---@field ld7032_i2c_60x32 function
---@field sh1106_i2c_128x64_vcomh0 function
---@field sh1106_i2c_128x64_noname function
---@field sh1107_i2c_64x128 function
---@field sh1107_i2c_128x128 function
---@field sh1107_i2c_seeed_96x96 function
---@field sh1108_i2c_160x160 function
---@field sh1122_i2c_256x64 function
---@field ssd0323_i2c_os128064 function
---@field ssd1305_i2c_128x32_noname function
---@field ssd1306_i2c_64x48_er function
---@field ssd1306_i2c_96x16_er function
---@field ssd1306_i2c_128x32_univision function
---@field ssd1306_i2c_128x64_alt0 function
---@field ssd1306_i2c_128x64_noname function
---@field ssd1306_i2c_128x64_vcomh0 function
---@field ssd1309_i2c_128x64_noname0 function
---@field ssd1309_i2c_128x64_noname2 function
---@field ssd1318_i2c_128x96 function
---@field ssd1318_i2c_128x96_xcp function
---@field ssd1325_i2c_nhd_128x64 function
---@field ssd1326_i2c_er_256x32 function
---@field ssd1327_i2c_ea_w128128 function
---@field ssd1327_i2c_midas_128x128 function
---@field ssd1327_i2c_seeed_96x96 function
---@field st7567_i2c_64x32 function
---@field st7588_i2c_jlx12864 function
---@field st75256_i2c_jlx256128 function
---@field st75256_i2c_jlx256160 function
---@field st75256_i2c_jlx240160 function
---@field st75256_i2c_jlx25664 function
---@field st75256_i2c_jlx172104 function
---@field uc1601_i2c_128x32 function
---@field uc1604_i2c_jlx19264 function
---@field uc1608_i2c_240x128 function
---@field uc1608_i2c_erc24064 function
---@field uc1610_i2c_ea_dogxl160 function
---@field uc1611_i2c_ea_dogm240 function
---@field uc1611_i2c_ea_dogxl240 function
---@field uc1611_i2c_ew50850 function
-- SPI Display Drivers
---@field hx1230_96x68 function
---@field il3820_v2_296x128 function
---@field ist3020_erc19264 function
---@field lc7981_160x80 function
---@field lc7981_160x160 function
---@field lc7981_240x64 function
---@field lc7981_240x128 function
---@field ld7032_60x32 function
---@field ls013b7dh03_128x128 function
---@field max7219_32x8 function
---@field nt7534_tg12864r function
---@field pcd8544_84x48 function
---@field pcf8812_96x65 function
---@field sed1520_122x32 function
---@field sh1107_64x128 function
---@field sh1106_128x64_noname function
---@field sh1106_128x64_vcomh0 function
---@field sh1107_128x128 function
---@field sh1108_160x160 function
---@field sh1107_seeed_96x96 function
---@field sh1122_256x64 function
---@field ssd0323_os128064 function
---@field ssd1305_128x32_noname function
---@field ssd1306_64x48_er function
---@field ssd1306_96x16_er function
---@field ssd1306_128x32_univision function
---@field ssd1306_128x64_alt0 function
---@field ssd1306_128x64_noname function
---@field ssd1306_128x64_vcomh0 function
---@field ssd1309_128x64_noname0 function
---@field ssd1309_128x64_noname2 function
---@field ssd1318_128x96 function
---@field ssd1318_128x96_xcp function
---@field ssd1322_nhd_128x64 function
---@field ssd1322_nhd_256x64 function
---@field ssd1325_nhd_128x64 function
---@field ssd1326_er_256x32 function
---@field ssd1327_ea_w128128 function
---@field ssd1327_midas_128x128 function
---@field ssd1327_seeed_96x96 function
---@field ssd1329_128x96_noname function
---@field ssd1606_172x72 function
---@field ssd1607_200x200 function
---@field ssd1607_gd_200x200 function
---@field ssd1607_ws_200x200 function
---@field st7565_64128n function
---@field st7565_ea_dogm132 function
---@field st7565_ea_dogm128 function
---@field st7565_erc12864 function
---@field st7565_erc12864_alt function
---@field st7565_lm6059 function
---@field st7565_nhd_c12832 function
---@field st7565_nhd_c12864 function
---@field st7565_zolen_128x64 function
---@field st7567_enh_dg128064i function
---@field st7567_64x32 function
---@field st7567_jlx12864 function
---@field st7567_pi_132x64 function
---@field st7586s_erc240160 function
---@field st7586s_s028hn118a function
---@field st7588_jlx12864 function
---@field st7920_s_192x32 function
---@field st7920_s_128x64 function
---@field st75256_jlx25664 function
---@field st75256_jlx172104 function
---@field st75256_jlx240160 function
---@field st75256_jlx256128 function
---@field st75256_jlx256160 function
---@field t6963_128x64 function
---@field t6963_160x80 function
---@field t6963_240x64 function
---@field t6963_240x128 function
---@field t6963_256x64 function
---@field uc1601_128x32 function
---@field uc1604_jlx19264 function
---@field uc1608_240x128 function
---@field uc1608_erc24064 function
---@field uc1610_ea_dogxl160 function
---@field uc1611_ea_dogm240 function
---@field uc1611_ea_dogxl240 function
---@field uc1611_ew50850 function
---@field uc1701_ea_dogs102 function
---@field uc1701_mini12864 function
-- fonts
---@field font_6x10_tf number
---@field font_unifont_t_symbols number
-- constants
---@field DRAW_UPPER_RIGHT number
---@field DRAW_UPPER_LEFT number
---@field DRAW_LOWER_RIGHT number
---@field DRAW_LOWER_LEFT number
---@field DRAW_ALL number
---@field MIRROR number
---@field R0 number
---@field R1 number
---@field R2 number
---@field R3 number
u8g2 = {}

---@class u8g2DisplayObj
local u8g2DispObj = {}

---Initialize a display via I²C.
---@param id integer i2c interface id, see i2c module
---@param address integer I²C slave address of display (unshifted)
---@param cb_fn? function optional callback function, see Framebuffer callback
---@return u8g2DisplayObj #u8g2 display object
function u8g2.u8g2DisplayTypeI2C(id, address, cb_fn) end

---Initialize a display via Hardware SPI.
---@param bus integer SPI master bus
---@param cs integer GPIO pin for CS
---@param dc integer GPIO pin for DC
---@param res? integer GPIO pin for RES, none if omitted
---@param cb_fn? function optional callback function, `function(rle_line?)`. **rle_line** is a string containing a run-length encoded framebuffer line, or `nil` to indicate start of frame.
---@return u8g2DisplayObj #u8g2 display object
function u8g2.u8g2DisplayTypeSPI(bus, cs, dc, res, cb_fn) end

---Clears all pixel in the memory frame buffer.
function u8g2DispObj:clearBuffer() end

---Draw a box (filled frame), starting at `x/y` position (upper left edge). The box has width `w` and height `h`.
---@param x integer X-position of upper left edge.
---@param y integer Y-position of upper left edge.
---@param w integer Width of the box.
---@param h integer Height of the box.
function u8g2DispObj:drawBox(x, y, w, h) end

---Draw a circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer Position of the center of the circle.
---@param y0 integer Position of the center of the circle.
---@param rad integer  Defines the size of the circle: Radus = rad.
---@param opt? integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawCircle(x0, y0, rad, opt) end

---Draw a filled circle with radus `rad` at position (`x0`, `y0`). The diameter of the circle is 2*rad+1.
---@param x0 integer Position of the center of the disc.
---@param y0 integer Position of the center of the disc.
---@param rad integer Defines the size of the circle: Radus = rad.
---@param opt? integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawDisc(x0, y0, rad, opt) end

---Draw an ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer Position of the center of the filled circle.
---@param y0 integer Position of the center of the filled circle.
---@param rx integer Defines the size of the ellipse.
---@param ry integer Defines the size of the ellipse.
---@param opt integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawEllipse(x0, y0, rx, ry, opt) end

---Draw a filled ellipse with radus `rx` and `ry` at position (`x0, y0`). rx*ry must be lower than 512 in 8 Bit mode of u8g2.
---@param x0 integer Position of the center of the filled circle.
---@param y0 integer Position of the center of the filled circle.
---@param rx integer Defines the size of the ellipse.
---@param ry integer Defines the size of the ellipse.
---@param opt integer|' u8g2.DRAW_ALL'|' u8g2.DRAW_UPPER_RIGHT'|' u8g2.DRAW_UPPER_LEFT'|' u8g2.DRAW_LOWER_LEFT'|' u8g2.DRAW_LOWER_RIGHT' is optional and defaults to u8g2.DRAW_ALL if omitted.
function u8g2DispObj:drawFilledEllipse(x0, y0, rx, ry, opt) end

---Draw a frame (empty box), starting at `x/y` position (upper left edge). The box has width `w` and height `h`.
---@param x integer X-position of upper left edge.
---@param y integer Y-position of upper left edge.
---@param w integer Width of the frame.
---@param h integer Height of the frame.
function u8g2DispObj:drawFrame(x, y, w, h) end

---Draw a single character. The character is placed at the specified pixel posion `x` and `y`.
---@param x integer Position of the character on the display.
---@param y integer Position of the character on the display.
---@param encoding integer Unicode value of the character.
function u8g2DispObj:drawGlyph(x, y, encoding) end

---Draw a horizontal line, starting at `x/y` position (left edge). The width (length) of the line is `w` pixel.
---@param x integer X-position
---@param y integer Y-position
---@param w integer Length of the horizontal line.
function u8g2DispObj:drawHLine(x, y, w) end

---Draw a line between two points.
---@param x0 integer X-position of the first point.
---@param y0 integer Y-position of the first point.
---@param x1 integer X-position of the second point.
---@param y1 integer Y-position of the second point.
function u8g2DispObj:drawLine(x0, y0, x1, y1) end

---Draw a pixel at the specified `x/y` position. Position (0,0) is at the upper left corner of the display.
---@param x integer Position of pixel.
---@param y integer Position of pixel.
function u8g2DispObj:drawPixel(x, y) end

---Draw a box with round edges, starting at `x/y` position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
---@param x integer Position of upper left edge.
---@param y integer Position of upper left edge.
---@param w integer Width of the box.
---@param h integer Height of the box.
---@param r integer Radius for the four edges.
function u8g2DispObj:drawRBox(x, y, w, h, r) end

---Draw a frame with round edges, starting at `x/y` position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that w >= 2*(r+1) and h >= 2*(r+1).
---@param x integer Position of upper left edge.
---@param y integer Position of upper left edge.
---@param w integer Width of the frame.
---@param h integer Height of the frame.
---@param r integer Radius for the four edges.
function u8g2DispObj:drawRFrame(x, y, w, h, r) end

---Draw a string. The first character is placed at position `x` and `y`.
---@param x integer Position of the first character on the display.
---@param y integer Position of the first character on the display.
---@param s string String, which will be printed on the screen.
---@return number #The width of the string.
function u8g2DispObj:drawStr(x, y, s) end

---Draw a triangle (filled polygon).
---@param x0 integer Point 0 of the triangle.
---@param y0 integer Point 0 of the triangle.
---@param x1 integer Point 1 of the triangle.
---@param y1 integer Point 1 of the triangle.
---@param x2 integer Point 2 of the triangle.
---@param y2 integer Point 2 of the triangle.
function u8g2DispObj:drawTriangle(x0, y0, x1, y1, x2, y2) end

---Draw a string which is encoded as UTF-8.
---@param x integer Position of the first character on the display.
---@param y integer Position of the first character on the display.
---@param s string  UTF-8 encoded text.
---@return number #The width of the string.
function u8g2DispObj:drawUTF8(x, y, s) end

---Draw a vertical line, starting at `x/y` position (upper end). The height (length) of the line is `h` pixel.
---@param x integer Top position of the line.
---@param y integer Top position of the line.
---@param h integer The height (length) of the vertical line.
function u8g2DispObj:drawVLine(x, y, h) end

---Draw a XBM Bitmap. Position (`x,y`) is the upper left corner of the bitmap. XBM contains monochrome, 1-bit bitmaps.
---@param x integer X-position.
---@param y integer Y-position.
---@param w integer Width of the bitmap.
---@param h integer Height of the bitmap.
---@param bitmap string bitmap string.char()
function u8g2DispObj:drawXBM(x, y, w, h, bitmap) end

---Returns the reference height of the glyphs above the baseline (ascent).
---@return number #The ascent of the current font.
function u8g2DispObj:getAscent() end

---Returns the reference height of the glyphs below the baseline (descent).
---@return number #The descent of the current font.
function u8g2DispObj:getDescent() end

---Return the pixel width of string.
---@param s string text
---@return number #Width of the string if drawn with the current font (setFont).
function u8g2DispObj:getStrWidth(s) end

---Return the pixel width of an UTF-8 encoded string.
---@param s string UTF-8 encoded text.
---@return number #Width of the string if drawn with the current font (setFont).
function u8g2DispObj:getUTF8Width(s) end

---Send the content of the memory frame buffer to the display.
function u8g2DispObj:sendBuffer() end

---Defines, whether the bitmap functions will write the background color (mode 0/solid, `is_transparent` = 0) or not (mode 1/transparent, `is_transparent` = 1). Default mode is 0 (solid mode).
---@param is_transparent integer Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setBitmapMode(is_transparent) end

---Set the contrast or brightness for the display (if supported).
---@param value integer Contrast or brightness from 0 to 255.
function u8g2DispObj:setContrast(value) end

---Changes the display rotation.
---@param u8g2_cb integer #Display rotation argument.
---|'u8g2.R0' #No rotation, landscape
---|'u8g2.R1' #90 degree clockwise rotation
---|'u8g2.R2' #180 degree clockwise rotation
---|'u8g2.R3' #270 degree clockwise rotation
---|'u8g2.MIRROR' #No rotation, landscape, display content is mirrored
function u8g2DispObj:setDisplayRotation(u8g2_cb) end

---Defines the bit value (color index) for all drawing functions.
---@param color integer **0** (clear pixel value in the display RAM), **1** (set pixel value) or **2** (XOR mode)
function u8g2DispObj:setDrawColor(color) end

---Set flip (180 degree rotation) mode.
---@param is_enable integer Enable (1) or disable (0) 180 degree rotation of the display
function u8g2DispObj:setFlipMode(is_enable) end

---Define a u8g2 font for the glyph and string drawing functions. They can be supplied as strings or compiled into the firmware image.
---@param font number|'u8g2.font_6x10_tf'|'u8g2.font_unifont_t_symbols'
function u8g2DispObj:setFont(font) end

---Set the drawing direction of all strings or glyphs.
---@param dir integer #Writing direction/string rotation.
---|'0' #0 degree   Left to right
---|'1' #90 degree  Top to down
---|'2' #180 degree Right to left
---|'3' #270 degree Down to top
function u8g2DispObj:setFontDirection(dir) end

---Defines, whether the glyph and string drawing functions will write the background color (mode 0/solid, 'is_transparent' = 0) or not (mode 1/transparent, 'is_transparent' = 1). Default mode is 0 (background color of the characters is overwritten).
---@param is_transparent integer Enable (1) or disable (0) transparent mode.
function u8g2DispObj:setFontMode(is_transparent) end

---Change the reference position for the glyph and string draw functions to "baseline".
function u8g2DispObj:setFontPosBaseline() end

---Change the reference position for the glyph and string draw functions to "bottom".
function u8g2DispObj:setFontPosBottom() end

---Change the reference position for the glyph and string draw functions to "top".
function u8g2DispObj:setFontPosTop() end

---Change the reference position for the glyph and string draw functions to "center".
function u8g2DispObj:setFontPosCenter() end

---Set ascent and descent calculation mode to "highest and lowest glyph".
function u8g2DispObj:setFontRefHeightAll() end

---Set ascent and descent calculation mode to "highest of [A1(], lowest of [g(]".
function u8g2DispObj:setFontRefHeightExtendedText() end

---Set ascent and descent calculation mode to "highest of [A1], lowest of [g]".
function u8g2DispObj:setFontRefHeightText() end

---Activate or disable power save mode of the display.
---@param is_enable integer Enable (1) or disable (0) power save mode for the display.
function u8g2DispObj:setPowerSave(is_enable) end

---Updates the display.
function u8g2DispObj:updateDisplay() end

---Updates the specified rectangle area of the display.
---@param tx integer Upper left corner of the area, given as tile position.
---@param ty integer Upper left corner of the area, given as tile position.
---@param tw integer Width of the area in tiles.
---@param th integer Height of the area in tiles.
function u8g2DispObj:updateDisplayArea(tx, ty, tw, th) end

--*** UART ***
uart = {}

---Sets the callback function to handle UART events. To unregister the callback, provide only the "data" parameter.
---@param id? integer uart id, default value is uart num of the console.
---@param method string data | error
---|' "data"' #"data", data has been received on the UART.
---|' "error"' #error occurred on the UART.
---@param number_or_endChar? number Only for event data.
-- - if pass in a number *n* < 255, the callback will called when *n* chars are received.
-- - if *n* = 0, will receive every char in buffer.
-- - if pass in a one char string "c", the callback will called when "c" is encounterd, or max *n* = 255 received.
---@param callback? function #function for event
---|' function(data) end' #for event "data"
---|' function(err) end' #for event "error" `err` could be one of "out_of_memory", "break", "rx_error".
---@param run_input? integer **0** or **1**. Only for "data" event on console uart.
---|' 0' #input from UART will not go into Lua interpreter, can accept binary data.
---|' 1' #input from UART will go into Lua interpreter, and run.
---@return nil
function uart.on(id, method, number_or_endChar, callback, run_input) end

---@class UartCfg
---@field tx integer
---@field rx integer
---@field cts integer
---@field rts integer
---@field tx_inverse boolean
---@field rx_inverse boolean
---@field cts_inverse boolean
---@field rts_inverse boolean
---@field flow_control integer

---(Re-)configures the communication parameters of the UART.
---@param id integer uart id
---@param baud integer|' 300'|' 600'|' 1200'|' 2400'|' 4800'|' 9600'|' 19200'|' 31250'|' 34400'|' 57600'|' 74880'|' 115200'|' 230000'|' 256000'|' 460800'|' 921600'|' 1843200'|' 3686400' 300 - 3686400
---@param databits integer|' 8'|' 7'|' 6'|' 5' one of 5, 6, 7, 8
---@param parity integer|' uart.PARITY_NONE'|' uart.PARITY_ODD'|' uart.PARITY_EVEN' none | odd | even
---@param stopbits integer|' uart.STOPBITS_1'|' uart.STOPBITS_1_5'|' uart.STOPBITS_2' 1 | 1.5 | 2
---@param echo_or_pins integer|UartCfg for *console uart*, this should be a int. if 0, disable echo, otherwise enable echo; for others, this is a table:
--**tx** int. TX pin. Required
--**rx** int. RX pin. Required
--**cts** in. CTS pin. Optional
--**rts** in. RTS pin. Optional
--**tx_inverse** boolean. Inverse TX pin. Default: false
--**rx_inverse** boolean. Inverse RX pin. Default: false
--**cts_inverse** boolean. Inverse CTS pin. Default: false
--**rts_inverse** boolean. Inverse RTS pin. Default: false
--**flow_control** int. Combination of uart.FLOWCTRL_NONE, uart.FLOWCTRL_CTS, uart.FLOWCTRL_RTS. Default: uart.FLOWCTRL_NONE
---@return number #configured baud rate
function uart.setup(id, baud, databits, parity, stopbits, echo_or_pins) end

---Returns the current configuration parameters of the UART.
---@param id integer UART id
---@return integer baud
---@return integer databits
---@return integer parity
---@return integer stopbits
function uart.getconfig(id) end

---Start the UART. You do not need to call `start()` on the console uart.
---@param id integer uart id, except console uart
---@return boolean #`true` if uart is started.
function uart.start(id) end

---Stop the UART. You should not call `stop()` on the console uart.
---@param id integer uart id, except console uart
---@return nil
function uart.stop(id) end

---Set UART controllers communication mode
---@param id integer uart id
---@param mode integer #value should be one of
---|>' uart.MODE_UART' #default UART mode, is set after uart.setup() call
---|' uart.MODE_RS485_COLLISION_DETECT' #receiver must be always enabled, transmitter is automatically switched using RTS pin, collision is detected by UART hardware (note: no event is generated on collision, limitation of esp-idf)
---|' uart.MODE_RS485_APP_CONTROL' #receiver/transmitter control is left to the application
---|' uart.MODE_RS485_HALF_DUPLEX' #receiver/transmitter are controlled by RTS pin
---|' uart.MODE_IRDA'
---@return nil
function uart.setmode(id, mode) end

---Wait for any data currently in the UART transmit buffers to be written out. It can be useful to call this immediately before a call to `node.sleep()` because otherwise data might not get written until after wakeup.
---@param id number uart id
---@return nil
function uart.txflush(id) end

---Configure the light sleep wakeup threshold. This is the number of positive edges that must be seen on the UART RX pin before a light sleep wakeup will be triggered.
---@param id integer uart id
---@param val number the new value. The minimum value is 3. The default value is undefined.
---@return nil
function uart.wakeup(id, val) end

---Write string or byte to the UART.
---@param id integer uart id
---@param data1 any ... string or byte to send via UART
---@vararg any ... string or byte to send via UART
---@return nil
function uart.write(id, data1, ...) end

--*** UCG ***
---@class ucg
---@field hx8352c_18x240x400_hw_spi function
---@field ili9163_18x128x128_hw_spi function
---@field ili9341_18x240x320_hw_spi function
---@field ili9486_18x320x480_hw_spi function
---@field pcf8833_16x132x132_hw_spi function
---@field seps225_16x128x128_uvis_hw_spi function
---@field ssd1351_18x128x128_hw_spi function
---@field ssd1351_18x128x128_ft_hw_spi function
---@field ssd1331_18x96x64_uvis_hw_spi function
---@field st7735_18x128x160_hw_spi function
-- fonts
---@field font_7x13B_tr number
---@field font_helvB08_hr number
---@field font_helvB10_hr number
---@field font_helvB12_hr number
---@field font_helvB18_hr number
---@field font_ncenB24_tr number
---@field font_ncenR12_tr number
---@field font_ncenR14_hr number
-- constants
---@field FONT_MODE_SOLID number
---@field FONT_MODE_TRANSPARENT number
---@field DRAW_UPPER_RIGHT number
---@field DRAW_UPPER_LEFT number
---@field DRAW_LOWER_RIGHT number
---@field DRAW_LOWER_LEFT number
---@field DRAW_ALL number
ucg = {}

---@class ucgDisplayObj
local ucgDispObj = {}

---Initialize a display via Hardware SPI.
---@param bus integer SPI master bus
---@param cs integer GPIO pin for /CS
---@param dc integer GPIO pin for DC
---@param res? integer GPIO pin for /RES, none if omitted
---@return ucgDisplayObj #ucg display object
function ucg.ucgDisplayType(bus, cs, dc, res) end

---Send init code to the display, setup internal data structures and define the text output mode.
---@param fontmode integer|'ucg.FONT_MODE_TRANSPARENT'|'ucg.FONT_MODE_SOLID' font mode
---@return number #0, if the init procedure fails.
function ucgDispObj:begin(fontmode) end

---Clear the screen and reset the clip range to maximum.
function ucgDispObj:clearScreen() end

---ucg.draw90Line
---@param x integer
---@param y integer
---@param len integer
---@param dir integer
---@param col_idx integer
function ucgDispObj:draw90Line(x, y, len, dir, col_idx) end

---Draw a filled box. Use current color from index 0. The top-left pixel is at `x`, `y`. The box has width of `w` and the height is `h` pixel.
---@param x integer Top-left position of the box.
---@param y integer Top-left position of the box.
---@param w integer Width of the box.
---@param h integer Height of the box.
function ucgDispObj:drawBox(x, y, w, h) end

---Draw a full circle or a quarter of a circle. Use current color from index 0. The center of the circle is at `x0`, `y0`. The circle has a diameter of `2*rad+1` pixel.
---@param x0 integer Center of the circle.
---@param y0 integer Center of the circle.
---@param rad integer Radius of the circle.
---@param option integer|' ucg.DRAW_ALL'|' ucg.DRAW_UPPER_RIGHT'|' ucg.DRAW_UPPER_LEFT'|' ucg.DRAW_LOWER_LEFT'|' ucg.DRAW_LOWER_RIGHT' One of the following constants:
function ucgDispObj:drawCircle(x0, y0, rad, option) end

---Draw a filled full circle or a quarter of a filled circle. Use current color from index 0. The center of the filled circle is at `x0`, `y0`. The filled circle has a diameter of `2*rad+1` pixel.
---@param x0 integer Center of the filled circle.
---@param y0 integer Center of the filled circle.
---@param rad integer Radius of the filled circle.
---@param option integer|' ucg.DRAW_ALL'|' ucg.DRAW_UPPER_RIGHT'|' ucg.DRAW_UPPER_LEFT'|' ucg.DRAW_LOWER_LEFT'|' ucg.DRAW_LOWER_RIGHT' One of the following constants:
function ucgDispObj:drawDisc(x0, y0, rad, option) end

---Draw a rectangle. Use current color from index 0. The top-left pixel is at `x`, `y`. The rectangle has width of `w` and the height is `h` pixel.
---@param x integer Top-left position of the rectangle.
---@param y integer Top-left position of the rectangle.
---@param w integer Width of the rectangle.
---@param h integer Height of the rectangle.
function ucgDispObj:drawFrame(x, y, w, h) end

---Draw a single character. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer Reference position of the character.
---@param y integer Reference position of the character.
---@param dir integer One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param encoding integer Code number of the character.
---@return number #Width of the gylph.
function ucgDispObj:drawGlyph(x, y, dir, encoding) end

---Draw a filled box. The upper left position is at `x`, `y`. Dimensions of the box are `w` (width) and `h` (height) pixel. The pixel at the upper left will have the color from index 0, upper right pixel has color from index 1, lower left from index 2 and lower right from index 3. The remaining colors will be interpolated between the four colors.
---@param x integer Start position of the line.
---@param y integer Start position of the line.
---@param w integer Width of the box.
---@param h integer Height of the box.
function ucgDispObj:drawGradientBox(x, y, w, h) end

---Draw a horizontal or vertical line. The line will start at `x`, `y` and has a total of `len` pixel. The pixel at `x`, `y` will have the color from index 0. The color will be changed until it matches the color of index 1.
---@param x integer Start position of the line.
---@param y integer Start position of the line.
---@param len integer Length of the line.
---@param dir integer One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
function ucgDispObj:drawGradientLine(x, y, len, dir) end

---Draw a horizontal line. Use current color from index 0. The leftmost pixel is at `x`, `y` and the rightmost pixel is at `x+len-1`, `y`
---@param x integer Left position of the horizontal line.
---@param y integer Left position of the horizontal line.
---@param len integer Length of the line.
function ucgDispObj:drawHLine(x, y, len) end

---Draw a line from pixel at `x1`, `y1` to pixel `x2`, `y2`. Use current color from index 0.
---@param x1 integer Start pixel of the line.
---@param y1 integer Start pixel of the line.
---@param x2 integer End pixel of the line.
---@param y2 integer End pixel of the line.
function ucgDispObj:drawLine(x1, y1, x2, y2) end

---Draw a pixel at position `x`, `y`. Use current color from index 0.
---@param x integer Position of pixel.
---@param y integer Position of pixel.
function ucgDispObj:drawPixel(x, y) end

---Draw a box/frame with round edges, starting at x/y position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked. Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer Position of upper left edge.
---@param y integer Position of upper left edge.
---@param w integer Width of the box.
---@param h integer Height of the box.
---@param r integer Radius for the four edges.
function ucgDispObj:drawRBox(x, y, w, h, r) end

---Draw a box/frame with round edges, starting at x/y position (upper left edge). The box/frame has width `w` and height `h`. Parts of the box can be outside of the display boundaries. Edges have radius `r`. It is required that `w >= 2*(r+1)` and `h >= 2*(r+1)`. This condition is not checked. Behavior is undefined if `w` or `h` is smaller than `2*(r+1)`. Use current color from index 0.
---@param x integer Position of upper left edge.
---@param y integer Position of upper left edge.
---@param w integer Width of the frame.
---@param h integer Height of the frame.
---@param r integer Radius for the four edges.
function ucgDispObj:drawRFrame(x, y, w, h, r) end

---Draw a string. Use current color from index 0. If the *setFontMode* is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`).
---@param x integer Reference position of the string.
---@param y integer Reference position of the string.
---@param dir integer One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up)
---@param str string String, which will be printed on the screen.
---@return number #The width of the string.
function ucgDispObj:drawString(x, y, dir, str) end

---Draw a filled tetragon (a shape with four corners), defined by four edge points. Use current color from index 0.
--This procedure will only draw "simple"/convex tetragons. The result will be undefined, if the tetragon is not convex.
---@param x0 integer Point 0 of the tetragon.
---@param y0 integer Point 0 of the tetragon.
---@param x1 integer Point 1 of the tetragon.
---@param y1 integer Point 1 of the tetragon.
---@param x2 integer Point 2 of the tetragon.
---@param y2 integer Point 2 of the tetragon.
---@param x3 integer Point 3 of the tetragon.
---@param y3 integer Point 3 of the tetragon.
function ucgDispObj:drawTetragon(x0, y0, x1, y1, x2, y2, x3, y3) end

---Draw a filled triangle, defined by three edge points. Use current color from index 0.
---@param x0 integer Point 0 of the triangle.
---@param y0 integer Point 0 of the triangle.
---@param x1 integer Point 1 of the triangle.
---@param y1 integer Point 1 of the triangle.
---@param x2 integer Point 2 of the triangle.
---@param y2 integer Point 2 of the triangle.
function ucgDispObj:drawTriangle(x0, y0, x1, y1, x2, y2) end

---Draw a vertical line. Use current color from index 0. The topmost pixel is at `x`, `y`. The bottom pixel is at `x,y+len-1`
---@param x integer Top position of the vertical line.
---@param y integer Top position of the vertical line.
---@param len integer Length of the vertical line.
function ucgDispObj:drawVLine(x, y, len) end

---Returns the height of the character 'A' or the number '1' above the baseline. For the font in the example below, getFontAscent returns the value 24.
---@return number #The height of the font.
function ucgDispObj:getFontAscent() end

---Some glphys of a font might are extended below the baseline ('g' or ')'). This procedure returns the extension of these characters above baseline. If the extension is below the baseline (which is usually the case) then a negative number is returned. In the example below, the returned descent value is "-7".
---@return number #The extension of the characters below the baseline.
function ucgDispObj:getFontDescent() end

---Returns the height of the display.
---@return number #The height of the display.
function ucgDispObj:getHeight() end

---Returns the number of pixels, required for the text in `*s` with the current font settings. Some extra pixels are added in front and after the text as defined in the current font.
---@param str string string
---@return number #Width of the text in pixel.
function ucgDispObj:getStrWidth(str) end

---Returns the width of the display.
---@return number #The width of the display.
function ucgDispObj:getWidth() end

---Print text or values. The position of the output is defined by `setPrintPos()`, the writing direction is defined by `setPrintDir()`. Values and text will have the current color from index 0. If the setFontMode is `ucg.FONT_MODE_SOLID`, then the background color is defined by color index 1 (`ucg.setColor(1, r, g, b)`). For best results use `h`, `m` or `8` fonts with `ucg.FONT_MODE_SOLID`
---@param str string string
---@return number #Number of characters.
function ucgDispObj:print(str) end

--- Defines the drawing area for all other commands. Graphics commands are "clipped" against this area. By default this is the complete visible area of the screen.
---@param x integer Upper left position of the drawing area.
---@param y integer Upper left position of the drawing area.
---@param w integer Width of the drawing area. Behavior is undefined for w=0 or h=0.
---@param h integer Height of the drawing area.
function ucgDispObj:setClipRange(x, y, w, h) end

---Defines up to four different colors for the graphics primitives. Most commands will use the color at index position 0. If the index (first argument) is skipped, then the color is stored as index 0.
---@param idx integer The index of the color being set. See each drawing function to determine the index to use. (Default: 0)
---@param r integer Red,
---@param g integer green, and
---@param b integer blue component of the color. Color range is always from 0 to 255 for each of the color components.
function ucgDispObj:setColor(idx, r, g, b) end

---Define a ucg font for the glyph and string drawing functions. They are available as `ucg.<font_name>` in Lua.
---@param font integer|'ucg.font_7x13B_tr'|'ucg.font_helvB08_hr'|'ucg.font_helvB10_hr'|'ucg.font_helvB12_hr'|'ucg.font_helvB18_hr'|'ucg.font_ncenB24_tr'|'ucg.font_ncenR12_tr'|'ucg.font_ncenR14_hr'constant to identify pre-compiled font
---@return nil
function ucgDispObj:setFont(font) end

---Define the text output mode.
---@param fontmode integer|'ucg.FONT_MODE_TRANSPARENT'|'ucg.FONT_MODE_SOLID'
---@return number #0, if the init procedure fails.
function ucgDispObj:setFontMode(fontmode) end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBaseline() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosBottom() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosCenter() end

---Change the reference position for the character output procedures *print*, *drawString* and *drawGlyph*.
function ucgDispObj:setFontPosTop() end

---This command will reset the clip area to the full display size. It will undo any settings from *setClipRange*.
function ucgDispObj:setMaxClipRange() end

--- This command will set the print direction for the following "print" commands.
---@param dir integer One of the values **0** (left to right), **1** (top down), **2** (right left) or **3** (bottom up).
function ucgDispObj:setPrintDir(dir) end

---This command will set the position for next "print" command.
---@param x integer Reference position for the characters of the next print command.
---@param y integer Reference position for the characters of the next print command.
function ucgDispObj:setPrintPos(x, y) end

---Rotate the screen by 90 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate90() end

---Rotate the screen by 180 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate180() end

---Rotate the screen by 270 degree. Depending on the aspect ratio of the display, this will put the display in portrait or landscape mode.
function ucgDispObj:setRotate270() end

---Scale everything by 2. This includes position values, lines, fonts, circles, etc. As long as scaling is active, the screen rotation commands must not be used.
function ucgDispObj:setScale2x2() end

---Removes the clip window. All graphics commands can now write to the entire screen.
function ucgDispObj:undoClipRange() end

---Restore the original display orientation.
function ucgDispObj:undoRotate() end

---Return to none scaling mode.
function ucgDispObj:undoScale() end

--*** WIFI ***
---@class wifi
---@field sta function
---@field ap function
---@field AUTH_OPEN integer
---@field AUTH_WPA_PSK integer
---@field AUTH_WPA2_PSK integer
---@field AUTH_WPA_WPA2_PSK integer
---@field HT20 integer
---@field HT40_ABOVE integer
---@field HT40_BELOW integer
---@field STATION integer
---@field SOFTAP integer
---@field STATIONAP integer
---@field NULLMODE integer
wifi = {}

---Gets the current WiFi channel.
---@return integer #current WiFi channel (primary channel)
---@return integer #HT20/HT40 information (secondary channel). One of the constants:
-- - wifi.HT20,
-- - wifi.HT40_ABOVE,
-- - wifi.HT40_BELOW
function wifi.getchannel() end

---Gets WiFi operation mode.
---@return integer #The WiFi mode, as one of the constants:
-- - wifi.STATION
-- - wifi.SOFTAP
-- - wifi.STATIONAP
-- - wifi.NULLMODE
function wifi.getmode() end

---Configures the WiFi mode to use.
---@param mode integer station | softap | stationap | nullmode
---|'wifi.STATION' #for when the device is connected to a WiFi router.
---|'wifi.SOFTAP' #for when the device is acting only as an access point.
---|'wifi.STATIONAP' #is the combination of wifi.STATION and wifi.SOFTAP
---|'wifi.NULLMODE' #disables the WiFi interface(s).
---@param save? boolean choose whether or not to save wifi mode to flash
---|>' true' #WiFi mode configuration will be retained through power cycle.
---|' false' #WiFi mode configuration will not be retained through power cycle.
---@return any #current mode after setup
function wifi.mode(mode, save) end

---Starts the WiFi interface(s).
---@return nil
function wifi.start() end

---Shuts down the WiFi interface(s).
---@return nil
function wifi.stop() end

---@class StaConfig32
---@field ssid string
---@field pwd string
---@field auto boolean
---@field bssid string

---Sets the WiFi station configuration. The WiFi mode must be set to *wifi.STATION* or *wifi.STATIONAP* before this function can be used.
---@param station_config StaConfig32 table containing configuration data for station
--**ssid** string which is less than 32 bytes.
--**pwd** string which is 8-64 or 0 bytes. Empty string indicates an open WiFi access point.
--**auto** defaults to true
-- - `true` to enable auto connect and connect to access point, hence with auto=true there's no need to call `wifi.sta.connect()`
-- - `false` to disable auto connect and remain disconnected from access point
--**bssid** string that contains the MAC address of the access point (optional). You can set BSSID if you have multiple access points with the same SSID.
-- Note: if you set BSSID for a specific SSID and would like to configure station to connect to the same SSID only without the BSSID requirement, you MUST first configure to station to a different SSID first, then connect to the desired SSID
-- The following formats are valid:
-- "DE:C1:A5:51:F1:ED"
-- "AC-1D-1C-B1-0B-22"
-- "DE AD BE EF 7A C0"
-- "AcDc0123c0DE"
---@param save boolean Save station configuration to flash.
---|' true' #configuration will be retained through power cycle.
---|>' false' #configuration will not be retained through power cycle.
---@return nil
function wifi.sta.config(station_config, save) end

---Connects to the configured AP in station mode. You only ever need to call this if auto-connect was disabled in wifi.sta.config().
---@return nil
function wifi.sta.connect() end

---Disconnects from AP in station mode.
---@return nil
function wifi.sta.disconnect() end

---Registers callbacks for WiFi station status events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"authmode_changed"'|'"got_ip"' WiFi station event you would like to set a callback for:
---@param callback function|' function(event, info) end' `function(event, info)` to perform when event occurs, or `nil` to unregister the callback for the event. The info argument given to the callback is a table containing additional information about the event.
-- Event information provided for each event is as follows:
--`"start"`: no additional info
--`"stop"`: no additional info
--`"connected"`: information about network/AP that was connected to:
-- - **ssid**: the SSID of the network
-- - **bssid**: the BSSID of the AP
-- - **channel**: the primary channel of the network
-- - **auth** authentication method, one of wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK (default), wifi.WPA_WPA2_PSK
--`"disconnected"`: information about the network/AP that was disconnected from:
-- - **ssid**: the SSID of the network
-- - **bssid**: the BSSID of the AP
-- - **reason**: an integer code for the reason (see table below for mapping)
--`"authmode_changed"`: authentication mode information:
-- - **old_mode**: the previous auth mode used
-- - **new_mode**: the new auth mode used
--`"got_ip"`: IP network information:
-- - **ip**: the IP address assigned
-- - **netmask**: the IP netmask
-- - **gw**: the gateway ("0.0.0.0" if no gateway)
---@return nil
function wifi.sta.on(event, callback) end

---Gets MAC address in station mode.
---@return string
function wifi.sta.getmac() end

---@class ScanCfg
---@field ssid string
---@field bssid string
---@field channel integer
---@field hidden integer

---Scan for available networks.
---@param cfg ScanCfg table that contains scan configuration:
---**ssid** SSID == `nil`, don't filter SSID
---**bssid** BSSID == `nil`, don't filter BSSID
---**channel** channel == 0, scan all channels, otherwise scan set channel (default is 0)
---**hidden** hidden == 1, get info for router with hidden SSID (default is 0)
---@param callback function |' function(ap_list) end' `function(ap_list)` to receive the list of APs when the scan is done. Each entry in the returned array follows the format used for `wifi.sta.config()`, with some additional fields. The following fields are provided for each scanned AP:
--**ssid**: the network SSID
--**bssid**: the BSSID of the AP
--**channel**: primary WiFi channel of the AP
--**rssi**: Received Signal Strength Indicator value
--**auth** authentication method, one of *wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK* (default), *wifi.WPA_WPA2_PSK*
--**bandwidth**: one of the following constants: *wifi.HT20, wifi.HT40_ABOVE, wifi.HT40_BELOW*
---@return nil
function wifi.sta.scan(cfg, callback) end

---@class Setip32
---@field ip string
---@field netmask string
---@field gateway string
---@field dns string

---Sets IP address, netmask, gateway, dns address in station mode.
---@param cfg Setip32 table to hold configuration:
--**ip** device ip address.
--**netmask** network netmask.
--**gateway** gateway address.
--**dns** name server address.
---@return nil
function wifi.sta.setip(cfg) end

---Sets station hostname. Must be called before wifi.sta.connect(). Options set by this function are not saved to flash.
---@param hostname string hostname must only contain letters, numbers and hyphens('-') and be 32 characters or less with first and last character being alphanumeric
---@return boolean
function wifi.sta.sethostname(hostname) end

---@class APconfig
---@field ssid string
---@field pwd string
---@field auth integer
---@field channel integer
---@field hidden boolean
---@field max integer
---@field beacon integer

---Configures the AP. The WiFi mode must be set to wifi.SOFTAP or wifi.STATIONAP before this function can be used.
---@param cfg APconfig table to hold configuration:
--**ssid** SSID chars 1-32
--**pwd** password chars 8-64
--**auth** authentication method, one of *wifi.AUTH_OPEN, wifi.AUTH_WPA_PSK, wifi.AUTH_WPA2_PSK* (default), *wifi.AUTH_WPA_WPA2_PSK*
--**channel** channel number 1-14 default = 11
--**hidden** false = not hidden, true = hidden, default = false
--**max** maximum number of connections 1-4 default=4
--**beacon** beacon interval time in range 100-60000, default = 100
---@param save boolean save configuration to flash.
---|>' true' #configuration will be retained through power cycle.
---|' false' #configuration will not be retained through power cycle.
---@return nil
function wifi.ap.config(cfg, save) end

---Registers callbacks for WiFi AP events.
---@param event string|'"start"'|'"stop"'|'"sta_connected"'|'"sta_disconnected"'|'"probe_req"' WiFi AP event you would like to set a callback for:
---@param callback function|' function(event, info) end' `function(event, info)` to perform when event occurs, or nil to unregister the callback for the event. The info argument given to the callback is a table containing additional information about the event.
-- Event information provided for each event is as follows:
--`"start"`: no additional info
--`"stop"`: no additional info
--`"sta_connected"`: information about the client that connected:
-- - **mac**: the MAC address
-- - **id**: assigned station id (AID)
--`"disconnected"`: information about disconnecting client
-- - **mac**: the MAC address
-- - **id**: assigned station id (AID)
--`"probe_req"`: information about the probing client
-- - **from**: MAC address of the probing client
-- - **rssi**: Received Signal Strength Indicator value
function wifi.ap.on(event, callback) end

---Gets MAC address in access point mode.
---@return string MAC address as string e.g. "18:fe:34:a2:d7:34"
function wifi.ap.getmac() end

---Sets IP address, netmask, gateway, dns address in AccessPoint mode.
---@param cfg Setip32 table to hold configuration:
--**ip** device ip address.
--**netmask** network netmask.
--**gateway** gateway address.
--**dns** name server address, which will be provided to clients over DHCP. (Optional)
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

---@class WS2812write
---@field pin integer
---@field data any

---Send data to up to 8 led strip using its native format which is generally Green,Red,Blue for RGB strips and Green,Red,Blue,White for RGBW strips.
---@param tbl WS2812write Variable number of tables, each describing a single strip. Required elements are:
--**pin** IO index
--**data** payload to be sent to one or more WS2812 like leds through GPIO2. Payload type could be:
-- - *string* representing bytes to send
-- - *ws2812.buffer* see Buffer module
---@return nil
function ws2812.write(tbl, ...) end

---Allocate a new memory buffer to store led values.
---@param numberOfLeds integer length of the led strip
---@param bytesPerLed integer 3 for RGB strips and 4 for RGBW strips
---@return ws2812 #ws2812.buffer
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
---@return string #A string containing the pixel values.
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
---@return integer #An integer which is the sum of all the pixel values.
function buffer:power() end

---Fade in or out. Defaults to out. Multiply or divide each byte of each led with/by the given value. Useful for a fading effect.
---@param value number value by which to divide or multiply each byte
---@param direction? integer|' ws2812.FADE_IN'|' ws2812.FADE_OUT' direction
---@return nil
function buffer:fade(value, direction) end

---Shift the content of (a piece of) the buffer in positive or negative direction.
---@param value number number of pixels by which to rotate the buffer. Positive values rotate forwards, negative values backwards.
---@param mode? integer is the shift mode to use. logical | circular
---|>' ws2812.SHIFT_LOGICAL' #the freed pixels are set to 0 (off).
---|' ws2812.SHIFT_CIRCULAR' #the buffer is treated like a ring buffer, inserting the pixels falling out on one end again on the other end.
---@param i? integer is the first offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is 1.
---@param j? integer is the last offset in the buffer to be affected. Negative values are permitted and count backwards from the end. Default is -1.
---@return nil
function buffer:shift(value, mode, i, j) end

---This implements the extraction function like string.sub. The indexes are in leds and all the same rules apply.
---@param i integer This is the start of the extracted data. Negative values can be used.
---@param j? integer this is the end of the extracted data. Negative values can be used. The default is -1.
---@return any #A buffer containing the extracted piece.
function buffer:sub(i, j) end
