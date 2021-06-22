--=== i2s ===

---@class i2s
---@field MODE_MASTER number
---@field MODE_SLAVE number
---@field MODE_TX number
---@field MODE_RX number
---@field MODE_DAC_BUILT_IN number
---@field MODE_ADC_BUILT_IN number
---@field MODE_PDM number
---@field CHANNEL_RIGHT_LEFT number
---@field CHANNEL_ALL_LEFT number
---@field CHANNEL_ONLY_LEFT number
---@field CHANNEL_ALL_RIGHT number
---@field CHANNEL_ONLY_RIGHT number
---@field FORMAT_I2S number
---@field FORMAT_I2S_MSB number
---@field FORMAT_I2S_LSB number
---@field FORMAT_PCM number
---@field FORMAT_PCM_SHORT number
---@field FORMAT_PCM_LONG number
---@field DAC_CHANNEL_DISABLE number
---@field DAC_CHANNEL_RIGHT number
---@field DAC_CHANNEL_LEFT number
---@field DAC_CHANNEL_BOTH number
i2s = {}

---Mute the I2S channel. The hardware buffer is instantly filled with silence.
---@param i2s_num integer|'0'|'1' @I2S peripheral 0 or 1
---@return nil
---An error is thrown in case of invalid parameters or if the i2s driver failed.
function i2s.mute(i2s_num) end

---Read data from I2S receive buffer.
---@param i2s_num integer|'0'|'1' @I2S peripheral 0 or 1
---@param size number @Bytes to read
---@param wait_ms? number @"(optional) Millisecond to wait if data is not ready.  \n Defaults to 0 (not to wait) when omitted."
---@return any @"Data read from data-in pin. If data is not ready in `wait_ms` millisecond,  \n less than `size` bytes can be returned. An error is thrown in case of invalid parameters  \n or if the i2s driver failed."
function i2s.read(i2s_num, size, wait_ms) end

---@class I2sCfg
---@field mode number
---@field rate number
---@field bits number
---@field channel number
---@field format number
---@field buffer_count number
---@field buffer_len number
---@field bck_pin number
---@field ws_pin number
---@field data_out_pin number
---@field data_in_pin number
---@field dac_mode number
---@field adc1_channel number

---Configuration and start I2S bus.
---@param i2s_num integer|'0'|'1' @I2S peripheral
---@param cfg I2sCfg @table containing configuration data:
--- - **mode** I2S work mode. Optional,\
---defaults to `i2s.MODE_MASTER + i2s.MODE_TX` when omitted.
---   - i2s.MODE_MASTER
---   - i2s.MODE_SLAVE
---   - i2s.MODE_TX
---   - i2s.MODE_RX
---   - i2s.MODE_DAC_BUILT_IN
---   - i2s.MODE_ADC_BUILT_IN
---   - i2s.MODE_PDM
--- - **rate** audio sample rate. Optional, defauls to 44100 when omitted.
--- - **bits** bits per sample. Optional, defaults to 16 when omitted.
--- - **channel** channel format of I2S stream. Optional,\
---defaults to `i2s.CHANNEL_RIGHT_LEFT` when omitted.
---   - i2s.CHANNEL_RIGHT_LEFT
---   - i2s.CHANNEL_ALL_LEFT
---   - i2s.CHANNEL_ONLY_LEFT
---   - i2s.CHANNEL_ALL_RIGHT
---   - i2s.CHANNEL_ONLY_RIGHT
--- - **format** communication format. Optional,\
---defaults to `i2s.FORMAT_I2S + i2s.FORMAT_I2S_MSB` when omitted.
---   - i2s.FORMAT_I2S
---   - i2s.FORMAT_I2S_MSB
---   - i2s.FORMAT_I2S_LSB
---   - i2s.FORMAT_PCM
---   - i2s.FORMAT_PCM_SHORT
---   - i2s.FORMAT_PCM_LONG
--- - **buffer_count** number of dma buffers. Optional, defaults to 2 when omitted.
--- - **buffer_len** size of one dma buffer. Optional, defaults to rate/100 when omitted.
--- - **bck_pin** clock pin, optional
--- - **ws_pin** WS pin, optional
--- - **data_out_pin** data output pin, optional
--- - **data_in_pin** data input pin, optional
--- - **dac_mode** DAC mode configuration. Optional,\
---defaults to `i2s.DAC_CHANNEL_DISABLE` when omitted.
---   - i2s.DAC_CHANNEL_DISABLE
---   - i2s.DAC_CHANNEL_RIGHT
---   - i2s.DAC_CHANNEL_LEFT
---   - i2s.DAC_CHANNEL_BOTH
--- - **adc1_channel** ADC1 channel number 0..7. Optional, defaults to off when omitted.
---@param cb function @function called when transmit data is requested or received data is available.
--- - the function is called with parameters **i2s_num** and **dir**
---   - **dir** "tx", for TX data request. Function shall call `i2s.write()`.
---   - **dir** "rx", for RX data available. Function shall call `i2s.read()`.\
---An error is thrown in case of invalid parameters or if the i2s driver failed.
---@return nil
function i2s.start(i2s_num, cfg, cb) end

---Stop I2S bus.
---@param i2s_num integer|'0'|'1' @I2S peripheral
---@return nil
---An error is thrown in case of invalid parameters\
---or if the i2s driver failed.
function i2s.stop(i2s_num) end

---Write to I2S transmit buffer.
---@param i2s_num integer|'0'|'1' @I2S peripheral
---@param data string @string containing I2S stream data
---@return nil
---An error is thrown in case of invalid parameters or\
---if the channel failed.
function i2s.write(i2s_num, data) end
