---@meta

--=== file_lfs ===

---@class file_lfs : file
file_lfs = {}

---Lists all files in the file system. It works almost in the same way as `file.list()`
---@param pattern? string @(optional) only files matching the Lua pattern will be returned
---@param SPIFFS_only? any @"(optional) if not `nil` LFS files won't be included in the result  \n (LFS files are returned only if the parameter is `nil`)"
---@return table @a Lua table which contains all {file name: file size} pairs, if no pattern given.
---If a pattern is given, only those file names matching the pattern (interpreted as\
---a traditional [Lua pattern](https://www.lua.org/pil/20.2.html), not, say, a UNIX shell glob) will be included in the resulting\
---table. `file.list` will throw any errors encountered during pattern matching.
---@nodiscard
function file_lfs.list(pattern, SPIFFS_only) end

---Renames a file. If a file is currently open, it will be closed first.\
---It works almost in the same way as `file.rename()`
---@param oldname string @old file name
---@param newname string @new file name
---@return boolean @"`true` on success,  \n `false` when the file is stored in LFS (so read-only) or on error"
function file_lfs.rename(oldname, newname) end

---Opens a LFS file included in LFS in the `resource.lua` file. If it\
---cannot be found in LFS not standard `file.open()` function is called.\
---LFS file is opened only when "r" access is requested.
---@param filename string @file to be opened
---@param mode? string @(optional) r | w | a | r+ | w+ | a+
---  - "r": read mode (the default). If file of the same name is present\
---in SPIFFS then SPIFFS file is opened instead of LFS file.
---  - "w": write mode - as LFS file is read-only a SPIFFS file of the same\
---name is created and opened for writing.
---  - "r+", "w+", "a", "a+": as LFS file is read-only and all these modes\
---allow file updates the LFS file is copied to SPIFFS and then it is\
---opened with corresponding open mode.
---@return fileObj LFSfileobject @"LFS file object (Lua table) or SPIFFS file object  \n if file opened ok. `nil` if file not opened, or not exists (read modes)."
function file_lfs.open(filename, mode) end

--- Read content from the open file. It has the same parameters and returns values as\
---`file.read()` / `file.obj:read()`
---@param n_or_char? integer @(optional)
---  - if nothing passed in, then read up to `FILE_READ_CHUNK` bytes or the entire file (whichever is smaller).
---  - if passed a number `n`, then read up to `n` bytes or the entire file (whichever is smaller).
---  - if passed a string containing the single character `char`, then read until `char` appears next\
---in the file, `FILE_READ_CHUNK` bytes have been read, or EOF is reached.
---@return string|nil @File content as a string, or `nil` when EOF
---@nodiscard
function file_lfs.read(n_or_char) end

--- Read the next line from the open file. Lines are defined as zero or more bytes ending with a EOL ('\n') byte.\
---If the next line is longer than 1024, this function only returns the first 1024 bytes.\
--- It has the same parameters and return values as `file.readline()` / `file.obj:readline()`
---@return string @File content in string, line by line, including EOL('\n'). Return `nil` when EOF.
---@nodiscard
function file_lfs.readline() end

--- Sets and gets the file position, measured from the beginning of the file,\
---to the position given by offset plus a base specified by the string whence.\
--- It has the same parameters and return values as `file.seek()` / `file.obj:seek()`
---@param whence? string @(optional)
---  - "set": base is position 0 (beginning of the file)
---  - "cur": base is current position (default value)
---  - "end": base is end of file
---@param offset? integer @(optional) default 0
--- If no parameters are given, the function simply returns the current file offset.
---@return integer|nil @the resulting file position, or `nil` on error
function file_lfs.seek(whence, offset) end

---Get attribtues of a file or directory in a table.
---@param filename string @file name
---@return { size:number, name:string, time:table, is_dir:boolean, is_rdonly:boolean, is_hidden:boolean, is_sys:boolean, is_arch:boolean, is_LFS:boolean } @table containing file attributes. Elements of the table are:
--- - **size** file size in bytes
--- - **name** file name
--- - **time** table with time stamp information. Default is\
---1970-01-01 00:00:00 in case time stamps are not supported (on SPIFFS).
---   - `year` `mon` `day` `hour` `min` `sec`
--- - **is_dir** flag `true` if item is a directory, otherwise `false`
--- - **is_rdonly** flag `true` if item is read-only, otherwise `false`
--- - **is_hidden** flag `true` if item is hidden, otherwise `false`
--- - **is_sys** flag `true` if item is system, otherwise `false`
--- - **is_arch** flag `true` if item is archive, otherwise `false`
--- - **is_LFS** flag `true` if item is stored in LFS, otherwise it is not present \
---in the `file.stat()` result table - **the only difference to `file.stat()`**
---@nodiscard
function file_lfs.stat(filename) end
