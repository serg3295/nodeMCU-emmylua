---@meta

--=== node ===

---@class node
---@field CPU80MHZ integer
---@field CPU160MHZ integer
---@field INT_UP integer
---@field INT_DOWN integer
---@field INT_BOTH integer
---@field INT_LOW integer
---@field INT_HIGH integer
node = {}

---@class node.LFS
node.LFS = {}

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

---Returns the boot reason and extended reset info.
---@return integer rawcode @The first value returned is the raw code,
---not the new "reset info" code which was introduced in recent SDKs. Values are:
--- - 1, power-on
--- - 2, reset (software?)
--- - 3, hardware reset via reset pin
--- - 4, WDT reset (watchdog timeout)
---@return integer reason @"The second value returned is the extended reset cause.  \n Values are:"
--- - 0, power-on
--- - 1, hardware watchdog reset
--- - 2, exception reset
--- - 3, software watchdog reset
--- - 4, software restart
--- - 5, wake from deep sleep
--- - 6, external reset
---In case of extended reset cause 3 (exception reset),\
---additional values are returned containing the crash information.\
---These are, in order, EXCCAUSE, EPC1, EPC2, EPC3, EXCVADDR, and DEPC.
function node.bootreason() end

---Returns the ESP chip ID.
---@return number @chip ID
function node.chipid() end

---Compiles a Lua text file into Lua bytecode,\
---and saves it as .lc file.
---@param filename string|".lua" @name of Lua text file
---@return nil
function node.compile(filename) end

---Enters deep sleep mode, wakes up when timed out.
---@param us integer @"number (integer) or `nil`, sleep time in micro second.  \n If *us* == 0, it will sleep forever. If *us* == nil, will not set sleep time."
---@param option integer @"number (integer) or `nil`. If `nil`, it will use last alive setting  \n as default option."
--- - 0 , init data byte 108 is valuable
--- - \>0, init data byte 108 is valueless
--- - 0, RF_CAL or not after deep-sleep wake up, depends on init data byte 108
--- - 1, RF_CAL after deep-sleep wake up, there will be large current
--- - 2, no RF_CAL after deep-sleep wake up, there will only be small current
--- - 4, disable RF after deep-sleep wake up, just like modem sleep,\
---there will be the smallest current
---@param instant integer @"number (integer) or `nil`. If present and non-zero, the chip  \n will enter Deep-sleep immediately and will not wait for the Wi-Fi core to be shutdown."
---@return nil
function node.dsleep(us, option, instant) end

---Returns the current theoretical\
---maximum deep sleep duration.
---@return number max_duration
function node.dsleepMax() end

---Returns the flash chip ID
---@return number flashID
function node.flashid() end

---@deprecated
---Deprecated synonym for `node.LFS.get()` to return\
---an LFS function reference. Note that this returns\
---`nil` if the function does not exist in LFS.
function node.flashindex() end

---@deprecated
---Deprecated synonym for `node.LFS.reload()`\
---to reload LFS (Lua Flash Store) with\
---the named flash image provided.
function node.flashreload() end

---Returns the flash chip size in bytes.
---@return integer @flash size in bytes
function node.flashsize() end

---Get the current CPU Frequency.
---@return number @Current CPU frequency
function node.getcpufreq() end

---Get the current LFS and SPIFFS partition information.
---@return { lfs_addr:number, lfs_size:number, spiffs_addr:number, spiffs_size:number } @"An array containing entries for **lfs_addr, lfs_size,  \n spiffs_addr** and **spiffs_size**. The address values are offsets  \n relative to the start of the Flash memory."
function node.getpartitiontable() end

---Returns the current available heap size in bytes.
---@return number heap @system heap size left in bytes
function node.heap() end

---Returns information about hardware, software version and build configuration.
---@param group? string|"hw"|"sw_version"|"build_config" @(optional) A designator for a group of properties.
---@return any @If a group is given the return value will be a table containing the following elements:
--- - for group = `"hw"`
---   - **chip_id** (number)
---   - **flash_id** (number)
---   - **flash_size** (number)
---   - **flash_mode** (number) 0 = QIO, 1 = QOUT, 2 = DIO, 15 = DOUT.
---   - **flash_speed** (number)
--- - for group = `"lfs"`
---   - **lfs_base** (number) Flash offset of selected LFS region
---   - **lfs_mapped** (number) Mapped memory address of selected LFS region
---   - **lfs_size** (number) size of selected LFS region
---   - **lfs_used** (number) actual size used by current LFS image
--- - for group = `"sw_version"`
---   - **git_branch** (string)
---   - **git_commit_id** (string)
---   - **git_release** (string) release name +additional commits e.g. "2.0.0-master_20170202 +403"
---   - **git_commit_dts** (string) commit timestamp in an ordering format. e.g. "201908111200"
---   - **node_version_major** (number)
---   - **node_version_minor** (number)
---   - **node_version_revision** (number)
--- - for group = `"build_config"`
---   - **ssl** (boolean)
---   - **lfs_size** (number) as defined at build time
---   - **modules** (string) comma separated list
---   - **number_type** (string) integer or float
function node.info(group) end

