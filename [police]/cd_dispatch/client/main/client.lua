local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1
Authorised = false
L0_1 = false
L1_1 = false
L2_1 = Citizen
L2_1 = L2_1.CreateThread
function L3_1()
  local L0_2, L1_2, L2_2
  L0_2 = SetNuiFocus
  L1_2 = false
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = Citizen
  L0_2 = L0_2.Wait
  L1_2 = 1000
  L0_2(L1_2)
  while true do
    L0_2 = L0_1
    if false ~= L0_2 then
      break
    end
    L0_2 = TriggerServerEvent
    L1_2 = "cd_dispatch:SpeedtrapLocations"
    L0_2(L1_2)
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 1000
    L0_2(L1_2)
  end
end
L2_1(L3_1)
L2_1 = RegisterNetEvent
L3_1 = "cd_dispatch:PoliceiconColour"
L2_1(L3_1)
L2_1 = AddEventHandler
L3_1 = "cd_dispatch:PoliceiconColour"
function L4_1(A0_2)
  local L1_2, L2_2
  L1_2 = L0_1
  if L1_2 then
    return
  end
  if nil ~= A0_2 then
    L1_2 = type
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if "number" == L1_2 then
      L1_2 = A0_2 - 8952
      if 12702 == L1_2 then
        L1_2 = true
        L0_1 = L1_2
        L1_2 = SendNUIMessage
        L2_2 = {}
        L2_2.mapdayhours = 845
        L1_2(L2_2)
        L1_2 = Citizen
        L1_2 = L1_2.Wait
        L2_2 = 1000
        L1_2(L2_2)
        while true do
          L1_2 = L1_1
          if false ~= L1_2 then
            break
          end
          L1_2 = Wait
          L2_2 = 1000
          L1_2(L2_2)
          L1_2 = SendNUIMessage
          L2_2 = {}
          L2_2.mapdayhours = 845
          L1_2(L2_2)
        end
        L1_2 = nil
        L0_1 = L1_2
      end
    end
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNUICallback
L3_1 = "dispatcheroffline"
function L4_1()
  local L0_2, L1_2
  L0_2 = true
  L1_1 = L0_2
  Authorised = true
  L0_2 = print
  L1_2 = "Loaded Successfully!"
  L0_2(L1_2)
end
L2_1(L3_1, L4_1)
Authorised = L1_1
L2_1 = {}
L3_1 = 0
L4_1 = {}
L2_1[L3_1] = L4_1
L4_1 = false
L5_1 = {}
L6_1 = false
NUI_status = false
L7_1 = {}
SourceInfo = L7_1
L7_1 = {}
L8_1 = 0
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L8_1
  L2_2 = L2_2 + 1
  L8_1 = L2_2
  if "update_ui_blips" == A1_2 then
    L2_2 = TriggerServerEvent
    L3_2 = "cd_dispatch:GetCoords"
    L4_2 = A0_2
    L5_2 = L8_1
    L2_2(L3_2, L4_2, L5_2)
  elseif "large_ui_data" == A1_2 then
    L2_2 = TriggerServerEvent
    L3_2 = "cd_dispatch:LargeUIData"
    L4_2 = A0_2
    L5_2 = L8_1
    L2_2(L3_2, L4_2, L5_2)
  elseif "check_vehicle_owner" == A1_2 then
    L2_2 = TriggerServerEvent
    L3_2 = "cd_dispatch:CheckVehicleOwner"
    L4_2 = A0_2
    L5_2 = L8_1
    L2_2(L3_2, L4_2, L5_2)
  end
  while true do
    L3_2 = L8_1
    L2_2 = L7_1
    L2_2 = L2_2[L3_2]
    if nil ~= L2_2 then
      break
    end
    L2_2 = Citizen
    L2_2 = L2_2.Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  L3_2 = L8_1
  L2_2 = L7_1
  L2_2 = L2_2[L3_2]
  return L2_2
end
Callback = L9_1
L9_1 = RegisterNetEvent
L10_1 = "cd_dispatch:Callback"
L9_1(L10_1)
L9_1 = AddEventHandler
L10_1 = "cd_dispatch:Callback"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L7_1
  L2_2[A1_2] = A0_2
  L2_2 = Citizen
  L2_2 = L2_2.Wait
  L3_2 = 5000
  L2_2(L3_2)
  L2_2 = L7_1
  L2_2[A1_2] = nil
end
L9_1(L10_1, L11_1)
function L9_1()
  local L0_2, L1_2
  L0_2 = SourceInfo
  L0_2 = L0_2.char_name
  if L0_2 then
    L0_2 = SourceInfo
    L0_2 = L0_2.callsign
    if L0_2 then
      L0_2 = true
      return L0_2
  end
  else
    L0_2 = false
    return L0_2
  end
