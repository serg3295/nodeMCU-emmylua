---@meta

--=== touch ===

---@class touch
---@field TOUCH_TRIGGER_BELOW number
---@field TOUCH_TRIGGER_ABOVE number
---@field TOUCH_LVOLT_0V4 number
---@field TOUCH_LVOLT_0V5 number
---@field TOUCH_LVOLT_0V6 number
---@field TOUCH_LVOLT_0V7 number
---@field TOUCH_HVOLT_2V4 number
---@field TOUCH_HVOLT_2V5 number
---@field TOUCH_HVOLT_2V6 number
---@field TOUCH_HVOLT_2V7 number
---@field TOUCH_HVOLT_ATTEN_0V number
---@field TOUCH_HVOLT_ATTEN_0V5 number
---@field TOUCH_HVOLT_ATTEN_1V number
---@field TOUCH_HVOLT_ATTEN_1V5 number
touch = {}

---@class tp
local tp = {}

---@class tpConfig
---@field pad integer
---@field cb function
---@field intrInitAtStart boolean
---@field thres integer
---@field thresTrigger number
---@field filterMs number
---@field lvolt number
---@field hvolt number
---@field atten number
---@field isDebug boolean

---Create the touch sensor object.
---@param tbl tpConfig @List of values for configuration table:
---  - **pad** Required. padNum || {table of padNums}. Specify one pad like `pad = 4`, or provide a table list of pads. For example use `pad = {0,1,2,3,4,5,6,7,8,9}` to specify all pads. Pads allowed are 0=GPIO4, 1=GPIO0, 2=GPIO2, 3=GPIO15, 4=GPIO13, 5=GPIO12, 6=GPIO14, 7=GPIO27, 8=GPIO33, 9=GPIO32.
---  - **cb** Optional. Your Lua method that gets called on touch event. `myfunction(pads)` will be called where `pads` is a table of pads that were touched. The key is the pad number while the value is true, i.e. `pads = {[2]=true, [3]=true}` if pad 2 and 3 were both touched at the same time. When you specify a callback, interrupt mode is automatically turned on. You can specify `intrInitAtState = false` to manually turn on the interrupt later. If no callback is provided or `nil` is specified, then polling mode is active where you must call `tp:read()` to get the touch pad values.
---  - **intrInitAtStart** Optional. Defaults to `true`. Turn on interrupt at start. Set to false to if you want to configure the touch sensors first and then manually turn on interrupts later with `tp:intrEnable()`.
---  - **thres** Optional. Defaults to 0. Range is 0 to 65536. Provide a threshold value to be set on all pads specified in the `pad` parameter. Typically you will set thresholds per pad since pad size/shape/wire legnth influences the counter value per pad and thus your threshold is usually differnt per pad. You can set thres later per pad with `tp:setThres(padNum, thres)`.
--- - **thresTrigger** Optional. Defaults to touch.TOUCH_TRIGGER_BELOW.
---   - touch.TOUCH_TRIGGER_BELOW
---   - touch.TOUCH_TRIGGER_ABOVE
--- - **filterMs** Optional. Range is 0 to 4294967295 milliseconds. Used in polling mode only (if you provide a callback polling mode is disabled). Will filter noise for this many ms to give more consistent counter results. When filterMs is specified you will receive a 2nd return value in the `raw, filter = tp:read()` call with the filtered values in a Lua table.
--- - **lvolt** Optional. Low reference voltage
---    - touch.TOUCH_LVOLT_0V4
---    - touch.TOUCH_LVOLT_0V5
---    - touch.TOUCH_LVOLT_0V6
---    - touch.TOUCH_LVOLT_0V7
--- - **hvolt** Optional. High reference voltage
---    - touch.TOUCH_HVOLT_2V4
---    - touch.TOUCH_HVOLT_2V5
---    - touch.TOUCH_HVOLT_2V6
---    - touch.TOUCH_HVOLT_2V7
--- - **atten** Optional. High reference voltage attenuation
---   - touch.TOUCH_HVOLT_ATTEN_0V
---   - touch.TOUCH_HVOLT_ATTEN_0V5
---   - touch.TOUCH_HVOLT_ATTEN_1V
---   - touch.TOUCH_HVOLT_ATTEN_1V5
--- - **isDebug** Optional. Defaults to `false`. Set to `true` to get debug information during development. The info returned while debug is on can be very helpful in understanding polling vs interrupts, configuration, and threshold settings. Set to `false` during production.
---@return tp touchObj @touch object
function touch.create(tbl) end

---Read the touch sensor counter values for all pads configured in touch.create() method.
---@return table raw @Lua table of touch sensor counter values per pad
---@return table filter @"A 2nd Lua table of touch sensor filtered counter values per pad  \n is returned if filterMs is specified during the `touch.create()` method."
function tp:read() end

---Set touch sensor interrupt threshold per pad.
---@param padNum number @"One pad number can be specified here.  \n If you did multiple pads you must call this per pad."
---@param thresVal number @"The threshold value to set for the pad interrupt trigger. If you set  \n `touch.TOUCH_TRIGGER_BELOW` then the interrupt occurs when the touch counter goes below  \n this threshold value, or vice versa for `touch.TOUCH_TRIGGER_ABOVE`."
---@return nil
function tp:setThres(padNum, thresVal) end

---Set the trigger mode globally for all touch pads.
---@param mode integer|'touch.TOUCH_TRIGGER_BELOW'|'touch.TOUCH_TRIGGER_ABOVE' @mode
---@return nil
function tp:setTriggerMode(mode) end

---Enable interrupt on the touch sensor hardware.
---@return nil
function tp:intrEnable() end

---Disable interrupt on the touch sensor hardware.
---@return nil
function tp:intrDisable() end
