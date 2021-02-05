---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text)
  local diffs = {}

  for displTypePos, finish in text:gmatch '[%w_]+%s*%=%s*ucg%.()[%w_]+_hw_spi()' do
    diffs[#diffs+1] = {
        start  = displTypePos,
        finish = finish - 1,
        text   = ('ucgDisplayType'),
    }
  end

  for displTypePos, finish in text:gmatch '[%w_]+%s*%=%s*u8g2%.()[%w]+_i2c_[%w_]+()' do
    diffs[#diffs+1] = {
        start  = displTypePos,
        finish = finish - 1,
        text   = ('u8g2DisplayTypeI2C'),
    }
  end

  for displTypePos, finish in text:gmatch '[%w_]+%s*%=%s*u8g2%.()[%w]+_[^i][%w_]+()' do
    diffs[#diffs+1] = {
        start  = displTypePos,
        finish = finish - 1,
        text   = ('u8g2DisplayTypeSPI'),
    }
  end

   return diffs
end
