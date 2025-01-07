local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
L0_1 = GetCurrentResourceName
L0_1 = L0_1()
L1_1 = "Please read our documentation website ^1[https://docs.codesign.pro]^3 and make efforts to resolve issues yourself. Only contact the Codesign team as a last resort.^0"
L2_1 = nil
L3_1 = Config
if nil == L3_1 then
  L3_1 = print
  L4_1 = "^3["
  L5_1 = L0_1
  L6_1 = "] - Unable to start (Syntax error in Config.lua) - "
  L7_1 = L1_1
  L4_1 = L4_1 .. L5_1 .. L6_1 .. L7_1
  L3_1(L4_1)
  L2_1 = false
end
L3_1 = Locales
L4_1 = Config
L4_1 = L4_1.Language
L3_1 = L3_1[L4_1]
if nil == L3_1 then
  L3_1 = print
  L4_1 = "^3["
  L5_1 = L0_1
  L6_1 = "] - Unable to start (Config.Language/locales.lua typo) - "
  L7_1 = L1_1
  L4_1 = L4_1 .. L5_1 .. L6_1 .. L7_1
  L3_1(L4_1)
  L2_1 = false
end
if "cd_dispatch" ~= L0_1 then
  L3_1 = print
  L4_1 = "^3["
  L5_1 = L0_1
  L6_1 = "] - Unable to start (Resource name changed) - "
  L7_1 = L1_1
  L4_1 = L4_1 .. L5_1 .. L6_1 .. L7_1
  L3_1(L4_1)
  L2_1 = false
end
L3_1 = Config
L3_1 = L3_1.Database
if "mysql" ~= L3_1 then
  L3_1 = Config
  L3_1 = L3_1.Database
  if "ghmattimysql" ~= L3_1 then
    L3_1 = Config
    L3_1 = L3_1.Database
    if "oxmysql" ~= L3_1 then
      L3_1 = print
      L4_1 = "^3["
      L5_1 = L0_1
      L6_1 = "] - Unable to start (Config.Database typo) - "
      L7_1 = L1_1
      L4_1 = L4_1 .. L5_1 .. L6_1 .. L7_1
      L3_1(L4_1)
      L2_1 = false
    end
  end
end
L3_1 = Config
L3_1 = L3_1.Framework
if "esx" ~= L3_1 then
  L3_1 = Config
  L3_1 = L3_1.Framework
  if "qbcore" ~= L3_1 then
    L3_1 = Config
    L3_1 = L3_1.Framework
    if "other" ~= L3_1 then
      L3_1 = print
      L4_1 = "^3["
      L5_1 = L0_1
      L6_1 = "] - Unable to start (Config.Framework typo) - "
      L7_1 = L1_1
      L4_1 = L4_1 .. L5_1 .. L6_1 .. L7_1
      L3_1(L4_1)
      L2_1 = false
    end
  end
end
if nil == L2_1 then
  L2_1 = true
end
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = "Unknown"
  L1_2 = PerformHttpRequest
  L2_2 = "ip.codesign.pro/"
  function L3_2(A0_3, A1_3, A2_3)
    if 200 == A0_3 then
      L0_2 = A1_3
    end
  end
  L4_2 = "GET"
  L5_2 = ""
  L6_2 = {}
  L6_2["Content-Type"] = "application/json"
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = 0
  while "Unknown" == L0_2 and L1_2 <= 5 do
    L2_2 = Wait
    L3_2 = 1000
    L2_2(L3_2)
    L1_2 = L1_2 + 1
  end
  return L0_2
end
L4_1 = Citizen
L4_1 = L4_1.CreateThread
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = Citizen
  L0_2 = L0_2.Wait
  L1_2 = 5000
  L0_2(L1_2)
  L0_2 = string
  L0_2 = L0_2.format
  L1_2 = [[
Resourcename: **%s**
Servername: **%s**
 IP: **%s**
 Version: **%s**]]
  L2_2 = L0_1
  L3_2 = GetConvar
  L4_2 = "sv_hostname"
  L3_2 = L3_2(L4_2)
  L4_2 = L3_1
  L4_2 = L4_2()
  L5_2 = GetResourceMetadata
  L6_2 = L0_1
  L7_2 = "version"
  L8_2 = 0
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L1_2 = PerformHttpRequest
  L2_2 = "https://discord.com/api/webhooks/903028275239092314/sTNnibE2GhnTCwMpVQSqhNGy-In0vZ-cyV8xH-VXIzFZHOBBxb3uy3nTeJs9Oom858Kf"
  function L3_2(A0_3, A1_3, A2_3)
  end
  L4_2 = "POST"
  L5_2 = json
  L5_2 = L5_2.encode
  L6_2 = {}
  L6_2.content = L0_2
  L5_2 = L5_2(L6_2)
  L6_2 = {}
  L6_2["Content-Type"] = "application/json"
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L4_1(L5_1)
L4_1 = Citizen
L4_1 = L4_1.CreateThread
function L5_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = 0
  while true do
    L1_2 = L2_1
    if not (nil == L1_2 and L0_2 <= 100) then
      break
    end
    L1_2 = Wait
    L2_2 = 1000
    L1_2(L2_2)
    L0_2 = L0_2 + 1
  end
  L1_2 = L2_1
  if true == L1_2 then
    Authorised = true
    L1_2 = RegisterServerEvent
    L2_2 = "cd_dispatch:SpeedtrapLocations"
    L1_2(L2_2)
    L1_2 = AddEventHandler
    L2_2 = "cd_dispatch:SpeedtrapLocations"
    function L3_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = TriggerClientEvent
      L1_3 = "cd_dispatch:PoliceiconColour"
      L2_3 = source
      L3_3 = 21654
      L0_3(L1_3, L2_3, L3_3)
    end
    L1_2(L2_2, L3_2)
    L1_2 = Citizen
    L1_2 = L1_2.Wait
    L2_2 = 5000
    L1_2(L2_2)
    L1_2 = TriggerClientEvent
    L2_2 = "cd_dispatch:ScriptRestarted"
    L3_2 = -1
    L1_2(L2_2, L3_2)
  end
