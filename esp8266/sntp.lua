--=== sntp ===

---@class sntp
sntp = {}

---Attempts to obtain time synchronization.
---@param server_ip? string|table @(optional) IP
---@param callback? function|'function (sec, usec, server, info) end' @(optional) if provided it will be invoked on a successful synchronization, with four parameters: seconds, microseconds, server and info.
---@param errcallback? function|'function()' @(optional) failure callback with two parameters: type of error &  string containing supplementary information.
---@param autorepeat? boolean @(optional) if this is non-nil, then the synchronization will happen every 1000 seconds and try and condition the clock if possible.
---@return nil
function sntp.sync(server_ip, callback, errcallback, autorepeat) end

---Sets the offset between the rtc clock and the NTP time.
---@param offset number @The offset between NTP time and the rtc time.
---@return nil
function sntp.setoffset(offset) end

---Gets the offset between the rtc clock and the NTP time.
---@return number offset @The current offset.
function sntp.getoffset() end