---Submits a string to the Lua interpreter.\
---Similar to `pcall(loadstring(str))`,\
---but without the single-line limitation.
---@param str any @Lua chunk
---@return nil
function node.input(str) end

---Returns the function reference for a function in LFS.
---@param modulename string|"" @The name of the module to be loaded.
---@return function|nil @"If the LFS is loaded and the modulename is a string  \n that is the name of a valid module in the LFS, then the function  \n is returned in the same way the `load()` and the other Lua load  \n functions do. Otherwise `nil` is returned."
function node.LFS.get(modulename) end

---List the modules in LFS.
---@return table|nil @"If no LFS image IS LOADED then `nil` is returned.  \n Otherwise an sorted array of the name of modules in LFS is returned."
function node.LFS.list() end

---Reload LFS with the flash image provided.
---@param imageName string|"" @The name of a image file in the filesystem to be loaded into the LFS.
---@return any|nil @"In the case when the imagename is a valid LFS image, this is expanded and  \n loaded into flash, and the ESP is then immediately rebooted, *so control is not returned to  \n the calling Lua application* in the case of a successful reload. The reload process internally  \n makes multiple passes through the LFS image file. The first pass validates the file and header  \n formats and detects many errors. If any is detected then an error string is returned."
function node.LFS.reload(imageName) end

---Redirects the Lua interpreter to a `stdout` pipe when a CB function is specified (See `pipe` module)\
---and resets output to normal otherwise. Optionally also prints to the serial console.
---@overload fun(): nil
---@param foo fun(pipe:any) @"`output_fn(pipe)` a function accept every output as str,  \n and can send the output to a socket (or maybe a file)."
---Note that this function must conform to the rules for a pipe reader callback.
---@param serial_debug integer @**1** - output also show in serial. **0** - no serial output.
---@return nil
function node.output(foo, serial_debug) end

---Restarts the chip.
---@return nil
function node.restart() end

---Restores system configuration to defaults\
---using the SDK function `system_restore()`
---@return nil
function node.restore() end

---Change the working CPU Frequency.
---@param speed integer|`node.CPU80MHZ`|`node.CPU160MHZ` @constant
---@return number @target CPU frequency
function node.setcpufreq(speed) end

---Overrides the default crash handling which always restarts the system.\
---It can be used to e.g. write an error to a logfile or to secure connected hardware\
---before restarting.\
--- **!!! attention** It is strongly advised to ensure that the callback ends with a restart.\
---Something has gone quite wrong and it is probably not safe to just wait for\
---the next event (e.g., timer tick) and hope everything works out.
---```lua
--- node.setonerror(function(s)
---     print("Error: "..s)
---     node.restart()
---   end)
---```
---@param callback function @"function to be executed when an error occurs,gets the error  \n  string as an argument, remember to **trigger a restart** at the end of the callback"
---@return nil
function node.setonerror(callback) end

---@class NodeSetPartTbl
---@field lfs_addr number
---@field lfs_size number
---@field spiffs_addr number
---@field spiffs_size number

---Sets the current LFS and / or SPIFFS partition information.
---@param partition_info NodeSetPartTbl @An array containing one or more of the following enties.
---The address values are byte offsets relative to the start of the Flash memory.\
---The size values are in bytes.\
---Note that these parameters must be a multiple of 8Kb to align to Flash page boundaries.
--- - **lfs_addr** - The base address of the LFS region.
--- - **lfs_size** - The size of the LFS region.
--- - **spiffs_addr** - The base address of the SPIFFS region.
--- - **spiffs_size** - The size of the SPIFFS region.
function node.setpartitiontable(partition_info) end

---Put NodeMCU in light sleep mode to reduce current consumption.
---@param wake_pin integer @1-12, pin to attach wake interrupt to. Note that pin 0(GPIO 16) does not support interrupts.
---@param int_type? integer @(optional) type of interrupt that you would like to wake on.
---| `node.INT_UP` #Rising edge
---| `node.INT_DOWN` #Falling edge
---| `node.INT_BOTH` #Both edges
---|>`node.INT_LOW` #Low level
---| `node.INT_HIGH` #High level
---@param resume_cb? fun() @(optional) Callback to execute when WiFi wakes from suspension.
---@param preserve_mode? boolean @(optional) preserve current WiFi mode through node sleep.
---|`true` #Station and StationAP modes will automatically reconnect to previously configured Access Point when NodeMCU resumes.
---|`false` #discard WiFi mode and leave NodeMCU in wifi.NULL_MODE. WiFi mode will be restored to original mode on restart.
---@return nil
function node.sleep(wake_pin, int_type, resume_cb, preserve_mode) end

---Query the performance of system startup.
---@param marker? any @"(optional) If present, this will add another  \n entry into the startup counts"
---@return table @"An array of tables which indicate how many CPU  \n cycles had been consumed at each step of platform boot."
function node.startupcounts(marker) end

