name    = 'ESP32'
words   = {'%-%-%-esp32\r?\n'}
configs = {
  {
    key    = 'Lua.runtime.version',
    action = 'set',
    value  = 'Lua 5.1',
  },
  {
    key    = 'Lua.runtime.builtin',
    action = 'prop',
    prop   = 'math',
    value  = 'disable',
  },
}
