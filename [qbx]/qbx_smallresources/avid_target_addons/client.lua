local isEscorted = false

-- Function to put a player in a vehicle
local function putInVehicle(vehicle)
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('police:client:PutInVehicle', GetPlayerServerId(closestPlayer), vehicle)
    else
        print("No player nearby to escort into the vehicle.")
    end
end

-- Helper function to find the closest player
local function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestPlayer = -1
    local closestDistance = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, playerId in ipairs(players) do
        if playerId ~= PlayerId() then
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)

            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

-- Register the ox_target command for vehicles
exports.ox_target:addGlobalVehicle({
    name = 'PutInVehicle',
    label = 'Put in Vehicle',
    icon = 'fa-solid fa-car',
    canInteract = function(entity, distance, data)
        return isEscorted -- Only allow if the player is being escorted
    end,
    onSelect = function(data)
        putInVehicle(data.entity)
    end
})

-- Listen for an escort event to toggle isEscorted
RegisterNetEvent('police:client:ToggleEscort', function(toggle)
    isEscorted = toggle
end)

exports.ox_target.addGlobalVehicle(options, {
    {
        name = 'lockVehicle',
        icon = 'fas fa-lock',
        label = '🔑 Toggle Lock',
        onSelect = function(data)
            local vehicle = data.entity
            if vehicle and DoesEntityExist(vehicle) then
                local plate = GetVehicleNumberPlateText(vehicle)
                -- Checks if the player has the key
                if exports['Renewed-Vehiclekeys']:hasKey(plate) then
                    -- Checks current vehicle status (locked or unlocked)
                    local isLocked = Entity(vehicle).state.vehicleLock and Entity(vehicle).state.vehicleLock.lock == 2
                    -- Changes vehicle status (locked/unlocked)
                    Entity(vehicle).state:set('vehicleLock', {
                        lock = isLocked and 1 or 2, -- 1 for unlocked, 2 for locked
                        sound = true, -- Play a sound
                    }, true)
                    -- Send a success notification
                    lib.notify({
                        title = 'Notification',
                        description = isLocked and 'Vehicle unlocked' or 'Vehicle locked',
                        type = 'success',
                        duration = 5000
                    })
                else
                    lib.notify({
                        title = 'Notification',
                        description = 'You do not have the key to this vehicle',
                        type = 'error',
                        duration = 5000
                    })
                end
            end
        end,
        canInteract = function(entity, distance, coords, name)
            local plate = GetVehicleNumberPlateText(entity)
            -- Allows interaction if the player has the key and the distance is less than 2.0
            return exports['Renewed-Vehiclekeys']:hasKey(plate) and distance < 2.0
        end
    }
})

