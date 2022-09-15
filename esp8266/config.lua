name    = 'ESP8266'
words   = {'%-%-%-esp8266\r?\n', 'wifi%.sta%.status', 'wifi%.sta%.getip', 'gpio%.mode'}
configs = {
  {
    key    = 'Lua.runtime.version',
    action = 'set',
    value  = 'Lua 5.3',
  }
}

for _, name in ipairs{"math", "bit", "bit32", "utf8", "os", "io"} do
  configs[#configs+1] = {
    key    = 'Lua.runtime.builtin',
    action = 'prop',
    prop   = name,
    value  = 'disable',
  }
end

for _, name in ipairs {"FAST_ftp", "SPIFFS_ftp", "fast", "dataSrv"} do
  configs[#configs+1] = {
    key    = 'Lua.diagnostics.globals',
    action = 'add',
    value  = name,
  }
end
