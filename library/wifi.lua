---@meta

--=== wifi ===

---@class EventmonReasons
---@field UNSPECIFIED integer
---@field AUTH_EXPIRE integer
---@field AUTH_LEAVE integer
---@field ASSOC_EXPIRE integer
---@field ASSOC_TOOMANY integer
---@field NOT_AUTHED integer
---@field NOT_ASSOCED integer
---@field ASSOC_LEAVE integer
---@field ASSOC_NOT_AUTHED integer
---@field DISASSOC_PWRCAP_BAD integer
---@field DISASSOC_SUPCHAN_BAD integer
---@field IE_INVALID integer
---@field MIC_FAILURE integer
---@field ["4WAY_HANDSHAKE_TIMEOUT"] integer
---@field GROUP_KEY_UPDATE_TIMEOUT integer
---@field IE_IN_4WAY_DIFFERS integer
---@field GROUP_CIPHER_INVALID integer
---@field PAIRWISE_CIPHER_INVALID integer
---@field AKMP_INVALID integer
---@field UNSUPP_RSN_IE_VERSION integer
---@field INVALID_RSN_IE_CAP integer
---@field ["802_1X_AUTH_FAILED"] integer
---@field CIPHER_SUITE_REJECTED integer
---@field BEACON_TIMEOUT integer
---@field NO_AP_FOUND integer
---@field AUTH_FAIL integer
---@field ASSOC_FAIL integer
---@field HANDSHAKE_TIMEOUT integer

---@class sta_connected_t
---@field SSID string SSID of access point.
---@field BSSID string BSSID of access point.
---@field channel integer The channel the access point is on.

---@class sta_disconnected_t
---@field SSID string SSID of access point.
---@field BSSID string BSSID of access point.
---@field reason EventmonReasons wifi.eventmon.reason.

---@class sta_authmode_change_t
---@field old_auth_mode integer Old wifi authorization mode.
---@field new_auth_mode integer New wifi authorization mode.

---@class sta_got_ip_t
---@field IP string The IP address assigned to the station.
---@field netmask string Subnet mask.
---@field gateway string The IP address of the access point the station is connected to.

---@class (exact) sta_dhcp_timeout_t

---@class ap_staconnected_t
---@field MAC string MAC address of client that has connected.
---@field AID string SDK provides no details concerning this return value.

---@class ap_stadisconnected_t
---@field MAC string MAC address of client that has disconnected.
---@field AID string SDK provides no details concerning this return value.

---@class ap_probereqrecved_t
---@field MAC string MAC address of the client that is probing the access point.
---@field RSSI string Received Signal Strength Indicator of client.

---@class wifi_mode_changed_t
---@field old_mode integer Old WiFi mode.
---@field new_mode integer New WiFi mode.

---@class wifi
---@field STATION integer
---@field SOFTAP integer
---@field STATIONAP integer
---@field NULLMODE integer
---@field PHYMODE_B integer
---@field PHYMODE_G integer
---@field PHYMODE_N integer
---@field COUNTRY_AUTO integer
---@field COUNTRY_MANUAL integer
---@field NONE_SLEEP integer
---@field LIGHT_SLEEP integer
---@field MODEM_SLEEP integer
---@field STA_IDLE integer
---@field STA_CONNECTING integer
---@field STA_WRONGPWD integer
---@field STA_APNOTFOUND integer
---@field STA_FAIL integer
---@field STA_GOTIP integer
---@field OPEN integer
---@field WPA_PSK integer
---@field WPA2_PSK integer
---@field WPA_WPA2_PSK integer
wifi = {}

---@class wifi.sta
wifi.sta = {}

---@class wifi.ap
wifi.ap = {}

---@class wifi.ap.dhcp
wifi.ap.dhcp = {}