end
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:KEY_smallui"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:KEY_smallui"
function L12_1()
  local L0_2, L1_2, L2_2
  L0_2 = Checks
  L1_2 = "is_allowed"
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L5_1.small
    if not L0_2 then
      L0_2 = L9_1
      L0_2 = L0_2()
      if L0_2 then
        L0_2 = ShowSmallUI
        L0_2()
        return
      else
        L0_2 = Notif
        L1_2 = 2
        L2_2 = "still_loading"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L0_2 = HideSmallUI
  L0_2()
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:KEY_largeui"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:KEY_largeui"
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = Checks
  L1_2 = "is_allowed"
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L5_1.large
    if not L0_2 then
      L0_2 = L9_1
      L0_2 = L0_2()
      if L0_2 then
        L5_1.large = true
        L0_2 = TabletAnimation
        L1_2 = true
        L0_2(L1_2)
        L0_2 = L5_1.small
        if L0_2 then
          L0_2 = HideSmallUI
          L0_2()
        end
        L0_2 = Checks
        L1_2 = "get_job"
        L0_2 = L0_2(L1_2)
        L1_2 = T
        L2_2 = L0_2
        L3_2 = "string"
        L1_2 = L1_2(L2_2, L3_2)
        if L1_2 then
          L1_2 = SendNUIMessage
          L2_2 = {}
          L2_2.action = "loading"
          L1_2(L2_2)
          L1_2 = SendNUIMessage
          L2_2 = {}
          L2_2.action = "showlarge_ui"
          L2_2.job = L0_2
          L3_2 = Callback
          L4_2 = L0_2
          L5_2 = "large_ui_data"
          L3_2 = L3_2(L4_2, L5_2)
          L2_2.large_uidata = L3_2
          L3_2 = GetTime
          L3_2 = L3_2()
          L2_2.mode = L3_2
          L1_2(L2_2)
          L1_2 = Checks
          L2_2 = "enable_nui"
          L1_2(L2_2)
          L1_2 = Config
          L1_2 = L1_2.Dispatcher
          L1_2 = L1_2.ENABLE
          if L1_2 then
            L1_2 = Config
            L1_2 = L1_2.Dispatcher
            L1_2 = L1_2.AutoRefreshBlips
            L1_2 = L1_2.ENABLE
            if L1_2 then
              L1_2 = false
              L2_2 = Checks
              L3_2 = "is_dispatcher"
              L2_2 = L2_2(L3_2)
              L3_2 = T
              L4_2 = L2_2
              L5_2 = "boolean"
              L3_2 = L3_2(L4_2, L5_2)
              if L3_2 then
                if L2_2 then
                  L1_2 = true
                end
              else
                L3_2 = E
                L4_2 = "6887"
                L3_2(L4_2)
              end
              if L1_2 then
                while true do
                  L3_2 = L5_1.large
                  if not L3_2 then
                    break
                  end
                  L3_2 = Citizen
                  L3_2 = L3_2.Wait
                  L4_2 = Config
                  L4_2 = L4_2.Dispatcher
                  L4_2 = L4_2.AutoRefreshBlips
                  L4_2 = L4_2.refresh_timer
                  L4_2 = L4_2 * 1000
                  L3_2(L4_2)
                  L3_2 = SendNUIMessage
                  L4_2 = {}
                  L4_2.action = "updatecoords"
                  L5_2 = Callback
                  L6_2 = L0_2
                  L7_2 = "update_ui_blips"
                  L5_2 = L5_2(L6_2, L7_2)
                  L4_2.coords = L5_2
                  L3_2(L4_2)
                end
              end
            end
          end
        else
          L1_2 = E
          L2_2 = "6584"
          L1_2(L2_2)
        end
      else
        L0_2 = Notif
        L1_2 = 2
        L2_2 = "still_loading"
        L0_2(L1_2, L2_2)
      end
    end
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:KEY_responding"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:KEY_responding"
function L12_1()
  local L0_2, L1_2, L2_2
  L0_2 = Checks
  L1_2 = "is_allowed"
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L5_1.small
    if L0_2 then
      L0_2 = L2_1
      if L0_2 then
        L0_2 = L2_1
        L0_2 = #L0_2
        if L0_2 > 0 then
          L1_2 = L3_1
          L0_2 = L2_1
          L0_2 = L0_2[L1_2]
          if L0_2 then
            L1_2 = L3_1
            L0_2 = L2_1
            L0_2 = L0_2[L1_2]
            L0_2 = L0_2.coords
            if nil ~= L0_2 then
              L1_2 = L3_1
              L0_2 = L2_1
              L0_2 = L0_2[L1_2]
              L0_2 = L0_2.responding_state
              if not L0_2 then
                L0_2 = L4_1
                if not L0_2 then
                  L0_2 = true
                  L4_1 = L0_2
                  L0_2 = TriggerEvent
                  L1_2 = "cd_dispatch:StopSpammings"
                  L0_2(L1_2)
                  L0_2 = Responding
                  L1_2 = L3_1
                  L2_2 = "add"
                  L0_2(L1_2, L2_2)
                else
                  L0_2 = Notif
                  L1_2 = 3
                  L2_2 = "cooldown"
                  L0_2(L1_2, L2_2)
                end
              else
                L0_2 = L4_1
                if not L0_2 then
                  L0_2 = true
                  L4_1 = L0_2
                  L0_2 = TriggerEvent
                  L1_2 = "cd_dispatch:StopSpammings"
                  L0_2(L1_2)
                  L0_2 = Responding
                  L1_2 = L3_1
                  L2_2 = "remove"
                  L0_2(L1_2, L2_2)
                else
                  L0_2 = Notif
                  L1_2 = 3
                  L2_2 = "cooldown"
                  L0_2(L1_2, L2_2)
                end
              end
            else
              L0_2 = E
              L1_2 = "2987"
              L0_2(L1_2)
            end
          end
        end
      end
    end
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:RefreshLargeUI"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:RefreshLargeUI"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L5_1.large
  if L2_2 then
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "showlarge_ui"
    L3_2.job = A0_2
    L3_2.large_uidata = A1_2
    L4_2 = GetTime
    L4_2 = L4_2()
    L3_2.mode = L4_2
    L2_2(L3_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:EnableMoveMode"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:EnableMoveMode"
function L12_1()
  local L0_2, L1_2
  L0_2 = Checks
  L1_2 = "is_allowed"
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L5_1.small
    if L0_2 then
      L0_2 = Checks
      L1_2 = "enable_nui"
      L0_2(L1_2)
      L0_2 = SendNUIMessage
      L1_2 = {}
      L1_2.action = "movemode"
      L0_2(L1_2)
    end
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:SendSourceData"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:SendSourceData"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = T
  L3_2 = A0_2
  L4_2 = "table"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = T
    L3_2 = A1_2
    L4_2 = "boolean"
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = SourceInfo
      L3_2 = A0_2.char_name
      L2_2.char_name = L3_2
      L2_2 = SourceInfo
      L3_2 = A0_2.callsign
      L2_2.callsign = L3_2
      L2_2 = SourceInfo
      L3_2 = A0_2.phone_number
      L2_2.phone_number = L3_2
      L2_2 = Config
      L2_2 = L2_2.Dispatcher
      L2_2 = L2_2.ENABLE
      if L2_2 then
        L2_2 = SourceInfo
        L3_2 = Checks
        L4_2 = "is_dispatcher"
        L3_2 = L3_2(L4_2)
        L2_2.dispatcher = L3_2
      else
        L2_2 = SourceInfo
        L2_2.dispatcher = false
      end
      L6_1 = A1_2
      L2_2 = SourceInfo
      L3_2 = A0_2.job
      L2_2.job = L3_2
      L2_2 = SourceInfo
      L3_2 = A0_2.source
      L2_2.source = L3_2
      L2_2 = SendNUIMessage
      L3_2 = {}
      L3_2.action = "currentplayer"
      L4_2 = SourceInfo
      L3_2.values = L4_2
      L2_2(L3_2)
      L2_2 = SourceInfo
      L2_2.dispatcher = nil
      L2_2 = SourceInfo
      L2_2.job = nil
  end
  else
    L2_2 = E
    L3_2 = "8751"
    L2_2(L3_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = Config
L10_1 = L10_1.UpdateDistanceUI
L10_1 = L10_1.ENABLE
if L10_1 then
  L10_1 = Citizen
  L10_1 = L10_1.CreateThread
  function L11_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = Config
      L1_2 = L1_2.UpdateDistanceUI
      L1_2 = L1_2.timer
      L1_2 = L1_2 * 1000
      L0_2(L1_2)
      L0_2 = {}
      L1_2 = 1
      L2_2 = ipairs
      L3_2 = L2_1
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = {}
        L0_2[L1_2] = L8_2
        L8_2 = L0_2[L1_2]
        L9_2 = L7_2.unique_id
        L8_2.unique_id = L9_2
        L8_2 = L0_2[L1_2]
        L9_2 = math
        L9_2 = L9_2.ceil
        L10_2 = vector3
        L11_2 = L7_2.coords
        L11_2 = L11_2.x
        L12_2 = L7_2.coords
        L12_2 = L12_2.y
        L13_2 = L7_2.coords
        L13_2 = L13_2.z
        L10_2 = L10_2(L11_2, L12_2, L13_2)
        L11_2 = GetEntityCoords
        L12_2 = PlayerPedId
        L12_2, L13_2 = L12_2()
        L11_2 = L11_2(L12_2, L13_2)
        L10_2 = L10_2 - L11_2
        L10_2 = #L10_2
        L9_2 = L9_2(L10_2)
        L8_2.distance = L9_2
        L1_2 = L1_2 + 1
      end
      L2_2 = #L0_2
      if L2_2 > 0 then
        L2_2 = SendNUIMessage
        L3_2 = {}
        L3_2.action = "updatedistance"
        L3_2.values = L0_2
        L2_2(L3_2)
      end
    end
  end
  L10_1(L11_1)
end
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:AddNotification"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:AddNotification"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = L2_1
  if L2_2 then
    L2_2 = T
    L3_2 = A0_2
    L4_2 = "table"
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = A0_2.unique_id
      if not L2_2 then
        L2_2 = E
        L3_2 = "3777"
        L2_2(L3_2)
        return
      end
      L2_2 = type
      L3_2 = A0_2.job
      L2_2 = L2_2(L3_2)
      if "string" ~= L2_2 then
        L2_2 = type
        L3_2 = A0_2.job_table
        L2_2 = L2_2(L3_2)
        if "string" ~= L2_2 then
          goto lbl_35
        end
      end
      L2_2 = {}
      A0_2.job_table = L2_2
      L2_2 = table
      L2_2 = L2_2.insert
      L3_2 = A0_2.job_table
      L4_2 = A0_2.job
      L2_2(L3_2, L4_2)
      ::lbl_35::
      L2_2 = Checks
      L3_2 = "check_job"
      L4_2 = A0_2.job_table
      L2_2 = L2_2(L3_2, L4_2)
      L3_2 = T
      L4_2 = L2_2
      L5_2 = "boolean"
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        if L2_2 then
          L3_2 = L6_1
          if L3_2 then
            L3_2 = SourceInfo
            L3_2 = L3_2.dispatcher
          end
          if L3_2 or A1_2 then
            L3_2 = L5_1.small
            if not L3_2 then
              L3_2 = L5_1.large
              if not L3_2 then
                L3_2 = ShowSmallUI
                L3_2()
              end
            end
            L3_2 = SourceInfo
            L3_2 = L3_2.dispatcher
            if L3_2 and A1_2 then
              return
            end
            L3_2 = L3_1
            L3_2 = L3_2 + 1
            L3_1 = L3_2
            L3_2 = L3_1
            L4_2 = L2_1
            L5_2 = {}
            L4_2[L3_2] = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L4_2.count = L3_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = A0_2.job_table
            L4_2.job_table = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L4_2.responding = 0
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L4_2.responding_state = false
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = {}
            L6_2 = RoundDec
            L7_2 = A0_2.coords
            L7_2 = L7_2.x
            L6_2 = L6_2(L7_2)
            L5_2.x = L6_2
            L6_2 = RoundDec
            L7_2 = A0_2.coords
            L7_2 = L7_2.y
            L6_2 = L6_2(L7_2)
            L5_2.y = L6_2
            L6_2 = RoundDec
            L7_2 = A0_2.coords
            L7_2 = L7_2.z
            L6_2 = L6_2(L7_2)
            L5_2.z = L6_2
            L4_2.coords = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = A0_2.title
            L4_2.title = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = A0_2.message
            L4_2.message = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = A0_2.flash
            L4_2.flash = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = A0_2.unique_id
            L4_2.unique_id = L5_2
            L4_2 = L2_1
            L4_2 = L4_2[L3_2]
            L5_2 = math
            L5_2 = L5_2.ceil
            L6_2 = vector3
            L7_2 = A0_2.coords
            L7_2 = L7_2.x
            L8_2 = A0_2.coords
            L8_2 = L8_2.y
            L9_2 = A0_2.coords
            L9_2 = L9_2.z
            L6_2 = L6_2(L7_2, L8_2, L9_2)
            L7_2 = GetEntityCoords
            L8_2 = PlayerPedId
            L8_2, L9_2 = L8_2()
            L7_2 = L7_2(L8_2, L9_2)
            L6_2 = L6_2 - L7_2
            L6_2 = #L6_2
            L5_2 = L5_2(L6_2)
            L4_2.distance = L5_2
            L4_2 = L6_1
            if L4_2 and A1_2 then
              L4_2 = Responding
              L5_2 = L3_2
              L6_2 = "add"
              L4_2(L5_2, L6_2)
            end
            L4_2 = SendNUIMessage
            L5_2 = {}
            L5_2.action = "AddNotification"
            L5_2.count = L3_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.job
            L5_2.job = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.responding
            L5_2.responding = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.flash
            L5_2.flash = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.coords
            L5_2.coords = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.title
            L5_2.title = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.message
            L5_2.message = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.unique_id
            L5_2.unique_id = L6_2
            L6_2 = L2_1
            L6_2 = L6_2[L3_2]
            L6_2 = L6_2.distance
            L5_2.distance = L6_2
            L5_2.dispatcher_table = A0_2
            L4_2(L5_2)
            L4_2 = A0_2.blip
            if L4_2 then
              L4_2 = Checks
              L5_2 = "blip_sound"
              L6_2 = A0_2.blip
              L6_2 = L6_2.sound
              L4_2(L5_2, L6_2)
              L4_2 = AddBlipForCoord
              L5_2 = A0_2.coords
              L5_2 = L5_2.x
              L6_2 = A0_2.coords
              L6_2 = L6_2.y
              L7_2 = A0_2.coords
              L7_2 = L7_2.z
              L4_2 = L4_2(L5_2, L6_2, L7_2)
              L5_2 = L2_1
              L5_2 = L5_2[L3_2]
              L5_2.blip = L4_2
              L3_2 = nil
              L5_2 = SetBlipSprite
              L6_2 = L4_2
              L7_2 = A0_2.blip
              L7_2 = L7_2.sprite
              L5_2(L6_2, L7_2)
              L5_2 = SetBlipScale
              L6_2 = L4_2
              L7_2 = A0_2.blip
              L7_2 = L7_2.scale
              L5_2(L6_2, L7_2)
              L5_2 = SetBlipColour
              L6_2 = L4_2
              L7_2 = A0_2.blip
              L7_2 = L7_2.colour
              L5_2(L6_2, L7_2)
              L5_2 = A0_2.blip
              L5_2 = L5_2.flashes
              if L5_2 then
                L5_2 = SetBlipFlashes
                L6_2 = L4_2
                L7_2 = true
                L5_2(L6_2, L7_2)
              end
              L5_2 = BeginTextCommandSetBlipName
              L6_2 = "STRING"
              L5_2(L6_2)
              L5_2 = AddTextComponentString
              L6_2 = A0_2.blip
              L6_2 = L6_2.text
              L5_2(L6_2)
              L5_2 = EndTextCommandSetBlipName
              L6_2 = L4_2
              L5_2(L6_2)
              L5_2 = A0_2.blip
              L5_2 = L5_2.time
              L5_2 = L5_2 * 0.1
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 250
              L9_2 = A0_2.blip
              L9_2 = L9_2.time
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 230
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 210
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 190
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 170
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 150
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 130
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 110
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 90
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = SetBlipFade
              L7_2 = L4_2
              L8_2 = 70
              L9_2 = 30000
              L6_2(L7_2, L8_2, L9_2)
              L6_2 = Citizen
              L6_2 = L6_2.Wait
              L7_2 = L5_2
              L6_2(L7_2)
              L6_2 = DoesBlipExist
              L7_2 = L4_2
              L6_2 = L6_2(L7_2)
              if L6_2 then
                L6_2 = RemoveBlip
                L7_2 = L4_2
                L6_2(L7_2)
              end
            end
          end
        end
      else
        L3_2 = E
        L4_2 = "5414"
        L3_2(L4_2)
      end
  end
  else
    L2_2 = E
    L3_2 = "1466"
    L2_2(L3_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:PlayerResponding"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:PlayerResponding"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = T
    L2_2 = A0_2.unique_id
    L3_2 = "string"
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = L2_1
      if L1_2 then
        L1_2 = FindUniqueID
        L2_2 = A0_2.unique_id
        L1_2 = L1_2(L2_2)
        if L1_2 then
          L2_2 = A0_2.action
          if "add" == L2_2 then
            L2_2 = L2_1
            L2_2 = L2_2[L1_2]
            L3_2 = A0_2.responding
            L3_2 = L3_2 + 1
            L2_2.responding = L3_2
            L2_2 = SendNUIMessage
            L3_2 = {}
            L3_2.action = "add_responding"
            L4_2 = A0_2.unique_id
            L3_2.unique_id = L4_2
            L4_2 = A0_2.char_info
            L4_2 = L4_2.char_name
            L3_2.SourceName = L4_2
            L4_2 = A0_2.char_info
            L4_2 = L4_2.callsign
            L3_2.SourceCallsign = L4_2
            L4_2 = A0_2.char_info
            L4_2 = L4_2.source
            L3_2.source = L4_2
            L2_2(L3_2)
          else
            L2_2 = A0_2.action
            if "remove" == L2_2 then
              L2_2 = L2_1
              L2_2 = L2_2[L1_2]
              L3_2 = A0_2.responding
              L3_2 = L3_2 - 1
              L2_2.responding = L3_2
              L2_2 = SendNUIMessage
              L3_2 = {}
              L3_2.action = "remove_responding"
              L4_2 = A0_2.unique_id
              L3_2.unique_id = L4_2
              L4_2 = A0_2.char_info
              L4_2 = L4_2.char_name
              L3_2.SourceName = L4_2
              L4_2 = A0_2.char_info
              L4_2 = L4_2.callsign
              L3_2.SourceCallsign = L4_2
              L4_2 = A0_2.char_info
              L4_2 = L4_2.source
              L3_2.source = L4_2
              L2_2(L3_2)
            end
          end
        end
      end
  end
  else
    L1_2 = E
    L2_2 = "0231"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:StopSpammings"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:StopSpammings"
function L12_1()
  local L0_2, L1_2
  L0_2 = Citizen
  L0_2 = L0_2.Wait
  L1_2 = 500
  L0_2(L1_2)
  L0_2 = false
  L4_1 = L0_2
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:GetNonOnesyncCoords"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:GetNonOnesyncCoords"
function L12_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = TriggerServerEvent
  L1_2 = "cd_dispatch:GetNonOnesyncCoords"
  L2_2 = GetEntityCoords
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L2_2, L3_2 = L2_2(L3_2)
  L0_2(L1_2, L2_2, L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:SetGPS"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:SetGPS"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SetNewWaypoint
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:DispatcherToggle"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:DispatcherToggle"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "boolean"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L6_1 = A0_2
  else
    L1_2 = E
    L2_2 = "8845"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:UpdateGroups"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:UpdateGroups"
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = SendNUIMessage
  L2_2 = {}
  L2_2.action = "updategroups"
  L2_2.values = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "cd_dispatch:SyncUserSettings"
L10_1(L11_1)
L10_1 = AddEventHandler
L11_1 = "cd_dispatch:SyncUserSettings"
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = SendNUIMessage
  L2_2 = {}
  L2_2.action = "syncusersettings"
  L2_2.values = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1)
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
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
      L2_2 = L2_1
      if L2_2 then
        L2_2 = L2_1
        L2_2 = L2_2[A0_2]
        if L2_2 then
          L2_2 = {}
          L2_2.action = A1_2
          L3_2 = L2_1
          L3_2 = L3_2[A0_2]
          L3_2 = L3_2.job_table
          L2_2.job_table = L3_2
          L3_2 = L2_1
          L3_2 = L3_2[A0_2]
          L3_2 = L3_2.responding
          L2_2.responding = L3_2
          L3_2 = L2_1
          L3_2 = L3_2[A0_2]
          L3_2 = L3_2.unique_id
          L2_2.unique_id = L3_2
          L3_2 = SourceInfo
          L2_2.char_info = L3_2
          if "add" == A1_2 then
            L3_2 = L2_1
            L3_2 = L3_2[A0_2]
            L3_2.responding_state = true
            L3_2 = SetNewWaypoint
            L4_2 = L2_1
            L4_2 = L4_2[A0_2]
            L4_2 = L4_2.coords
            L4_2 = L4_2.x
            L5_2 = L2_1
            L5_2 = L5_2[A0_2]
            L5_2 = L5_2.coords
            L5_2 = L5_2.y
            L3_2(L4_2, L5_2)
            L3_2 = TriggerServerEvent
            L4_2 = "cd_dispatch:PlayerResponding"
            L5_2 = L2_2
            L3_2(L4_2, L5_2)
          elseif "remove" == A1_2 then
            L3_2 = L2_1
            L3_2 = L3_2[A0_2]
            L3_2.responding_state = false
            L3_2 = SetWaypointOff
            L3_2()
            L3_2 = TriggerServerEvent
            L4_2 = "cd_dispatch:PlayerResponding"
            L5_2 = L2_2
            L3_2(L4_2, L5_2)
          else
            L3_2 = E
            L4_2 = "6544"
            L3_2(L4_2)
          end
      end
      else
        L2_2 = E
        L3_2 = "3332"
        L2_2(L3_2)
      end
  end
  else
    L2_2 = E
    L3_2 = "8866"
    L2_2(L3_2)
  end
end
Responding = L10_1
function L10_1()
  local L0_2, L1_2, L2_2
  L5_1.large = false
  NUI_status = false
  L0_2 = ShowSmallUI
  L0_2()
  L0_2 = TabletAnimation
  L1_2 = false
  L0_2(L1_2)
  L0_2 = FreezeEntityPosition
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = false
  L0_2(L1_2, L2_2)
end
HideLargeUI = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L5_1.small = true
  L0_2 = SendNUIMessage
  L1_2 = {}
  L2_2 = GetNUIState
  L3_2 = L5_1.small
  L2_2 = L2_2(L3_2)
  L1_2.action = L2_2
  L0_2(L1_2)
end
ShowSmallUI = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L5_1.small = false
  L0_2 = SendNUIMessage
  L1_2 = {}
  L2_2 = GetNUIState
  L3_2 = L5_1.small
  L2_2 = L2_2(L3_2)
  L1_2.action = L2_2
  L0_2(L1_2)
end
HideSmallUI = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = GetClockHours
  L0_2 = L0_2()
  L1_2 = T
  L2_2 = Config
  L2_2 = L2_2.DayHours
  L2_2 = L2_2[1]
  L3_2 = "number"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = T
    L2_2 = Config
    L2_2 = L2_2.DayHours
    L2_2 = L2_2[2]
    L3_2 = "number"
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.DayHours
      L1_2 = L1_2[1]
      if L0_2 > L1_2 then
        L1_2 = Config
        L1_2 = L1_2.DayHours
        L1_2 = L1_2[2]
        if L0_2 < L1_2 then
          L1_2 = "day"
          return L1_2
      end
      else
        L1_2 = "night"
        return L1_2
      end
  end
  else
    L1_2 = E
    L2_2 = "3156"
    L1_2(L2_2)
    L1_2 = "day"
    return L1_2
  end
end
GetTime = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "boolean"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    if A0_2 then
      L1_2 = "show_small"
      return L1_2
    else
      L1_2 = "hide_small"
      return L1_2
    end
  else
    L1_2 = E
    L2_2 = "6146"
    L1_2(L2_2)
  end
end
GetNUIState = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L5_1.small
  if L0_2 then
    L0_2 = L2_1
    if L0_2 then
      L0_2 = L3_1
      if L0_2 then
        L1_2 = L3_1
        L0_2 = L2_1
        L0_2 = L0_2[L1_2]
        if L0_2 then
          L0_2 = L2_1
          L0_2 = #L0_2
          if 0 == L0_2 then
            goto lbl_60
          end
          L0_2 = L3_1
          L0_2 = L0_2 + 1
          L3_1 = L0_2
          L0_2 = L3_1
          L1_2 = L2_1
          L1_2 = #L1_2
          if L0_2 > L1_2 then
            L0_2 = 1
            L3_1 = L0_2
          end
          while true do
            L1_2 = L3_1
            L0_2 = L2_1
            L0_2 = L0_2[L1_2]
            if nil ~= L0_2 then
              break
            end
            L0_2 = Citizen
            L0_2 = L0_2.Wait
            L1_2 = 0
            L0_2(L1_2)
            L0_2 = L3_1
            L0_2 = L0_2 + 1
            L3_1 = L0_2
            L0_2 = L3_1
            L1_2 = L2_1
            L1_2 = #L1_2
            if L0_2 > L1_2 then
              L0_2 = 1
              L3_1 = L0_2
            end
          end
          L0_2 = SendNUIMessage
          L1_2 = {}
          L1_2.action = "move_right"
          L0_2(L1_2)
      end
    end
    else
      L0_2 = E
      L1_2 = "3516"
      L0_2(L1_2)
    end
  end
  ::lbl_60::
end
Increasecount = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L5_1.small
  if L0_2 then
    L0_2 = L2_1
    if L0_2 then
      L0_2 = L3_1
      if L0_2 then
        L1_2 = L3_1
        L0_2 = L2_1
        L0_2 = L0_2[L1_2]
        if L0_2 then
          L0_2 = L2_1
          L0_2 = #L0_2
          if 0 == L0_2 then
            goto lbl_58
          end
          L0_2 = L3_1
          L0_2 = L0_2 - 1
          L3_1 = L0_2
          L0_2 = L3_1
          if L0_2 < 1 then
            L0_2 = L2_1
            L0_2 = #L0_2
            L3_1 = L0_2
          end
          while true do
            L1_2 = L3_1
            L0_2 = L2_1
            L0_2 = L0_2[L1_2]
            if nil ~= L0_2 then
              break
            end
            L0_2 = Citizen
            L0_2 = L0_2.Wait
            L1_2 = 0
            L0_2(L1_2)
            L0_2 = L3_1
            L0_2 = L0_2 - 1
            L3_1 = L0_2
            L0_2 = L3_1
            if L0_2 < 1 then
              L0_2 = L2_1
              L0_2 = #L0_2
              L3_1 = L0_2
            end
          end
          L0_2 = SendNUIMessage
          L1_2 = {}
          L1_2.action = "move_left"
          L0_2(L1_2)
      end
    end
    else
      L0_2 = E
      L1_2 = "7655"
      L0_2(L1_2)
    end
  end
  ::lbl_58::
end
Decreasecount = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "number"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = math
    L1_2 = L1_2.floor
    L2_2 = math
    L2_2 = L2_2.pow
    L3_2 = 10
    L4_2 = 2
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = A0_2 * L2_2
    L2_2 = L2_2 + 0.5
    L1_2 = L1_2(L2_2)
    L1_2 = L1_2 / 100
    return L1_2
  else
    L1_2 = E
    L2_2 = "6844"
    L1_2(L2_2)
  end
end
RoundDec = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "string"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "playsound"
    L2_2.type = A0_2
    L1_2(L2_2)
  else
    L1_2 = E
    L2_2 = "4564"
    L1_2(L2_2)
  end
end
DispatchSound = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = pairs
  L2_2 = L2_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.unique_id
    if L7_2 == A0_2 then
      L7_2 = L6_2.count
      return L7_2
    end
  end
end
FindUniqueID = L10_1
L10_1 = RegisterNUICallback
L11_1 = "hidelarge_ui"
function L12_1()
  local L0_2, L1_2
  L0_2 = HideLargeUI
  L0_2()
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "deletesingle_alert"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = tonumber
    L2_2 = A0_2.count
    L1_2 = L1_2(L2_2)
    A0_2.count = L1_2
    L1_2 = L2_1
    if L1_2 then
      L2_2 = A0_2.count
      L1_2 = L2_1
      L1_2 = L1_2[L2_2]
      if L1_2 then
        L1_2 = DoesBlipExist
        L3_2 = A0_2.count
        L2_2 = L2_1
        L2_2 = L2_2[L3_2]
        L2_2 = L2_2.blip
        L1_2 = L1_2(L2_2)
        if L1_2 then
          L1_2 = RemoveBlip
          L3_2 = A0_2.count
          L2_2 = L2_1
          L2_2 = L2_2[L3_2]
          L2_2 = L2_2.blip
          L1_2(L2_2)
        end
        L2_2 = A0_2.count
        L1_2 = L2_1
        L1_2[L2_2] = nil
        L1_2 = L2_1
        L1_2 = #L1_2
        L3_1 = L1_2
    end
    else
      L1_2 = E
      L2_2 = "3651"
      L1_2(L2_2)
    end
  else
    L1_2 = E
    L2_2 = "7796"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "deleteall_alerts"
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = T
  L1_2 = L2_1
  L2_2 = "table"
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = pairs
    L1_2 = L2_1
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = L5_2.blip
      if L6_2 then
        L6_2 = DoesBlipExist
        L7_2 = L5_2.blip
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = RemoveBlip
          L7_2 = L5_2.blip
          L6_2(L7_2)
        end
      end
    end
    L0_2 = {}
    L2_1 = L0_2
    L0_2 = 0
    L3_1 = L0_2
    L1_2 = L3_1
    L0_2 = L2_1
    L2_2 = {}
    L0_2[L1_2] = L2_2
  else
    L0_2 = E
    L1_2 = "9989"
    L0_2(L1_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "add_responding"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = Responding
    L2_2 = A0_2.count
    L3_2 = "add"
    L1_2(L2_2, L3_2)
  else
    L1_2 = E
    L2_2 = "9846"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "remove_responding"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = Responding
    L2_2 = A0_2.count
    L3_2 = "remove"
    L1_2(L2_2, L3_2)
  else
    L1_2 = E
    L2_2 = "6958"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "getglobalcoords"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "updatecoords"
    L3_2 = Callback
    L4_2 = A0_2.job
    L5_2 = "update_ui_blips"
    L3_2 = L3_2(L4_2, L5_2)
    L2_2.coords = L3_2
    L1_2(L2_2)
  else
    L1_2 = E
    L2_2 = "9684"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "moveend_smallui"
function L12_1()
  local L0_2, L1_2
  NUI_status = false
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "usersettings"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = TriggerServerEvent
    L2_2 = "cd_dispatch:SaveUserSettings"
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
  else
    L1_2 = E
    L2_2 = "6123"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "togglevoice"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = A0_2.enabled
    if L1_2 then
      NUI_status = false
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 100
      L1_2(L2_2)
      L1_2 = Checks
      L2_2 = "enable_nui_2"
      L1_2(L2_2)
      L1_2 = FreezeEntityPosition
      L2_2 = PlayerPedId
      L2_2 = L2_2()
      L3_2 = true
      L1_2(L2_2, L3_2)
    else
      NUI_status = false
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 100
      L1_2(L2_2)
      L1_2 = Checks
      L2_2 = "enable_nui"
      L1_2(L2_2)
      L1_2 = FreezeEntityPosition
      L2_2 = PlayerPedId
      L2_2 = L2_2()
      L3_2 = false
      L1_2(L2_2, L3_2)
    end
  else
    L1_2 = E
    L2_2 = "2233"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "changechannel"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = A0_2.channel
    if L1_2 then
      L1_2 = A0_2.channel
      if L1_2 > 0 then
        L1_2 = Checks
        L2_2 = "change_radio"
        L3_2 = A0_2.channel
        L1_2(L2_2, L3_2)
    end
    else
      L1_2 = A0_2.channel
      if 0 == L1_2 then
        L1_2 = Checks
        L2_2 = "leave_radio"
        L1_2(L2_2)
      end
    end
  else
    L1_2 = E
    L2_2 = "2315"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "setgps"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.UsingOneSync
    if L1_2 then
      L1_2 = TriggerServerEvent
      L2_2 = "cd_dispatch:SetGPS"
      L3_2 = A0_2.id
      L1_2(L2_2, L3_2)
    else
      L1_2 = GetEntityCoords
      L2_2 = GetPlayerPed
      L3_2 = GetPlayerFromServerId
      L4_2 = A0_2.id
      L3_2, L4_2 = L3_2(L4_2)
      L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2)
      L2_2 = SetNewWaypoint
      L3_2 = L1_2.x
      L4_2 = L1_2.y
      L2_2(L3_2, L4_2)
    end
  else
    L1_2 = E
    L2_2 = "2315"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "dispatchertoggle"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = Checks
    L2_2 = "get_job"
    L1_2 = L1_2(L2_2)
    L2_2 = T
    L3_2 = L1_2
    L4_2 = "string"
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = SourceInfo
      L2_2.dispatcher = true
      L2_2 = TriggerServerEvent
      L3_2 = "cd_dispatch:DispatcherToggle"
      L4_2 = A0_2.state
      L5_2 = L1_2
      L2_2(L3_2, L4_2, L5_2)
    else
      L2_2 = E
      L3_2 = "3354"
      L2_2(L3_2)
    end
  else
    L1_2 = E
    L2_2 = "6654"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "assigncall"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = TriggerServerEvent
    L2_2 = "cd_dispatch:Dispatcher_AddCall"
    L3_2 = A0_2.notification
    L1_2(L2_2, L3_2)
  else
    L1_2 = E
    L2_2 = "1544"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "updategroups"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = T
  L2_2 = A0_2
  L3_2 = "table"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = TriggerServerEvent
    L2_2 = "cd_dispatch:UpdateGroups"
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
  else
    L1_2 = E
    L2_2 = "7844"
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = print
  L2_2 = "^1[error_code-"
  L3_2 = A0_2
  L4_2 = "]"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
end
E = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = print
  L2_2 = "^1[Codesign ErrorHandler] - "
  L3_2 = A0_2
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
end
E2 = L10_1
function L10_1(A0_2, A1_2)
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
T = L10_1
function L10_1(A0_2, A1_2, ...)
  local L2_2, L3_2, L4_2, L5_2
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
      L2_2 = Locales
      L3_2 = Config
      L3_2 = L3_2.Language
      L2_2 = L2_2[L3_2]
      if L2_2 then
        L2_2 = Locales
        L3_2 = Config
        L3_2 = L3_2.Language
        L2_2 = L2_2[L3_2]
        L2_2 = L2_2[A1_2]
        if L2_2 then
          L2_2 = string
          L2_2 = L2_2.format
          L3_2 = Locales
          L4_2 = Config
          L4_2 = L4_2.Language
          L3_2 = L3_2[L4_2]
          L3_2 = L3_2[A1_2]
          L4_2, L5_2 = ...
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          if 1 == A0_2 or 2 == A0_2 or 3 == A0_2 then
            L3_2 = xpcall
            function L4_2()
              local L0_3, L1_3, L2_3
              L0_3 = Notification
              L1_3 = A0_2
              L2_3 = L2_2
              L0_3(L1_3, L2_3)
            end
            L5_2 = E2
            L3_2 = L3_2(L4_2, L5_2)
            if not L3_2 then
              L3_2 = E
              L4_2 = "98676 ^"
              L3_2(L4_2)
            end
          end
      end
      else
        L2_2 = E
        L3_2 = "8814"
        L2_2(L3_2)
      end
  end
  else
    L2_2 = E
    L3_2 = "3016"
    L2_2(L3_2)
  end
end
Notif = L10_1
L10_1 = Citizen
L10_1 = L10_1.CreateThread
function L11_1()
  local L0_2, L1_2
  while true do
    L0_2 = L1_1
    if false ~= L0_2 then
      break
    end
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 1000
    L0_2(L1_2)
  end
  L0_2 = SendNUIMessage
  L1_2 = {}
  L1_2.gunshots = "cd_dispatch:Sendplayername"
  L0_2(L1_2)
  L0_2 = nil
  L1_1 = L0_2
end
L10_1(L11_1)
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  if "blip_sound" == A0_2 then
    L3_2 = xpcall
    function L4_2()
      local L0_3, L1_3
      L0_3 = BlipSound
      L1_3 = A1_2
      L0_3(L1_3)
    end
    L5_2 = E2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = E
      L4_2 = "5554 ^"
      L3_2(L4_2)
    end
  elseif "is_allowed" == A0_2 then
    L3_2 = nil
    L4_2 = xpcall
    function L5_2()
      local L0_3, L1_3
      L0_3 = IsAllowed
      L0_3 = L0_3()
      L3_2 = L0_3
    end
    L6_2 = E2
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      return L3_2
    else
      L4_2 = E
      L5_2 = "8876 ^"
      L4_2(L5_2)
    end
  elseif "get_job" == A0_2 then
    L3_2 = nil
    L4_2 = xpcall
    function L5_2()
      local L0_3, L1_3
      L0_3 = GetJob
      L0_3 = L0_3()
      L3_2 = L0_3
    end
    L6_2 = E2
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      return L3_2
    else
      L4_2 = E
      L5_2 = "7784 ^"
      L4_2(L5_2)
    end
  elseif "enable_nui" == A0_2 then
    L3_2 = xpcall
    function L4_2()
      local L0_3, L1_3
      L0_3 = TriggerEvent
      L1_3 = "cd_dispatch:ToggleNUIFocus"
      L0_3(L1_3)
    end
    L5_2 = E2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = E
      L4_2 = "5146 ^"
      L3_2(L4_2)
    end
  elseif "enable_nui_2" == A0_2 then
    L3_2 = xpcall
    function L4_2()
      local L0_3, L1_3
      L0_3 = TriggerEvent
      L1_3 = "cd_dispatch:ToggleNUIFocus_2"
      L0_3(L1_3)
    end
    L5_2 = E2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = E
      L4_2 = "1555 ^"
      L3_2(L4_2)
    end
  elseif "is_dispatcher" == A0_2 then
    L3_2 = nil
    L4_2 = xpcall
    function L5_2()
      local L0_3, L1_3
      L0_3 = IsDispatcher
      L0_3 = L0_3()
      L3_2 = L0_3
    end
    L6_2 = E2
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      return L3_2
    else
      L4_2 = E
      L5_2 = "8742 ^"
      L4_2(L5_2)
    end
  elseif "check_job" == A0_2 then
    L3_2 = nil
    L4_2 = xpcall
    function L5_2()
      local L0_3, L1_3
      L0_3 = CheckJob
      L1_3 = A1_2
      L0_3 = L0_3(L1_3)
      L3_2 = L0_3
    end
    L6_2 = E2
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      return L3_2
    else
      L4_2 = E
      L5_2 = "6645 ^"
      L4_2(L5_2)
    end
  elseif "change_radio" == A0_2 then
    L3_2 = xpcall
    function L4_2()
      local L0_3, L1_3
      L0_3 = ChangeRadio
      L1_3 = A1_2
      L0_3(L1_3)
    end
    L5_2 = E2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = E
      L4_2 = "7765 ^"
      L3_2(L4_2)
    end
  elseif "leave_radio" == A0_2 then
    L3_2 = xpcall
    function L4_2()
      local L0_3, L1_3
      L0_3 = LeaveRadio
      L0_3()
    end
    L5_2 = E2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = E
      L4_2 = "4567 ^"
      L3_2(L4_2)
    end
  end
end
Checks = L10_1
