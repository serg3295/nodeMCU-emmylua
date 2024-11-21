---@meta

--=== mqtt ===

---@class mqtt
---@field CONN_FAIL_SERVER_NOT_FOUND integer
---@field CONN_FAIL_NOT_A_CONNACK_MSG integer
---@field CONN_FAIL_DNS integer
---@field CONN_FAIL_TIMEOUT_RECEIVING integer
---@field CONN_FAIL_TIMEOUT_SENDING integer
---@field CONNACK_ACCEPTED integer
---@field CONNACK_REFUSED_PROTOCOL_VER integer
---@field CONNACK_REFUSED_ID_REJECTED integer
---@field CONNACK_REFUSED_SERVER_UNAVAILABLE integer
---@field CONNACK_REFUSED_BAD_USER_OR_PASS integer
---@field CONNACK_REFUSED_NOT_AUTHORIZED integer
mqtt = {}

---@class mqttObj
---Registers a callback function for an event.
---@field on fun(self: mqttObj, event: "connect", callback: fun(client: mqttObj))
---@field on fun(self: mqttObj, event: "connfail", callback: fun(client: mqttObj, connectionFailureCode: integer)))
---@field on fun(self: mqttObj, event: "suback", callback: fun(client: mqttObj))
---@field on fun(self: mqttObj, event: "unsuback", callback: fun(client: mqttObj))
---@field on fun(self: mqttObj, event: "puback", callback: fun(client: mqttObj))
---@field on fun(self: mqttObj, event: "message", callback: fun(client: mqttObj, topic: string, message: string))
---@field on fun(self: mqttObj, event: "overflow", callback: fun(client: mqttObj, topic :string, message: string))
---@field on fun(self: mqttObj, event: "offline", callback: fun(client: mqttObj))
local mqttObj = {}

---Creates a MQTT client.
---@param clientid string @client ID
---@param keepalive integer @keepalive seconds
---@param username? string @(optional) user name
---@param password? string @(optional) user password
---@param cleansession? integer @(optional) **0/1** for `false/true`. Default is 1 (`true`).
---@param max_message_length? integer @(optional) how large messages to accept. Default is 1024.
---@return mqttObj @MQTT client
---@nodiscard
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Schedules a clean teardown of the connection.
---@return nil
function mqttObj:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string @host, domain or IP
---@param port? integer|`1883` @(optional) broker port (number), default 1883
---@param secure? boolean @(optional) if `true`, use TLS.
---@param conn_est? fun(client: mqttObj) @(optional) `function(client)` callback function for when the connection was established
---@param conn_not_est? fun(client: mqttObj, reason: mqtt) @"(optional) `function(client, reason)` callback function for when the connection could not be established.  \n No further callbacks should be called."
---@return nil @use callbacks to observe the outcome.
function mqttObj:connect(host, port, secure, conn_est, conn_not_est) end

---Setup [Last Will and Testament](http://www.hivemq.com/blog/mqtt-essentials-part-9-last-will-and-testament).
---@param topic string @the topic to publish to
---@param message string @the message to publish, (buffer or string)
---@param qos? integer|`0`|`1`|`2` @(optional) QoS level, default 0
---@param retain? integer|`0`|`1` @(optional) retain flag, default 0
---@return nil
function mqttObj:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string
---@param callback function
---@return nil
function mqttObj:on(event, callback) end

---Publishes a message.
---@param topic string @the topic to publish to (topic string)
---@param payload string @the message to publish, (buffer or string)
---@param qos integer|`0`|`1`|`2` @QoS level
---@param retain integer|`0`|`1` @retain flag
---@param callback? fun(client: mqttObj) @(optional) `function(client)` fired when PUBACK received (for QoS 1 or 2) or when message sent (for QoS 0).
---@return boolean
function mqttObj:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string|table @a topic string, or table array of `topic, qos` pairs to subscribe to.
---@param qos integer|`0`|`1`|`2` @QoS subscription level, default 0
---@param callback? fun(client: mqttObj) @(optional) `function(client)` fired when subscription(s) succeeded.
---@return boolean
function mqttObj:subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string|table @a topic string, or table array of `topic, anything` pairs to unsubscribe from.
---@param callback? fun(client: mqttObj) @(optional) `function(client)` fired when unsubscription(s) succeeded.
---@return boolean
function mqttObj:unsubscribe(topic, callback) end
