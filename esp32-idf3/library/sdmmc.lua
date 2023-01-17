---@meta

--=== sdmmc ===

---@class sdmmc
---@field HS1 integer
---@field HS2 integer
---@field HSPI integer
---@field VSPI integer
---@field W1BIT integer
---@field W4BIT integer
---@field W8BIT integer
sdmmc = {}

---@class card
local card = {}

---@class SDmmcCfg
---@field cd_pin integer
---@field wp_pin integer
---@field fmax integer
---@field width  integer

---SDMMC Mode. Initialize the SDMMC and probe the attached SD card.
---@param slot integer|`sdmmc.HS1`|`sdmmc.HS2` @SDMMC slot
---@param cfg? SDmmcCfg @optional table containing slot configuration:
--- - **cd_pin** card detect pin, none if omitted
--- - **wp_pin** write-protect pin, none if omitted
--- - **fmax** maximum communication frequency, defaults to 20  if omitted
--- - **width** bis width, defaults to sdmmc.W1BIT if omitted, one of:
---   - sdmmc.W1BIT
---   - sdmmc.W4BIT
---   - sdmmc.W8BIT, not supported yet
---@return card cardObj @Card object.
---Error is thrown for invalid parameters or if SDMMC hardware or\
---card cannot be initialized.
---@nodiscard
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
---@param slot integer|`sdmmc.HSPI`|`sdmmc.VSPI` @SD SPI slot
---@param cfg SDspiCfg @mandatory table containing slot configuration:
--- - **sck_pin** SPI SCK pin, mandatory
--- - **mosi_pin**, SPI MOSI pin, mandatory
--- - **miso_pin**, SPI MISO pin, mandatory
--- - **cs_pin**, SPI CS pin, mandatory
--- - **cd_pin** card detect pin, none if omitted
--- - **wp_pin** write-protect pin, none if omitted
--- - **fmax** maximum communication frequency, defaults to 20 if omitted
---@return card cardObj @Card object.
---Error is thrown for invalid parameters or if SDMMC hardware or\
---card cannot be initialized.
---@nodiscard
function sdmmc.init(slot, cfg) end

---Retrieve information from the SD card.
---@return { ocr:number, cid:table, csd:table, scr:table, rca:number } @Table containing the card's OCR, CID, CSD, SCR, and RCA with elements:
--- - **ocr** Operation Conditions Register
--- - **cid** Card IDentification:
---   - date - manufacturing date
---   - mfg_id - manufacturer ID
---   - name - product name
---   - oem_id - OEM/product ID
---   - revision - product revision
---   - serial - product serial number
--- - **csd** Card-Specific Data:
---   - capacity - total number of sectors
---   - card_command_class - card command class for SD
---   - csd_ver - CSD structure format
---   - mmc_ver - MMC version (for CID format)
---   - read_block_len - block length for reads
---   - sector_size - sector size in bytes
---   - tr_speed - maximum transfer speed
--- - **scr**:
---   - sd_spec-  SD physical layer specification version, reported by card
---   - bus_width - bus widths supported by card
--- - **rca** Relative Card Address
---@nodiscard
function card:get_info() end

---Mount filesystem on SD card.
---@param ldrv string|"/SD0"|"/SD1" @name of logical drive
---@param slot? integer|`sdmmc.HS2`|`sdmmc.HS1` @(optional) defaults to sdmmc.HS2 if omitted
---@return boolean
function card:mount(ldrv, slot) end

---Read one or more sectors.
---@param start_sec integer @first sector to read from
---@param num_sec integer @number of sectors to read (>= 1)
---@return string @String containing the sector data.
---Error is thrown for invalid parameters or if sector(s) cannot be read.
---@nodiscard
function card:read(start_sec, num_sec) end

---Unmount filesystem. Error is thrown\
---if filesystem is not mounted or if it\
---cannot be unmounted.
---@return nil
function card:umount() end

---Write one or more sectors.
---@param start_sec integer @first sector to write to
---@param data any @string of data to write, must be multiple of sector size (512 bytes)
---@return nil
---Error is thrown for invalid parameters or if sector(s) cannot be written.
function card:write(start_sec, data) end
