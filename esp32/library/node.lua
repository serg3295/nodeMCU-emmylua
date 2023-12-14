---@meta

--=== node ===

---@class node
---@field CPU80MHZ integer
---@field CPU160MHZ integer
---@field wakeup_GPIO integer
---@field wakeup_TIMER integer
---@field wakeup_TOUCHPAD integer
---@field wakeup_UART integer
---@field wakeup_ULP integer
node = {}

---@class node.egc
---@field NOT_ACTIVE integer
---@field ON_ALLOC_FAILURE integer
---@field ON_MEM_LIMIT integer
---@field ALWAYS integer
node.egc = {}

---@class node.task
---@field LOW_PRIORITY integer
---@field MEDIUM_PRIORITY integer
---@field HIGH_PRIORITY integer
node.task = {}

---@class node.LFS
---@field time integer
---@field config table
node.LFS = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode @The first value returned is the raw code, not the new 'reset info' code which was introduced in recent SDKs. Values are:
--- - 1, power-on
--- - 2, reset (software?)
--- - 3, hardware reset via reset pin
--- - 4, WDT reset (watchdog timeout)
---@return integer reason @The second value returned is the extended reset cause. Values are:
--- - 0, power-on
--- - 1, hardware watchdog reset
--- - 2, exception reset
--- - 3, software watchdog reset
--- - 4, software restart
--- - 5, wake from deep sleep
--- - 6, external reset
--Or the internal reset code of the system can be returned as extended reset cause:
--- - 7: NO_MEAN                 no known reason
--- - 8: POWERON_RESET           power on reset, this includes reset button connected to power-on reset
--- - 9:
--- - 10: SW_RESET               software reset digital core caused by esp-idk firmware
--- - 11: OWDT_RESET             legacy watch dog reset digital core
--- - 12: DEEPSLEEP_RESET        Deep Sleep reset digital core
--- - 13: SDIO_RESET             Reset by SLC module, reset digital core
--- - 14: TG0WDT_SYS_RESET       Timer Group0 Watch dog reset digital core
--- - 15: TG1WDT_SYS_RESET       Timer Group1 Watch dog reset digital core
--- - 16: RTCWDT_SYS_RESET       RTC Watch dog Reset digital core
--- - 17: INTRUSION_RESET        Instrusion tested to reset CPU
--- - 18: TGWDT_CPU_RESET        Time Group reset CPU
--- - 19: SW_CPU_RESET           Software reset (from node.restart() or lua PANIC)
--- - 20: RTCWDT_CPU_RESET       RTC Watch dog Reset CPU
--- - 21: EXT_CPU_RESET          for APP CPU, reseted by PRO CPU
--- - 22: RTCWDT_BROWN_OUT_RESET Reset when the vdd voltage is not stable
--- - 23: RTCWDT_RTC_RESET       RTC Watch dog reset digital core and rtc module
---
---In general, the extended reset cause supercedes the raw code. The raw code is kept for backwards compatibility only.\
---For new applications it is highly recommended to use the extended reset cause instead.
---In case of extended reset cause 19 (SW_CPU_RESET),\
---an additional value is returned containing the number of consecutive Lua panics. If the reset was caused by a call to\
---node.restart() this value is 0; after the first panic the value is 1; if a panic reoccurs the value increments upto 15.
---In case of extended reset cause 3 (exception reset), additional values are returned containing the crash information. These are, in order, EXCCAUSE, EPC1, EPC2, EPC3, EXCVADDR, and DEPC.
---@return integer|nil EXCCAUSE #Exception Cause
---@return integer|nil EPC1 #additional CPU register
---@return integer|nil EPC2 #additional CPU register
---@return integer|nil EPC3 #additional CPU register
---@return integer|nil EXCVADDR #an invalid memory location address which was written/read
---@return integer|nil DEPC
---@nodiscard
function node.bootreason() end

---Returns the ESP chip ID.
---@return string @chip ID
---@nodiscard
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as .lc file.
---@param filename string|".lua" @filename name of Lua text file
---@return nil
function node.compile(filename) end

---@class DsleepCfg
---@field secs number
---@field us number
---@field gpio number|table
---@field level number
---@field isolate table
---@field pull boolean
---@field touch boolean

