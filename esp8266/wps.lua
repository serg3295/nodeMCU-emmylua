--=== wps ===

---@class wps
wps = {}

---Disable WiFi WPS function.
---@return nil
function wps.disable() end

---Enable WiFi WPS function.
---@return nil
function wps.enable() end

---Start WiFi WPS function. WPS must be enabled\
---prior calling this function.
---@param callback? function @"(optional) `function(status)`  \n for when the WPS function ends."
---@return nil
function wps.start(callback) end