end
L4_1(L5_1)
L4_1 = {}
self = L4_1
L4_1 = {}
DispatcherData = L4_1
L4_1 = DispatcherData
L4_1.active = false
L4_1 = DispatcherData
L4_1.count = 0
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = #A0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = A0_2[L5_2]
    L7_2 = Config
    L7_2 = L7_2.UsingOneSync
    if L7_2 then
      L7_2 = GetEntityCoords
      L8_2 = GetPlayerPed
      L9_2 = L6_2.source
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
      L8_2 = self
      L9_2 = L6_2.source
      L8_2 = L8_2[L9_2]
      L9_2 = {}
      L10_2 = L7_2.x
      L9_2.x = L10_2
      L10_2 = L7_2.y
      L9_2.y = L10_2
      L8_2.coords = L9_2
    end
    L7_2 = "blue"
    L8_2 = Config
    L8_2 = L8_2.BlipData
    L9_2 = self
    L10_2 = L6_2.source
    L9_2 = L9_2[L10_2]
    L9_2 = L9_2.job
    L8_2 = L8_2[L9_2]
    if L8_2 then
      L8_2 = Config
      L8_2 = L8_2.BlipData
      L9_2 = self
      L10_2 = L6_2.source
      L9_2 = L9_2[L10_2]
      L9_2 = L9_2.job
      L8_2 = L8_2[L9_2]
      L8_2 = L8_2.largeui_blip_colour
      if L8_2 then
        L8_2 = Config
        L8_2 = L8_2.BlipData
        L9_2 = self
        L10_2 = L6_2.source
        L9_2 = L9_2[L10_2]
        L9_2 = L9_2.job
        L8_2 = L8_2[L9_2]
        L7_2 = L8_2.largeui_blip_colour
      end
    end
    L8_2 = #L1_2
    L8_2 = L8_2 + 1
    L9_2 = {}
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.source
    L9_2.id = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.char_name
    L9_2.name = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.callsign
    L9_2.callsign = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.radio_channel
    L9_2.channel = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.vehicle
    L9_2.vehicle = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.group
    L9_2.group = L10_2
    L9_2.blipcolour = L7_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.coords
    L9_2.coords = L10_2
    L10_2 = self
    L11_2 = L6_2.source
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.status
    L9_2.status = L10_2
    L1_2[L8_2] = L9_2
  end
  return L1_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = Config
  L1_2 = L1_2.Dispatcher
  L1_2 = L1_2.ENABLE
  if L1_2 then
    L1_2 = DispatcherData
    L1_2 = L1_2.active
    if L1_2 then
      L1_2 = {}
      L2_2 = CheckMultiJobs
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L3_2 = pairs
      L4_2 = self
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = pairs
        L10_2 = L2_2
        L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
        for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
          L15_2 = L8_2.job
          if L15_2 == L14_2 then
            L15_2 = L8_2.on_duty
            if L15_2 then
              L15_2 = #L1_2
              L15_2 = L15_2 + 1
              L1_2[L15_2] = L8_2
              break
            end
          end
        end
      end
      L3_2 = L4_1
      L4_2 = L1_2
      L3_2 = L3_2(L4_2)
      L4_2 = 1
      L5_2 = #L1_2
      L6_2 = 1
      for L7_2 = L4_2, L5_2, L6_2 do
        L8_2 = TriggerClientEvent
        L9_2 = "cd_dispatch:RefreshLargeUI"
        L10_2 = L1_2[L7_2]
        L10_2 = L10_2.source
        L11_2 = A0_2
        L12_2 = L3_2
        L8_2(L9_2, L10_2, L11_2, L12_2)
      end
    end
  end
