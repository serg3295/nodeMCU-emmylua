---@meta

--=== http ===

---@class http
---@field GET integer
---@field POST integer
---@field DELETE integer
---@field HEAD integer
http = {}

---@class connection
local connection = {}

---@class CreateHTTPConn
---@field async boolean
---@field bufsz number
---@field cert string
---@field headers table
---@field max_redirects number
---@field timeout number

---Creates a connection object which can be configured and then executed.
---@param url string|"http://"|"https://" @The URL to fetch, including the http:// or https:// prefix. Required.
---@param method? integer|`http.GET`|`http.POST`|`http.DELETE`|`http.HEAD` @The HTTP method to use. Optional and may be omitted, the default is http.GET.
---@param options? CreateHTTPConn @An optional table containing any or all of:
--- - **async** If true, the request is processed asynchronously, meaning `request()` returns immediately rather than blocking until\
---the connection is complete and all callbacks have been made. Some other connection APIs behave differently in asynchronous mode,\
---see their documentation for details. If not specified, the default is false, meaning requests are processed synchronously.
--- - **bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--- - **cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or\
---intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--- - **headers** Table of headers to add to the request.
--- - **max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10.\
---Specify 0 to disable following redirects entirely.
--- - **timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@return connection @The connection object.
function http.createConnection(url, method, options) end

---Set a callback to be called when a certain event occurs.
---@param event string @connect | headers | data | complete
---|"connect" #Called when the connection is first established. Callback receives no arguments.
---|"headers" #Called once the HTTP headers from the remote end have been received. Callback is called as callback(status_code, headers_table).
---|"data" #Can be called multiple times, each time more (non-headers) data is received. Callback is called as callback(status_code, data).
---|"complete" #Called once all data has been received. Callback is called as callback status_code, connected) where connected is true if the connection is still open.
---@param callback? fun() @"(optional) a function to be called when the given event occurs.  \n Can be `nil` to remove a previously configured callback."
---@return nil
function connection:on(event, callback) end

---Opens the connection to the server and issues the request.
---@return any|nil @"In asynchronous mode, always returns `nil`.  \nIn synchronous mode, it returns 2 results, `status_code`, `connected`  \n where connected is `true` if the connection is still open."
function connection:request() end

---Sets the connection method.
---@param method? integer|`http.GET`|`http.POST`|`http.DELETE`|`http.HEAD` @(optional) one of
---@return nil
function connection:setmethod(method) end

---Sets the connection URL.
---@param url string|"" @Required. The URL to use for the next `request()` call.
---@return nil
function connection:seturl(url) end

---Sets an individual header in the request.
---@param name string @name of the header to set.
---@param value? string|nil @(optional) what to set it to. Must be a string, or `nil` to unset it.
---@return nil
function connection:setheader(name, value) end

---Sets the POST data to be used for this request.\
---Also sets the method to http.POST if it isn't already.
---@param data any|nil @"The data to POST.  \n Unless a custom Content-Type header has been set, this data should be  \n in application/x-www-form-urlencoded format. Can be `nil` to unset  \n what to post and the Content-Type header."
---@return nil
function connection:setpostdata(data) end

---Completes a callback that was previously\
---delayed by returning http.DELAYACK.
---@return nil
function connection:ack() end

---Closes the connection if it is still open.
---@return nil
function connection:close() end

---Make an HTTP GET request. If a callback is specifed then the function operates in asynchronous mode, otherwise it is synchronous.
---@param url string|"http://"|"https://" @The URL to fetch
---@param options? any|nil @(optional) Same options as http.createConnection(), except that async is set for you based on whether a callback is specified or not. May be `nil` or omitted.
--- - **bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--- - **cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--- - **headers** Table of headers to add to the request.
--- - **max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10. Specify 0 to disable following redirects entirely.
--- - **timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@param callback? fun(code:number, data:any) @(optional) or `nil`
---@return any|nil @In synchronous mode, returns 3 results `status_code, body, headers` once the request has completed. In asynchronous mode, returns `nil` immediately.
function http.get(url, options, callback) end

---Executes a single HTTP POST request and closes the connection. If a callback is specifed then the function operates\
---in asynchronous mode, otherwise it is synchronous.
---@param url string|"http://"|"https://" @The URL to fetch
---@param options any|nil @Same options as http.createConnection(), except that async is set for you based on whether a callback is specified or not. May be `nil`.
--- - **bufsz** The size in bytes of the temporary buffer used for reading data. If not specified, the default is 512.
--- - **cert** A PEM-encoded certificate (or certificates). If specified, the server's TLS certificate must chain back to one of these root or\
---intermediate certificates otherwise the request will fail. This option is ignored for HTTP requests (unless they redirect to an HTTPS URL).
--- - **headers** Table of headers to add to the request.
--- - **max_redirects** Maximum number of 30x redirects to follow before giving up. If not specified, the default is 10.\
---Specify 0 to disable following redirects entirely.
--- - **timeout** Network timeout, in milliseconds. If not specified, the default is 10000 (10 seconds).
---@param body any @The body to post. Required and must already be encoded in the appropriate format, but may be empty.
---@param callback? fun(code:number, data:any) @(optional) Should be `nil` or omitted to specify synchronous behaviour, otherwise a callback function to be invoked when the response has been received or an error occurred, which is called with the arguments **status_code**, **body** and **headers**. In case of an error **status_code** will be a negative number.
---@return any|nil @"In synchronous mode, returns 3 results **status_code, body, headers** once the request has completed.  \n In asynchronous mode, returns `nil` immediately."
function http.post(url, options, body, callback) end
