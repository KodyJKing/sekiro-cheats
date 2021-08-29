package.loaded.makeEventSpace = nil
local makeEventSpace = require("makeEventSpace")
local eventspace = makeEventSpace()

local addressList = getAddressList()

local playerXRecord = addressList.getMemoryRecordByDescription("playerX")
local playerYRecord = addressList.getMemoryRecordByDescription("playerY")
local playerZRecord = addressList.getMemoryRecordByDescription("playerZ")

function setPosition(v)
    playerXRecord.Value = v.x
    playerYRecord.Value = v.y
    playerZRecord.Value = v.z
end

function getPosition()
    return {
        x = playerXRecord.Value,
        y = playerYRecord.Value,
        z = playerZRecord.Value
    }
end

local savedPositions = {}
for i = 1, 9 do
    local iStr = tostring(i)
    local hkey = loadstring("return VK_NUMPAD" .. iStr)()
    savedPositions[i] = getPosition()
    eventspace.addHotkey("load" .. iStr, function()
        speak("position" .. iStr)
        setPosition(savedPositions[i])
    end, hkey, nil)
    eventspace.addHotkey("set" .. iStr, function()
        speak("set position" .. iStr)
        savedPositions[i] =  getPosition()
    end, VK_NUMPAD0, hkey)

end

speak("script reloaded")
return eventspace.cleanup