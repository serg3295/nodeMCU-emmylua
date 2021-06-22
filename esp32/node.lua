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

---@class egc
---@field NOT_ACTIVE integer
---@field ON_ALLOC_FAILURE integer
---@field ON_MEM_LIMIT integer
---@field ALWAYS integer
node.egc = {}

---@class task
---@field LOW_PRIORITY integer
---@field MEDIUM_PRIORITY integer
---@field HIGH_PRIORITY integer
node.task = {}

---Returns the boot reason and extended reset info.
---@return integer rawcode @"The first value returned is the raw code, not the new  \n 'reset info' code which was introduced in recent SDKs. Values are:"
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
--- - 23: RTCWDT_RTC_RESET       RTC Watch dog reset digital core and rtc module\
---In general, the extended reset cause supercedes the raw code. The raw code is kept for backwards compatibility only.\
---For new applications it is highly recommended to use the extended reset cause instead. In case of extended reset\
---cause 3 (exception reset), additional values are returned containing the crash information. These are, in order,\
---EXCCAUSE, EPC1, EPC2, EPC3, EXCVADDR, and DEPC. In case of extended extended reset cause 19 (SW_CPU_RESET),\
---an additional value is returned containing the number of consecutive Lua panics. If the reset was caused by a call to\
---node.restart() this value is 0; after the first panic the value is 1; if a panic reoccurs the value increments upto 15.
---@return any @ [`exccause, epc1, epc2, epc3, excvaddr, depc`]
function node.bootreason() end

---Returns the ESP chip ID.
---@return string @chip ID
function node.chipid() end

---Compiles a Lua text file into Lua bytecode, and saves it as .lc file.
---@param filename string|'".lua"' @filename name of Lua text file
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

---Returns the flash chip ID.
---@return number flashID @flash ID
function node.flashid() end

---Returns the current available heap size in bytes.
---@return number heap @system heap size left in bytes
function node.heap() end

---Returns NodeMCU version, chipid, flashid,\
---flash size, flash mode, flash speed.
---@return number majorVer
---@return number minorVer
---@return number devVer
---@return number chipid
---@return number flashid
---@return number flashsize
---@return number flashmode
---@return number flashspeed
function node.info() end

---@deprecated
---Defines action to take on button press (on the old devkit 0.9), button connected to GPIO 16.\
---This function is only available if the firmware was compiled with DEVKIT_VERSION_0_9 defined.
---@param type string @"type is either string 'long' or 'short'. long: press the key for 3 seconds,  \n short: press shortly(less than 3 seconds)"
---@param foo function @"user defined function which is called when key is pressed. If `nil`, remove  \n the user defined function. Default function: long: change LED blinking rate, short: reset chip"
---@return nil
function node.key(type, foo) end

---@deprecated
---Sets the on/off time for the LED (on the old devkit 0.9), with the LED\
---connected to GPIO16, multiplexed with node.key(). This function is only\
---available if the firmware was compiled with DEVKIT_VERSION_0_9 defined.
---@param low number @"LED off time, LED keeps on when low=0.  \n Unit: milliseconds, time resolution: 80~100ms"
---@param high number @LED on time. Unit: milliseconds, time resolution: 80~100ms
---@return nil
function node.led(low, high) end

---Submits a string to the Lua interpreter.\
---Similar to pcall(loadstring(str)), but\
---without the single-line limitation.
---@param str string @Lua chunk
---@return nil
function node.input(str) end

---Redirects the Lua interpreter output to a callback function.\
---Optionally also prints it to the serial console.
---@param callback function @"`output_fn(str)` a function accept every output as str,  \n and can send the output to a socket (or maybe a file). `nil` to unregister  \n the previous function."
---@param serial_output integer @0 | 1
---|>'1' #output also sent out the serial port.
---|'0' #no serial output.
---@return nil
function node.output(callback, serial_output) end

---Redirects the debugging output from the Espressif SDK to\
---a callback function allowing it to be captured or processed in Lua.
---@param callback function @"`function(str)` a function accepts debugging  \n output as str, and can send the output to a socket (or maybe a file).  \n `nil` to unregister the previous function."
function node.osoutput(callback) end

---@deprecated
---Moved to `adc.readvdd33()`.
function node.readvdd33() end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults using\
---the SDK function *system_restore()*, which \
---doesn't document precisely what it erases/restores.
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|'node.CPU80MHZ'|'node.CPU160MHZ' @constant
---@return number @target CPU frequency
function node.setcpufreq(speed) end

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
---|'1' #don't discard debug info
---|'2' #discard Local and Upvalue debug info
---|'3' #discard Local, Upvalue and line-number debug info
---@param callback? function @"(optional) `function` a compiled function to be stripped  \n per setfenv except 0 is not permitted."
---@return integer|nil @"If invoked without arguments, returns the current level settings.  \n Otherwise, `nil` is returned."
function node.stripdebug(level, callback) end

---Controls whether the debugging output from the Espressif SDK is printed.
---@param enabled boolean @>
---|'true' #to enable printing
---|>'false' #to disable printing
function node.osprint(enabled) end

---Returns the value of the system counter, which counts\
---in microseconds starting at 0 when the device is booted.
---@return number lowbits @"the time in microseconds since boot or  \n the last time the counter wrapped"
---@return number highbits @the number of times the counter has wrapped
function node.uptime() end

---Sets the Emergency Garbage Collector mode.
---@param mode integer @>
---|'node.egc.NOT_ACTIVE' #EGC inactive, no collection cycle will be forced in low memory situations
---|'node.egc.ON_ALLOC_FAILURE' #Try to allocate a new block of memory, and run the garbage collector if the allocation fails.
---|'node.egc.ON_MEM_LIMIT' #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit.
---|'node.egc.ALWAYS' #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error.
---@param level number @in the case of `node.egc.ON_MEM_LIMIT`, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Enable a Lua callback or task to post another task request.
---@param task_priority? number @(optional) 0 | 1 | 2
---|'node.task.LOW_PRIORITY' #= 0
---|>'node.task.MEDIUM_PRIORITY' #= 1
---|'node.task.HIGH_PRIORITY''0' #= 2
---@param callback function|'function() end' @function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, callback) end