end
RefreshLargeUI = L5_1
L5_1 = RegisterServerEvent
L6_1 = "cd_dispatch:LargeUIData"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "cd_dispatch:LargeUIData"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "string"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = {}
    L3_2 = {}
    L4_2 = CheckMultiJobs
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = pairs
    L6_2 = self
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = pairs
      L12_2 = L4_2
      L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
      for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
        L17_2 = L10_2.job
        if L17_2 == L16_2 then
          L17_2 = L10_2.on_duty
          if L17_2 then
            L17_2 = #L3_2
            L17_2 = L17_2 + 1
            L3_2[L17_2] = L10_2
            break
          end
        end
      end
    end
    L5_2 = Config
    L5_2 = L5_2.UsingOneSync
    if L5_2 then
      L5_2 = L4_1
      L6_2 = L3_2
      L5_2 = L5_2(L6_2)
      L2_2 = L5_2
    else
      L5_2 = 1
      L6_2 = #L3_2
      L7_2 = 1
      for L8_2 = L5_2, L6_2, L7_2 do
        L9_2 = TriggerClientEvent
        L10_2 = "cd_dispatch:GetNonOnesyncCoords"
        L11_2 = L3_2[L8_2]
        L11_2 = L11_2.source
        L9_2(L10_2, L11_2)
      end
      L5_2 = Wait
      L6_2 = 1000
      L5_2(L6_2)
      L5_2 = L4_1
      L6_2 = L3_2
      L5_2 = L5_2(L6_2)
      L2_2 = L5_2
    end
    L5_2 = 1
    L6_2 = #L3_2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = TriggerClientEvent
      L10_2 = "cd_dispatch:Callback"
      L11_2 = L3_2[L8_2]
      L11_2 = L11_2.source
      L12_2 = L2_2
      L13_2 = A1_2
      L9_2(L10_2, L11_2, L12_2, L13_2)
    end
  else
    L2_2 = E
    L3_2 = "3334"
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1)
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = #A0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = A0_2[L5_2]
    if L6_2 then
      L7_2 = GetPlayerName
      L8_2 = L6_2.source
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = Config
        L7_2 = L7_2.UsingOneSync
        if L7_2 then
          L7_2 = GetEntityCoords
          L8_2 = GetPlayerPed
          L9_2 = L6_2.source
          L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
          L8_2 = #L1_2
          L8_2 = L8_2 + 1
          L9_2 = {}
          L10_2 = self
          L11_2 = L6_2.source
          L10_2 = L10_2[L11_2]
          L10_2 = L10_2.char_name
          L9_2.char_name = L10_2
          L10_2 = L7_2.x
          L9_2.x = L10_2
          L10_2 = L7_2.y
          L9_2.y = L10_2
          L1_2[L8_2] = L9_2
        else
          L7_2 = #L1_2
          L7_2 = L7_2 + 1
          L8_2 = {}
          L9_2 = self
          L10_2 = L6_2.source
          L9_2 = L9_2[L10_2]
          L9_2 = L9_2.char_name
          L8_2.char_name = L9_2
          L9_2 = self
          L10_2 = L6_2.source
          L9_2 = L9_2[L10_2]
          L9_2 = L9_2.coords
          L9_2 = L9_2.x
          L8_2.x = L9_2
          L9_2 = self
          L10_2 = L6_2.source
          L9_2 = L9_2[L10_2]
          L9_2 = L9_2.coords
          L9_2 = L9_2.y
          L8_2.y = L9_2
          L1_2[L7_2] = L8_2
        end
      end
    end
  end
  return L1_2
end
L6_1 = RegisterServerEvent
L7_1 = "cd_dispatch:GetCoords"
L6_1(L7_1)
L6_1 = AddEventHandler
L7_1 = "cd_dispatch:GetCoords"
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "string"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = {}
    L3_2 = CheckMultiJobs
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = pairs
    L5_2 = self
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = pairs
      L11_2 = L3_2
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        L16_2 = L9_2.job
        if L16_2 == L15_2 then
          L16_2 = L9_2.on_duty
          if L16_2 then
            L16_2 = #L2_2
            L16_2 = L16_2 + 1
            L2_2[L16_2] = L9_2
            break
          end
        end
      end
    end
    L4_2 = Config
    L4_2 = L4_2.UsingOneSync
    if not L4_2 then
      L4_2 = 1
      L5_2 = #L2_2
      L6_2 = 1
      for L7_2 = L4_2, L5_2, L6_2 do
        L8_2 = TriggerClientEvent
        L9_2 = "cd_dispatch:GetNonOnesyncCoords"
        L10_2 = L2_2[L7_2]
        L10_2 = L10_2.source
        L8_2(L9_2, L10_2)
      end
      L4_2 = Wait
      L5_2 = 1000
      L4_2(L5_2)
    end
    L4_2 = 1
    L5_2 = #L2_2
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = TriggerClientEvent
      L9_2 = "cd_dispatch:Callback"
      L10_2 = L2_2[L7_2]
      L10_2 = L10_2.source
      L11_2 = L5_1
      L12_2 = L2_2
      L11_2 = L11_2(L12_2)
      L12_2 = A1_2
      L8_2(L9_2, L10_2, L11_2, L12_2)
    end
  else
    L2_2 = E
    L3_2 = "4777"
    L2_2(L3_2)
  end
