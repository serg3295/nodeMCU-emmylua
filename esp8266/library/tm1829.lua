---@meta

--=== tm1829 ===

---@class tm1829
tm1829 = {}

---Send data to a led strip using native chip format.
---@param data any @"payload to be sent to one or more TM1829 leds.  \n It is either a 3-channel `pixbuf` (e.g., `pixbuf.TYPE_RGB`) or a string  \n of raw byte values to be sent."
---@return nil
function tm1829.write(data) end
