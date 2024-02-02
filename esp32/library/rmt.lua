---@meta

--=== rmt ===

---@class rmt
rmt = {}

---@class rmtChannel
local rmtChannel = {}

---@class RmtConfig
---@field invert? boolean if true, then the output is inverted.
---@field carrier_hz? integer specifies that the signal is to modulate the carrier at the specified frequency. This is useful for IR transmissions.
---@field carrier_duty? number specifies the duty cycle of the carrier. Defaults to 50%
---@field idle_level? integer specifies what value to send when the transmission completes.
---@field slots? integer If specified, then the number of memory slots used for transmission. 1 slot = 64 pulses (i.e. high and low widths). Total slots in the system are 8 (on the ESP32). Slots cannot be shared.

---This sets up a transmit channel on the specified gpio pin at the specified rate. Various options described below\
---can be specified in the `options`. The bit time is specified in picoseconds so that integer values can be used.\
---An error will be thrown if the bit time cannot be approximated.
---@param gpio integer @The GPIO pin number to use.
---@param bittime integer @"The bit time to use in picoseconds. Only certain times can be handled exactly. The actual set time  \nwill be returned. The actual range is limited -- probably using 100,000 (0.1&micro;S) or 1,000,000 (1&micro;S). The actual constraint is  \nthat the interval is 1 - 255 cycles of an 80MHz clock."
---@param options? RmtConfig @"(optional) A table with the keys as defined below. This optional table consists of a number of keys  \nthat control various aspects of the RMT transmission.""
--- - **invert** if true, then the output is inverted.
--- - **carrier_hz** specifies that the signal is to modulate the carrier at the specified frequency. This is useful for IR transmissions.
--- - **carrier_duty** specifies the duty cycle of the carrier. Defaults to 50%
--- - **idle_level** specifies what value to send when the transmission completes.
--- - **slots** If specified, then the number of memory slots used for transmission. 1 slot = 64 pulses (i.e. high and low widths). Total slots in the system are 8 (on the ESP32). Slots cannot be shared.
---@return rmtChannel @
--- - The `rmt.channel` object that can be used for sending data
--- - The actual bit time in picoseconds.
---@nodiscard
function rmt.txsetup(gpio, bittime, options) end

---This sets up a receive channel on the specified gpio pin at the specified rate. Various options described below\
---can be specified in the `options`. The bit time is specified in picoseconds so that integer values can be used.\
---An error will be thrown if the bit time cannot be approximated.
---@param gpio integer @The GPIO pin number to use.
---@param bittime integer @"The bit time to use in picoseconds. Only certain times can be handled exactly. The actual set time  \nwill be returned. The actual range is limited -- probably using 100,000 (0.1&micro;S) or 1,000,000 (1&micro;S). The actual constraint  \nis that the interval is 1 - 255 cycles of an 80MHz clock."
---@param options? RmtConfig @"(optional) A table with the keys as defined below. This optional table consists of a number of keys  \nthat control various aspects of the RMT transmission."
--- - **invert** if true, then the input is inverted.
--- - **filter_ticks** If specified, then any pulse shorter than this will be ignored. This is in units of the bit time.
--- - **idle_threshold** If specified, then any level longer than this will set the receiver as idle. The default is 65535 bit times.
--- - **slots** If specified, then the number of memory slots used for reception. 1 slot = 64 pulses (i.e. high and low widths). Total slots in the system are 8 (on the ESP32). Slots cannot be shared.
---@return rmtChannel @
--- - The `rmt.channel` object that can be used for receiving data
--- - The actual bit time in picoseconds.
---@nodiscard
function rmt.rxsetup(gpio, bittime, options) end

---This is establishes a callback to use when data is received and it also starts the data reception process.\
---It can only be called once per receive channel.
---@param event string|"data" @This must be the string 'data' and it sets the callback that gets invoked when data is received.
---@param callback? function @"(optional) This is invoked with a single argument that is a string that contains the data  \nreceived in the format described for `send`. `struct.unpack` is your friend."
---@return nil
function rmtChannel:on(event, callback) end

---This is a (default) blocking call that transmits the data using the parameters specified on the `txsetup` call.
---@param data string|table @This is either a string or a table of strings.
---@param cb? function @"(optional) This is an optional callback when the transmission is actually complete.  \nIf specified, then the `send` call is non-blocking, and the callback invoked when the transmission is complete.  \nOtherwise the `send` call is synchronous and does not return until transmission is complete."
---@return nil
function rmtChannel:send(data, cb) end

---This shuts down the RMT channel and makes it available for other uses (e.g. ws2812). The channel cannot be used after this call returns.\
---The channel is also released when the garbage collector frees it up. However you should always `close` the channel explicitly as otherwise\
---you can run out of RMT channels before the garbage collector frees some up.
---@return nil
function rmtChannel:close() end
