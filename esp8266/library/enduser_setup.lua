---@meta

--=== enduser_setup ===

---@class enduser_setup
enduser_setup = {}

---Controls whether manual AP configuration is used.
---@param on_off? boolean @"(optional) value indicating whether to use manual mode;  \n if not given, the function only returns the current setting."
---@return boolean @The current setting, `true` if manual mode is enabled, `false` if it is not.
function enduser_setup.manual(on_off) end

---Starts the captive portal.
---@param AP_SSID? string @(optional) the SSID to use for the AP. This defaults to NodeMCU_<device id>.
---@param onConnected? function @"(optional) callback will be fired when an IP-address has been obtained,  \n just before the enduser_setup module will terminate itself"
---@param onError? function @"(optional) callback will be fired if an error is encountered.  \n *err_num* is a number describing the error, and string contains a description of the error."
---@param onDebug? function @"(optional) callback is disabled by default  \n (controlled by #define ENDUSER_SETUP_DEBUG_ENABLE in enduser_setup.c)."
---@return nil
function enduser_setup.start(AP_SSID, onConnected, onError, onDebug) end

---Stops the captive portal.
---@return nil
function enduser_setup.stop() end
