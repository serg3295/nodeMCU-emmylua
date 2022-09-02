---@meta

--=== bthci ===

---@class bthci
bthci = {}

---@class bthci.adv
---@field CONN_UNDIR integer
---@field CONN_DIR_HI integer
---@field SCAN_UNDIR integer
---@field NONCONN_UNDIR integer
---@field CONN_DIR_LO integer
---@field CHAN_ALL integer
---@field CHAN_37 integer
---@field CHAN_38 integer
---@field CHAN_39 integer
bthci.adv = {}

---@class bthci.scan
bthci.scan = {}

---Sends a raw HCI command to the BlueTooth controller.
---@param hcibytes any @raw HCI command bytes to send to the BlueTooth controller.
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its first argument is the HCI error code, or `nil` on success. The second argument  \n contains any subsequent raw result bytes, or an empty string if the result only  \n contained the status code."
---@return nil
function bthci.rawhci(hcibytes, callback) end

---Resets the BlueTooth controller.
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.reset(callback) end

---Enables or disables BlueTooth LE advertisements. Before enabling advertisements,\
---both parameters and data should be set.
---@param onoff integer|`0`|`1` @**1** or **0** to enable or disable advertisements, respectively.
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.adv.enable(onoff, callback) end

---Configures the data to advertise.
---@param advbytes any @the raw bytes to advertise (up to 31 bytes), in the correct format
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.adv.setdata(advbytes, callback) end

---@class BthciSet1
---@field interval_min number
---@field interval_max number
---@field type integer
---@field own_addr_type number
---@field peer_addr_type number
---@field peer_addr number
---@field channel_map number
---@field filter_policy number

---Configures advertisement parameters.
---@param paramtable BthciSet1 @a table with zero or more of the following fields:
--- - **interval_min** value in units of 0.625ms. Default 0x0400 (0.64s).
--- - **interval_max** value in units of 0.625ms. Default 0x0800 (1.28s).
--- - **type** advertising type, one of following constants:
---   - bthci.adv.CONN_UNDIR, the default (ADV_IND in BT spec)
---   - bthci.adv.CONN_DIR_HI (ADV_DIRECT_IND, high duty cycle in the BT spec)
---   - bthci.adv.SCAN_UNDIR (ADV_SCAN_IND in the BT spec)
---   - bthci.adv.NONCONN_UNDIR (ADV_NONCONN_IND in the BT spec)
---   - bthci.adv.CONN_DIR_LO (ADV_DIRECT_IND, low duty cycle in the BT spec)
--- - **own_addr_type** own address type. Default 0 (public address).
--- - **peer_addr_type** peer address type. Default 0 (public address).
--- - **peer_addr** TODO, not yet implemented
--- - **channel_map** which channels to advertise on.\
---The constants *bthci.adv.CHAN_37, bthci.adv.CHAN_38, bthci.adv.CHAN_39*\
---or *bthci.adv.CHAN_ALL* may be used. Default is all channels.
--- - **filter_policy** filter policy, default 0 (no filtering).
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.adv.setparams(paramtable, callback) end

---Enables or disable scanning for advertisements from other BlueTooth devices.
---@param onoff integer|`0`|`1` @**1** or **0** to enable or disable advertisements, respectively.
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.scan.enable(onoff, callback) end

---@class BthciSet2
---@field mode number
---@field interval number
---@field window number
---@field own_addr_type number
---@field filter_policy number

---Configures scan parameters.
---@param paramstable BthciSet2 @a table with zero or more of the following fields:
--- - **mode** scanning mode, 0 for passive, 1 for active. Default 0.
--- - **interval** scanning interval in units of 0.625ms. Default 0x0010.
--- - **window** length of scanning window in units of 0.625ms. Default 0x0010.
--- - **own_addr_type** own address type. Default 0 (public).
--- - **filter_policy** filtering policy. Default 0 (no filtering).
---@param callback? function @"(optional) function to be invoked when the reset completes.  \n Its only argument is the HCI error code, or `nil` on success."
---@return nil
function bthci.scan.setparams(paramstable, callback) end

---Registers the callback to be passed any received advertisements.
---@param event string|'"adv_report"' @the string describing the event.
---@param callback? function @"(optional) the callback function to receive the advertising  \n reports, or `nil` to deregister the callback. This callback receives the raw bytes  \n of the advertisement payload."
---@return nil
function bthci.scan.on(event, callback) end
