---@meta

--=== espnow ===

---@class espnow
espnow = {}

---@class espnow_options
---@field channel integer|nil
---@field lmk string|nil
---@field encrypt integer|nil

---Starts the ESP-NOW stack. While this may be called prior to `wifi.start()`, packet transmission and reception will not be possible until after the WiFi stack has been started.
---@return nil
---An error will be raised if the ESP-NOW stack cannot be started.
function espnow.start() end

---Stops the ESP-NOW stack.
---@return nil
---An error will be raised if the ESP-NOW stack cannot be stopped.
function espnow.stop() end

---Returns the raw version number enum value. Currently, it is `1`. Might be useful for checking version compatibility in the future.
---@return integer @An integer representing the ESP-NOW version.
function espnow.getversion() end

---Sets the Primary Master Key (PMK). When using security, this should be done prior to adding any peers, as their LMKs will be encrypted by the current PMK.
---@param pmk string @The Primary Master Key, given as a hex-encoding of a 16-byte key (i.e. the `pmk` should consist of 32 hex digits.
---@return nil
---An error will be raised if the PMK cannot be set.
function espnow.setpmk(pmk) end

---Controls the wake window during which ESP-NOW listens. In most cases this should never need to be changed from the default. Refer to the Espressif documentation for further details.
---@param window integer @An integer between 0 and 65535.
---@return nil
function espnow.setwakewindow(window) end

---Registers a peer MAC address. Optionally parameters for the peer may be included, such as encryption key.
---@param mac string @The peer mac address, given as a string in `00:11:22:33:44:55` format (colons optional, and may also be replaced by '-' or ' ').
---@param options? espnow_options @(optional) A table with with following entries:
---  - **channel** An integer indicating the WiFi channel to be used. The default is `0`, indicating that the current WiFi channel should be used. If non-zero, must match the current WiFi channel.
---  - **lmk** The LMK for the peer, if encryption is to be used.
---  - **encrypt** A non-zero integer to indicate encryption should be enabled. When set, makes `lmk` a required field.
---@return nil
---An error will be raised if a peer cannot be added, such as if the peer list if full, or the peer has already been added.
function espnow.addpeer(mac, options) end

---Deletes a previously added peer from the internal peer list.
---@param mac string @The MAC address of the peer to delete.
---@return nil
---Returns an error if the peer cannot be deleted.
function espnow.delpeer(mac) end

---Registers or unregisters callback handlers for the ESP-NOW events.\
---There are two events available, `sent` which is issued in response to a packet send request and which reports the status of the send attempt, and 'receive' which is issued when an ESP-NOW packet is successfully received.\
---Only a single callback function can be registered for each event.\
---The callback function for the `sent` event is invoked with two parameters, the destination MAC address, and a `1`/`nil` to indicate whether the send was believed to be successful or not.\
---The callback function for the `receive` event is invoked with a single parameter, a table with the following keys:
--- - **src** The sender MAC address
--- - **dst** The destination MAC address (likely either the local MAC of the receiver, or the broadcast address)
--- - **rssi** The RSSI value from the packet, indicating signal strength between the two devices
--- - **data** The actual payload data, as a string. The string may contain binary data.
---@param event string|'sent'|'receive' @The event name, one of `sent` or `receive`.
---@param callback function @ The callback function to register, or `nil` to unregister the previously set callback function for the event.
---@return nil
---Raises an error if invalid arguments are given.
function espnow.on(event, callback) end

---Attempts to send an ESP-NOW packet to one or more peers.\
---In general it is strongly recommended to use the encryption functionality, as this ensures not only secrecy but also prevent unintentional interference between different users of ESP-NOW.\
---If you do need to use broadcasts or multicasts, you should make sure to have a unique, recognisable marker at the start of the payload to make filtering out unwanted messages easy, both for you and other ESP-NOW users.
---@param peer string @The peer MAC address to send to. Must have previously been added via `espnow.addpeer()`. If `peer` is given as `nil`, the packet is sent to all registered non-broadcast/multicast peers, and the `sent` callback is invoked for each of those peers.
---@param data string @A string of data to send. May contain binary bytes. Maximum supported length at the time of writing is 250 bytes.
---@return nil @but the `sent` callback is invoked with the status afterwards.
---Raises an error if the peer is not valid, or other fatal errors preventing a send attempt from even being made. The `sent` callback will not be invoked in this case.
function espnow.send(peer, data) end
