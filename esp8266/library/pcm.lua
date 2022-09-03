---@meta

--=== pcm ===

---@class pcm
---@field SD integer
---@field RATE_1K integer
---@field RATE_2K integer
---@field RATE_4K integer
---@field RATE_5K integer
---@field RATE_8K integer
---@field RATE_10K integer
---@field RATE_12K integer
---@field RATE_16K integer
pcm = {}

---@class pcmdrv
local pcmdrv = {}

---Initializes the audio driver.
---@param pcm_SD any @pcm.SD use sigma-delta hardware
---@param pin integer @pin 1~10, IO index
---@return pcmdrv obj @Audio driver object.
function pcm.new(pcm_SD, pin) end

---Stops playback and releases\
---the audio hardware.
---@return nil
function pcmdrv:close() end

---Register callback functions for events.
---@param event string @`event` identifier, one of:
---|"data" #callback function is supposed to return a string containing the next chunk of data.
---|"drained" #playback was stopped due to lack of data. The last 2 invocations of the data callback didn't provide new chunks in time (intentionally or unintentionally) and the internal buffers were fully consumed.
---|"paused" #playback was paused by pcm.drv:pause().
---|"stopped" #playback was stopped by pcm.drv:stop().
---|"vu" #new peak data, cb_fn is triggered freq times per second (1 to 200 Hz).
---@param callback? function @"(optional) function for the specified event. Unregisters previous function if omitted.  \n First parameter is `drv`, followed by peak data for `vu` callback."
---@return nil
function pcmdrv:on(event, callback) end

---Starts playback.
---@param rate integer|`pcm.RATE_1K`|`pcm.RATE_2K`|`pcm.RATE_4K`|`pcm.RATE_5K`|`pcm.RATE_8K`|`pcm.RATE_10K`|`pcm.RATE_12K`|`pcm.RATE_16K` @defaults to RATE_8K if omitted
---@return nil
function pcmdrv:play(rate) end

---Pauses playback. A call to `drv:play()`\
---will resume from the last position.
---@return nil
function pcmdrv:pause() end

---Stops playback and releases\
---buffered chunks.
---@return nil
function pcmdrv:stop() end