---@class wifi.eventmon
---@field reason EventmonReasons
---@field EVENT_MAX integer
wifi.eventmon = {
	STA_CONNECTED = 0, ---@alias wifi.eventmon.STA_CONNECTED 0 | `wifi.eventmon.STA_CONNECTED`
	STA_DISCONNECTED = 1, ---@alias wifi.eventmon.STA_DISCONNECTED 1 | `wifi.eventmon.STA_DISCONNECTED`
	STA_AUTHMODE_CHANGE = 2, ---@alias wifi.eventmon.STA_AUTHMODE_CHANGE 2 | `wifi.eventmon.STA_AUTHMODE_CHANGE`
	STA_GOT_IP = 3, ---@alias wifi.eventmon.STA_GOT_IP 3 | `wifi.eventmon.STA_GOT_IP`
	STA_DHCP_TIMEOUT = 4, ---@alias wifi.eventmon.STA_DHCP_TIMEOUT 4 | `wifi.eventmon.STA_DHCP_TIMEOUT`
	AP_STACONNECTED = 5, ---@alias wifi.eventmon.AP_STACONNECTED 5 | `wifi.eventmon.AP_STACONNECTED`
	AP_STADISCONNECTED = 6, ---@alias wifi.eventmon.AP_STADISCONNECTED 6 | `wifi.eventmon.AP_STADISCONNECTED`
	AP_PROBEREQRECVED = 7, ---@alias wifi.eventmon.AP_PROBEREQRECVED 7 | `wifi.eventmon.AP_PROBEREQRECVED`
	WIFI_MODE_CHANGED = 8, ---@alias wifi.eventmon.WIFI_MODE_CHANGED 8 | `wifi.eventmon.WIFI_MODE_CHANGED`
}

---Gets the current WiFi channel.
---@return integer @current WiFi channel
---@nodiscard
function wifi.getchannel() end

---Get the current country info.
---@return { country:string, start_ch:number, end_ch:number, policy:number } @`country_info` this table contains the current country info configuration
---  - **country** Country code, 2 character string.
---  - **start_ch** Starting channel.
---  - **end_ch** Ending channel.
---  - **policy** The policy parameter determines which country info configuration to use,\
---country info given to station by AP or local configuration.
---    - **0** - Country policy is auto, NodeMCU will use the country info provided by AP\
---that the station is connected to.
---    - **1** - Country policy is manual, NodeMCU will use locally configured country info.
---@nodiscard
function wifi.getcountry() end

---Gets default WiFi operation mode.
---@return integer @constants:
--- - wifi.STATION
--- - wifi.SOFTAP
--- - wifi.STATIONAP
--- - wifi.NULLMODE
---@nodiscard
function wifi.getdefaultmode() end

---Gets WiFi operation mode.
---@return integer @constants:
--- - wifi.STATION
--- - wifi.SOFTAP
--- - wifi.STATIONAP
--- - wifi.NULLMODE
---@nodiscard
function wifi.getmode() end

---Gets WiFi physical mode.
---@return integer @>
--- - wifi.PHYMODE_B
--- - wifi.PHYMODE_G
--- - wifi.PHYMODE_N
---@nodiscard
function wifi.getphymode() end

---Configures whether or not WiFi automatically goes to sleep\
---in *NULL_MODE*. Enabled by default.
---@param enable? boolean @(optional) WiFi auto sleep in NULL_MODE
---|>`true` #Enable WiFi auto sleep in NULL_MODE.
---|`false` #Disable WiFi auto sleep in NULL_MODE.
---@return any @sleep_enabled Current/New *NULL_MODE* sleep setting.
--- - If `wifi.nullmodesleep()` is called with no arguments,\
---current setting is returned.
--- - If `wifi.nullmodesleep()` is called with enable argument,\
---confirmation of new setting is returned.
function wifi.nullmodesleep(enable) end

---Wake up WiFi from suspended state or cancel pending wifi suspension.
---@param resume_cb? fun() @"(optional) Callback to execute when WiFi wakes  \n from suspension. Any previously provided callbacks will be replaced!"
---@return nil
function wifi.resume(resume_cb) end