end
L6_1(L7_1, L8_1)
L6_1 = RegisterServerEvent
L7_1 = "cd_dispatch:GetNonOnesyncCoords"
L6_1(L7_1)
L6_1 = AddEventHandler
L7_1 = "cd_dispatch:GetNonOnesyncCoords"
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = source
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "vector3"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = self
    L2_2 = L2_2[L1_2]
    if L2_2 then
      L2_2 = self
      L2_2 = L2_2[L1_2]
      L3_2 = {}
      L4_2 = A0_2.x
      L3_2.x = L4_2
      L4_2 = A0_2.y
      L3_2.y = L4_2
      L2_2.coords = L3_2
    else
      L2_2 = E
      L3_2 = "6844"
      L2_2(L3_2)
    end
  end
end
L6_1(L7_1, L8_1)
L6_1 = {}
L7_1 = RegisterServerEvent
L8_1 = "cd_dispatch:PlayerBlips:emergancylights"
L7_1(L8_1)
L7_1 = AddEventHandler
L8_1 = "cd_dispatch:PlayerBlips:emergancylights"
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = source
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "boolean"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = L6_1
    L2_2 = L2_2[L1_2]
    L2_2.flashing_blip = A0_2
    L2_2 = PlayerBlipsActions
    L3_2 = L1_2
    L4_2 = "update"
    L2_2(L3_2, L4_2)
  else
    L2_2 = E
    L3_2 = "7784"
    L2_2(L3_2)
  end
end
L7_1(L8_1, L9_1)
L7_1 = {}
L8_1 = Citizen
L8_1 = L8_1.CreateThread
function L9_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = Config
  L0_2 = L0_2.PauseMenuBlips
  L0_2 = L0_2.ENABLE
  if not L0_2 then
    return
  end
  while true do
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = Config
    L1_2 = L1_2.PauseMenuBlips
    L1_2 = L1_2.data_update_timer
    L1_2 = L1_2 * 1000
    L0_2(L1_2)
    L0_2 = L6_1
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.UsingOneSync
      if L0_2 then
        L0_2 = pairs
        L1_2 = L6_1
        L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
        for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
          L7_2 = L5_2.source
          L6_2 = L6_1
          L6_2 = L6_2[L7_2]
          L7_2 = GetEntityCoords
          L8_2 = GetPlayerPed
          L9_2 = L5_2.source
          L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
          L6_2.coords = L7_2
        end
      end
      L0_2 = pairs
      L1_2 = L6_1
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = TriggerClientEvent
        L7_2 = "cd_dispatch:PlayerBlips_update"
        L8_2 = L5_2.source
        L9_2 = L5_2.source
        L10_2 = L6_1
        L11_2 = L7_1
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
        L6_2 = {}
        L7_1 = L6_2
      end
    end
  end
