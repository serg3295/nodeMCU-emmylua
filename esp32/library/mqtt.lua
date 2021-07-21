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

---@class Mqtt
local Mqtt = {}

---Creates a MQTT client.
---@param clientid string @client ID
---@param keepalive integer @keepalive seconds
---@param username? string @(optional) user name
---@param password? string @(optional) user password
---@param cleansession? integer @(optional) **0/1** for `false/true`. Default is 1 (`true`).
---@return Mqtt @MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession) end

---Closes connection to the broker.
---@return boolean
function Mqtt:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string @host, domain or IP (string)
---@param port? integer @(optional) broker port (number), default 1883
---@param secure? boolean|table @(optional) either an interger with **0/1** for `false/true` (default 0), or a table with optional entries
--- - **ca_cert CA** - certificate data in PEM format for server verify with SSL
--- - **client_cert** - client certificate data in PEM format for SSL mutual authentication
--- - **client_key** - client private key data in PEM format for SSL mutual authentication.\
---Note that both client_cert and client_key have to be provided for mutual authentication.
---@param conn_est? fun(client:Mqtt) @(optional) `function(client)` callback function for when the connection was established
---@param conn_notest? fun(client:Mqtt, reason:mqtt) @(optional) `function(client, reason)` callback function for when the connection could not be established. No further callbacks should be called.
---@return boolean
function Mqtt:connect(host, port, secure, conn_est, conn_notest) end

---Setup Last Will and Testament. A broker will publish a message with qos = 0, retain = 0, data = "offline"\
---to topic "/lwt" if client does not send keepalive packet.
---@param topic string @the topic to publish to (string)
---@param message string @the message to publish, (buffer or string)
---@param qos? integer|'0'|'1'|'2' @(optional) QoS level, default **0**
---@param retain? integer|'0'|'1' @(optional) retain flag, default **0**
---@return nil
function Mqtt:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"message"'|'"offline"' @can be "connect", "message" or "offline"
---@param callback fun(client:Mqtt, topic:string, message:string) @`function(client, topic?:string, message?:string)`.
---The first parameter is the client. If event is "message",\
---the 2nd and 3rd param are received topic and message (strings).
---@return nil
function Mqtt:on(event, callback) end

---Publishes a message.
---@param topic string @topic the topic to publish to (topic string)
---@param payload string @message the message to publish, (buffer or string)
---@param qos integer|'0'|'1'|'2' @QoS level
---@param retain integer|'0'|'1' @retain flag
---@param callback? fun(client:Mqtt) @(optional) `function(client)` fired when PUBACK received.
---NOTE: When calling `publish()` more than once, the last callback function defined\
---will be called for ALL publish commands.
---@return boolean
function Mqtt:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string @a topic string
---@param qos integer|'0'|'1'|'2' @QoS subscription level, default 0
---@param callback? fun(client:Mqtt) @(optional) `function(client)` fired when subscription(s) succeeded.
---NOTE: When calling `subscribe()` more than once, the last callback function defined\
---will be called for ALL subscribe commands.
---@return boolean
function Mqtt:subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string @a topic string
---@param callback? fun(client:Mqtt) @(optional) `function(client)` fired when unsubscription(s) succeeded.
---NOTE: When calling unsubscribe() more than once, the last callback function defined\
---will be called for ALL unsubscribe commands.
---@return boolean
function Mqtt:unsubscribe(topic, callback) end
