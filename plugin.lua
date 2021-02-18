---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return diff[]
function OnSetText(uri, text)
  local diffs = {}

  local subst = {
    ['[%w_]+%s*%=%s*ucg%.()[%w_]+_hw_spi()']         = 'ucgDisplayType',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_i2c_[%w_]+()']     = 'u8g2DisplayTypeI2C',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_[^i][%w_]+()']     = 'u8g2DisplayTypeSPI',
    ['()node%.LFS%.ftpserver[%(%s]+[%)]+()']         = 'FTP',
    ['()require[%(%s\"\']+ftpserver[%)\"\']+()']     = 'FTP',
    ['()require[%(%s\"\']+liquidcrystal[%)\"\']+()'] = 'lc_meta',
    ['()require[%(%s\"\']+mcp23017[%)\"\']+()']      = 'mcp23017',
    ['()require[%(%s\"\']+bme280[%)\"\']+()']        = 'bme280',
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

  for endPos in text:gmatch 'local%s+[%w_]+%s*=%s*mcp23017%s*%(.-%)()' do
    diffs[#diffs+1] = {
      start  = endPos,
      finish = endPos - 1,
      text   = (' ---@type mcp23017')
    }
  end

  return diffs

end
