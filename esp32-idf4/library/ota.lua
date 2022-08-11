---@meta

--=== ota ===

---@class otaupgrade
otaupgrade = {}

---The boot info and application state and version info can be queried with this function.
---@return string @the name of the partition of the running application
---@return string @the name of the partition currently marked for boot next
---@return { state:string, name:string, date:string, time:string, version:string, secure_version:string, idf_version:string } @"a table whose keys are the names of OTA partitions and  \n corresponding values are tables containing:"
--- - **state** one of *new, testing, valid, invalid, aborted* or possibly *undefined*
--- - **name** the application name, typically "NodeMCU"
--- - **date** the build date
--- - **time** the build time
--- - **version** the build version, as set by the *PROJECT_VER* variable during build
--- - **secure_version** the secure version number, if secure boot is enabled
--- - **idf_version** the IDF version
function otaupgrade.info() end

---Wipes the spare application partition and prepares to receive\
---the new application firmware.
---@return nil @`nil`.
---A Lua error may be raised if the OTA upgrade cannot be commenced\
---for some reason (such as due to incorrect partition setup).
function otaupgrade.commence() end

---Write a chunk of application firmware data to the correct partition\
---and location. Data must be streamed sequentially, the IDF does not \
---support out-of-order data as would be the case from e.g. bittorrent.
---@param data string @a string of binary data
---@return nil
---A Lua error may be raised if the data can not be written,\
---e.g. due to the data not being a valid OTA image\
---(the IDF performs some checks in this regard).
function otaupgrade.write(data) end

---Finalises the upgrade, and optionally reboots into the new application firmware right away.
---@param reboot integer|nil @`1` to reboot into the new firmware immediately, `nil` to keep running
---@return nil
---A Lua error may be raised if the image does not pass validation,\
---or no data has been written to the image at all.
function otaupgrade.complete(reboot) end

---When the installed boot loader is built with rollback support,\
---a new application image is by default only booted once.\
---During this "test run" it can perform whatever checks is appropriate\
---(like testing whether it can still reach the update server),\
---and if satisfied can mark itself as valid.\
---Without being marked valid, upon the next reboot the system\
---would "roll back" to the previous version instead.
---@return nil
function otaupgrade.accept() end

---A new firmware may decide that it is not performing as expected,\
---and request an explicit rollback to the previous version. If the call\
---to this function succeeds, the system will reboot without returning\
---from the call. Note that it is also possible to roll back to a previous\
---firmware version even after the new version has called\
---`otaupgrade.accept()`.
function otaupgrade.rollback() end