---@class SetCountry
---@field country string
---@field start_ch integer
---@field end_ch integer
---@field policy integer

---Set the current country info.
---@param country_info SetCountry @"This table contains the country info configuration.  \n (If a blank table is passed to this function, default values will be configured.)"
---  - **country** Country code, 2 character string containing the country code. (Default:"CN")
---  - **start_ch** Starting channel (range:1-14). (Default:1)
---  - **end_ch** Ending channel, must not be less than starting channel (range:1-14). (Default:13)
---  - **policy** The policy parameter determines which country info configuration to use,\
---country info given to station by AP or local configuration. (default: *wifi.COUNTRY_AUTO*)
---    - wifi.COUNTRY_AUTO - Country policy is auto, NodeMCU will use the country info\
---provided by AP that the station is connected to. While in stationAP mode, beacon/probe\
---response will reflect the country info of the AP that the station is connected to.
---    - wifi.COUNTRY_MANUAL - Country policy is manual,\
---NodeMCU will use locally configured country info.
---@return boolean @`true` if configuration was sucessful.
function wifi.setcountry(country_info) end

---Configures the WiFi mode to use. NodeMCU can run in one of four WiFi modes.
---@param mode integer @Station | Access point (AP) | Station + AP | WiFi off
---|`wifi.STATION` #for when the device is connected to a WiFi router.
---|`wifi.SOFTAP` #for when the device is acting only as an access point.
---|`wifi.STATIONAP` #is the combination of wifi.STATION and wifi.SOFTAP
---|`wifi.NULLMODE` #changing WiFi mode to NULL_MODE will put wifi into a low power state similar to MODEM_SLEEP, provided 'wifi.nullmodesleep(false)' has not been called.
---@param save? boolean @(optional) choose whether or not to save wifi mode to flash
---|>`true` #WiFi mode configuration will be retained through power cycle.
---|`false` #WiFi mode configuration will not be retained through power cycle.
---@return integer @current mode after setup
function wifi.setmode(mode, save) end

---Sets WiFi physical mode.
---@param mode integer @b | g | n
---|`wifi.PHYMODE_B` #802.11b, more range, low Transfer rate, more current draw
---|`wifi.PHYMODE_G` #802.11g, medium range, medium transfer rate, medium current draw
---|`wifi.PHYMODE_N` #802.11n, least range, fast transfer rate, least current draw (STATION ONLY)
---@return integer @physical mode after setup
function wifi.setphymode(mode) end

---Sets WiFi maximum TX power.\
---The default value, 82, corresponds to maximum TX power.
---@param max_tpw number @"maximum value of RF Tx Power,  \n unit: 0.25 dBm, range [0, 82]."
---@return nil
function wifi.setmaxtxpower(max_tpw) end

---Starts to auto configuration, if success set up SSID and password automatically.\
---Only usable in *wifi.STATION* mode.
---@param type integer @**0** for ESP_TOUCH, **1** for AIR_KISS
---@param callback fun() @"a callback function of the form `function(ssid, password)`  \n end which gets called after configuration."
---@return nil
function wifi.startsmart(type, callback) end

---Stops the smart configuring process.
---@return nil
function wifi.stopsmart() end

---@class SuspendCfg
---@field duration number
---@field suspend_cb function
---@field resume_cb function
---@field preserve_mode boolean

---Suspend Wifi to reduce current consumption.
---@param tbl SuspendCfg @>
--- - **duration** number Suspend duration in microseconds(μs).
--- - **suspend_cb?** function Callback to execute when WiFi is suspended.
--- - **resume_cb?** function Callback to execute when WiFi wakes from suspension.
--- - **preserve_mode?** boolean preserve current WiFi mode through node sleep.
---   - If `true`, Station and StationAP modes will automatically reconnect\
---to previously configured Access Point when NodeMCU resumes.
---   - If `false`, discard WiFi mode and leave NodeMCU in *wifi.NULL_MODE*.\
---WiFi mode will be restored to original mode on restart.
---@return integer suspend_state @>
--- - **suspend_state** if no parameters are provided,\
---current WiFi suspension state will be returned. States:
---   - 0 - WiFi is awake.
---   - 1 - WiFi suspension is pending. (Waiting for idle task)
---   - 2 - WiFi is suspended.
function wifi.suspend(tbl) end

