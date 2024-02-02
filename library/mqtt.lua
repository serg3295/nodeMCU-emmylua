---@meta

--=== mqtt ===

---@class mqtt
mqtt = {}

---@class mqttObj
local mqttObj = {}

---Creates a mqttObj client.
---@param clientid string @client ID
---@param keepalive integer @keepalive seconds
---@param username? string @(optional) user name
---@param password? string @(optional) user password
---@param cleansession? integer @(optional) **0/1** for `false/true`. Default is 1 (`true`).
---@return mqttObj @MQTT client
---@nodiscard
function mqtt.Client(clientid, keepalive, username, password, cleansession) end

---Closes connection to the broker.
function mqttObj:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@overload fun(self, host: string, conn_est: function, conn_notest: function): boolean
---@overload fun(self, host: string, port: integer, secure: integer|table, conn_est: function): boolean
---@overload fun(self, host: string, conn_est: function): boolean
---@param host string @host, domain or IP (string), or schema://host
---@param port? integer|`1883` @(optional) broker port (number), default 1883
---@param secure? integer|table @(optional) either an interger with **0/1** for `false/true` (default 0), or a table with optional entries
--- - **ca_cert CA** - certificate data in PEM format for server verify with SSL
--- - **client_cert** - client certificate data in PEM format for SSL mutual authentication
--- - **client_key** - client private key data in PEM format for SSL mutual authentication.\
---Note that both client_cert and client_key have to be provided for mutual authentication.
---@param autoreconnect? integer @(optional) **0/1** for `false/true` (default 0). This option is *deprecated*.
---@param conn_est? fun(client:mqttObj) @(optional) `function(client)` callback function for when the connection was established
---@param conn_notest? fun(client:mqttObj, reason:mqtt) @(optional) `function(client, reason)` callback function for when the connection could not be established. No further callbacks should be called.
---@return boolean
function mqttObj:connect(host, port, secure, autoreconnect, conn_est, conn_notest) end

---Setup Last Will and Testament. A broker will publish a message with qos = 0, retain = 0, data = "offline"\
---to topic "/lwt" if client does not send keepalive packet.
---@param topic string @the topic to publish to (string)
---@param message string @the message to publish, (buffer or string)
---@param qos? integer|`0`|`1`|`2` @(optional) QoS level, default **0**
---@param retain? integer|`0`|`1` @(optional) retain flag, default **0**
---@return nil
function mqttObj:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|"connect"|"message"|"offline" @can be "connect", "message" or "offline"
---@param callback fun(client:mqttObj, topic:string, message:string) @`function(client, topic?:string, message?:string)`.
---The first parameter is the client. If event is "message", the 2nd and 3rd param are received topic and message (strings).
---@return nil
function mqttObj:on(event, callback) end

---Publishes a message.
---@param topic string @topic the topic to publish to (topic string)
---@param payload string @message the message to publish, (buffer or string)
---@param qos integer|`0`|`1`|`2` @QoS level
---@param retain integer|`0`|`1` @retain flag
---@param callback? fun(client:mqttObj) @(optional) `function(client)` fired when PUBACK received.
---NOTE: When calling `publish()` more than once, the last callback function defined will be called for ALL publish commands.
---@return boolean
function mqttObj:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string @a topic string
---@param qos integer|`0`|`1`|`2` @QoS subscription level, default 0
---@param callback? fun(client:mqttObj) @(optional) `function(client)` fired when subscription(s) succeeded.
---NOTE: When calling `subscribe()` more than once, the last callback function defined\
---will be called for ALL subscribe commands.
---@return boolean
function mqttObj: subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string @a topic string
---@param callback? fun(client:mqttObj) @(optional) `function(client)` fired when unsubscription(s) succeeded.
---NOTE: When calling unsubscribe() more than once, the last callback function defined\
---will be called for ALL unsubscribe commands.
---@return boolean
function mqttObj:unsubscribe(topic, callback) end
