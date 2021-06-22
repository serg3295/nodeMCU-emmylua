--=== ws2812_effects ===

---@class ws2812_effects
ws2812_effects = {}

---Initialize the effects library with the provided buffer\
---for the connected LED strip.
---@param buffer buffer @is a ws2812.buffer for the connected strip.
---@return nil
function ws2812_effects.init(buffer) end

---Start the animation effect.
---@return nil
function ws2812_effects.start() end

---Stop the animation effect.
---@return nil
function ws2812_effects.stop() end

---Set the brightness.
---@param brightness integer @brightness between 0 and 255
---@return nil
function ws2812_effects.set_brightness(brightness) end

---Set the color.
---@param g integer @is the green value between 0 and 255
---@param r integer @is the red value between 0 and 255
---@param b integer @is the blue value between 0 and 255
---@param w? integer @(optional) is the white value between 0 and 255
---@return nil
function ws2812_effects.set_color(g, r, b, w) end

---Set the speed.
---@param speed integer @speed between 0 and 255
---@return nil
function ws2812_effects.set_speed(speed) end

---Get current speed.
---@return integer speed @between 0 and 255
function ws2812_effects.get_speed() end

---Set the delay between two effect steps in milliseconds.
---@param delay number @is the delay in milliseconds, minimum 10ms
---@return nil
function ws2812_effects.set_delay(delay) end

---Get current delay.
---@return number delay @is the current effect delay in milliseconds
function ws2812_effects.get_delay() end

---Set the active effect mode.
---@param mode string|'"static"'|'"blink"'|'"gradient"'|'"gradient_rgb"'|'"random_color"'|'"rainbow"'|'"rainbow_cycle"'|'"flicker"'|'"fire"'|'"fire_soft"'|'"fire_intense"'|'"halloween"'|'"circus_combustus"'|'"larson_scanner"'|'"color_wipe"'|'"random_dot"'|'"cycle"' @is the effect mode as a string
---@param effect_param? integer|string @is an optional effect parameter.
---@return nil
function ws2812_effects.set_mode(mode, effect_param) end
