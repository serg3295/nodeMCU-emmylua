---@meta

--=== dcc ===

---@class dcc
---@field DCC_RESET integer
---@field DCC_IDLE integer
---@field DCC_SPEED integer
---@field DCC_SPEED_RAW integer
---@field DCC_FUNC integer
---@field DCC_TURNOUT integer
---@field DCC_ACCESSORY integer
---@field DCC_RAW integer
---@field DCC_SERVICEMODE integer
---@field FLAGS_MY_ADDRESS_ONLY integer
---@field FLAGS_DCC_ACCESSORY_DECODER integer
---@field FLAGS_OUTPUT_ADDRESS_MODE integer
---@field FLAGS_AUTO_FACTORY_DEFAULT integer
---@field MAN_ID_DIY integer
---@field CV_VALID integer
---@field CV_READ integer
---@field CV_WRITE integer
---@field CV_RESET integer
---@field CV_ACK_COMPLETE integer
dcc = {}

---Initializes the dcc module and links callback functions.
---@param Pin integer @the GPIO pin number connected to the DCC detector (must be interrupt capable pin).
---@param AckPin? integer @(optional) the GPIO pin number connected to the ACK mechanism. Will be set HIGH to signal an ACK.
---@param DCC_command fun(cmd:number, params:any) @`DCC_command(cmd, params)` calllback function that is called when a DCC command is decoded. `cmd` parameters is one of the following values. `params` contains a collection of parameters specific to given command.
---  - **dcc.DCC_RESET** no additional parameters, `params` is `nil`.
---  - **dcc.DCC_IDLE** no additional parameters, `params` is `nil`.
---  - **dcc.DCC_SPEED** parameters collection members are `Addr`, `AddrType`, `Speed`, `Dir`, `SpeedSteps`.
---  - **dcc.DCC_SPEED_RAW**  parameters collection members are `Addr`, `AddrType`, `Raw`.
---  - **dcc.DCC_FUNC**  parameters collection members are  `Addr`, `AddrType`, `FuncGrp`, `FuncState`.
---  - **dcc.DCC_TURNOUT** parameters collection members are `BoardAddr`, `OutputPair`, `Direction`, `OutputPower` or `Addr`, `Direction`, `OutputPower`.
---  - **dcc.DCC_ACCESSORY** parameters collection has one member `BoardAddr` or `Addr` or `State`.
---  - **dcc.DCC_RAW** parameters collection member are `Size`, `PreambleBits`, `Data1` to `Data6`.
---  - **dcc.DCC_SERVICEMODE**  parameters collection has one member `InServiceMode`.
---@param ManufacturerId integer @Manufacturer ID returned in CV 8. Commonly `dcc.MAN_ID_DIY`.
---@param VersionId integer @Version ID returned in CV 7.
---@param Flags integer @one of or combination (OR operator) of
---  - **dcc.FLAGS_MY_ADDRESS_ONLY** Only process packets with My Address.
---  - **dcc.FLAGS_DCC_ACCESSORY_DECODER** Decoder is an accessory decode.
---  - **dcc.FLAGS_OUTPUT_ADDRESS_MODE** This flag applies to accessory decoders only. Accessory decoders normally have 4 paired outputs and a single address refers to all 4 outputs. Setting this flag causes each address to refer to a single output.
---  - **dcc.FLAGS_AUTO_FACTORY_DEFAULT**  Call DCC command callback with `dcc.CV_RESET` command if CV 7 & 8 == 255.
---@param OpsModeAddressBaseCV? integer @(optional)  Ops Mode base address. Set it to 0?
---@param CV_table? table @(optional)  The CV values will be directly accessed from this table. metamethods will be invoked if needed. Any errors thrown will cause the CV to be considered invalid. Using this option will prevent `CV_VALID`, `CV_READ`, `CV_WRITE` and `CV_ACK_COMPLETE` from happening.
---@param CV_callback? fun(operation:any, param:any) @(optional) `CV_callback(operation, param)` callback function that is called when any manipulation with CV (Configuarion Variable) is requested.
---  - **dcc.CV_VALID** to determine if a given CV is valid and (possibly) writable. This callback must determine if a CV is readable or writable and return the appropriate value(0/1/true/false). The `param` collection has members `CV` and `Writable`.
---  - **dcc.CV_READ** to read a CV. This callback must return the value of the CV. The `param` collection has one member `CV` determing the CV number to be read.
---  - **dcc.CV_WRITE** to write a value to a CV. This callback must write the Value to the CV and return the value of the CV. The `param` collection has members `CV` and `Value`. Ideally, the final value should be returned -- this may differ from the requested value.
---  - **dcc.CV_RESET** Called when CVs must be reset to their factory defaults.
---  - **dcc.CV_ACK_COMPLETE** Called when an ACK pulse has finished being sent. Only invoked if `AckPin` is specified.
---@return nil
function dcc.setup(Pin, AckPin, DCC_command, ManufacturerId, VersionId, Flags, OpsModeAddressBaseCV, CV_table, CV_callback) end

---Stops the dcc module.
---@return nil
function dcc.close() end