---Auto connects to AP in station mode.
---@param auto integer @"**0** to disable auto connecting,  \n **1** to enable auto connecting"
---@return nil
function wifi.sta.autoconnect(auto) end

---Select Access Point from list returned by `wifi.sta.getapinfo()`
---@param ap_index integer @"Index of Access Point you would like to change to. (Range:1-5)  \n Corresponds to index used by `wifi.sta.getapinfo()` and `wifi.sta.getapindex()`"
---@return boolean
function wifi.sta.changeap(ap_index) end

---Clears the currently saved WiFi station\
---configuration, erasing it from the flash.
---@return boolean
function wifi.sta.clearconfig() end

---@class StaConfig
---@field ssid string
---@field pwd? string
---@field auto? boolean
---@field bssid? string
---@field save? boolean
---@field connect_cb? function
---@field disconnect_cb? function
---@field authmode_change_cb? function
---@field got_ip_cb? function
---@field dhcp_timeout_cb? function

---Sets the WiFi station configuration.
---@param station_config StaConfig @table containing configuration data for station
--- - **ssid** string which is less than 32 bytes.
--- - **pwd**  (Optional) string which is 0-64. Empty string indicates an open WiFi access point.
--- - **auto** (Optional)
---   - `true` (default) to enable auto connect and connect to access point,\
---hence with auto=true there's no need to call `wifi.sta.connect()`
---   - `false` to disable auto connect and remain disconnected from access point
--- - **bssid** (Optional) string that contains the MAC address of the access point (optional).\
---The following formats are valid:
---   - "DE:C1:A5:51:F1:ED"
---   - "AC-1D-1C-B1-0B-22"
---   - "DE AD BE EF 7A C0"
--- - **save** (Optional) Save station configuration to flash.
---   - `true` configuration will be retained through power cycle. (Default).
---   - `false` configuration will not be retained through power cycle.
--- - **Event callbacks** will only be available if WIFI_SDK_EVENT_MONITOR_ENABLE\
---is uncommented in user_config.h:
---   - *connect_cb*: Callback to execute when station is connected to an access point.\
---(Optional). Items returned in table:
---     - SSID: SSID of access point. (format: string)
---     - BSSID: BSSID of access point. (format: string)
---     - channel: The channel the access point is on. (format: number)
--- - *disconnect_cb*: Callback to execute when station is disconnected from an access point.\
---(Optional) Items returned in table:
---   - SSID: SSID of access point. (format: string)
---   - BSSID: BSSID of access point. (format: string)
---   - reason: See wifi.eventmon.reason. (format: number)
--- - *authmode_change_cb*: Callback to execute when the access point has changed authorization mode.\
---(Optional) Items returned in tabl:
---   - old_auth_mode: Old wifi authorization mode. (format: number)
---   - new_auth_mode: New wifi authorization mode. (format: number)
--- - *got_ip_cb*: Callback to execute when the station received an IP address from the access point.\
---(Optional) Items returned in table:
---   - IP: The IP address assigned to the station. (format: string)
---   - netmask: Subnet mask. (format: string)
---   - gateway: The IP address of the access point the station is connected to. (format: string)
--- - *dhcp_timeout_cb*: (Optional) Station DHCP request has timed out.
---   - Blank table is returned.
---@return boolean
function wifi.sta.config(station_config) end

---Connects to the configured AP in station mode. You only ever\
---need to call this if auto-connect was disabled in `wifi.sta.config()`.
---@param connected_cb? function @"(optional) Callback to execute when station  \n is connected to an access point. Items returned in table:"
--- - **SSID**: SSID of access point. (format: string)
--- - **BSSID**: BSSID of access point. (format: string)
--- - **channel**: The channel the access point is on. (format: number)
---@return nil
function wifi.sta.connect(connected_cb) end

