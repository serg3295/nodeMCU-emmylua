---@meta

--=== wifi ===

---@class wifi
---@field STATION integer
---@field SOFTAP integer
---@field STATIONAP integer
---@field NULLMODE integer
---@field HT20 integer
---@field HT40_ABOVE integer
---@field HT40_BELOW integer
---@field AUTH_OPEN integer
---@field AUTH_WPA_PSK integer
---@field AUTH_WPA2_PSK integer
---@field AUTH_WPA_WPA2_PSK integer
wifi = {}

---@class wifi.sta
---@field PMF_OFF integer
---@field PMF_AVAILABLE integer
---@field PMF_REQUIRED integer
wifi.sta = {}

---@class wifi.ap
wifi.ap = {}

---Gets the current WiFi channel.
---@return integer @current WiFi channel (primary channel)
---@return integer @"HT20/HT40 information (secondary channel).  \n One of the constants:"
--- - wifi.HT20,
--- - wifi.HT40_ABOVE,
--- - wifi.HT40_BELOW
---@nodiscard
function wifi.getchannel() end

---Gets WiFi operation mode.
---@return integer @The WiFi mode, as one of the constants:
--- - wifi.STATION
--- - wifi.SOFTAP
--- - wifi.STATIONAP
--- - wifi.NULLMODE
---@nodiscard
function wifi.getmode() end

---Configures the WiFi mode to use.
---@param mode integer @station | softap | stationap | nullmode
---|`wifi.STATION` #for when the device is connected to a WiFi router.
---|`wifi.SOFTAP` #for when the device is acting only as an access point.
---|`wifi.STATIONAP` #is the combination of wifi.STATION and wifi.SOFTAP
---|`wifi.NULLMODE` #disables the WiFi interface(s).
---@param save? boolean @(optional) choose whether or not to save wifi mode to flash
---|>`true` #WiFi mode configuration will be retained through power cycle.
---|`false` #WiFi mode configuration will not be retained through power cycle.
---@return nil
function wifi.mode(mode, save) end

---Starts the WiFi interface(s).
---@return nil
function wifi.start() end

---Shuts down the WiFi interface(s).
---@return nil
function wifi.stop() end

---@class (exact) StaConfig32
---@field ssid string
---@field pwd string
---@field bssid string?
---@field pmf number?

---Sets the WiFi station configuration. The WiFi mode must be set to *wifi.STATION* or *wifi.STATIONAP* before this function can be used.
---@param station_config StaConfig32 @table containing configuration data for station
--- - **ssid** string which is less than 32 bytes.
--- - **pwd** string which is 8-64 or 0 bytes. Empty string indicates an open WiFi access point.
--- - **bssid** (optional) string that contains the MAC address of the access point. You can set BSSID if you have multiple access points with the same SSID.\
---Note: if you set BSSID for a specific SSID and would like to configure station to connect to the same SSID only without the BSSID requirement, you MUST first configure to station to a different SSID first, then connect to the desired SSID. The following formats are valid:\
--- "DE:C1:A5:51:F1:ED"\
--- "AC-1D-1C-B1-0B-22"\
--- "DE AD BE EF 7A C0"\
--- "AcDc0123c0DE"
--- - **pmf** an (optional) setting to control whether Protected Management Frames are supported and/or required. One of:
---   - `wifi.sta.PMF_AVAILABLE` Defaults to `wifi.sta.PMF_AVAILABLE`.
---   - `wifi.sta.PMF_REQUIRED`.\
---PMF is required when joining to WPA3-Personal access points. The value `wifi.sta.PMF_OFF` is no longer available as it is no longer supported by the wifi stack.
--- - **channel** (optional) integer value, the channel number to start scanning for the AP from, if known.
--- - **scan_method** (optional) string value, one of `"fast"` or `"all"` do either do a fast scan or all channel scan when looking for the AP to connect to. With fast scan, the first found matching AP is used even if it is not the best/closest one.
--- - **listen_interval** (optional) listen interval to receive beacon if max wifi power saving mode is enabled. Units is in AP beacon intervals. Defaults to 3.
--- - **sort_by** (optional) string value for preferential selection of AP. Must be one of `"rssi"` or `"authmode"` if present.
--- - **threshold_rssi** (optional) integer value to limit APs to only those which have a signal stronger than this value.
--- - **threshold_authmode** (optional) value to limit APs to those with an authentication mode of at least this settings. One of `wifi.AUTH_OPEN`, `wifi.AUTH_WEP`, `wifi.AUTH_WPA_PSK`, `wifi.AUTH_WPA2_PSK`, `wifi.AUTH_WPA_WPA2_PSK`, `wifi.AUTH_WPA2_ENTERPRISE`, `wifi.AUTH_WPA3_PSK`, `wifi.AUTH_WPA2_WPA3_PSK`, `wifi.AUTH_WAPI_PSK`.
--- - **rm** (optional) boolean, set to `true` to enable Radio Measurements
--- - **btm** (optional) boolean, set to `true` to enable BSS Transition Management
--- - **mbo** (optional) boolean, set to `true` to enable Multi-Band Operation
--- - **sae_pwe** optional, configures WPA3 SAE Password Element setting. One of `wifi.SAE_PWE_UNSPECIFIED`, `wifi.SAE_PWE_HUNT_AND_PECK`, `wifi.SAE_PWE_HASH_TO_ELEMENT` or `wifi.SAE_PWE_BOTH`.
---@param save boolean @Save station configuration to flash.
---|`true` #configuration will be retained through power cycle.
---|>`false` #configuration will not be retained through power cycle.
---@return nil
function wifi.sta.config(station_config, save) end

