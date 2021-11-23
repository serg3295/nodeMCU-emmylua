---@param  uri  string # The uri of file
---@param  text string # The content of file
---@diagnostic disable-next-line: undefined-doc-name
---@return diff[]
function OnSetText(uri, text)
  local diffs = {}

  local subst = {
    ['()require[%(%s\"\']+bh1750[%)\"\']+()']        = 'bh1750',
    ['()require[%(%s\"\']+bme280[%)\"\']+()']        = 'bme280',
    ['()require[%(%s\"\']+cohelper[%)\"\']+()']      = 'cohelper',
    ['()require[%(%s\"\']+ds18b20[%)\"\']+()']       = 'ds18b20',
    ['()require[%(%s\"\']+ds3231[%)\"\']+()']        = 'ds3231',
    ['()%(require[%(%s\"\']+fifo[%)\"\']+%)()']      = 'FIFO',
    ['()node%.LFS%.ftpserver[%(%s]+[%)]+()']         = 'FTP',
    ['()require[%(%s\"\']+ftpserver[%)\"\']+()']     = 'FTP',
    ['()require[%(%s\"\']+gossip[%)\"\']+()']        = 'gossip',
    ['()require[%(%s\"\']+HDC1000[%)\"\']+()']       = 'HDC1000',
    ['()require[%(%s\"\']+httpserver[%)\"\']+()']    = 'httpserver',
    ['()require[%(%s\"\']+imap[%)\"\']+()']          = 'imap',
    ['[%w_]+%s*%=%s*ucg%.()[%w_]+_hw_spi()']         = 'ucgDisplayType',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_i2c_[%w_]+()']     = 'u8g2DisplayTypeI2C',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_[^i][%w_]+()']     = 'u8g2DisplayTypeSPI',
    ['()require[%(%s\"\']+liquidcrystal[%)\"\']+()'] = 'lc_meta',
    ['()require[%(%s\"\']+lc%-i2c4bit[%)\"\']+()']   = 'i2c4bit_meta',
    ['()require[%(%s\"\']+lc%-gpio4bit[%)\"\']+()']  = 'gpio4bit_meta',
    ['()require[%(%s\"\']+lc%-gpio8bit[%)\"\']+()']  = 'gpio8bit_meta',
    ['()require[%(%s\"\']+lm92[%)\"\']+()']          = 'lm92',
    ['()require[%(%s\"\']+mcp23008[%)\"\']+()']      = 'mcp23008',
    ['()require[%(%s\"\']+mcp23017[%)\"\']+()']      = 'mcp23017',
    ['()node%.LFS%.telnet[%(%s]+[%)]+()']            = 'telnet',
    ['()require[%(%s\"\']+telnet[%)\"\']+()']        = 'telnet',
    ['()require[%(%s\"\']+yeelink_lib[%)\"\']+()']   = 'yeelink',
    ['()require[%(%s\"\']+file_lfs[%)\"\']+()']      = 'file_lfs',
  }

  for patt, txt in pairs(subst) do
    for startPos, finishPos in text:gmatch(patt) do
      diffs[#diffs+1] = {
        start  = startPos,
        finish = finishPos - 1,
        text   = ('%s'):format(txt),
      }
    end
  end

  if #diffs == 0 then
    return nil
  end

  return diffs

end