---Disconnects from AP in station mode.
---@param disconnected_cb? function @"(optional) Callback to execute when station  \n is disconnected from an access point. Items returned in table:"
--- - **SSID**: SSID of access point. (format: string)
--- - **BSSID**: BSSID of access point. (format: string)
--- - **reason**: See wifi.eventmon.reason. (format: number)
---@return nil
function wifi.sta.disconnect(disconnected_cb) end

---@class StaGetap
---@field ssid string
---@field bssid string
---@field channel integer
---@field show_hidden integer

---Scans AP list as a Lua table into callback function.
---@param cfg? StaGetap @(optional) table that contains scan configuration:
--- - **ssid** SSID == nil, don't filter SSID
--- - **bssid** BSSID == nil, don't filter BSSID
--- - **channel** channel == 0, scan all channels, otherwise scan set channel (default is 0)
--- - **show_hidden** show_hidden == 1, get info for router with hidden SSID (default is 0)
---@param format? integer @(optional) select output table format, defaults to 0
--- - **0** - old format (SSID : Authmode, RSSI, BSSID, Channel), any duplicate SSIDs will be discarded
--- - **1** - new format (BSSID : SSID, RSSI, auth mode, Channel)
---@param callback function @"function to receive the AP table when the scan is done.This function  \n  receives a table, the key is the BSSID, the value is other info in format:  \n **SSID, RSSID, auth mode, channel**."
---@return nil
function wifi.sta.getap(cfg, format, callback) end

---Get index of current Access Point stored in AP cache.
---@return integer current_index @"index of currently selected  \n Access Point. (Range:1-5)"
---@nodiscard
function wifi.sta.getapindex() end

---Get information of APs cached by ESP8266 station.
---@return { qty:number, ssid:string, pwd:string, bssid:string} @table `ap_info`:
--- - **qty** quantity of APs returned
--- - **1-5** index of AP. (the index corresponds to index used by\
---`wifi.sta.changeap()` and `wifi.sta.getapindex()`)
--- - **ssid** ssid of Access Point
--- - **pwd** password for Access Point, nil if no password was configured
--- - **bssid** MAC address of Access Point. `nil` will be returned\
---if no MAC address was configured during station configuration.
---@nodiscard
function wifi.sta.getapinfo() end

---Gets the broadcast address in station mode.
---@return string|nil @"broadcast address as string,  \n for example '192.168.0.255',  \n returns `nil` if IP address = '0.0.0.0'."
---@nodiscard
function wifi.sta.getbroadcast() end

---Gets the WiFi station configuration.
---@param return_table boolean @"`true`: returns data in a table;  \n `false`: returns data in the old format (default)"
---@return table|string @>
--- - If `return_table` is true -> *config_table*:
---   - **ssid** ssid of Access Point.
---   - **pwd** password to Access Point, nil if no password was configured
---   - **bssid_set** will return true if the station was configured specifically\
---to connect to the AP with the matching bssid.
---   - **bssid** If a connection has been made to the configured AP\
---this field will contain the AP's MAC address.\
---Otherwise "ff:ff:ff:ff:ff:ff" will be returned.
--- - If `return_table` is false:
---   - **ssid, password, bssid_set, bssid**, if bssid_set is equal to 0\
---then bssid is irrelevant
---@nodiscard
function wifi.sta.getconfig(return_table) end

---Gets the default WiFi station configuration stored in flash.
---@param return_table boolean @"`true` returns data in a table;  \n `false` returns data in the old format (default)"
---@return table|string @>
--- - If `return_table` is true -> *config_table*:
---   - **ssid** - ssid of Access Point.
---   - **pwd** - password to Access Point, nil if no password was configured
---   - **bssid_set** - will return true if the station was configured specifically\
---to connect to the AP with the matching bssid.
---   - **bssid** - If a connection has been made to the configured AP\
---this field will contain the AP's MAC address.\
---Otherwise "ff:ff:ff:ff:ff:ff" will be returned.
--- - If `return_table` is false:
---   - **ssid, password, bssid_set, bssid**, if bssid_set is equal to 0\
---then bssid is irrelevant
---@nodiscard
function wifi.sta.getdefaultconfig(return_table) end