---Enters deep sleep mode.\
--- *@param* `usecs` - For compatibility, a `number` parameter `usecs` can be supplied instead of\
---an `options` table, which is equivalent to `node.dsleep({us = usecs})`.
---@overload fun(usecs: number)
---@param options DsleepCfg @a table containing some of:
--- - **secs**, a number of seconds to sleep.\
---This permits longer sleep periods compared to using the us parameter.
--- - **us**, a number of microseconds to sleep.\
---If both secs and us are provided, the values are combined.
--- - **gpio**, a single GPIO number or a list of GPIOs.\
---These pins must all be RTC-capable otherwise an error is raised.
--- - **level**. Whether to trigger when *any* of the GPIOs are high (level=1,\
---which is the default if not specified),\
---or when *all* the GPIOs are low (level=0).
--- - **isolate**. A list of GPIOs to isolate.\
---Isolating a GPIO disables input, output, pullup, pulldown, and enables hold\
---feature for an RTC IO. Use this option if an RTC IO needs to be disconnected\
---from internal circuits in deep sleep, to minimize leakage current.
--- - **pull**, boolean, whether to keep powering previously-configured\
---internal pullup/pulldown resistors. Default is `false` if not specified.
--- - **touch**, boolean, whether to trigger wakeup from any previously-configured\
---touchpads. Default is `false` if not specified.
function node.dsleep(options) end

---@version 5.1
---Sets the Emergency Garbage Collector mode.
---@param mode integer @>
---|`node.egc.NOT_ACTIVE` #EGC inactive, no collection cycle will be forced in low memory situations
---|`node.egc.ON_ALLOC_FAILURE` #Try to allocate a new block of memory, and run the garbage collector if the allocation fails.
---|`node.egc.ON_MEM_LIMIT` #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit.
---|`node.egc.ALWAYS` #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error.
---@param level number @in the case of `node.egc.ON_MEM_LIMIT`, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---@deprecated
---Deprecated synonym for `node.LFS.reload()`.\
---Reload LFS (Lua Flash Store) with the flash image provided.
---@param imageName string @"The name of a image file in the filesystem  \nto be loaded into the LFS."
---@return any|nil @"In the case when the imagename is a valid LFS image,  \n this is expanded and loaded into flash, and the ESP is then  \n immediately rebooted, *so control is not returned to the calling  \n Lua application* in the case of a successful reload.
function node.flashreload(imageName) end

---@deprecated
---Deprecated synonym for `node.LFS.get()` to return an LFS\
---function reference.
---@param modulename string @@The name of the module to be loaded.
---@return function|nil @"If the LFS is loaded and the modulename is a string  \n that is the name of a valid module in the LFS, then the function  \n is returned in the same way the `load()` and the other Lua load  \n functions do. Otherwise `nil` is returned."
function node.flashindex(modulename) end

---Returns the current available heap size in bytes.
---@return number heap @system heap size left in bytes
---@nodiscard
function node.heap() end

---Returns the function reference for a function in LFS.\
---Note that unused `node.LFS` properties map onto the equialent `get()` call\
---so for example: `node.LFS.mySub1` is a synonym for `node.LFS.get('mySub1')`.
---@param modulename string @ The name of the module to be loaded.
---@return table|nil @
--- - If the LFS is loaded and the `modulename` is a string that is the name of\
---a valid module in the LFS, then the function is returned in the same way\
---the `load()` and the other Lua load functions do
--- - Otherwise `nil` is returned.
function node.LFS.get(modulename) end

--- List the modules in LFS.
---@return table|nil @
--- - If no LFS image IS LOADED then `nil` is returned.
--- - Otherwise an sorted array of the name of modules in LFS is returned.
---@nodiscard
function node.LFS.list() end

---Reload LFS with the flash image provided. Flash images can be generated
---on the host machine using the `luac.cross`command.
---@param imageName string @The name of a image file in the filesystem to be loaded into the LFS.
---@return string|nil @
--- - In the case when the `imagename` is a valid LFS image, this is expanded and loaded into flash, and the ESP is then immediately rebooted, *so control is not returned to the calling Lua application* in the case of a successful reload.
--- - The reload process internally makes multiple passes through the LFS image file. The first pass validates the file and header formats and detects many errors. If any is detected then an error string is returned.
function node.LFS.reload(imageName) end