end
L8_1(L9_1)
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = Config
  L2_2 = L2_2.PauseMenuBlips
  L2_2 = L2_2.ENABLE
  if not L2_2 then
    return
  end
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "number"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = T
    L3_2 = A1_2
    L4_2 = "string"
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = self
      if L2_2 then
        L2_2 = self
        L2_2 = L2_2[A0_2]
        if L2_2 then
          if "update" == A1_2 then
            L2_2 = CheckMultiJobs
            L3_2 = self
            L3_2 = L3_2[A0_2]
            L3_2 = L3_2.job
            L2_2 = L2_2(L3_2)
            if L2_2 then
              L3_2 = self
              L3_2 = L3_2[A0_2]
              L3_2 = L3_2.on_duty
              if L3_2 then
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                if not L3_2 then
                  L3_2 = L6_1
                  L4_2 = {}
                  L3_2[A0_2] = L4_2
                end
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                L4_2 = {}
                L5_2 = 0
                L6_2 = 0
                L4_2[1] = L5_2
                L4_2[2] = L6_2
                L3_2.blip_colour = L4_2
                L3_2 = Config
                L3_2 = L3_2.BlipData
                if L3_2 then
                  L3_2 = Config
                  L3_2 = L3_2.BlipData
                  L4_2 = self
                  L4_2 = L4_2[A0_2]
                  L4_2 = L4_2.job
                  L3_2 = L3_2[L4_2]
                  if L3_2 then
                    L3_2 = Config
                    L3_2 = L3_2.BlipData
                    L4_2 = self
                    L4_2 = L4_2[A0_2]
                    L4_2 = L4_2.job
                    L3_2 = L3_2[L4_2]
                    L3_2 = L3_2.pausemenu_blip_colour
                    if L3_2 then
                      L3_2 = L6_1
                      L3_2 = L3_2[A0_2]
                      L4_2 = Config
                      L4_2 = L4_2.BlipData
                      L5_2 = self
                      L5_2 = L5_2[A0_2]
                      L5_2 = L5_2.job
                      L4_2 = L4_2[L5_2]
                      L4_2 = L4_2.pausemenu_blip_colour
                      L3_2.blip_colour = L4_2
                    end
                  end
                end
                L3_2 = Config
                L3_2 = L3_2.PauseMenuBlips
                L3_2 = L3_2.blip_type
                if "dynamic" == L3_2 then
                  L3_2 = self
                  L3_2 = L3_2[A0_2]
                  L3_2 = L3_2.vehicle
                  if L3_2 then
                    L3_2 = L6_1
                    L3_2 = L3_2[A0_2]
                    L4_2 = Config
                    L4_2 = L4_2.PauseMenuBlips
                    L4_2 = L4_2.blip_sprites
                    L5_2 = self
                    L5_2 = L5_2[A0_2]
                    L5_2 = L5_2.vehicle
                    L4_2 = L4_2[L5_2]
                    L3_2.blip_sprite = L4_2
                end
                else
                  L3_2 = L6_1
                  L3_2 = L3_2[A0_2]
                  L4_2 = Config
                  L4_2 = L4_2.PauseMenuBlips
                  L4_2 = L4_2.blip_sprites
                  L4_2 = L4_2.static
                  L3_2.blip_sprite = L4_2
                end
                L3_2 = Config
                L3_2 = L3_2.PauseMenuBlips
                L3_2 = L3_2.radiochannel_on_blips
                if L3_2 then
                  L3_2 = L6_1
                  L3_2 = L3_2[A0_2]
                  L4_2 = self
                  L4_2 = L4_2[A0_2]
                  L4_2 = L4_2.radio_channel
                  if not L4_2 then
                    L4_2 = 0
                  end
                  L3_2.radio_channel = L4_2
                end
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                L4_2 = L
                L5_2 = "playerblip"
                L6_2 = self
                L6_2 = L6_2[A0_2]
                L6_2 = L6_2.callsign
                L7_2 = self
                L7_2 = L7_2[A0_2]
                L7_2 = L7_2.char_name
                L4_2 = L4_2(L5_2, L6_2, L7_2)
                L3_2.name = L4_2
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                L4_2 = self
                L4_2 = L4_2[A0_2]
                L4_2 = L4_2.job
                L3_2.job = L4_2
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                L3_2.job_table = L2_2
                L3_2 = L6_1
                L3_2 = L3_2[A0_2]
                L3_2.source = A0_2
            end
            else
              L3_2 = L6_1
              L3_2 = L3_2[A0_2]
              if not L3_2 then
                return
              end
              L3_2 = L6_1
              L3_2[A0_2] = nil
              L3_2 = table
              L3_2 = L3_2.insert
              L4_2 = L7_1
              L5_2 = A0_2
              L3_2(L4_2, L5_2)
              L3_2 = TriggerClientEvent
              L4_2 = "cd_dispatch:PlayerBlips_disable"
              L5_2 = A0_2
              L3_2(L4_2, L5_2)
            end
          elseif "remove" == A1_2 then
            L2_2 = L6_1
            L2_2 = L2_2[A0_2]
            if not L2_2 then
              return
            end
            L2_2 = L6_1
            L2_2[A0_2] = nil
            L2_2 = table
            L2_2 = L2_2.insert
            L3_2 = L7_1
            L4_2 = A0_2
            L2_2(L3_2, L4_2)
            L2_2 = TriggerClientEvent
            L3_2 = "cd_dispatch:PlayerBlips_disable"
            L4_2 = A0_2
            L2_2(L3_2, L4_2)
          end
      end
      else
        L2_2 = E
        L3_2 = "4855"
        L2_2(L3_2)
      end
  end
  else
    L2_2 = E
    L3_2 = "6656"
    L2_2(L3_2)
  end
end
PlayerBlipsActions = L8_1
L8_1 = RegisterServerEvent
L9_1 = "cd_dispatch:PlayerResponding"
L8_1(L9_1)
L8_1 = AddEventHandler
L9_1 = "cd_dispatch:PlayerResponding"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = pairs
  L2_2 = self
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = pairs
    L8_2 = A0_2.job_table
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L6_2.job
      if L13_2 == L12_2 then
        L13_2 = TriggerClientEvent
        L14_2 = "cd_dispatch:PlayerResponding"
        L15_2 = L6_2.source
        L16_2 = A0_2
        L13_2(L14_2, L15_2, L16_2)
      end
    end
  end
