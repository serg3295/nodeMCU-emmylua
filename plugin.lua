---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return diff[]
function OnSetText(uri, text)
  local diffs = {}

  local subst = {
    ['[%w_]+%s*%=%s*ucg%.()[%w_]+_hw_spi()']         = 'ucgDisplayType',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_i2c_[%w_]+()']     = 'u8g2DisplayTypeI2C',
    ['[%w_]+%s*%=%s*u8g2%.()[%w]+_[^i][%w_]+()']     = 'u8g2DisplayTypeSPI',
    ['()require[%(%s\"\']+ftpserver[%)\"\']+()']     = 'FTP',
    ['()require[%(%s\"\']+liquidcrystal[%)\"\']+()'] = 'lc_meta',
    ['()require[%(%s\"\']+mcp23017[%)\"\']+()']      = 'mcp23017',
  }

  for patt, _ in pairs(subst) do
    for startPos, finishPos in text:gmatch(patt) do
      diffs[#diffs+1] = {
        start  = startPos,
        finish = finishPos - 1,
        text   = ('%s'):format(subst[patt]),
      }
    end
  end

  return diffs

end
