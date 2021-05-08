local __GLOBAL_NAMESPACE__ = _G
local getGlobalNamespace = function() return __GLOBAL_NAMESPACE__ end

setglobal("sudo", {})

local debugMode = false
-- Enable / Disable debug
sudo.setDebug = function(aBool)
  debugMode = aBool
end
-- Print if in Debug Mode
local _debug = function(m)
  if m == nil then return end
  if debugMode then print("sudo: " .. m) end
end

local isSure = {}
local areYouSure = function(aMsg, aCB)
  StaticPopupDialogs["SUDO_ARE_YOU_SURE?"] = {
    text = aMsg,
    button1 = "Approve",
    button2 = "Deny",
    OnAccept = function()
      isSure[aMsg] = true
      print("sudo: request sucessfuly approved"
      -- TODO
      -- print("sudo: Choice can be made permanent, see documentation for details")
      aCB()
    end,
    OnCancel = function() 
      print("sudo: request sucessfuly denied"
      -- TODO
      -- print("sudo: Choice can be made permanent, see documentation for details")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
  }
  if isSure[aMsg] == false then return end
  if isSure[aMsg] == true then
    aCB()
  else
    StaticPopup_Show("SUDO_ARE_YOU_SURE?")
  end
end

-- Restores the original global namespace within the local scope of the env
sudo.su = function(g)
  local tCallback = function()
    if g ~= nil then
      if g ~= getGlobalNamespace() then
        _debug("Restoring Global Namespace")
        g = getGlobalNamespace()
      end
    end
  end
  areYouSure("Remove WeakAura Safety Features for the Blizzard API: 'ALL THE THINGS'?", tCallback)
end

-- Restores specific api to 'global' namespace within local scop of the env
sudo.add = function(aAPI_Name, g)
  local tCallback = function()
    local tAPI = getGlobalNamespace()[aAPI_Name]
    if type(g) == 'table' then
      _debug("Restoring " .. aAPI_Name .. "to 'Global' Namespace")
      g[aAPI_Name] = tAPI
    end
  end
  if type(aAPI_Name) == 'string' then
    areYouSure("Remove WeakAura Safety Features for the Blizzard API: '" .. aAPI_Name .. "'?", tCallback)
  end
end