---Gets current station hostname.
---@return string hostname @currently configured hostname
---@nodiscard
function wifi.sta.gethostname() end

---Gets IP address, netmask, and gateway address in station mode.
---@return string IP_address @"as string, for example '192.168.0.111'.  \n Returns `nil` if IP = '0.0.0.0'."
---@return string netmask
---@return string gateway_address @Returns `nil` if IP = '0.0.0.0'.
---@nodiscard
function wifi.sta.getip() end

---Gets MAC address in station mode.
---@return string MAC @"address as string  \n e.g. '18:fe:34:a2:d7:34'"
---@nodiscard
function wifi.sta.getmac() end

---Get RSSI (Received Signal Strength Indicator) of the Access Point\
---which ESP8266 station connected to.
---@return number|nil @>
--- - If station is connected to an access point, `rssi` is returned.
--- - If station is not connected to an access point, `nil` is returned.
---@nodiscard
function wifi.sta.getrssi() end

---Set Maximum number of Access Points to store\
---in flash. This value is written to flash
---@param qty integer @"Quantity of Access Points to store  \n in flash. Range: 1-5 (Default: 1)"
---@return boolean
function wifi.sta.setaplimit(qty) end

---Sets station hostname.
---@param hostname string @"must only contain letters, numbers  \n and hyphens('-') and be 32 characters or less with first  \n and last character being alphanumeric."
---@return boolean
function wifi.sta.sethostname(hostname) end

---@class WifiCfgTbl
---@field ip string IP address
---@field netmask string netmask
---@field gateway string gateway

---Sets IP address, netmask, gateway address in station mode.
---@param cfg WifiCfgTbl @table contain IP address, netmask, and gateway
---```lua
---{      ip = "192.168.0.111",
---  netmask = "255.255.255.0",
---  gateway = "192.168.0.1" }
---```
---@return boolean
function wifi.sta.setip(cfg) end

---Sets MAC address in station mode.
---@param mac string @"address in string  \n e.g. 'DE:AD:BE:EF:7A:C0'"
---@return boolean
function wifi.sta.setmac(mac) end

---Configures the WiFi modem sleep type to be used while station is connected to an Access Point.\
---Does not apply to *wifi.SOFTAP*, *wifi.STATIONAP* or *wifi.NULLMODE*.
---@param type_wanted integer @none | light | modem sleep
---|`wifi.NONE_SLEEP` #to keep the modem on at all times
---|`wifi.LIGHT_SLEEP` #to allow the CPU to power down under some circumstances
---|`wifi.MODEM_SLEEP` #to power down the modem as much as possible
---@return number @"The actual sleep mode set,  \n as one of *wifi.NONE_SLEEP, wifi.LIGHT_SLEEP* or *wifi.MODEM_SLEEP*."
function wifi.sta.sleeptype(type_wanted) end

---Gets the current status in station mode.
---@return integer state @"The current state  \n which can be one of the following:"
--- - wifi.STA_IDLE
--- - wifi.STA_CONNECTING
--- - wifi.STA_WRONGPWD
--- - wifi.STA_APNOTFOUND
--- - wifi.STA_FAIL
--- - wifi.STA_GOTIP
---@nodiscard
function wifi.sta.status() end

---@class APConfig
---@field ssid string
---@field pwd string
---@field auth integer
---@field channel integer
---@field hidden boolean
---@field max integer
---@field beacon integer
---@field save boolean

