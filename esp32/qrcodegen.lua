--=== qrcodegen ===

---@class qrcodegen
---@field LOW integer
---@field MEDIUM integer
---@field QUARTILE integer
---@field HIGH integer
qrcodegen = {}

---@class QRcodeCfg
---@field minver integer
---@field maxver integer
---@field ecl integer
---@field mask integer
---@field boostecl boolean

---Generates a QR Code from a text string.
---@param text any @The text or URL to encode. Should be UTF-8 or ASCII.
---@param options? QRcodeCfg @An optional table, containing any of:
--- - **minver** the minimum version according to the QR Code Model 2 standard.\
---If not specified, defaults to 1.
--- - **maxver** the maximum version according to the QR Code Model 2 standard.\
---If not specified, defaults to 40. Specifying a lower maximum version reduces\
---the amount of temporary memory the function requires, so it can be worthwhile\
---to specify a smaller value if you know the text will fit in a lower-version QR Code.
--- - **ecl** the error correction level in a QR Code symbol.\
---Higher error correction produces a larger QR Code. One of:
---   - qrcodegen.LOW (default if not specified)
---   - qrcodegen.MEDIUM
---   - qrcodegen.QUARTILE
---   - qrcodegen.HIGH
--- - **mask** the mask pattern used in a QR Code symbol. An integer 0-7,\
---or qrcodegen.AUTO (the default).
--- - **boostecl** defaults to false.
---@return string|nil @The QR Code, encoded as a string.
---Use `qrcodegen.getSize()` and `qrcodegen.getPixel()` to extract data from\
---the result. If the text cannot be represented within the given version\
---range (for example it is too long) then `nil` is returned.
function qrcodegen.encodeText(text, options) end

---@param qrcode string @a QR Code string, as returned by `qrcodegen.encodeText()`.
---@return integer @Returns the side length in pixels of the given QR Code.
---The result is in the range [21, 177].
function qrcodegen.getSize(qrcode) end

---Get the color of the pixel at the given coordinates of the QR Code.\
---`x` and `y` must be between 0 and the value returned by `qrcodegen.getSize()`.
---@param qrcode string @a QR Code string, as returned by `qrcodegen.encodeText()`.
---@param x number @coordinate
---@param y number @coordinate
---@return boolean @`true` if the given pixel is black, `false` if it is white.
function qrcodegen.getPixel(qrcode, x, y) end
