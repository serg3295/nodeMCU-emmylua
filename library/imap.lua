---@meta

--=== imap ===

---@class imap
imap = {}

---Function used to check if IMAP command was processed.
---@return boolean @"The response process status of the last IMAP  \n command sent."
function imap.response_processed() end

---Initiates the IMAP settings.
---@param username string @IMAP username. For most e-mail providers e-mail address is used as username.
---@param password string @IMAP password.
---@param tag any @IMAP tag. With current implementation any tag like "t1" should work.
---@param dbug? boolean @"(optional) if set to `true` entire conversation between the ESP8266 and IMAP server  \n will be shown. Default setting is `false`."
---@return nil
function imap.config(username, password, tag, dbug) end

---Logs into a new email session.
---@param socket any @"IMAP TCP socket object created  \n using `net.createConnection`"
---@return nil
function imap.login(socket) end

---Function to check the most recent email number.\
---Should only be called after examine function.
---@return number @The most recent email number.
---@nodiscard
function imap.get_most_recent_num() end

---IMAP examines the given mailbox/folder. Sends the IMAP EXAMINE command.
---@param socket any @IMAP TCP socket object created using `net.createConnection`
---@param mailbox string @E-mail folder name to examine like example "INBOX"
---@return nil
function imap.examine(socket, mailbox) end

---Function that gets the last fetched header field.
---@return string @The last fetched header field.
---@nodiscard
function imap.get_header() end

---Fetches an e-mails header field e.g. SUBJECT, FROM, DATE.
---@param socket any @IMAP TCP socket object created using `net.createConnection`
---@param msg_number number @The email number to read e.g. 1 will read fetch the latest/newest email
---@param field string @A header field such as SUBJECT, FROM, or DATE
---@return nil
function imap.fetch_header(socket, msg_number, field) end

---Function to get the last email read's body.
---@return any @The last email read's body.
---@nodiscard
function imap.get_body() end

---Sends the IMAP command to fetch a plain text version of the email's body.
---@param socket any @IMAP TCP socket object created using `net.createConnection`
---@param msg_number number @The email number to obtain e.g. **1** will obtain the latest email.
---@return nil
function imap.fetch_body_plain_text(socket, msg_number) end

---Sends the IMAP command to logout of the email session.
---@param socket any @"IMAP TCP socket object created  \n using `net.createConnection`"
---@return nil
function imap.logout(socket) end
