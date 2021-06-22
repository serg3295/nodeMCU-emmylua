--=== can ===

---@class can
---@field STANDARD_FRAME integer
---@field EXTENDED_FRAME integer
can = {}

---Send a frame.
---@param format integer|'can.STANDARD_FRAME'|'can.EXTENDED_FRAME' @frame standart | extended
---@param msg_id any @msg_id CAN Message ID
---@param data any @data CAN data, up to 8 bytes
---@return nil
function can.send(format, msg_id, data) end

---@class CanSetup
---@field speed number
---@field tx number
---@field rx number
---@field dual_filter number
---@field code number
---@field mask number

---Configuration CAN controller.
---@param tbl CanSetup @config table
--- - **speed** kbps. One of following value: 1000, 800, 500, 250, 100.
--- - **tx** Pin num for TX.
--- - **rx** Pin num for RX.
--- - **dual_filter** `true` dual filter mode, `false` single filter mode (default)
--- - **code** 4-bytes integer. Use this with mask to filter CAN frame.\
---Default: 0. See SJA1000
--- - **mask** 4-bytes integer. Default: 0xffffffff
---@param callback function|'function(format, msg_id, data) end' @function to be called when CAN data received.
--- - **format** Frame format. can.STANDARD_FRAME or can.EXTENDED_FRAME
--- - **msg_id** CAN Messge ID
--- - **data** CAN data, up to 8 bytes
---@return nil
function can.setup(tbl, callback) end

---Start CAN controller.
---@return nil
function can.start() end

---Stop CAN controller.
---@return nil
function can.stop() end
