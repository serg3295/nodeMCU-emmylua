--=== mdns ===

---@class mdns
mdns = {}

---Register a hostname and start the mDNS service.
---@param hostname string @The hostname for this device. Alphanumeric characters are best.
---@param attributes? table @A optional table of options. The keys must all be strings.
---@return nil
function mdns.register(hostname , attributes) end

---Shut down the mDNS service.\
---This is not normally needed.
---@return nil
function mdns.close() end
