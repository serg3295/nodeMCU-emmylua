--=== crypto ===

---@class crypto
crypto = {}

---Encrypts Lua strings.
---@param algo string @the name of a supported encryption algorithm to use
---@param key string @the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param plain string @the string to encrypt; it will be automatically zero-padded to a 16-byte boundary if necessary
---@param iv? any @(optional) the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any @The encrypted data as a binary string. For AES this is always a multiple of 16 bytes in length.
function crypto.encrypt(algo, key, plain , iv) end

---Decrypts previously encrypted data.
---@param algo string @the name of a supported encryption algorithm to use
---@param key string @the encryption key as a string; for AES encryption this MUST be 16 bytes long
---@param cipher any @the cipher text to decrypt (as obtained from `crypto.encrypt()`)
---@param iv? any @(optional) the initilization vector, if using AES-CBC; defaults to all-zero if not given
---@return any @The decrypted string.
function crypto.decrypt(algo, key, cipher , iv) end

---Compute a cryptographic hash of a a file.
---@param algo string @the hash algorithm to use, case insensitive string
---@param filename string @the path to the file to hash
---@return any @A binary string containing the message digest.
---To obtain the textual version (ASCII hex characters), please use `encoder.toHex()`.
function crypto.fhash(algo, filename)	end

---Compute a cryptographic hash of a Lua string.
---@param algo string @the hash algorithm to use, case insensitive string
---@param str string @to hash contents of
---@return any @A binary string containing the message digest.
---To obtain the textual version (ASCII hex characters), please use `encoder.toHex()`.
function crypto.hash(algo, str) end

---Create a digest/hash object that can have any number of strings.\
---Object has update and finalize functions.added to it.
---@param algo string @the hash algorithm to use, case insensitive string
---@return any @Userdata object with update and finalize functions available.
function crypto.new_hash(algo) end

---Compute a HMAC (Hashed Message Authentication Code) signature for a Lua string.
---@param algo string @hash algorithm to use, case insensitive string
---@param str string @data to calculate the hash for
---@param key any @key to use for signing, may be a binary string
---@return any @A binary string containing the HMAC signature.
---Use `encoder.toHex()` to obtain the textual version.
function crypto.hmac(algo, str, key) end

---Create a hmac object that can have any number of strings added to it.\
---Object has update and finalize functions.
---@param algo string @he hash algorithm to use, case insensitive string
---@param key any @the key to use (may be a binary string)
---@return any @Userdata object with `update` and `finalize` functions available.
function crypto.new_hmac(algo, key) end

---Applies an XOR mask to a Lua string.
---@param message any @message to mask
---@param mask any @the mask to apply, repeated if shorter than the message
---@return any @The masked message, as a binary string.
---Use `encoder.toHex()` to get a textual representation of it.
function crypto.mask(message, mask) end

---@deprecated
---See encoder.toHex
function crypto.toHex() end

---@deprecated
---See encoder.toBase64
function crypto.toBase64() end