---@class NodeStartup
---@field banner boolean
---@field frequency number
---@field delay_mount number
---@field command number

---Get/set options that control the startup process. This interface will grow over time.
---@param tbl? NodeStartup @(optional) If the argument is omitted, then no change is made to the current set of startup options.
---If the argument is the empty table **{ }** then all options are reset to their default values. Table one or more options:
--- - **banner** - set to `true` or `false` to indicate whether the startup banner should be displayed or not. (default: true)
--- - **frequency** - set to node.CPU80MHZ or node.CPU160MHZ to indicate the initial CPU speed. (default: node.CPU80MHZ)
--- - **delay_mount** - set to true or false to indicate whether the SPIFFS filesystem mount is delayed until it is first needed or not.\
---(default: false)
--- - **command** - set to a string which is the initial command that is run. This is the same string as in the node.startupcommand.
---@return table @This is the complete set of options in the state that will take effect on the next boot.
---Note that the command key may be missing in which case the default value will be used.
function node.startup(tbl) end

---@deprecated
---Overrides the default startup action on processor restart, preplacing\
---the executing `init.lua` if it exists. This is now deprecated in favor of\
---`node.startup({command="the command"})`.
---@param str string @prefixed with either
--- - `@`, the remaining string is a filename to be executed.
--- - `=`, the remaining string is Lua chunk to be compiled and executed.
---@return boolean @`status` this is `false` if write to the Reboot Config Record fails.
function node.startupcommand(str) end

---Controls the amount of debug information kept during `node.compile()`, and\
---allows removal of debug information from already compiled Lua code.
---@param level? integer @(optional) level
---|`1` #don't discard debug info
---|`2` #discard Local and Upvalue debug info
---|`3` #discard Local, Upvalue and line-number debug info
---@param foo? function @"(optional) a compiled function to be stripped per setfenv  \n except 0 is not permitted."
---@return integer|nil @"If invoked without arguments, returns the current level settings.  \n Otherwise, `nil` is returned."
function node.stripdebug(level, foo) end

---Controls whether the debugging output\
---from the Espressif SDK is printed.
---@param enabled boolean @"This is either `true` to enable printing,  \n or `false` to disable it. The default is `false`."
function node.osprint(enabled) end

---This behaves like math.random except that it uses true random numbers derived from\
---the ESP8266 hardware. It returns uniformly distributed numbers in the required range.
--- - `node.random()` Returns a random real number with uniform distribution in the interval [0,1).
--- - `node.random(u)` Returns an integer random number x such that 1 <= x <= u.
--- - `node.random(l, u)` Returns a pseudo-random integer x such that l <= x <= u.
---@overload fun():number
---@overload fun(u: integer):integer
---@param l integer @the lower bound of the range
---@param u integer @the upper bound of the range
---@return integer @The random number in the appropriate range.
---Note that the zero argument form will always return 0 in the integer build.
function node.random(l, u) end

---Sets the Emergency Garbage Collector mode.
---@param mode integer @mode
---|`node.egc.NOT_ACTIVE` #EGC inactive, no collection cycle will be forced in low memory situations
---|`node.egc.ON_ALLOC_FAILURE` #Try to allocate a new block of memory, and run the garbage collector if the allocation fails. If the allocation fails even after running the garbage collector, the allocator will return with error.
---|`node.egc.ON_MEM_LIMIT` #Run the garbage collector when the memory used by the Lua script goes beyond an upper limit. If the upper limit can't be satisfied even after running the garbage collector, the allocator will return with error. If the given limit is negative, it is interpreted as the desired amount of heap which should be left available. Whenever the free heap (as reported by node.heap() falls below the requested limit, the garbage collector will be run.
---|`node.egc.ALWAYS` #Run the garbage collector before each memory allocation. If the allocation fails even after running the garbage collector, the allocator will return with error. This mode is very efficient with regards to memory savings, but it's also the slowest.
---@param level? number @(optional) in the case of **node.egc.ON_MEM_LIMIT**, this specifies the memory limit.
---@return nil
function node.egc.setmode(mode, level) end

---Returns memory usage information for the Lua runtime.
---@return number total_allocated @"The total number of bytes allocated by the Lua runtime.  \n This is the number which is relevant when using the **node.egc.ON_MEM_LIMIT** option  \n with positive limit values."
---@return number estimated_used @This value shows the estimated usage of the allocated memory.
function node.egc.meminfo() end

---Enable a Lua callback or task to post another task request.
---@overload fun(callback: function): nil
---@param task_priority? integer @(optional) 0 | 1 | 2
---| `node.task.LOW_PRIORITY` #=0
---|>`node.task.MEDIUM_PRIORITY` #=1
---| `node.task.HIGH_PRIORITY` #=2
---@param callback fun() @function to be executed when the task is run.
---@return nil
function node.task.post(task_priority, callback) end
