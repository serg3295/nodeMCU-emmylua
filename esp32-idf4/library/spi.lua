---@meta

--=== spi ===

---@class spi
---@field VSPI integer
---@field HSPI integer
---@field SPI1 integer
spi = {}

---@class busmaster
local busmaster = {}

---@class devSpi
local devSpi = {}

---@class SpiMaster
---@field sclk integer
---@field mosi integer
---@field miso integer
---@field quadwp integer
---@field quadhd integer

---Initializes a bus in master mode and returns a bus master object.
---@param host integer|`spi.VSPI`|`spi.HSPI` @id
---@param config? SpiMaster @"(optional) table listing the assigned GPIOs.  \n All signal assignment are optional. **sclk, mosi, miso, quadwp, quadhd**"
---@param dma? integer|`1`|`2`|`0` @(optional) set DMA channel (1 or 2) or disable DMA (0), defaults to 1 if omitted.
---@return busmaster @SPI bus master object
function spi.master(host, config, dma) end

---Close the bus host. This fails if there are\
---still devices registered on this bus.
---@return nil
function busmaster:close() end

---@class DeviceCfg
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

---Adds a device on the given master bus.\
---Up to three devices per bus are supported.
---@param config DeviceCfg @table describing the device parameters:
--- - **cs** GPIO connected to device's chip-select pin, optional
--- - **mode** SPI mode used for this device (0-3), mandatory
--- - **freq** clock frequency used for this device [Hz], mandatory
--- - **command_bits** amount of bits in command phase (0-16),\
---defaults to 0 if omitted
--- - **address_bits** amount of bits in address phase (0-64),\
---defaults to 0 if omitted
--- - **dummy_bits** amount of dummy bits to insert address\
--- and data phase, defaults to 0 if omitted
--- - **cs_ena_pretrans**, optional
--- - **cs_ena_posttrans**, optional
--- - **duty_cycle_pos**, optional
--- - **tx_lsb_first** transmit command/address/data LSB first if true,\
---MSB first otherwise (or if omitted)
--- - **rx_lsb_first** receive data LSB first if true,\
---MSB first otherwise (or if omitted)
--- - **wire3** use spiq for both transmit and receive if true,\
---use mosi and miso otherwise (or if omitted)
--- - **positive_cs** chip-select is active high during a transaction if true,\
---cs is active low otherwise (or if omitted)
--- - **halfduplex** transmit data before receiving data if true,\
---transmit and receive simultaneously otherwise (or if omitted)
--- - **clk_as_cs** output clock on cs line when cs is active if true,\
---defaults to false if omitted
---@return devSpi @SPI device object
function busmaster:device(config) end

---Removes a device from the related bus master.
---@return nil
function devSpi:remove() end

---@class SpiTransfer
---@field cmd any
---@field addr any
---@field txdata string
---@field rxlen integer
---@field mode integer
---@field addr_mode number

---Initiate an SPI transaction.\
--- *@param* `txdata` - string of data to be sent to the device
---@overload fun(txdata: string):string
---@param trans SpiTransfer @table containing the elements of the transaction:
--- - **cmd** data for command phase,\
---amount of bits was defined during device creation, optional
--- - **addr** data for address phase,\
---amount of bits was defined during device creation, optional
--- - **txdata** string of data to be sent to the device, optional
--- - **rxlen** number of bytes to be received, optional
--- - **mode** optional, one of:
---   - sio transmit in SIO mode, default if omitted
---   - dio transmit in DIO mode
---   - qio transmit in QIO mode
--- - **addr_mode** transmit address also in selected mode if true,\
---transmit address in SIO otherwise.
---@return string @String of rxlen length, or #txdata length if rxlen is omitted.
function devSpi:transfer(trans) end

---Initializes a bus in slave mode\
---and returns a slave object.\
---`Not yet supported.`
function spi.slave() end