end
L8_1(L9_1, L10_1)
L8_1 = RegisterServerEvent
L9_1 = "cd_dispatch:SaveUserSettings"
L8_1(L9_1)
L8_1 = AddEventHandler
L9_1 = "cd_dispatch:SaveUserSettings"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = source
  L2_2 = self
  if L2_2 then
    L2_2 = self
    L2_2 = L2_2[L1_2]
    if L2_2 then
      L2_2 = A0_2.status
      if L2_2 then
        L2_2 = A0_2.status
        L3_2 = self
        L3_2 = L3_2[L1_2]
        L3_2 = L3_2.status
        if L2_2 ~= L3_2 then
          L2_2 = self
          L2_2 = L2_2[L1_2]
          L3_2 = A0_2.status
          L2_2.status = L3_2
        end
      end
      L2_2 = A0_2.callsign
      if L2_2 then
        L2_2 = A0_2.callsign
        L3_2 = self
        L3_2 = L3_2[L1_2]
        L3_2 = L3_2.callsign
        if L2_2 ~= L3_2 then
          L2_2 = self
          L2_2 = L2_2[L1_2]
          L3_2 = A0_2.callsign
          L2_2.callsign = L3_2
          L2_2 = Checks
          L3_2 = "set_callsign"
          L4_2 = L1_2
          L5_2 = A0_2.callsign
          L2_2(L3_2, L4_2, L5_2)
          L2_2 = PlayerBlipsActions
          L3_2 = L1_2
          L4_2 = "update"
          L2_2(L3_2, L4_2)
        end
      end
      L2_2 = A0_2.vehicle
      if L2_2 then
        L2_2 = A0_2.vehicle
        L3_2 = self
        L3_2 = L3_2[L1_2]
        L3_2 = L3_2.vehicle
        if L2_2 ~= L3_2 then
          L2_2 = self
          L2_2 = L2_2[L1_2]
          L3_2 = A0_2.vehicle
          L2_2.vehicle = L3_2
          L2_2 = PlayerBlipsActions
          L3_2 = L1_2
          L4_2 = "update"
          L2_2(L3_2, L4_2)
        end
      end
      L2_2 = CheckMultiJobs
      L3_2 = self
      L3_2 = L3_2[L1_2]
      L3_2 = L3_2.job
      L2_2 = L2_2(L3_2)
      L3_2 = T
      L4_2 = L2_2
      L5_2 = "table"
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = pairs
        L4_2 = self
        L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
        for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
          L9_2 = pairs
          L10_2 = L2_2
          L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
          for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
            L15_2 = L8_2.job
            if L15_2 == L14_2 then
              L15_2 = L8_2.on_duty
              if L15_2 then
                L15_2 = TriggerClientEvent
                L16_2 = "cd_dispatch:SyncUserSettings"
                L17_2 = L8_2.source
                L18_2 = {}
                L18_2.source = L1_2
                L19_2 = self
                L19_2 = L19_2[L1_2]
                L19_2 = L19_2.status
                L18_2.status = L19_2
                L19_2 = self
                L19_2 = L19_2[L1_2]
                L19_2 = L19_2.callsign
                L18_2.callsign = L19_2
                L19_2 = self
                L19_2 = L19_2[L1_2]
                L19_2 = L19_2.vehicle
                L18_2.vehicle = L19_2
                L15_2(L16_2, L17_2, L18_2)
                break
              end
            end
          end
        end
      else
        L3_2 = E
        L4_2 = "7841"
        L3_2(L4_2)
      end
  end
  else
    L2_2 = E
    L3_2 = "1454"
    L2_2(L3_2)
  end
end
L8_1(L9_1, L10_1)
L8_1 = RegisterServerEvent
L9_1 = "cd_dispatch:Dispatcher_AddCall"
L8_1(L9_1)
L8_1 = AddEventHandler
L9_1 = "cd_dispatch:Dispatcher_AddCall"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = vector3
  L2_2 = A0_2.coords
  L2_2 = L2_2.x
  L3_2 = A0_2.coords
  L3_2 = L3_2.y
  L4_2 = A0_2.coords
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  A0_2.coords = L1_2
  L1_2 = TriggerClientEvent
  L2_2 = "cd_dispatch:AddNotification"
  L3_2 = A0_2.source
  L4_2 = A0_2
  L5_2 = true
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = RegisterServerEvent
L9_1 = "cd_dispatch:DispatcherToggle"
L8_1(L9_1)
L8_1 = AddEventHandler
L9_1 = "cd_dispatch:DispatcherToggle"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = source
  L3_2 = T
  L4_2 = A0_2
  L5_2 = "boolean"
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = T
    L4_2 = A1_2
    L5_2 = "string"
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = type
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if "number" == L3_2 then
        L3_2 = self
        L3_2 = L3_2[L2_2]
        L3_2.dispatcher = A0_2
      end
      if A0_2 then
        L3_2 = DispatcherData
        L4_2 = DispatcherData
        L4_2 = L4_2.count
        L4_2 = L4_2 + 1
        L3_2.count = L4_2
        L3_2 = DispatcherData
        L3_2.active = true
      else
        L3_2 = DispatcherData
        L4_2 = DispatcherData
        L4_2 = L4_2.count
        L4_2 = L4_2 - 1
        L3_2.count = L4_2
        L3_2 = DispatcherData
        L3_2 = L3_2.count
        if L3_2 <= 0 then
          L3_2 = DispatcherData
          L3_2.count = 0
          L3_2 = DispatcherData
          L3_2.active = false
        end
      end
      L3_2 = CheckMultiJobs
      L4_2 = A1_2
      L3_2 = L3_2(L4_2)
      L4_2 = pairs
      L5_2 = self
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        L10_2 = pairs
        L11_2 = L3_2
        L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
        for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
          L16_2 = L9_2.job
          if L16_2 == L15_2 then
            L16_2 = L9_2.on_duty
            if L16_2 then
              L16_2 = TriggerClientEvent
              L17_2 = "cd_dispatch:DispatcherToggle"
              L18_2 = L9_2.source
              L19_2 = DispatcherData
              L19_2 = L19_2.active
              L16_2(L17_2, L18_2, L19_2)
              break
            end
          end
        end
      end
  end
  else
    L3_2 = E
    L4_2 = "1145"
    L3_2(L4_2)
  end
