local addressList = getAddressList()
function breakpointCopy(description, instruction, runOnce, getAddr, check)
  if check == nil then
    check = function() return true end
  end
  local record = addressList.getMemoryRecordByDescription(description)
  debug_setBreakpoint(instruction, function()
    local address = getAddr()
    if not check() then return end
    if runOnce then debug_removeBreakpoint(instruction) end
    record.Address = address
    print("Copied address: " .. string.format("%x",address))
  end)
end

-- Useful for determining if a check identifies the right entities.
function breakLogInstances(instruction, getAddr, check)
  local visited = {}
  local count = 0
  debug_setBreakpoint(instruction, function()
    local address = getAddr()
    if not check() then return end
    local key = string.format("%x",address)
    if visited[key] == nil then
      visited[key] = true
      count = count + 1
      print("Found address: " .. key)
      print("Total instances found: " .. tostring(count))
    end
  end)
end

--[[
breakpointCopy("Sen", "sekiro.exe+66DA63", true,
  function() return RCX+0x7C end)
breakpointCopy("PlayerPtr", "sekiro.exe+BD5F84", true,
  function() return RBX end,
  function() return readInteger(RBX + 0x18) == 0 end)
]]--

--[[
breakLogInstances(
  "sekiro.exe+BD5F84",
  function() return RBX end,
  function(addr) return readInteger(RBX + 0x18) == 0 end
)
]]--