---Returns the current station configuration.
---@return table @A table with the configuration settings.
---Refer to `wifi.sta.config()` for field details.
function wifi.sta.getconfig() end

---Connects to the configured AP in station mode. You will want to call this\
---on start-up after `wifi.start()`, and quite possibly also in response to\
---`disconnected` events.
---@return nil
function wifi.sta.connect() end

---Disconnects from AP in station mode.
---@return nil
function wifi.sta.disconnect() end

---Allows adjusting the maximum TX power for the WiFi. This is (unfortunately)\
---needed for some boards which have a badly matched antenna.
---@param power number @"The maximum transmit power in dBm. This must have  \n the range 2dBm - 20dBm. This value is a float."
---@return boolean @A `boolean` where `true` is OK.
function wifi.sta.settxpower(power) end

---Configures power-saving setting in station mode.
---@param setting string |"none"|"min"|"max" @"In `\"min\"` mode, the station wakes up every DTIM period to receive the beacon.  \nIn `\"max\"` mode, the station wakes up at the interval configured in `listen_interval` see `wifi.sta.config()`.  \nWhen set to `\"none\"` the station does not go to sleep and can receive frames immediately."
---@return nil
function wifi.sta.powersave(setting) end

--- Returns the configured station power-saving mode.
---@return string @One of `"none"`, `"min"` or `"max"`.
--- Refer to `wifi.sta.powersave()` for details.
function wifi.sta.getpowersave() end

---Registers callbacks for WiFi station status events.
---@param event string|"start"|"stop"|"connected"|"disconnected"|"authmode_changed"|"got_ip" @WiFi station event you would like to set a callback for:
---@param callback fun(event:string, info:table) @"`function(event, info)` to perform when event occurs, or `nil` to unregister the callback for  \n the event. The *info* argument given to the callback is a table containing additional information about the event."
---Event information provided for each event is as follows:\
---`"start"`: no additional info\
---`"stop"`: no additional info\
---`"connected"`: information about network/AP that was connected to:
--- - **ssid**: the SSID of the network
--- - **bssid**: the BSSID of the AP
--- - **channel**: the primary channel of the network
--- - **auth** authentication method, one of wifi.AUTH_OPEN, wifi.AUTH_WEP, wifi.AUTH_WPA_PSK, wifi.AUTH_WPA2_PSK, wifi.AUTH_WPA_WPA2_PSK,\
---wifi.AUTH_WPA2_ENTERPRISE, wifi.AUTH_WPA3_PSK, wifi.AUTH_WPA2_WPA3_PSK, wifi.AUTH_WAPI_PSK
---
---`"disconnected"`: information about the network/AP that was disconnected from:
--- - **ssid**: the SSID of the network
--- - **bssid**: the BSSID of the AP
--- - **reason**: an integer code for the reason
---
---`"authmode_changed"`: authentication mode information:
--- - **old_mode**: the previous auth mode used
--- - **new_mode**: the new auth mode used
---
---`"got_ip"`: IP network information:
--- - **ip**: the IP address assigned
--- - **netmask**: the IP netmask
--- - **gw**: the gateway ("0.0.0.0" if no gateway)
---@return nil
function wifi.sta.on(event, callback) end

---Gets MAC address in station mode.
---@return string
---@nodiscard
function wifi.sta.getmac() end

---@class ScanCfg
---@field ssid? string
---@field bssid? string
---@field channel? integer
---@field hidden? integer

