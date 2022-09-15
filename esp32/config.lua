name    = 'ESP32'
words   = {'%-%-%-esp32\r?\n'}
configs = {
  {
    key    = 'Lua.runtime.version',
    action = 'set',
    value  = 'Lua 5.1',
  },
}

for _, name in ipairs{"math", "bit", "bit32", "utf8", "os", "io"} do
  configs[#configs+1] = {
    key    = 'Lua.runtime.builtin',
    action = 'prop',
    prop   = name,
    value  = 'disable',
  }
end
