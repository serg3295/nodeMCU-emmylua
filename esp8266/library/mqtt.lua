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

---@class MQTT
local MQTT = {}

---Creates a MQTT client.
---@param clientid string @client ID
---@param keepalive integer @keepalive seconds
---@param username? string @(optional) user name
---@param password? string @(optional) user password
---@param cleansession? integer @(optional) **0/1** for `false/true`. Default is 1 (`true`).
---@param max_message_length? integer @(optional) how large messages to accept. Default is 1024.
---@return MQTT @MQTT client
function mqtt.Client(clientid, keepalive, username, password, cleansession, max_message_length) end

---Closes connection to the broker.
---@return nil
function MQTT:close() end

---Connects to the broker specified by the given host, port, and secure options.
---@param host string @host, domain or IP
---@param port? integer @(optional) broker port (number), default 1883
---@param secure? boolean @(optional) if `true`, use TLS.
---@param conn_est? fun(client: MQTT) @(optional) `function(client)` callback function for when the connection was established
---@param conn_not_est? fun(client: MQTT, reason:mqtt) @"(optional) `function(client, reason)` callback function for when the connection could not be established.  \n No further callbacks should be called."
---@return nil
function MQTT:connect(host, port, secure, conn_est, conn_not_est) end

---Setup [Last Will and Testament](http://www.hivemq.com/blog/mqtt-essentials-part-9-last-will-and-testament).
---@param topic string @the topic to publish to (string)
---@param message string @the message to publish, (buffer or string)
---@param qos? integer|'0'|'1'|'2' @(optional) QoS level, default 0
---@param retain? integer|'0'|'1' @(optional) retain flag, default 0
---@return nil @`nil`; use callbacks to observe the outcome.
function MQTT:lwt(topic, message, qos, retain) end

---Registers a callback function for an event.
---@param event string|'"connect"'|'"connfail"'|'"suback"'|'"unsuback"'|'"puback"'|'"message"'|'"overflow"'|'"offline"' @event
---@param callback fun(client:MQTT, topic:string, message:string) @"`function(client[, topic[, message]])`. The first parameter is always the client object itself.  \n Any remaining parameters passed differ by event:"
--- - If event is `"message"`, the 2nd and 3rd parameters are received topic and message, respectively, as Lua strings.
--- - If the event is `"overflow"`, the parameters are as with `"message"``,\
---save that the message string is truncated to the maximum message size.
--- - If the event is `"connfail"`, the 2nd parameter will be the connection failure code.
--- - Other event types do not provide additional arguments.
---@return nil
function MQTT:on(event, callback) end

---Publishes a message.
---@param topic string @the topic to publish to (topic string)
---@param payload string @the message to publish, (buffer or string)
---@param qos integer|'0'|'1'|'2' @QoS level
---@param retain integer|'0'|'1' @retain flag
---@param callback? fun(client:MQTT) @(optional) `function(client)` fired when PUBACK received (for QoS 1 or 2) or when message sent (for QoS 0).
---@return boolean
function MQTT:publish(topic, payload, qos, retain, callback) end

---Subscribes to one or several topics.
---@param topic string|table @a topic string, or table array of `topic, qos` pairs to subscribe to.
---@param qos integer|'0'|'1'|'2' @QoS subscription level, default 0
---@param callback? fun(client:MQTT) @(optional) `function(client)` fired when subscription(s) succeeded.
---@return boolean
function MQTT:subscribe(topic, qos, callback) end

---Unsubscribes from one or several topics.
---@param topic string|table @a topic string, or table array of `topic, anything` pairs to unsubscribe from.
---@param callback? fun(client:MQTT) @(optional) `function(client)` fired when unsubscription(s) succeeded.
---@return boolean
function MQTT:unsubscribe(topic, callback) end
