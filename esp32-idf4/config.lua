name    = 'ESP32-IDF4'
words   = {'%-%-%-esp32%-idf4\r?\n', 'eromfs%.%l+', 'heaptrace%.%l+', 'rmt%.%l+', 'wifi%.start', 'wifi%.sta%.on', 'wifi%.ap%.on', 'gpio%.config'}
configs = {
  {
    key    = 'Lua.runtime.version',
    action = 'set',
    value  = 'Lua 5.3',
  },
}

for _, name in ipairs{"math", "bit", "bit32", "utf8", "os"} do
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
