--=== cron ===

---@class cron
cron = {}

---@class CRON
local CRON = {}

---Creates a new schedule entry.
---@param mask string|'"* * * * *"' @crontab-like string mask for schedule
---@param callback function|'function(e) end' @`function(entry)` that is executed at the scheduled time
---@return CRON cron.entry @sub module
function cron.schedule(mask, callback) end

---Removes all scheduled entries.
---@return nil
function cron.reset() end

---Sets a new handler for entry.
---@param callback function|'function(e) end' @`function(entry)` that is executed at the scheduled time
---@return nil
function CRON:handler(callback) end

---Sets a new schedule mask.
---@param mask string|'"* * * * *"' @crontab-like string mask for schedule
function CRON:schedule(mask) end

---Disables schedule. Disabled schedules may be\
---enabled again by calling `:schedule(mask)`.
---@return nil
function CRON:unschedule() end
