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
---@return integer remaining
---@return integer used
---@return integer total
---@nodiscard
function file.fsinfo() end

---Lists all files in the file system.
---@param mountpoint? any @(optional) to list files in other file systems, the mountpoint can be given.
---@return table @"a lua table which contains the `{file name: file size}` pairs. For SPIFFS file systems  \n the size is returned in bytes, whereas for FAT file systems the size is given in kilobytes."
---@nodiscard
function file.list(mountpoint) end

---Creates a directory, provided the underlying file system supports directories.\
---SPIFFS does not, but FAT (which you may have on an attached SD card) does.
---@param path string @the full path name of the directory to create. E.g. "/SD0/MYDIR".
---@param mode? integer @(optional), only used for file systems which use mode permissions. Defaults to 0777 (octal).
---@return nil
---Throws an error if the directory could not be created. Error code 134 (at the time of writing)\
---indicates that the filesystem at the given path does not support directories.
function file.mkdir(path, mode) end

---Removes an empty directory, provided the underlying file system supports directories.\
---SPIFFS does not, but FAT (which you may have on an attached SD card) does.
---@param path string @the path to the directory to remove. The directory must be empty.
---@return nil
---Throws an error if the directory could not be removed.
function file.rmdir(path) end

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
