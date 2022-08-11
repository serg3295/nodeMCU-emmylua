---@meta

--=== eromfs ===

---@class eromfs
eromfs = {}

---Returns a list of the bundled file sets (volumes).
---@return table @An array with the names of the bundled volumes.
function eromfs.list() end

---Mounts a volume at a specified point in the virtual file system.\
---Note that it is technically possible to mount a volume multiple times on\
---different mount points. The benefit of doing so however is questionable.
---@param volname string @the name of the volume to mount, e.g. `myvol`.
---@param mountpt string @where to mount said volume. Must start with '/', e.g. `/myvol`.
---@return nil @"`nil` on success. Raises an error if the named volume cannot be found,  \nor cannot be mounted."
function eromfs.mount(volname, mountpt) end

---Unmounts the specified EROMFS volume from the given mount point.
---@param volname string @the name of the volume to mount.
---@param mountpt string @the current mount point of the volume.
---@return nil @`nil` if:
--- - the volume was successfully unmounted; or
--- - the volume was not currently mounted at the given mount point
---*Raises an error if:*
--- - the unmounting fails for some reason; or
--- - a different EROMFS volume is mounted on the given mount point
function eromfs.unmount(volname, mountpt) end
