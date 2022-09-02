---@meta

--=== pulsecnt ===

---@class pulsecnt
---@field PCNT_COUNT_DIS integer
---@field PCNT_COUNT_INC integer
---@field PCNT_COUNT_DEC integer
---@field PCNT_MODE_KEEP integer
---@field PCNT_MODE_REVERSE integer
---@field PCNT_MODE_DISABLE integer
pulsecnt = {}

---@class pulsecntObj
local pulsecntObj = {}

---Create the pulse counter object.
---@param unit integer @ESP32 has 0 thru 7 units to count pulses on.
---@param callbackOnEvents? function @"(optional) Your Lua method to call on  \n `event.myfunction(unit, isThr0, isThr1, isLLim, isHLim, isZero)` will be called."
---Event will be
--- - PCNT_EVT_THRES_0 (Threshold 0 hit),
--- - PCNT_EVT_THRES_1 (Threshold 1 hit),
--- - PCNT_EVT_L_LIM (Minimum counter value),
--- - PCNT_EVT_H_LIM (Maximum counter value),
--- - PCNT_EVT_ZERO (counter value zero event)
---@return pulsecntObj @pulsecnt object
function pulsecnt.create(unit, callbackOnEvents) end

---@alias pulse_mode1 integer
---|`pulsecnt.PCNT_COUNT_DIS` #= 0 Counter mode: Inhibit counter (counter value will not change in this condition).
---|`pulsecnt.PCNT_COUNT_INC` #= 1 Counter mode: Increase counter value.
---|`pulsecnt.PCNT_COUNT_DEC` #= 2 Counter mode: Decrease counter value.

---@alias pulse_mode2 integer
---|`pulsecnt.PCNT_MODE_KEEP` #= 0 Control mode: will not change counter mode.
---|`pulsecnt.PCNT_MODE_REVERSE` #= 1 Control mode: invert counter mode (increase -> decrease, decrease -> increase).
---|`pulsecnt.PCNT_MODE_DISABLE` #= 2 Control mode: Inhibit counter (counter value will not change in this condition).

---Configure channel 0 of the pulse counter object you created from the create() method.
---@param pulse_gpio_num integer @Any GPIO pin can be used.
---@param ctrl_gpio_num integer @Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 @Positive rising edge count mode, i.e. count the pulse when the rising edge occurs.
---@param neg_mode pulse_mode1 @Negative falling edge count mode, i.e. count the pulse when the falling edge occurs.
---@param lctrl_mode pulse_mode2 @Required. When ctrl_gpio_num is low how should the counter be influenced.
---@param hctrl_mode pulse_mode2 @Required. When ctrl_gpio_num is high how should the counter be influenced.
---@param counter_l_lim integer @Range -32768 to 32767. The lower limit counter. You get a callback at this count and the counter is reset to zero after this lower limit is hit.
---@param counter_h_lim integer @Range -32768 to 32767. The high limit counter.You get a callback at this count and the counter is reset to zero after this high limit is hit.
---@return nil
function pulsecntObj:chan0Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Configure channel 1 of the pulse counter object you created from the `create()` method.
---@param pulse_gpio_num integer @Any GPIO pin can be used.
---@param ctrl_gpio_num integer @Required (although you can specify pulsecnt.PIN_NOT_USED to ignore)
---@param pos_mode pulse_mode1 @Positive rising edge count mode, i.e. count the pulse when the rising edge occurs.
---@param neg_mode pulse_mode1 @Negative falling edge count mode, i.e. count the pulse when the falling edge occurs.
---@param lctrl_mode pulse_mode2 @Required. When ctrl_gpio_num is low how should the counter be influenced.
---@param hctrl_mode pulse_mode2 @Required. When ctrl_gpio_num is high how should the counter be influenced.
---@param counter_l_lim integer @Range -32768 to 32767. The lower limit counter. You get a callback at this count and the counter is reset to zero after this lower limit is hit.
---@param counter_h_lim integer @Range -32768 to 32767. The high limit counter. You get a callback at this count and the counter is reset to zero after this high limit is hit.
---@return nil
function pulsecntObj:chan1Config(pulse_gpio_num, ctrl_gpio_num, pos_mode, neg_mode, lctrl_mode, hctrl_mode, counter_l_lim, counter_h_lim) end

---Set the threshold values to establish watchpoints for getting callbacks on.
---@param thr0 integer @"Threshold 0 value. Range -32768 to 32767. This is a watchpoint  \n value to get a callback with isThr0 set to true on this count being reached."
---@param thr1 integer @"Threshold 1 value. Range -32768 to 32767. This is a watchpoint  \n value to get a callback with isThr1 set to true on this count being reached."
---@return nil
function pulsecntObj:setThres(thr0, thr1) end

---Set a filter to ignore pulses on the pulse_gpio_num pin and the ctrl_gpio_num\
---to avoid short glitches. Any pulses lasting shorter than this will be ignored.
---@param clkCycleCnt integer @0 to 1023 allowed.
---Any pulses lasting shorter than this will be ignored. A pulse needs to be high or\
---low for longer than this filter clock cycle. Clock is 80Mhz APB clock, so one cycle is\
---1000/80,000,000 = 0.0000125 ms. The longest value of 1023 cycles = 0.0127875 ms.
---@return nil
function pulsecntObj:setFilter(clkCycleCnt) end

---Clear the counter. Sets it back to zero.
---@return nil
function pulsecntObj:clear() end

---Get the current pulse counter.
---@return integer
function pulsecntObj:getCnt() end