end
L8_1(L9_1, L10_1)
L8_1 = RegisterServerEvent
L9_1 = "cd_dispatch:SetGPS"
L8_1(L9_1)
L8_1 = AddEventHandler
L9_1 = "cd_dispatch:SetGPS"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = TriggerClientEvent
  L2_2 = "cd_dispatch:SetGPS"
  L3_2 = source
  L4_2 = GetEntityCoords
  L5_2 = GetPlayerPed
  L6_2 = A0_2
  L5_2, L6_2 = L5_2(L6_2)
  L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L8_1(L9_1, L10_1)
L8_1 = {}
L9_1 = RegisterServerEvent
L10_1 = "cd_dispatch:UpdateGroups"
L9_1(L10_1)
L9_1 = AddEventHandler
L10_1 = "cd_dispatch:UpdateGroups"
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = source
  L2_2 = nil
  L3_2 = 1
  L4_2 = Config
  L4_2 = L4_2.AllowedJobs
  L4_2 = #L4_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = Config
    L7_2 = L7_2.AllowedJobs
    L7_2 = L7_2[L6_2]
    if L7_2 then
      L7_2 = pairs
      L8_2 = Config
      L8_2 = L8_2.AllowedJobs
      L8_2 = L8_2[L6_2]
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = A0_2.job
        if L12_2 == L13_2 then
          L13_2 = L8_1
          L13_2 = L13_2[L6_2]
          if not L13_2 then
            L13_2 = L8_1
            L14_2 = {}
            L13_2[L6_2] = L14_2
          end
          L13_2 = L8_1
          L14_2 = A0_2.groups
          L13_2[L6_2] = L14_2
          L2_2 = L6_2
          break
        end
      end
    else
      L7_2 = E
      L8_2 = "4114"
      L7_2(L8_2)
    end
  end
  A0_2.job = nil
  L3_2 = L8_1
  L3_2 = L3_2[L2_2]
  if L3_2 then
    L3_2 = A0_2.sources
    if L3_2 then
      L3_2 = pairs
      L4_2 = A0_2.sources
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = TriggerClientEvent
        L10_2 = "cd_dispatch:UpdateGroups"
        L11_2 = L8_2
        L12_2 = A0_2
        L9_2(L10_2, L11_2, L12_2)
      end
      L2_2 = nil
    end
  end
end
L9_1(L10_1, L11_1)
function L9_1(A0_2, A1_2, A2_2, ...)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = T
  L4_2 = A0_2
  L5_2 = "number"
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = T
    L4_2 = A1_2
    L5_2 = "number"
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = T
      L4_2 = A2_2
      L5_2 = "string"
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = Locales
        L4_2 = Config
        L4_2 = L4_2.Language
        L3_2 = L3_2[L4_2]
        if L3_2 then
          L3_2 = Locales
          L4_2 = Config
          L4_2 = L4_2.Language
          L3_2 = L3_2[L4_2]
          L3_2 = L3_2[A2_2]
          if L3_2 then
            L3_2 = string
            L3_2 = L3_2.format
            L4_2 = Locales
            L5_2 = Config
            L5_2 = L5_2.Language
            L4_2 = L4_2[L5_2]
            L4_2 = L4_2[A2_2]
            L5_2, L6_2 = ...
            L3_2 = L3_2(L4_2, L5_2, L6_2)
            L4_2 = xpcall
            function L5_2()
              local L0_3, L1_3, L2_3, L3_3
              L0_3 = Notification
              L1_3 = A0_2
              L2_3 = A1_2
              L3_3 = L3_2
              L0_3(L1_3, L2_3, L3_3)
            end
            L6_2 = E2
            L4_2 = L4_2(L5_2, L6_2)
            if not L4_2 then
              L4_2 = E
              L5_2 = "6584 ^"
              L4_2(L5_2)
            end
        end
        else
          L3_2 = E
          L4_2 = "0063"
          L3_2(L4_2)
        end
    end
  end
  else
    L3_2 = E
    L4_2 = "0132"
    L3_2(L4_2)
  end
