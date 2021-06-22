--=== crypto ===

---@class crypto
crypto = {}

---@class hashobj
local hashobj = {}

---for streaming data through the hash function
function hashobj:update(str) end

---for finalizing and returning the resulting signature
function hashobj:finalize() end

---@alias crypto_algo string|'"MD5"'|'"SHA1"'|'"RIPEMD160"'|'"SHA224"'|'"SHA256"'|'"SHA384"'|'"SHA512"'

---Create a digest/hash object that can have any number of strings\
---added to it. The returned object has `update(str)` and `finalize()`\
---functions, for streaming data through the hash function, and for \
---finalizing and returning the resulting digest.
---@param algo crypto_algo @the hash algorithm to use, case insensitive string
---@return hashobj @Hasher object with update and finalize functions available.
function crypto.new_hash(algo) end

---Create an object for calculating a HMAC (Hashed Message Authentication Code,\
---aka "signature"). A HMAC can be used to simultaneously verify both integrity\
---and authenticity of data. The returned object has `update(str)` and `finalize()`\
---functions, for streaming data through the hash function, and for finalizing\
---and returning the resulting signature.
---@param algo crypto_algo @the hash algorithm to use, case insensitive string
---@param key any @the signing key (may be a binary string)
---@return hashobj @Hasher object with update and finalize functions available.
function crypto.new_hmac(algo, key) end
