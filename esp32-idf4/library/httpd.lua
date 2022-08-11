--=== httpd ===

---@class httpd
---@field GET integer
---@field PUT integer
---@field HEAD integer
---@field POST integer
---@field DELETE integer
---@field INDEX_NONE integer
---@field INDEX_ROOT integer
---@field INDEX_ALL integer
httpd = {}

---Starts the web server. The server has to be started before routes can be configured.
---@param tbl table @A single configuration table is provided, with the following possible fields:
--- - **webroot** (mandatory) This sets the prefix used when serving static files.
---For example, with `webroot` set to "web", a HTTP request for "/index.html"
---will result in the httpd module trying to serve the file "web/index.html"
---from the file system. Do NOT set this to the empty string, as that would
---provide remote access to your entire virtual file system, including special
---files such as virtual device files (e.g. "/dev/uart1") which would likely
---present a serious security issue.
--- - **max_handlers** (optional) Configures the maximum number of route handlers
--- the server will support. Default value is 20, which includes both the
--- standard static file extension handlers and any user-provided handlers.
--- Raising this will result in a bit of additional memory being used. Adjust
--- if and when necessary.
--- - **auto_index** Sets the indexer mode to be used. Most web servers
--- automatically go looking for an "index.html" file when a directory is
--- requested. For example, when pointing your web browser to a web site
--- for the first time, e.g. http://www.example.com/ the actual request will
--- come through for "/", which in turn commonly gets translated to "/index.html"
--- on the server. This behaviour can be enabled in this module as well. There
--- are three modes provided:
---   - **httpd.INDEX_ROOT** Only the root ("/") is translated to "/index.html".
---   - **httpd.INDEX_NONE** No automatic translation to "index.html" is provided.
---   - **httpd.INDEX_ALL** Any path ending with a "/" has "index.html" appended.
---For example, a request for "subdir/" would become "subdir/index.html",
---which in turn might result in the file "web/subdir/index.html" being
---served (if the `webroot` was set to "web").
---The default value is `httpd.INDEX_ROOT`.
---@return nil
function httpd.start(tbl) end

---Stops the web server. All registered\
---route handlers are removed.
---@return nil
function httpd.stop() end

---Registers a static route handler.
---@param route string @"The route prefix. Typically in the form of \*.ext to serve all files with the *.ext* extension statically.  \nRefer to the Espressif documentation if you wish to use the native Espressif style of static routes instead."
---@param content_type string @The value to send in the `Content-Type` header for this file type.
---@return integer|nil @"An error code on failure, or `nil` on success. The error code is the value returned from  \nthe `httpd_register_uri_handler()` function."
function httpd.static(route, content_type) end

---Registers a dynamic route handler.
---@param method integer|'httpd.GET'|'httpd.HEAD'|'httpd.PUT'|'httpd.POST'|'httpd.DELETE' @The HTTP method this route applies to.
---@param route string @The route prefix. Be mindful of any trailing "/" as that may interact with the `auto_index` functionality.
---@param handler function @The route handler function - `handler(req)`. The provided request object `req` has the following fields/functions:
--- - **method** The request method. Same as the `method` parameter above. If the same function is registered for several methods,\
---this field can be used to determine the method the request used.
--- - **uri** The requested URI. Includes both path and query string (if applicable).
--- - **query** The query string on its own. Not decoded.
--- - **headers** A table-like object in which request headers may be looked up.\
---Note that due to the Espressif API not providing a way to iterate over all headers this table will appear empty if fed to `pairs()`.
--- - **getbody** A function which may be called to read in the request body incrementally. The size of each chunk is set via\
---the Kconfig option "Receive body chunk size". When this function returns `nil` the end of the body has been reached.\
---May raise an error if reading the body fails for some reason (e.g. timeout, network error).\
---Note that the provided `req` object is _only valid_ within the scope of this single invocation of the handler.\
---Attempts to store away the request and use it later _will_ fail.
---@return table @A table with the response data to send to the requesting client:
---Supported fields:
--- - **status** The status code and string to send. If not included "200 OK" is used Other common strings would be "404 Not Found",\
---"400 Bad Request" and everybody's  favourite "500 Internal Server Error".
--- - **type** The value for the `Content-Type` header. The Espressif web server component handles this header specially,\
---which is why it's provided here and not within the `headers` table.
--- - **body** The full content body to send.
--- - **getbody** A function to source the body content from, similar to the way the request body is read in. This function will be called\
---repeatedly and the returned string from each invocation will be sent as a chunk to the client. Once this function returns `nil`\
---the body is deemed to be complete and no further calls to the function will be made. It is guaranteed that the function \
---will be called until it returns `nil` even if the sending of the content encounters an error. This ensures that any resource cleanup\
---necessary will still take place in such circumstances (e.g. file closing).\
---Only one of `body` and `getbody` should be specified.
function httpd.dynamic(method, route, handler) end

---Unregisters a previously registered handler. The default handlers\
---may be unregistered.
---@param method integer|'httpd.GET'|'httpd.HEAD'|'httpd.PUT'|'httpd.POST'|'httpd.DELETE' @The method the route was registered for.
---@param route string @The route prefix.
---@return integer|nil @"`1` on success, `nil` on failure (including if the route  \nwas not registered)."
function httpd.unregister(method, route) end
