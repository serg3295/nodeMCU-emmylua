---@meta

--=== softuart ===

---@class softuart
softuart = {}

---@class softuartObj
local softuartObj = {}

---Creates new SoftUART instance.\
---Note that rx pin cannot be shared between instances but tx pin can.
---@param baudrate number @SoftUART baudrate. Maximum supported is 230400.
---@param txPin number @SoftUART tx pin. If set to `nil` `write` method will not be supported.
---@param rxPin number @SoftUART rx pin. If set to `nil` `on("data")` method will not be supported.
---@return softuartObj @softuart instance.
function softuart.setup(baudrate, txPin, rxPin) end

---Sets up the callback function to receive data.
---@param event string|"data" @Event name. Currently only `data` is supported.
---@param trigger number @Can be a character or a number.
--- - If **character** @is set, the callback function will only be run when that character gets received.
--- - When a **number** @is set, the callback function will only be run when buffer will have\
--- as many characters as number.
---@param callback function @function. the data parameter is software UART receiving buffer.
---@return nil
function softuartObj:on(event, trigger, callback) end

---Transmits a byte or sequence of them.
---@param data number|string @Can be a number or string.
--- - When a **number** is passed, only one byte will be sent.
--- - When a **string** is passed, whole sequence will be transmitted.
---@return nil
function softuartObj:write(data) end
