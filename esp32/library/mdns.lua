---@meta

--=== mdns ===

---@class mdns
---@field TYPE_A integer IPv4 address lookup query.
---@field TYPE_AAAA integer IPv6 address lookup query.
---@field TYPE_PTR integer PTR record query (find services).
---@field TYPE_TXT integer TXT record query.
---@field TYPE_SRV integer SRV record query (find hostname/port for service).
---@field TYPE_ANY integer Query all record types.
mdns = {}

---@class mdns_query
---@field query_type integer|`mdns.TYPE_A`|`mdns.TYPE_AAAA`|`mdns.TYPE_PTR`|`mdns.TYPE_TXT`|`mdns.TYPE_SRV`|`mdns.TYPE_ANY` The type of mDNS query to issue.
---@field name? string Name to query for.
---@field service_type? string The service type to query for.
---@field protocol? string The transport protocol of the service being queried for (e.g. `"_tcp"` or `"_udp"`).
---@field timeout? integer Timeout in milliseconds to wait for responses. Default 2000.
---@field max_results? integer Maximum number of responses to return. Default 10.

---@class mdns_services
---@field service_type string The service type to register, e.g. `"_http"`.
---@field protocol string The protocol to register, one of `"_udp"` or `"_tcp"` typically.
---@field port integer The port number of the service, e.g. `80`.
---@field subtype? string The service subtype, if applicable.
---@field instance_name? string The instance name of the service. Defaults to the system-wide instance name if not set explicitly.
---@field txt? table A table of key/value value pairs to add to the service's `TXT` entry.

---@class mdns_config
---@field hostname string The hostname to use for mDNS.
---@field instance_name? string The default service instance name. Defaults to the hostname if not set explicitly.
---@field services? mdns_services[] An array of service entries to register with mDNS

---Initialises the mDNS subsystem and registers any services for the device.
---@param config mdns_config @Table containing the mDNS service configuration:
---  - **hostname** (Required if any services are to be registered) The hostname to use for mDNS.
---  - **instance_name** (Optional) The default service instance name. Defaults to the hostname if not set explicitly.
---  - **services** (Optional) An array of service entries to register with mDNS, with each entry being a table comprising these fields:
---    - **service_type** (Required) The service type to register, e.g. `"_http"`.
---    - **protocol** (Required) The protocol to register, one of `"_udp"` or `"_tcp"` typically.
---    - **port** (Required) The port number of the service, e.g. `80`.
---    - **subtype** (Optional) The service subtype, if applicable.
---    - **instance_name** (Optional) The instance name of the service. Defaults to the system-wide instance name if not set explicitly.
---    - **txt** (Optional) A table of key/value value pairs to add to the service's `TXT` entry.
---@return integer @The number of services registered with the mDNS subsystem.
function mdns.start(config) end

---Perform an mDNS query.
---@param query mdns_query @Table with the query parameters. Most fields are optional depending on the query type.
---  - **query_type** (Required) The type of mDNS query to issue. One of:
---     - **mdns.TYPE_A** IPv4 address lookup query.
---     - **mdns.TYPE_AAAA** IPv6 address lookup query.
---     - **mdns.TYPE_PTR** PTR record query (find services).
---     - **mdns.TYPE_TXT** TXT record query.
---     - **mdns.TYPE_SRV** SRV record query (find hostname/port for service).
---     - **mdns.TYPE_ANY** Query all record types.
---  - **name** Name to query for.
---  - **service_type** The service type to query for.
---  - **protocol** The transport protocol of the service being queried for (e.g. `"_tcp"` or `"_udp"`.
---  - **timeout** Timeout in milliseconds to wait for responses. Default 2000.
---  - **max_results** Maximum number of responses to return. Default 10.
---@return table @A Lua array with the results. Each result is a table. The fields in the table depend on the query type performed.
--[[```lua
{ {
  -- PTR results
  instance_name=,
  service_type=,
  protocol=,
  -- SRV results
  hostname=,
  port=,
  -- TXT results
  txt={
    key1=,
    key2=,
    ...
  },
  -- A and AAAA results
  addresses={ ip1str, ip2str, ...  }
  },
  ...
}
```]]
function mdns.query(query) end

---Unregisters any services and shuts down the mDNS subsystems.
---@return nil
function mdns.stop() end
