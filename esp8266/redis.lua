--=== redis ===

---@class redis
redis = {}

---@class rds
local rds = {}

---Function used to connect to Redis server.
---@param host string @Redis host name or address
---@param port integer @Redis database port. Default value is 6379.
---@return rds rdsObj @Object with rest of the functions.
function redis.connect(host, port) end

---Subscribe to a Redis channel.
---@param channel any @Channel name
---@param handler function @"Handler function that will be called on new  \n message in subscribed channel"
---@return nil
function rds:subscribe(channel, handler) end

---Publish a message to a Redis channel.
---@param channel any @Channel name
---@param message any @Message to publish
---@return nil
function rds:publish(channel, message) end

---Unsubscribes from a channel.
---@param channel any @Channel name to unsubscribe from
---@return nil
function rds:unsubscribe(channel) end

---Function to close connection to Redis server.
---@return nil
function rds:close() end
