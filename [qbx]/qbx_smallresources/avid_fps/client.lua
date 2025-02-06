CreateThread(function() -- If player is in a car or truck
    while true do
        local ped = PlayerPedId()
        local _, weapon = GetCurrentPedWeapon(ped)
        local unarmed = `WEAPON_UNARMED`
        local inVeh = GetVehiclePedIsIn(PlayerPedId(), false)
        sleep = 1000
        if IsPedInAnyVehicle(PlayerPedId()) and weapon ~= unarmed then
            sleep = 1
            if IsControlJustPressed(0, 25) then
                SetFollowVehicleCamViewMode(3)
            elseif IsControlJustReleased(0, 25) then
                SetFollowVehicleCamViewMode(0)
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()  --  If a player is on a bike
    while true do
        sleep = 1000
        local _, weapon = GetCurrentPedWeapon(PlayerPedId())
        local unarmed = `WEAPON_UNARMED`
        if IsPedOnAnyBike(PlayerPedId()) and weapon ~= unarmed then
            sleep = 1
            if IsControlJustPressed(0, 25) then
                SetCamViewModeForContext(2, 3)
            elseif IsControlJustReleased(0, 25) then
                SetCamViewModeForContext(2, 0)
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)



