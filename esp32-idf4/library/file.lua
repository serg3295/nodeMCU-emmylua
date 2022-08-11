---@meta

--=== file ===

---@class file
file = {}

---@class fd
local fd = {}

---Determines whether the specified file exists.
---@param filename string @file to check
---@return boolean @"`true` if the file exists (even if 0 bytes in size),  \n and `false` if it does not exist"
function file.exists(filename) end

---Format the file system. Completely erases any\
---existing file system and writes a new one.
---@return nil
function file.format() end

---Return size information for the file system.\
---The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Lists all files in the file system.
---@param mountpoint? any @(optional) to list files in other file systems, the mountpoint can be given.
---@return table @"a lua table which contains the `{file name: file size}` pairs. For SPIFFS file systems  \n the size is returned in bytes, whereas for FAT file systems the size is given in kilobytes."
function file.list(mountpoint) end

---Opens a file for access, potentially creating it (for write modes).\
---When done with the file, it must be closed using `file.close()`.
---@param filename string @file to be opened, directories are not supported
---@param mode string @mode
---|>' "r"' #read mode
---| ' "w"' #write mode
---| ' "a"' #append mode
---| ' "r+"' #update mode, all previous data is preserved
---| ' "w+"' #update mode, all previous data is erased
---| ' "a+"' #append update mode, previous data is preserved, writing is only allowed at the end of file
---@return fd fileObj @file object if file opened ok. `nil` if file not opened, or not exists (read modes).
function file.open(filename, mode) end

---Remove a file from the file system.\
---The file must not be currently open.
---@param filename string @file to remove
---@return nil
function file.remove(filename) end

---Renames a file. If a file is currently open, it will be closed first.
---@param oldname string @old file name
---@param newname string @new file name
---@return boolean
function file.rename(oldname, newname) end
