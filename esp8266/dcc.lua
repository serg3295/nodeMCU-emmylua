--=== dcc ===

---@class dcc
---@field DCC_RESET any
---@field DCC_IDLE any
---@field DCC_SPEED any
---@field DCC_SPEED_RAW any
---@field DCC_FUNC any
---@field DCC_TURNOUT any
---@field DCC_ACCESSORY any
---@field DCC_RAW any
---@field DCC_SERVICEMODE any
---@field MAN_ID_DIY any
---@field FLAGS_MY_ADDRESS_ONLY any
---@field FLAGS_DCC_ACCESSORY_DECODER any
---@field FLAGS_OUTPUT_ADDRESS_MODE any
---@field FLAGS_AUTO_FACTORY_DEFAULT any
---@field CV_VALID any
---@field CV_READ any
---@field CV_WRITE any
---@field CV_RESET any
dcc = {}

---Initializes the dcc module and links callback functions.
---@param DCC_command function @`DCC_command(cmd, params)` calllback function that is called when a DCC command is decoded. **cmd** parameters is one of the following values. **params** contains a collection of parameters specific to given command.
--- - dcc.DCC_RESET no additional parameters, params is `nil`.
--- - dcc.DCC_IDLE no additional parameters, params is `nil`.
--- - dcc.DCC_SPEED parameters collection members are *Addr, AddrType, Speed, Dir, SpeedSteps*.
--- - dcc.DCC_SPEED_RAW parameters collection members are *Addr, AddrType, Raw*.
--- - dcc.DCC_FUNC parameters collection members are *Addr, AddrType, FuncGrp, FuncState*.
--- - dcc.DCC_TURNOUT parameters collection members are *BoardAddr, OutputPair, Direction,OutputPower or Addr, Direction, OutputPower*.
--- - dcc.DCC_ACCESSORY parameters collection has one member *BoardAddr* or *Addr* or *State*.
--- - dcc.DCC_RAW parameters collection member are *Size*, *PreambleBits*, *Data1* to *Data6*.
--- - dcc.DCC_SERVICEMODE parameters collection has one member *InServiceMode*.
---@param ManufacturerId number @Manufacturer ID returned in CV 8. Commonly dcc.MAN_ID_DIY.
---@param VersionId number @Version ID returned in CV 7.
---@param Flags any @one of or combination (OR operator) of
--- - dcc.FLAGS_MY_ADDRESS_ONLY Only process packets with My Address.
--- - dcc.FLAGS_DCC_ACCESSORY_DECODER Decoder is an accessory decode.
--- - dcc.FLAGS_OUTPUT_ADDRESS_MODE This flag applies to accessory decoders only. Accessory decoders normally have 4 paired outputs and a single address refers to all 4 outputs. Setting this flag causes each address to refer to a single output.
--- - dcc.FLAGS_AUTO_FACTORY_DEFAULT Call DCC command callback with `dcc.CV_RESET` command if CV 7 & 8 == 255.
---@param OpsModeAddressBaseCV number @Ops Mode base address. Set it to 0?
---@param CV_callback function @`CV_callback(operation, param)` callback function that is called when any manipulation with CV (Configuarion Variable) is requested.
--- - dcc.CV_VALID to determine if a given CV is valid. This callback must determine if a CV is valid and return the appropriate value. The `param` collection has members `CV` and Value.
--- - dcc.CV_READ to read a CV. This callback must return the value of the CV. param collection has one member CV determing the CV number to be read.
--- - dcc.CV_WRITE to write a value to a CV. This callback must write the Value to the CV and return the value of the CV. The `param` collection has members `CV` and `Value`.
--- - dcc.CV_RESET Called when CVs must be reset to their factory defaults.
---@return nil
function dcc.setup(DCC_command, ManufacturerId, VersionId, Flags, OpsModeAddressBaseCV, CV_callback) end

---Stops the dcc module.
---@return nil
function dcc.close() end
