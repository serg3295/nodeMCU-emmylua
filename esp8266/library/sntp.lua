--=== sntp ===

---@class sntp
sntp = {}

---Attempts to obtain time synchronization.\
--- *@param* `serverTbl` - (optional) { server1, server2, .. } these are either the ip address or dns name of one or more servers to try.
---@overload fun(serverTbl?:table, callback?:fun(sec:number, usec:number, server:string, info:table), errcallback?:fun(), autorepeat?:number):nil
---@param serverIP? string @(optional) if non-nil, that server is used. If `nil`, then the last contacted server is used.
---@param callback? fun(sec:number, usec:number, server:string, info:table) @(optional) if provided it will be invoked on a successful synchronization, with four parameters: seconds, microseconds, server and info.
---@param errcallback? fun() @(optional) failure callback with two parameters. The first is an integer describing the type of error. The module automatically performs a number of retries before giving up and reporting the error. The second is a string containing supplementary information (if any).
---@param autorepeat? number @(optional) if this is non-nil, then the synchronization will happen every 1000 seconds and try and condition the clock if possible. The callbacks will be called after each sync operation.
---@return nil
function sntp.sync(serverIP, callback, errcallback, autorepeat) end

---Sets the offset between the rtc clock and the NTP time.
---@param offset? number @"The offset between NTP time and  \n the rtc time. This can be omitted, and defaults to zero.  \n This call enables the offset tracking."
---@return nil
function sntp.setoffset(offset) end

---Gets the offset between the rtc clock and the NTP time.
---@return number offset @The current offset.
function sntp.getoffset() end
