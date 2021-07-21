--=== hmc5883l ===

---@class hmc5883l
hmc5883l = {}

---Samples the sensor and returns X,Y and Z data.
---@return integer x @measurements multiplied with 10
---@return integer y @measurements multiplied with 10
---@return integer z @measurements multiplied with 10
function hmc5883l.read() end

---Initializes the module.
---@return nil
function hmc5883l.setup() end
