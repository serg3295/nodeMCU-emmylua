--=== http ===

---@class http
http = {}

---Executes a HTTP DELETE request. Note that concurrent requests are not supported.
---@param url string|'"http://"'|'"https://"' @The URL to fetch, including the http:// or https:// prefix
---@param headers string @Optional additional headers to append, including \r\n; may be `nil`
---@param body string @The body to post; must already be encoded in the appropriate format, but may be empty
---@param callback function|'function(code, data) end' @"The callback function to be invoked when the response has been received or an error occurred;  \n it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1."
---@return nil
function http.delete(url, headers, body, callback) end

---Executes a HTTP GET request. Note that concurrent requests are not supported.
---@param url string|'"http://"'|'"https://"' @The URL to fetch, including the http:// or https:// prefix
---@param headers string @Optional additional headers to append, including \r\n; may be `nil`
---@param callback function|'function(code, data) end' @"The callback function to be invoked when the response has been received or an error occurred;  \n it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1."
---@return nil
function http.get(url, headers, callback) end

---Executes a HTTP POST request. Note that concurrent requests are not supported.
---@param url string|'"http://"'|'"https://"' @The URL to fetch, including the http:// or https:// prefix
---@param headers string @Optional additional headers to append, including \r\n; may be `nil`
---@param body string @The body to post; must already be encoded in the appropriate format, but may be empty
---@param callback function|'function(code, data) end' @"The callback function to be invoked when the response has been received or an error occurred;  \n it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1."
---@return nil
function http.post(url, headers, body, callback) end

---Executes a HTTP PUT request. Note that concurrent requests are not supported.
---@param url string|'"http://"'|'"https://"' @The URL to fetch, including the http:// or https:// prefix
---@param headers string @Optional additional headers to append, including \r\n; may be `nil`
---@param body string @The body to post; must already be encoded in the appropriate format, but may be empty
---@param callback function|'function(code, data) end' @"The callback function to be invoked when the response has been received or an error occurred;  \n it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1."
---@return nil
function http.put(url, headers, body, callback) end

---Execute a custom HTTP request for any HTTP method. Note that concurrent requests are not supported.
---@param url string|'"http://"'|'"https://"' @The URL to fetch, including the http:// or https:// prefix
---@param method string |'"GET"'|'"HEAD"'|'"POST"'|'"PUT"'|'"DELETE"'|'"CONNECT"'|'"TRACE"'|'"PATCH"'|'"OPTIONS"' @The HTTP method to use
---@param headers string @Optional additional headers to append, including \r\n; may be `nil`
---@param body string @The body to post; must already be encoded in the appropriate format, but may be empty
---@param callback function|'function(code, data) end' @"The callback function to be invoked when the response has been received or an error occurred;  \n it is invoked with the arguments status_code, body and headers. In case of an error status_code is set to -1."
---@return nil
function http.request(url, method, headers, body, callback) end
