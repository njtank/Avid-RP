AddEventHandler("pma-voice:radioActive", function(radioTalking)
   Client.Data.Voice = radioTalking and 'radio' or false
end)

if Config.Framework == "ESX" then
   AddEventHandler("esx_status:onTick", function(data)
      for i = 1, #data do
         if data[i].name == "thirst" then
            Client.Data.Thirst = math.floor(data[i].percent)
         end
         if data[i].name == "hunger" then
            Client.Data.Hunger = math.floor(data[i].percent)
         end
      end
   end)
end

if Config.Show.Info then
   CreateThread(function()
      while true do
         Client.Functions.TriggerCallback("hud:server:getTime", function (time)
            Client.Time.Time = time
         end)
         SendNUIMessage({
            action = "updateTime",
            time = Client.Time
         })
         Wait(Config.Refresh.Time)
      end
   end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function()
   Client.Functions.PlayerLoaded()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
   Client.Functions.PlayerLoaded()
end)

CreateThread(function()
   while true do
       Wait(500)

       if not Client.Functions.isPlayerLoaded() then
           DisplayRadar(false)
       else
           if not Client.Loaded then
               Client.Functions.PlayerLoaded()
               break
            else
               break
           end
       end
   end
end)

CreateThread(function()
   while true do
      if Client.Loaded then
         Client.Functions.UpdateData()
         SendNUIMessage({
            action = "updateHud",
            data = Client.Data
         })
         if IsPedInAnyVehicle(PlayerPedId(), false) then
            SendNUIMessage({
               action = "showCar"
            })
            Client.Functions.UpdateVehicleData()
            SendNUIMessage({
               action = "updateVehicle",
               vehData = Client.Vehicle
            })
            Wait(Config.Refresh.car)
         else
            SendNUIMessage({
               action = "hideCar"
            })
            Wait(Config.Refresh.onFoot)
         end
      else
         Wait(100)
      end
   end
end)

RegisterCommand("hud", function()
   SetNuiFocus(true, true)
   SendNUIMessage({
      action = "openSettings"
   })
end)

local button = 56 -- 167 (F6 by default)
local commandEnabled = false -- (false by default) If you set this to true, typing "/engine" in chat will also toggle your engine.

Citizen.CreateThread(function()
    if commandEnabled then
        RegisterCommand('engine', function() 
            toggleEngine()
        end, false)
    end
    while true do
        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if (IsControlJustReleased(0, button) or IsDisabledControlJustReleased(0, button)) and vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
            toggleEngine()
        end
        
    end
end)

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end