end
Notif = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = print
  L2_2 = "^1["
  L3_2 = L0_1
  L4_2 = "] [error_code-"
  L5_2 = A0_2
  L6_2 = "] - ^3"
  L7_2 = L1_1
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2
  L1_2(L2_2)
end
E = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = print
  L2_2 = "^1[Codesign ErrorHandler] - "
  L3_2 = A0_2
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
end
E2 = L9_1
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 == A1_2 then
    L3_2 = true
    return L3_2
  else
    L3_2 = E2
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "%s expected, got %s : %s"
    L6_2 = A1_2
    L7_2 = L2_2
    L8_2 = A0_2
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = false
    return L3_2
  end
end
T = L9_1
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  if nil == A1_2 then
    L2_2 = {}
    A1_2 = L2_2
  end
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "string"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = true
    L3_2 = nil
    L4_2 = Config
    L4_2 = L4_2.Database
    if "mysql" == L4_2 then
      L4_2 = xpcall
      function L5_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = MySQL
        L0_3 = L0_3.Async
        L0_3 = L0_3.fetchAll
        L1_3 = A0_2
        L2_3 = A1_2
        function L3_3(A0_4)
          local L1_4
          L3_2 = A0_4
          L1_4 = false
          L2_2 = L1_4
        end
        L0_3(L1_3, L2_3, L3_3)
      end
      L6_2 = E2
      L4_2 = L4_2(L5_2, L6_2)
      if not L4_2 then
        L4_2 = E
        L5_2 = "99999999 ^"
        L4_2(L5_2)
      end
      L4_2 = 0
      while L2_2 and L4_2 <= 50 do
        L5_2 = Citizen
        L5_2 = L5_2.Wait
        L6_2 = 0
        L5_2(L6_2)
        L4_2 = L4_2 + 1
      end
    else
      L4_2 = Config
      L4_2 = L4_2.Database
      if "ghmattimysql" == L4_2 then
        L4_2 = xpcall
        function L5_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3
          L0_3 = exports
          L0_3 = L0_3.ghmattimysql
          L1_3 = L0_3
          L0_3 = L0_3.execute
          L2_3 = A0_2
          L3_3 = A1_2
          function L4_3(A0_4)
            local L1_4
            L3_2 = A0_4
            L1_4 = false
            L2_2 = L1_4
          end
          L0_3(L1_3, L2_3, L3_3, L4_3)
        end
        L6_2 = E2
        L4_2 = L4_2(L5_2, L6_2)
        if not L4_2 then
          L4_2 = E
          L5_2 = "99998888 ^"
          L4_2(L5_2)
        end
        L4_2 = 0
        while L2_2 and L4_2 <= 50 do
          L5_2 = Citizen
          L5_2 = L5_2.Wait
          L6_2 = 0
          L5_2(L6_2)
          L4_2 = L4_2 + 1
        end
      else
        L4_2 = Config
        L4_2 = L4_2.Database
        if "oxmysql" == L4_2 then
          L4_2 = xpcall
          function L5_2()
            local L0_3, L1_3, L2_3, L3_3
            L0_3 = MySQL
            L0_3 = L0_3.Async
            L0_3 = L0_3.fetchAll
            L1_3 = A0_2
            L2_3 = A1_2
            function L3_3(A0_4)
              local L1_4
              L3_2 = A0_4
              L1_4 = false
              L2_2 = L1_4
            end
            L0_3(L1_3, L2_3, L3_3)
          end
          L6_2 = E2
          L4_2 = L4_2(L5_2, L6_2)
          if not L4_2 then
            L4_2 = E
            L5_2 = "99997777 ^"
            L4_2(L5_2)
          end
          L4_2 = 0
          while L2_2 and L4_2 <= 50 do
            L5_2 = Citizen
            L5_2 = L5_2.Wait
            L6_2 = 0
            L5_2(L6_2)
            L4_2 = L4_2 + 1
          end
        end
      end
    end
    return L3_2
  else
    L2_2 = E
    L3_2 = "5465474878"
    L2_2(L3_2)
  end
end
DatabaseQuery = L9_1
function L9_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2
  if "set_callsign" == A0_2 then
    L4_2 = xpcall
    function L5_2()
      local L0_3, L1_3, L2_3
      L0_3 = SetCallsign
      L1_3 = A1_2
      L2_3 = A2_2
      L0_3(L1_3, L2_3)
    end
    L6_2 = E2
    L4_2 = L4_2(L5_2, L6_2)
    if not L4_2 then
      L4_2 = E
      L5_2 = "5554 ^"
      L4_2(L5_2)
    end
  end
end
Checks = L9_1