---Scan for available networks.
---@param cfg ScanCfg @table that contains scan configuration:
--- - **ssid** SSID == `nil`, don't filter SSID
--- - **bssid** BSSID == `nil`, don't filter BSSID
--- - **channel** channel == 0, scan all channels, otherwise scan set channel (default is 0)
--- - **hidden** hidden == 1, get info for router with hidden SSID (default is 0)
---@param callback fun(err: integer, ap_list:table) @"`function(err, ap_list)` to receive the list of APs when the scan is done.  \n Each entry in the returned array follows the format used for `wifi.sta.config()`,  \n with some additional fields. The following fields are provided for each scanned AP:"
--- - **ssid**: the network SSID
--- - **bssid**: the BSSID of the AP
--- - **channel**: primary WiFi channel of the AP
--- - **rssi**: Received Signal Strength Indicator value
--- - **auth** authentication method, one of *wifi.AUTH_OPEN, wifi.AUTH_WEP, wifi.AUTH_WPA_PSK,\
---wifi.AUTH_WPA2_PSK, wifi.AUTH_WPA_WPA2_PSK, wifi.AUTH_WPA2_ENTERPRISE, wifi.AUTH_WPA3_PSK\
---wifi.AUTH_WPA2_WPA3_PSK, wifi.AUTH_WAPI_PSK*
--- - **bandwidth**: one of the following constants: *wifi.HT20, wifi.HT40_ABOVE, wifi.HT40_BELOW*
---@return nil
function wifi.sta.scan(cfg, callback) end

---@class Setip32
---@field ip string
---@field netmask string
---@field gateway string
---@field dns string

---Sets IP address, netmask, gateway, dns address\
---in station mode. Options set by this function\
---are not saved to flash.
---@param cfg Setip32 @table to hold configuration:
--- - **ip** device ip address.
--- - **netmask** network netmask.
--- - **gateway** gateway address.
--- - **dns** name server address.
---@return nil
function wifi.sta.setip(cfg) end

---Sets station hostname. Must be called before wifi.sta.connect().\
---Options set by this function are not saved to flash.
---@param hostname string @"hostname must only contain letters,  \n numbers and hyphens('-') and be 32 characters or less with first  \n and last character being alphanumeric"
---@return boolean
function wifi.sta.sethostname(hostname) end

---@class APconfig
---@field ssid string
---@field pwd string
---@field auth integer
---@field channel integer
---@field hidden boolean
---@field max integer
---@field beacon integer

---Configures the AP. The WiFi mode must be set to wifi.SOFTAP or wifi.STATIONAP\
---before this function can be used.
---@param cfg APconfig @table to hold configuration:
--- - **ssid** SSID chars 1-32
--- - **pwd** password chars 8-64
--- - **auth** authentication method, one of wifi.AUTH_OPEN, wifi.AUTH_WPA_PSK,\
---wifi.AUTH_WPA2_PSK (default), wifi.AUTH_WPA_WPA2_PSK
--- - **channel** channel number 1-14 default = 11
--- - **hidden** false = not hidden, true = hidden, default = false
--- - **max** maximum number of connections 1-4 default=4
--- - **beacon** beacon interval time in range 100-60000, default = 100
---@param save boolean @save configuration to flash.
---|>`true` #configuration will be retained through power cycle.
---|`false` #configuration will not be retained through power cycle.
---@return nil
function wifi.ap.config(cfg, save) end

---Registers callbacks for WiFi AP events.
---@param event string|"start"|"stop"|"sta_connected"|"sta_disconnected"|"probe_req" @WiFi AP event you would like to set a callback for: start, stop, sta_connected, sta_disconnected, probe_req
---@param callback fun(event:string, info:table) @"`function(event, info)` to perform when event occurs, or `nil` to unregister the callback for the event.  \n The *info* argument given to the callback is a table containing additional information about the event."
---Event information provided for each event is as follows:\
---`"start"`: no additional info\
---`"stop"`: no additional info\
---`"sta_connected"`: information about the client that connected:
--- - **mac**: the MAC address
--- - **id**: assigned station id (AID)
---
---`"disconnected"`: information about disconnecting client
--- - **mac**: the MAC address
--- - **id**: assigned station id (AID)
---
---`"probe_req"`: information about the probing client
--- - **from**: MAC address of the probing client
--- - **rssi**: Received Signal Strength Indicator value
function wifi.ap.on(event, callback) end

---Gets MAC address in access point mode.
---@return string MAC @address as string
---e.g. "18:fe:34:a2:d7:34"
---@nodiscard
function wifi.ap.getmac() end

---Sets IP address, netmask, gateway, dns address in AccessPoint mode.\
---Options set by this function are not saved to flash.
---@param cfg Setip32 @table to hold configuration:
--- - **ip** device ip address.
--- - **netmask** network netmask.
--- - **gateway** gateway address.
--- - **dns** (optional) name server address,\
---which will be provided to clients over DHCP.
---@return nil
function wifi.ap.setip(cfg) end

---Sets AccessPoint hostname.\
---Options set by this function are not saved to flash.
---@param hostname string @"must only contain letters,  \n numbers and hyphens('-') and be 32 characters or  \n less with first and last character being alphanumeric"
---@return boolean @`true` if success, `false` otherwise
function wifi.ap.sethostname(hostname) end
