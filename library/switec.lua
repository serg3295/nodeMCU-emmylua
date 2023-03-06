---@meta

--=== switec ===

---@class switec
switec = {}

---Initialize the nodemcu to talk to a switec X.27 or compatible instrument stepper motor.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
---@param pin1 integer @This is a GPIO number and connects to pin 1 on the stepper.
---@param pin2 integer @This is a GPIO number and connects to pin 2 on the stepper.
---@param pin3 integer @This is a GPIO number and connects to pin 3 on the stepper.
---@param pin4 integer @This is a GPIO number and connects to pin 4 on the stepper.
---@param maxDegPerSec? number @(optional) This can set to limit the maximum slew rate. The default is 400 degrees per second.
--- If the arguments are in error, or the operation cannot be completed, then an error is thrown.
function switec.setup(channel, pin1, pin2, pin3, pin4, maxDegPerSec) end

---Starts the needle moving to the specified position.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
---@param position number @"The position (number of steps clockwise) to move the needle.  \n Typically in the range 0 to around 1000."
---@param stoppedCallback? function @(optional)
--- The channel must have been setup, otherwise an error is thrown.
function switec.moveto(channel, position, stoppedCallback) end

---This sets the current position of the needle as being zero. The needle must be stationary.
---@param channel integer @The switec module supports three stepper motors. The channel is either 0, 1 or 2.
--- The channel must have been setup and the needle must not be moving, otherwise an error is thrown.
function switec.reset(channel) end

---Gets the current position of the needle and whether it is moving.
---@param channel integer @"The switec module supports three  \n stepper motors. The channel is either 0, 1 or 2."
---@return number position @the current position of the needle
---@return integer moving @"**0** if the needle is stationary. **1** for clockwise,  \n **-1** for anti-clockwise."
---@nodiscard
function switec.getpos(channel) end

---Releases the resources associated with the stepper.
---@param channel integer @"The switec module supports three  \n stepper motors. The channel is either 0, 1 or 2."
--- The needle must not be moving, otherwise an error is thrown.
function switec.close(channel) end
