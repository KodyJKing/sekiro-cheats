-- Boilerplate

timers = {}
hotkeys = {}

function onReload()
    for k, v in pairs(timers) do
        v.Destroy()
    end
    for k, v in pairs(hotkeys) do
        v.Destroy()
    end
end

function addHotkey(name, hotkey, fn)
    hotkeys[name] = createHotkey(fn, hotkey)
end

function addTimer(name, interval, fn)
    local timer = createTimer(nil, true)
    timer.OnTimer = fn
    timer.Interval = interval
    timers[name] = timer
    return timer
end

-- \Boilerplate

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

local savedPos = getPosition()

addHotkey("save", VK_NUMPAD0, function()
    speak("Save position.")
    savedPos =  getPosition()
end)

addHotkey("load", VK_NUMPAD1, function()
    speak("Load position.")
    setPosition(savedPos)
end)

speak("script reloaded")

return onReload