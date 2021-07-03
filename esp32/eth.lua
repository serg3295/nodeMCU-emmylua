--=== eth ===

---@class eth
---@field CLOCK_GPIO0_IN integer
---@field CLOCK_GPIO0_OUT integer
---@field CLOCK_GPIO16_OUT integer
---@field CLOCK_GPIO17_OUT integer
---@field PHY_IP101 integer
---@field PHY_LAN8720 integer
---@field PHY_TLK110 integer
eth = {}

---Get MAC address.
---@return string @MAC address as string
---"aa:bb:cc:dd:ee:dd".
function eth.get_mac() end

---Get Ethernet connection speed.
---@return any @Connection speed in Mbit/s
--- - 10
--- - 100,\
---or error if not connected.
function eth.get_speed() end

---@class EthInit
---@field addr integer
---@field clock_mode integer
---@field mdc integer
---@field mdio integer
---@field phy integer
---@field power integer

---Initialize the PHY chip and set up its tcpip adapter.
---@param cfg EthInit @"table containing configuration data.  \n All entries are mandatory:"
--- - **addr** PHY address, 0 to 31
--- - **clock_mode** external/internal clock mode selection, one of
---   - eth.CLOCK_GPIO0_IN
---   - eth.CLOCK_GPIO0_OUT
---   - eth.CLOCK_GPIO16_OUT
---   - eth.CLOCK_GPIO17_OUT
--- - **mdc** MDC pin number
--- - **mdio** MDIO pin number
--- - **phy** PHY chip model, one of
---   - eth.PHY_IP101
---   - eth.PHY_LAN8720
---   - eth.PHY_TLK110
--- - **power** power enable pin, optional
---@return nil
function eth.init(cfg) end

---Register or unregister callback functions for Ethernet events.
---@param event string|'"start"'|'"stop"'|'"connected"'|'"disconnected"'|'"got_ip"' @event
---@param callback fun(event:string, info:table) @"`function(event, info)` to perform when event occurs, or `nil` to unregister  \n the callback for the event. The info argument given to the callback is a table containing additional  \n information about the event. Event information provided for each event is as follows:"
--- - **start**: no additional info
--- - **stop**: no additional info
--- - **connected**: no additional info
--- - **disconnected**: no additional info
--- - **got_ip**: IP network information:
---   - *ip*: the IP address assigned
---   - *netmask*: the IP netmask
---   - *gw*: the gateway ("0.0.0.0" if no gateway)
function eth.on(event, callback) end

---Set MAC address.
---@param mac string @MAC address as string "aa:bb:cc:dd:ee:ff"
---@return nil
---An error is thrown in case of invalid parameters or\
---if the ethernet driver failed.
function eth.set_mac(mac) end