---Sets SSID and password in AP mode.
---@param cfg APConfig @table to hold configuration
--- - **ssid** - SSID chars 1-32
--- - **pwd** - password chars 8-64
--- - **auth** - authentication method, one of\
---*wifi.OPEN* (default), *wifi.WPA_PSK, wifi.WPA2_PSK, wifi.WPA_WPA2_PSK*
--- - **channel** - channel number 1-14 default = 6
--- - **hidden** - false = not hidden, true = hidden, default = false
--- - **max** - maximum number of connections 1-4 default=4
--- - **beacon** - beacon interval time in range 100-60000, default = 100
--- - **save** - save configuration to flash.
---   - `true` - configuration will be retained through power cycle. (Default)
---   - `false` - configuration will not be retained through power cycle. Event callbacks will only be available if\
---WIFI_SDK_EVENT_MONITOR_ENABLE is uncommented in user_config.h
--- - *staconnected_cb*: Callback executed when a new client has connected to the access point. (Optional).\
---Items returned in table :
---   - MAC: MAC address of client that has connected.
---   - AID: SDK provides no details concerning this return value.
--- - *stadisconnected_cb*: Callback executed when a client has disconnected from the access point. (Optional).\
---Items returned in table :
---   - MAC: MAC address of client that has disconnected.
---   - AID: SDK provides no details concerning this return value.
--- - *probereq_cb*: Callback executed when a probe request was received. (Optional). Items returned in table :
---   - MAC: MAC address of the client that is probing the access point.
---   - RSSI: Received Signal Strength Indicator of client.
---@return boolean
function wifi.ap.config(cfg) end

---Deauths (forcibly removes) a client from the ESP access point.
---@param MAC? string @(optional) MAC address of station to be deauthed.
---@return boolean @Returns `true` unless called while the ESP is in the STATION opmode
function wifi.ap.deauth(MAC) end

---Gets broadcast address in AP mode.
---@return string|nil @"broadcast address in string,  \n for example '192.168.0.255',  \n returns `nil` if IP address = '0.0.0.0'."
function wifi.ap.getbroadcast() end

---Gets table of clients connected to\
---device in AP mode.
---@return table @table of connected clients
---@nodiscard
function wifi.ap.getclient() end

---Gets the current SoftAP configuration.
---@param return_table boolean @"`true`: returns data in a table;  \n `false`: returns data in the old format (default)"
---@return table|string @>
--- - If `return_table` is `true` -> *config_table*
---   - **ssid** - Network name
---   - **pwd** - Password, nil if no password was configured
---   - **auth** - Authentication Method\
---(wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK or wifi.WPA_WPA2_PSK)
---   - **channel** - Channel number
---   - **hidden** - `false` = not hidden, `true` = hidden
---   - **max** - Maximum number of client connections
---   - **beacon** - Beacon interval
--- - If `return_table` is `false`:
---   - **ssid, password**, if bssid_set is equal to 0 then bssid is irrelevant
---@nodiscard
function wifi.ap.getconfig(return_table) end

---Gets the default SoftAP configuration stored in flash.
---@param return_table boolean @"`true`: returns data in a table;  \n `false`: returns data in the old format (default)"
---@return table|string @>
--- - If `return_table` is `true` -> *config_table*
---   - **ssid** - Network name
---   - **pwd** - Password, `nil` if no password was configured
---   - **auth** Authentication Method\
---(wifi.OPEN, wifi.WPA_PSK, wifi.WPA2_PSK or wifi.WPA_WPA2_PSK)
---   - **channel** - Channel number
---   - **hidden** - `false` = not hidden, `true` = hidden
---   - **max** - Maximum number of client connections
---   - **beacon** - Beacon interval
--- - If return_table is false:
---   - **ssid, password**, if bssid_set is equal to 0 then bssid is irrelevant
---@nodiscard
function wifi.ap.getdefaultconfig(return_table) end

---Gets IP address, netmask and gateway in AP mode.
---@return string @"IP address, netmask, gateway address  \n  as string,for example '192.168.0.111',  \n returns `nil` if IP address = '0.0.0.0'."
---@nodiscard
function wifi.ap.getip() end

