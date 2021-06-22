--=== gdbstub ===

---@class gdbstub
gdbstub = {}

---Runs gdbstub initialization routine. Note that subsequent calls\
---are ignored and the break functions will do this automatically\
---if not already done so this is options
function gdbstub.open() end

---Enters gdb by executing a `break 0,0` instruction,\
---and if necessary first does initialisation.
function gdbstub.brk() end

---Enters gdb by executing a `break 0,0` instruction, and if necessary\
---first does initialisation; It also set the `gdboutput` mode to 1\
---allowing the debug client to capture and echo UART output\
---through the debug session.
function gdbstub.pbrk() end

---Controls whether system output is encapsulated in gdb remote debugging protocol.
---@param enable boolean @>
--- - If `true`, then output is wrapped in gdb remote debugging protocol.
--- - If `false`, then it is sent straight to the UART.
function gdbstub.gdboutput(enable) end
