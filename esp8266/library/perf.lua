--=== perf ===

---@class perf
perf = {}

---Starts a performance monitoring session.
---@param start? number @"(optional) The lowest PC address for the histogram.  \n Default is 0x40000000."
---@param endaddr? number @"(optional) The highest address for the histogram.  \n Default is the end of the used space in the flash memory."
---@param nbins? number @"(optional) The number of bins in the histogram.  \n Keep this reasonable otherwise you will run out of memory. Default is 1024."
---@return nil
function perf.start(start, endaddr, nbins) end

---Terminates a performance monitoring session and returns the histogram.
---@return number total @The total number of samples captured in this run
---@return number outside @The number of samples that were outside the histogram range
---@return number histogram @"The histogram represented as a table indexed by address  \n where the value is the number of samples."
---@return number binsize @The number of bytes per histogram bin.
function perf.stop() end
