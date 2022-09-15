---@meta

--=== encoder ===

---@class encoder
encoder = {}

---Provides a Base64 representation of a (binary) Lua string.
---@param binary string @binary input string to Base64 encode
---@return string @A Base64 encoded string.
---@nodiscard
function encoder.toBase64(binary) end

---Decodes a Base64 representation of a (binary) Lua string\
---back into the original string. An error is thrown if the string\
---is not a valid base64 encoding.
---@param b64 string @Base64 encoded input string
---@return string @The decoded Lua (binary) string.
---@nodiscard
function encoder.fromBase64(b64) end

---Provides an ASCII hex representation of a (binary) Lua string. Each byte\
---in the input string is represented as two hex characters in the output.
---@param binary string @binary input string to get hex representation for
---@return string @An ASCII hex string.
---@nodiscard
function encoder.toHex(binary) end

---Returns the Lua binary string decode of a ASCII hex string. Each byte\
---in the output string is represented as two hex characters in the input.\
---An error is thrown if the string is not a valid base64 encoding.
---@param hexstr string @hexstr An ASCII hex string.
---@return string @Decoded string of hex representation.
---@nodiscard
function encoder.fromHex(hexstr) end
