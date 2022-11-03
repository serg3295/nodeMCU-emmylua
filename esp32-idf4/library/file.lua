---@meta

--=== file ===

---@class file
file = {}

---Determines whether the specified file exists.
---@param filename string @file to check
---@return boolean @"`true` if the file exists (even if 0 bytes in size),  \n and `false` if it does not exist"
function file.exists(filename) end

---Format the file system. Completely erases any\
---existing file system and writes a new one.\
---Function is not supported for SD cards.
---@return nil
function file.format() end

---Return size information for the file system, in bytes.\
---Function is not supported for SD cards.
---@return number remaining
---@return number used
---@return number total
---@nodiscard
function file.fsinfo() end

---Lists all files in the file system.
---@param mountpoint? any @(optional) to list files in other file systems, the mountpoint can be given.
---@return table @"a lua table which contains the `{file name: file size}` pairs. For SPIFFS file systems  \n the size is returned in bytes, whereas for FAT file systems the size is given in kilobytes."
---@nodiscard
function file.list(mountpoint) end

---Remove a file from the file system.\
---The file must not be currently open.
---@param filename string @file to remove
---@return nil
function file.remove(filename) end

---Renames a file. If a file is currently open, it will be closed first.
---@param oldname string @old file name
---@param newname string @new file name
---@return boolean @`true` on success, `false` on error.
function file.rename(oldname, newname) end
