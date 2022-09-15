---@meta

--=== hdc1080 ===

---@class hdc1080
hdc1080 = {}

---Samples the sensor then returns temperature\
---and humidity value.
---@return number TH @"Temperature data in centigrade  \n and humidity data in percentage (0-100)"
---@nodiscard
function hdc1080.read() end

---Initializes the module.
---@return nil
function hdc1080.setup() end
