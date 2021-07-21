--=== ow ===

---@class ow
ow = {}

---Computes the 1-Wire CRC16 and compare it against the received CRC.
---@param buf string @string value, data to be calculated check sum in string
---@param inverted_crc0 number @LSB of received CRC
---@param inverted_crc1 number @MSB of received CRC
---@param crc? number @(optional) CRC starting value
---@return boolean @`true` if the CRC matches, `false` otherwise
function ow.check_crc16(buf, inverted_crc0, inverted_crc1, crc) end

---Computes a Dallas Semiconductor 16 bit CRC.
---@param buf number @string value, data to be calculated check sum in string
---@param crc? number @(optional) CRC starting value
---@return number @the CRC16 as defined by Dallas Semiconductor
function ow.crc16(buf, crc) end

---Computes a Dallas Semiconductor 8 bit CRC, these are used\
---in the ROM and scratchpad registers.
---@param buf string @string value, data to be calculated check sum in string
---@return number @CRC result as byte
function ow.crc8(buf) end

---Stops forcing power onto the bus.\
---You only need to do this if you used the **power** flag\
---to `ow.write()` or used a `ow.write_bytes()`\
---and aren't about to do another read or write.
---@param pin integer @IO index
---@return nil
function ow.depower(pin) end

---Reads a byte.
---@param pin integer @IO index
---@return integer @byte read from slave device
function ow.read(pin) end

---Reads multi bytes.
---@param pin integer @IO index,
---@param size number @number of bytes to be read from slave device (up to 256)
---@return string @bytes read from slave device
function ow.read_bytes(pin, size) end

---Performs a 1-Wire reset cycle.
---@param pin integer @IO index
---@return integer @>
--- - **1** if a device responds with a presence pulse;\
--- - **0** if there is no device or the bus is shorted or\
---otherwise held low for more than 250 µS
function ow.reset(pin) end

---Clears the search state so that it will start\
---from the beginning again.
---@param pin integer @IO index
---@return nil
function ow.reset_search(pin) end

---Looks for the next device.
---@param pin integer @IO index
---@return string|nil @"**rom_code** string with length of 8 upon success.  \n It contains the rom code of slave device. Returns `nil` if  \n search was unsuccessful."
function ow.search(pin) end

---Issues a 1-Wire rom select command.\
---Make sure you do the `ow.reset(pin)` first.
---@param pin integer @IO index
---@param rom string @string value, len 8, rom code of the slave device
---@return nil
function ow.select(pin, rom) end

---Sets a pin in onewire mode.
---@param pin integer @IO index
---@return nil
function ow.setup(pin) end

---Issues a 1-Wire rom skip command,\
---to address all on bus.
---@param pin integer @IO index
---@return nil
function ow.skip(pin) end

---Sets up the search to find the device type family_code. The search\
---itself has to be initiated with a subsequent call to `ow.search()`.
---@param pin integer @IO index
---@param family_code integer @byte for family code
---@return nil
function ow.target_search(pin, family_code) end

---Writes a byte. If power is 1 then the wire is held high at the end for\
---parasitically powered devices. You are responsible for eventually\
---depowering it by calling `ow.depower()` or doing another read or write.
---@param pin integer @IO index
---@param v integer @byte to be written to slave device
---@param power integer @1 for wire being held high for parasitically powered devices
---@return nil
function ow.write(pin, v, power) end

---Writes multi bytes. If power is 1 then the wire is held high at the end for\
---parasitically powered devices. You are responsible for eventually depowering it\
---by calling `ow.depower()` or doing another read or write.
---@param pin integer @IO index
---@param buf string @string to be written to slave device
---@param power integer @1 for wire being held high for parasitically powered devices
---@return nil
function ow.write_bytes(pin, buf, power) end
