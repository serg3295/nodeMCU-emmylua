---@meta

--=== sodium ===

---@class sodium
sodium = {}

---@class sodium.random
sodium.random = {}

---@class sodium.crypto_box
sodium.crypto_box = {}

---Returns a random integer between\
---`0` and `0xFFFFFFFF` inclusive.
---@return integer @"A uniformly-distributed random  \n integer between 0 and 0xFFFFFFFF inclusive."
function sodium.random.random() end

---Returns a random integer 0 <= result < upper_bound
---@param upper_bound integer @must be an integer *<= 0xFFFFFFFF*.
---@return integer @An integer *>= 0* and *< upper_bound*
function sodium.random.uniform(upper_bound) end

---Generates *n* bytes of random data. Wifi must be started,\
---by calling `wifi.start()`, before calling this function.
---@param n number @number of bytes to return.
---@return string @A string of *n* random bytes.
function sodium.random.buf(n) end

---Generates a new keypair. Wifi must be started,\
---by calling `wifi.start()`, before calling this function.
---@return string public_key
---@return string secret_key
function sodium.crypto_box.keypair() end

---Encrypts a message using a public key.
---@param message string @the string to encrypt.
---@param public_key string @the public key to encrypt with.
---@return string|any @The encrypted message, as a string.
---Errors if public_key is not a valid public key as returned by\
---`sodium.crypto_box.keypair()` or if the message could not be encrypted.
function sodium.crypto_box.seal(message, public_key) end

---Decrypts a message encrypted with `crypto_box.seal()`.
---@param ciphertext any @the encrypted message.
---@param public_key string @the public key the message was encrypted with.
---@param secret_key string @the secret key corresponding to the specified public key.
---@return any|nil @The decrypted plain text of the message.
---Returns `nil` if the *ciphertext* could not be decrypted.
function sodium.crypto_box.seal_open(ciphertext, public_key, secret_key) end
