---@meta

--=== eth ===

---@class eth
---@field PHY_DP83848 integer
---@field PHY_IP101 integer
---@field PHY_KSZ8041 integer
---@field PHY_KSZ8081 integer
---@field PHY_LAN8720 integer
---@field PHY_RTL8201 integer
eth = {}

---Get MAC address.
---@return string @MAC address as string
---"aa:bb:cc:dd:ee:dd".
---@nodiscard
function eth.get_mac() end

---Get Ethernet connection speed.
---@return any @Connection speed in Mbit/s
--- - 10
--- - 100,\
---or error if not connected.
---@nodiscard
function eth.get_speed() end

---@class EthInit
---@field addr integer
---@field mdc integer
---@field mdio integer
---@field phy integer
---@field power integer

---Initialize the internal ethernet interface by configuring the MAC and PHY\
---and starting the interface. Note that while the PHY model and some GPIO pins\
---are configured at runtime, the clock configuration has been moved into\
---the menuconfig and is no longer available at runtime.\
---Please refer to the settings available under\
---`Component config -> Ethernet -> Support ESP32 internal EMAC controller`.
---@param cfg EthInit @"table containing configuration data.  \nUnless otherwise noted, the entries are mandatory:"
--- - **addr** PHY address, 0 to 31, optional (default will attempt auto-detect)
--- - **mdc** MDC pin number
--- - **mdio** MDIO pin number
--- - **phy** PHY chip model, one of
---   - eth.PHY_DP83848
---   - eth.PHY_IP101
---   - eth.PHY_KSZ8041
---   - eth.PHY_KSZ8081
---   - eth.PHY_LAN8720
---   - eth.PHY_RTL8201
--- - **power** power enable pin, optional
---@return nil @"`nil`; An error is thrown in case of invalid parameters,  \nMAC/PHY setup errors, or if the ethernet interface  \nhas already been successfully configured."
function eth.init(cfg) end

---Register or unregister callback functions for Ethernet events.
---@param event string|"start"|"stop"|"connected"|"disconnected"|"got_ip" @event
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

---Sets IP address, netmask, gateway, dns address of the ethernet.\
---Options set by this function are not saved to flash.
---@param cfg table @table to hold configuration:
--- - **ip** device ip address.
--- - **netmask** network netmask.
--- - **gateway** gateway address.
--- - **dns** name server address.
---@return nil
function eth.set_ip(cfg) end

---Configures a static IPv4 address on the ethernet interface.\
---Calling this function does three things:
--- - disables the DHCP client for the ethernet interface
--- - sets the IP address, netmask and gateway
--- - set the DNS server to use\
---Note that these settings are not persisted to flash.
---@param cfg_opts table @table with the following fields:
--- - **ip** static IPv4 address to set
--- - **netmask** the network netmask
--- - **gateway** default gateway to use
--- - **dns** DNS server
---@return nil @"`nil`; An error is thrown in case of invalid  \nparameters or if any of the options can not be set."
function eth.set_ip(cfg_opts) end

---Configures the interface specific hostname for the ethernet interface.\
---The ethernet interface must be initialized before the hostname can be configured.\
---By default the system hostname is used, as configured in the menu config.\
---An error is thrown in case the hostname cannot be set.
---@param hostname string @the hostname to use on the ethernet interface
---@return nil
function eth.set_hostname(hostname) end
