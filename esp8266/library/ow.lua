---@meta

--=== ow ===

---@class ow
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string @value, data to be calculated check sum in string
---@param inverted_crc0 number @LSB of received CRC
---@param inverted_crc1 number @MSB of received CRC
---@param crc? number @(optional) CRC starting value
---@return boolean @`true` if the CRC matches, `false` otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf string @value, data to be calculated check sum in string
---@param crc? number @(optional) CRC starting value
---@return number @the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used\
---in the ROM and scratchpad registers.
---@param buf string @value, data to be calculated check sum in string
---@return number CRC @result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus.
---@param pin integer @1~12, I/O index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer @1~12, I/O index
---@return integer @byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer @1~12, I/O index
---@param size number @of bytes to be read from slave device (up to 256)
---@return string @bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer @1~12, I/O index
---@return integer @"**1** if a device responds with a presence pulse;  \n **0** if there is no device or the bus is shorted or  \n otherwise held low for more than 250 µS"
function ow.reset(pin) end

---Clears the search state so that it will start\
---from the beginning again.
---@param pin integer @1~12, I/O index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer @1~12, I/O index
---@param alarm_search? integer @"(optional) 1 / 0,  \n if 0 a regular 0xF0 search is performed(default if parameter is absent),  \nif 1 a 0xEC ALARM SEARCH is performed."
---@return string|nil @"string with length of 8 upon success.  \n It contains the rom code of slave device.  \n Returns `nil` if search was unsuccessful."
function ow.search(pin, alarm_search) end

---Issues a 1-Wire rom select command.\
---Make sure you do the `ow.reset(pin)` first.
---@param pin integer @1~12, I/O index
---@param rom string @string value, len 8, rom code of the slave device
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer @1~12, I/O index
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command,\
---to address all on bus.
---@param pin integer @1~12, I/O index
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code. The search\
---itself has to be initiated with a subsequent call to `ow.search()`.
---@param pin integer @1~12, I/O index
---@param family_code integer @byte for family code
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end\
---for parasitically powered devices.
---@param pin integer @1~12, I/O index
---@param v integer @byte to be written to slave device
---@param power integer @"**1** for wire being held high for parasitically  \n powered devices"
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end\
---for parasitically powered devices.
---@param pin integer @1~12, I/O index
---@param buf string @string to be written to slave device
---@param power integer @"**1** for wire being held high for parasitically  \n powered devices"
---@return nil
function ow.write_bytes(pin, buf, power) end

---Tweak different bit timing parameters.
---Each parameter specifies number of microseconds to delay at different stages in the 1-wire bit-banging process.
---A `nil` value will leave the value unmodified.
---@param reset_tx integer @pull bus low during reset (default 480)
---@param reset_wait integer @wait for presence pulse after reset (default 70)
---@param reset_rx integer @delay after presence pulse have been checked (default 410)
---@param w1_low integer @pull bus low during write 1 slot (default 5)
---@param w1_high integer @leave bus high during write 1 slot (default 52)
---@param w0_low integer @pull bus low during write 1 slot (default 65)
---@param w0_high integer @leave bus high during write 1 slot (default 5)
---@param r_low integer @pull bus low during read slot (default 5)
---@param r_wait integer @wait before reading bus level during read slot  (default 8)
---@param r_delay integer @delay after reading bus level (default 52)
---@return nil
function ow.set_timings(reset_tx, reset_wait, reset_rx, w1_low, w1_high, w0_low, w0_high, r_low, r_wait, r_delay) end
