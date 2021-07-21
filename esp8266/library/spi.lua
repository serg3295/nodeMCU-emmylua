---@meta

--=== spi ===

---@class spi
---@field MASTER integer
---@field SLAVE integer
---@field CPOL_LOW integer
---@field CPOL_HIGH integer
---@field CPHA_LOW integer
---@field CPHA_HIGH integer
---@field HALFDUPLEX integer
---@field FULLDUPLEX integer
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
---@param mode integer|'spi.MASTER'|'spi.SLAVE' @select master or slave mode. Slave not supported currently
---@param cpol integer|'spi.CPOL_LOW'|'spi.CPOL_HIGH' @clock polarity selection
---@param cpha integer|'spi.CPHA_LOW'|'spi.CPHA_HIGH' @clock phase selection
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
