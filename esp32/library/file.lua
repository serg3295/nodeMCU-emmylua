---@meta

--=== file ===

---@class file
file = {}

---@class fd
local fd = {}

---Change current directory (and drive). This will be used\
---when no drive/directory is prepended to filenames.
---@param dir string|"/FLASH"|"/SD0"|"/SD1" @directory name
---@return boolean
function file.chdir(dir) end

---Determines whether the specified file exists.
---@param filename string @file to check
---@return boolean @"`true` of the file exists (even if 0 bytes in size),  \n and `false` if it does not exist"
function file.exists(filename) end

---Format the file system. Completely erases any\
---existing file system and writes a new one.
---@return nil
function file.format() end

---Returns the flash address and physical\
---size of the file system area, in bytes.
---@return number flash_address
---@return number size
function file.fscfg() end

---Return size information for the file system.\
---The unit is Byte for SPIFFS and kByte for FatFS.
---@return number remaining
---@return number used
---@return number total
function file.fsinfo() end

---Lists all files in the file system.
---@return table @"a lua table which contains  \n the `{file name: file size}` pairs"
function file.list() end

---Registers callback functions.
---@param event string|"rtc" @"Trigger events are: **rtc** deliver current date & time to the file system.  \n Function is expected to return a table containing the fields **year, mon, day, hour, min, sec**  \n of current date and time. Not supported for internal flash."
---@param callback fun() @function. Unregisters the callback if function() is omitted.
---@return nil
function file.on(event, callback) end

---Opens a file for access, potentially creating it (for write modes).\
---When done with the file, it must be closed using `file.close()`.
---@param filename string @file to be opened, directories are not supported
---@param mode string @mode
---|> "r" #read mode
---|  "w" #write mode
---|  "a" #append mode
---|  "r+" #update mode, all previous data is preserved
---|  "w+" #update mode, all previous data is erased
---|  "a+" #append update mode, previous data is preserved, writing is only allowed at the end of file
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

---Closes the open file, if any.
---@return nil
function file.close() end

---Closes the open file, if any.
---@return nil
function fd:close() end

---Flushes any pending writes to the file system,\
---ensuring no data is lost on a restart. Closing\
---the open file using `file.close() / fd:close()`\
---performs an implicit flush as well.
---@return nil
function file.flush() end

---Flushes any pending writes to the file system,\
---ensuring no data is lost on a restart. Closing\
---the open file using `file.close() / fd:close()`\
---performs an implicit flush as well.
---@return nil
function fd:flush() end

---Read content from the open file.
---@param n_or_char? integer @(optional):
--- - if nothing passed in, then read up to FILE_READ_CHUNK bytes\
---or the entire file (whichever is smaller).
--- - if passed a number n, then read up to n bytes or the entire file\
---(whichever is smaller).
--- - if passed a string containing the single character `char`,\
---then read until char appears next in the file,\
---FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil @File content as a string, or `nil` when EOF
function file.read(n_or_char) end

---Read content from the open file.
---@param n_or_char? integer @(optional):
--- - if nothing passed in, then read up to FILE_READ_CHUNK bytes\
---or the entire file (whichever is smaller).
--- - if passed a number `n`, then read up to *n* bytes or the entire file\
---(whichever is smaller).
--- - if passed a string containing the single character `char`,\
---then read until char appears next in the file,\
---FILE_READ_CHUNK bytes have been read, or EOF is reached.
---@return string|nil @File content as a string, or `nil` when EOF
function fd:read(n_or_char) end

---Read the next line from the open file. Lines are defined as zero\
---or more bytes ending with a EOL ('\n') byte.
---@return string|nil @File content in string, line by line, including EOL('\n').
---Return `nil` when EOF.
function file.readline() end

---Read the next line from the open file. Lines are defined as zero\
---or more bytes ending with a EOL ('\n') byte.
---@return string|nil @File content in string, line by line, including EOL('\n').
---Return `nil` when EOF.
function fd:readline() end

---@alias seekwhence32_f string
---| "set" #Base is position 0 (beginning of the file)
---|>"cur" #Base is current position
---| "end" #Base is end of file

---Sets and gets the file position, measured from the beginning of the file,\
---to the position given by offset plus a base specified by the string whence.\
---If no parameters are given, the function simply returns the current file offset.
---@param whence? seekwhence32_f @(optional) 'set' | 'cur' | 'end'
---@param offset? integer @(optional) default 0
---@return integer @the resulting file position, or `nil` on error
function file.seek(whence, offset) end

---Sets and gets the file position, measured from the beginning of the file,\
---to the position given by offset plus a base specified by the string whence.\
---If no parameters are given, the function simply returns the current file offset.
---@param whence? seekwhence32_f @(optional) 'set' | 'cur' | 'end'
---@param offset? integer @(optional) default 0
---@return integer @the resulting file position, or `nil` on error
function fd:seek(whence, offset) end

---Write a string to the open file.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function file.write(str) end

---Write a string to the open file.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function fd:write(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function file.writeline(str) end

---Write a string to the open file and append '\n' at the end.
---@param str string @content to be write to file
---@return boolean|nil @`true` if write ok, `nil` on error
function fd:writeline(str) end
