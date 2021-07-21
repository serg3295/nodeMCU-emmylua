---@meta

--=== gossip ===

---@class gossip
gossip = {}

---@class GossipCfg
---@field seedList table
---@field roundInterval integer
---@field comPort integer
---@field debug boolean
---@field debugOutput function

---Sets the configuration for gossip.
---@param config GossipCfg @table. The available options are:
--- - **seedList**: the list of seeds gossip will start with;\
---this will be updated as new nodes are discovered.\
---Note that it's enough for all nodes to start with the same IP\
---in the seedList, as once they have one seed in common,\
--- the data will propagate. Default: `nil`.
--- - **roundInterval**: interval in milliseconds at which gossip\
---will pick a random node from the seed list\
---and send a SYN request. Default: 10000 (10 seconds)
--- - **comPort**: port for the listening UDP socket. Default: 5000.
--- - **debug**: flag that will provide debugging messages.\
---Default: `false`.
--- - **debugOutput**: if debug is set to true,then this method\
--- will be used as a callback with the debug message \
---as the first parameter. Default: print
function gossip.setConfig(config) end

---Starts gossip, sets the started flag\
---to `true` and initiates the revision.
function gossip.start() end

---If declared, this function will get called every time\
---there is a SYN with new data.
---```lua
---gossip.callbackFunction = function(data)
---  processData(data)
---end
---gossip.callbackFunction = nil -- stop the callback
---```
function gossip.callbackFunction() end

---Send a SYN request outside of the normal gossip round.\
---The IP is optional and if none given, it will pick a random node.
---@param data any|nil @"By calling `pushGossip(nil)` you effectively remove  \n the **data** table  from the node's network state and notify other nodes of this."
---@param ip? string @"(optional) The IP is optional and if none given,it will pick  \n  a random node."
function gossip.pushGossip(data, ip) end

---The only scenario when rev should be set manually is when a new node is added to\
---the network and has the same IP. Having a smaller revision than the previous node\
---with the same IP would make gossip think the data it received is old, thus ignoring it.
function gossip.setRevFileValue(number) end

---The network state can be directly accessed as a Lua table:\
---`gossip.networkState` or it can be received as a JSON with this method.
---@return string @JSON formatted string regarding the network state.
function gossip.getNetworkState() end
