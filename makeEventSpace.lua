function makeEventSpace()
    timers = {}
    hotkeys = {}

    function cleanup()
        for k, v in pairs(timers) do
            v.Destroy()
        end
        for k, v in pairs(hotkeys) do
            v.Destroy()
        end
    end

    function addHotkey(name, fn, hotkey1, hotkey2)
        hotkeys[name] = createHotkey(fn, hotkey1, hotkey2)
    end

    function addTimer(name, interval, fn)
        local timer = createTimer(nil, true)
        timer.OnTimer = fn
        timer.Interval = interval
        timers[name] = timer
        return timer
    end

    return {
        addHotkey = addHotkey,
        addTimer = addTimer,
        cleanup = cleanup
    }
end

return makeEventSpace