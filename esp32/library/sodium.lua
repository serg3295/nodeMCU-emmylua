---@meta

--=== sodium ===

---@class sodium
sodium = {}

---@class sodium.random
sodium.random = {}

---@class sodium.crypto_box
sodium.crypto_box = {}

---Returns a random signed 32-bit integer between `INT32_MIN` and `INT32_MAX`. On builds with 64-bit integer support (`5.3-int64-xxx`), you can convert this to an unsigned 32-bit integer with `result % (1 << 32)`, or on builds with only 64-bit double support (`5.1-doublefp`, `5.3-int32-doublefp`), with `result % (2 ^ 32)`.\
---If WiFi is not started by calling `wifi.start()` before calling this function, then the result will only be pseudo-random, not truly random.
---@return integer @A uniformly-distributed random 32-bit integer.
---@nodiscard
function sodium.random.random() end

---Returns a random integer `0 <= result < upper_bound`. Unlike `sodium.random.random() % upper_bound`, it guarantees a uniform distribution of the possible output values even when `upper_bound` is not a power of 2. Specifying an `upper_bound > 0x7FFFFFFF` is not recommended because the behavior will vary depending on the Lua build configuration.\
---If WiFi is not started by calling `wifi.start()` before calling this function, then the result will only be pseudo-random, not truly random.
---@param upper_bound integer @an integer.
---@return integer @An integer *>= 0* and *< upper_bound*
---@nodiscard
function sodium.random.uniform(upper_bound) end

---Generates `n` bytes of random data. If WiFi is not started by calling `wifi.start()` before\
---calling this function, then the result will only be pseudo-random, not truly random.
---@param n number @number of bytes to return.
---@return string @A string of *n* random bytes.
---@nodiscard
function sodium.random.buf(n) end

---Generates a new keypair. Wifi must be started,\
---by calling `wifi.start()`, before calling this function.
---@return string public_key
---@return string secret_key
---@nodiscard
function sodium.crypto_box.keypair() end

---Encrypts a message using a public key.
---@param message string @the string to encrypt.
---@param public_key string @the public key to encrypt with.
---@return string|any @The encrypted message, as a string.
---Errors if public_key is not a valid public key as returned by\
---`sodium.crypto_box.keypair()` or if the message could not be encrypted.
---@nodiscard
function sodium.crypto_box.seal(message, public_key) end

---Decrypts a message encrypted with `crypto_box.seal()`.
---@param ciphertext any @the encrypted message.
---@param public_key string @the public key the message was encrypted with.
---@param secret_key string @the secret key corresponding to the specified public key.
---@return any|nil @The decrypted plain text of the message.
---Returns `nil` if the *ciphertext* could not be decrypted.
---@nodiscard
function sodium.crypto_box.seal_open(ciphertext, public_key, secret_key) end