---Submits a string to the Lua interpreter.\
---Similar to pcall(loadstring(str)), but\
---without the single-line limitation.
---@param str string @Lua chunk
---@return nil
function node.input(str) end

---Redirects all standard output (`stdout`) to a callback function. Optionally also prints it\
---to the console device, as specified in Kconfig under the "ESP System Settings" section.
---@overload fun(): nil
---@param callback function @"`output_fn(str)` a function accept every output as str,  \n and can send the output to a socket (or maybe a file). `nil` to unregister  \n the previous function."
---@param console_output integer @0 | 1
---|>`1` #output also sent out the console port.
---|`0` #no console output.
---@return nil
function node.output(callback, console_output) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean @>
---|`true` #to enable printing
---|>`false` #to disable printing
function node.osprint(enabled) end

---Restarts the chip.
---@return nil
function node.restart() end

---Overrides the default crash handling which always restarts the system.\
---It can be used to e.g. write an error to a logfile or to secure connected hardware before restarting.
---
---**!!! attention**\
---It is strongly advised to ensure that the callback ends with a restart. Something has gone quite wrong\
---and it is probably not safe to just wait for the next ---event (e.g., timer tick) and hope everything works out.
---@param callback function @"a callback function to be executed when an error occurs, gets the error string  \nas an argument, remember to **trigger a restart** at the end of the callback"
---@return nil
function node.setonerror(callback) end

---@class SleepCfg
---@field secs number
---@field us number
---@field gpio boolean
---@field touch boolean
---@field uart integer
---@field ulp boolean

---Enters light sleep mode, which saves power without losing state. The state of the CPU and\
---peripherals is preserved during light sleep and is resumed once the processor wakes up.\
---When the processor wakes back up depends on the supplied options.
---@param options SleepCfg @a table containing some of:
--- - **secs**, a number of seconds to sleep.\
---This permits longer sleep periods compared to using the **us** parameter.
--- - **us**, a number of microseconds to sleep.\
---If both **secs** and **us** are provided, the values are combined.
--- - **gpio**, a boolean, whether to allow wakeup by GPIOs. Default is `false` if not specified.
--- - **touch**, boolean, whether to trigger wakeup from any previously-configured touchpads.\
---Default is `false` if not specified.
--- - **uart**, an integer or list of integers. Which UARTs should trigger wakeup.\
---Default is the empty list if not specified.
--- - **ulp**, a boolean, whether to allow the ULP to trigger wakeup.\
---Default is `false` if not specified.
---@return integer @One of the following values, depending on what triggered the wakeup.
--- - node.wakeup_GPIO
--- - node.wakeup_TIMER
--- - node.wakeup_TOUCHPAD
--- - node.wakeup_UART
--- - node.wakeup_ULP
function node.sleep(options) end

---Controls the amount of debug information kept during node.compile(), and\
---allows removal of debug information from already compiled Lua code.
---@param level? number @(optional) 1 | 2 | 3
---|`1` #don't discard debug info
---|`2` #discard Local and Upvalue debug info
---|`3` #discard Local, Upvalue and line-number debug info
---@param callback? function @"(optional) `function` a compiled function to be stripped  \n per setfenv except 0 is not permitted."
---@return integer|nil @"If invoked without arguments, returns the current level settings.  \n Otherwise, `nil` is returned."
function node.stripdebug(level, callback) end

---Enable a Lua callback or task to post another task request.
---@overload fun(callback: function): nil
---@param task_priority? number @(optional) 0 | 1 | 2
---|`node.task.LOW_PRIORITY` #= 0
---|>`node.task.MEDIUM_PRIORITY` #= 1
---|`node.task.HIGH_PRIORITY` #= 2
---@param callback fun() @function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, callback) end

---Returns the value of the system counter, which counts\
---in microseconds starting at 0 when the device is booted.
---@return number lowbits @"the time in microseconds since boot or  \n the last time the counter wrapped"
---@return number highbits @the number of times the counter has wrapped
function node.uptime() end