---Gets MAC address in AP mode.
---@return string @"MAC address as string,  \n for example '1A-33-44-FE-55-BB'"
---@nodiscard
function wifi.ap.getmac() end

---Sets IP address, netmask and gateway address in AP mode.
---@param cfg WifiCfgTbl @table contain IP address, netmask, and gateway
---```lua
---{      ip = "192.168.1.1",
---  netmask = "255.255.255.0",
---  gateway = "192.168.1.1" }
---```
---@return boolean
function wifi.ap.setip(cfg) end

---Sets MAC address in AP mode.
---@param mac string @"MAC address in byte string,  \n for example 'AC-1D-1C-B1-0B-22'"
---@return boolean
function wifi.ap.setmac(mac) end

---Configure the dhcp service. Currently only supports\
---setting the start address of the dhcp address pool.
---@param dhcp_config table @"table containing the start-IP  \n of the DHCP address pool, eg. '192.168.1.100'"
---@return string @pool_startip, pool_endip
function wifi.ap.dhcp.config(dhcp_config) end

---Starts the DHCP service.
---@return boolean @boolean indicating success
function wifi.ap.dhcp.start() end

---Stops the DHCP service.
---@return boolean @boolean indicating success
function wifi.ap.dhcp.stop() end

---Register callback for WiFi event **STA_CONNECTED**.\
---Station is connected to access point.
---@param eventID wifi.eventmon.STA_CONNECTED
---@param callback fun(T: sta_connected_t)
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **STA_DISCONNECTED**.\
---Station was disconnected from access point.
---@param eventID wifi.eventmon.STA_DISCONNECTED
---@param callback fun(T: sta_disconnected_t)
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **STA_AUTHMODE_CHANGE**\
---Access point has changed authorization mode.
---@param eventID wifi.eventmon.STA_AUTHMODE_CHANGE
---@param callback fun(T: sta_authmode_change_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.STA_GOT_IP**:\
---Station got an IP address.
---@param eventID wifi.eventmon.STA_GOT_IP
---@param callback fun(T: sta_got_ip_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.STA_DHCP_TIMEOUT**:\
---Station DHCP request has timed out.
---@param eventID wifi.eventmon.STA_DHCP_TIMEOUT
---@param callback fun(T: sta_dhcp_timeout_t)  @Blank table is returned.
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.AP_STACONNECTED**:\
---A new client has connected to the access point.
---@param eventID wifi.eventmon.AP_STACONNECTED
---@param callback fun(T: ap_staconnected_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.AP_STADISCONNECTED**:\
---A client has disconnected from the access point.
---@param eventID wifi.eventmon.AP_STADISCONNECTED
---@param callback fun(T: ap_stadisconnected_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.AP_PROBEREQRECVED**:\
---A probe request was received.
---@param eventID wifi.eventmon.AP_PROBEREQRECVED
---@param callback fun(T: ap_probereqrecved_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Register callback for WiFi event **wifi.eventmon.WIFI_MODE_CHANGED**:\
---WiFi mode has changed.
---@param eventID wifi.eventmon.WIFI_MODE_CHANGED
---@param callback fun(T: wifi_mode_changed_t)
---@return nil
function wifi.eventmon.register(eventID, callback) end

---Unregister callbacks for WiFi event monitor
---@param Event integer|`wifi.eventmon.STA_CONNECTED`|`wifi.eventmon.STA_DISCONNECTED`|`wifi.eventmon.STA_AUTHMODE_CHANGE`|`wifi.eventmon.STA_GOT_IP`|`wifi.eventmon.STA_DHCP_TIMEOUT`|`wifi.eventmon.AP_STACONNECTED`|`wifi.eventmon.AP_STADISCONNECTED`|`wifi.eventmon.AP_PROBEREQRECVED`|`wifi.eventmon.WIFI_MODE_CHANGED` @WiFi event you would like to remove the callback for.
---@return nil
function wifi.eventmon.unregister(Event) end
