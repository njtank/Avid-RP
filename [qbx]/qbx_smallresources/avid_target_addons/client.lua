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