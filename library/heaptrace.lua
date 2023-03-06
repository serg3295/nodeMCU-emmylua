---@meta

--=== heaptrace ===

---@class heaptrace
---@field TRACE_LEAKS integer
---@field TRACE_ALL integer
heaptrace = {}

---Allocates and registers the heap tracing buffer.
---@param bufsz integer @"the size of the heap tracing buffer,  \nexpressed as number of heap tracing records.  \nThe actual size depends on the call chain depth  \nconfigured in Kconfig."
---@return nil
function heaptrace.init(bufsz) end

---Starts the heap tracing. All allocations and frees will be recorded\
---in the heap tracing buffer, subject to availability within the buffer.
---@param mode integer @the heap tracing mode to use. One of:
--- - **heaptrace.TRACE_LEAKS**
--- - **heaptrace.TRACE_ALL**
---@return nil
function heaptrace.start(mode) end

---Stops the heap tracing session.\
---A stopped session may be resumed later.
---@return nil
function heaptrace.stop() end

---Resumes a previously stopped heap tracing session.
---@return nil
function heaptrace.resume() end

---Dumps the heap trace buffer to the console.
---@return nil
function heaptrace.dump() end
