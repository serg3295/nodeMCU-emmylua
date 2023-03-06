---@meta

--=== yeelink ===

---@class yeelink
yeelink = {}

---Initializes Yeelink client.
---@param device number
---@param sensor number
---@param apikey string
---@return string|boolean @IP address of api.yeelink.net, if not obtained then `false`
function yeelink.init(device, sensor, apikey) end

---Function to check DNS resolution of\
---api.yeelink.net status.
---@return string|nil @"IP address of api.yeelink.net  \n or `nil` when name resolution failed."
---@nodiscard
function yeelink.getDNS() end

---Send data to Yeelink Sever.
---@param datapoint any @Data to send to Yeelink API
---@return nil
function yeelink.update(datapoint) end
