local Server = lib.require('sv_config')
local thief
local onCooldown = false
local tracker = 0
local carHeist = {}

function TryToGetItem()
    local chance = math.random(1, 100) -- Generate a random integer between 1 and 100

    if chance <= 3 then
        Player.Functions.AddItem('purple_lootcrate', 1) -- Add the item if the chance is 3% or less
    else
        print("Better luck next time!")
    end
end

local function initCooldown(src)
    onCooldown = true
    SetTimeout(Server.Cooldown * 60000, function()
        if carHeist[src] then 
            carHeist[src] = nil
        end
        if thief then thief = nil end
        TriggerClientEvent('randol_carheist:client:resetHeist', -1)
        onCooldown = false
    end)
end

local function updateTracker(source, vehicle)
    CreateThread(function()
        local miniGameAttempted = false

        -- Listen for a mini-game trigger using gps_remover
        RegisterNetEvent('avid:useGPSRemover')
        AddEventHandler('avid:useGPSRemover', function(playerSource)
            if playerSource == source and not miniGameAttempted then
                miniGameAttempted = true
                local success = StartGPSMiniGame(source) -- Function for the mini-game
                if success then
                    TriggerClientEvent('randol_carheist:client:trackerOff', source)
                    tracker = 0
                    return -- Exit the thread if mini-game succeeds
                end
            end
        end)

        while tracker < 120 do -- 120 intervals for 10 minutes
            if not DoesEntityExist(vehicle) then
                if carHeist[source] then carHeist[source] = nil end
                thief = nil
                break
            end

            local coords = GetEntityCoords(vehicle)
            PoliceTracker(coords)

            tracker += 1
            Wait(5000)
        end
        tracker = 0
        TriggerClientEvent('randol_carheist:client:trackerOff', -1)
    end)
end

-- Example Mini-Game Function (Simplified)
function StartGPSMiniGame(player)
    -- Logic for the mini-game, e.g., solving a puzzle or pressing keys
    -- Return true if successful, false otherwise
    local success = exports.bl_ui:Untangle(3, {
        numberOfNodes = 10,
        duration = 15000,
    })
    if success then
        TriggerClientEvent('randol_carheist:client:notify', player, "GPS tracker removed successfully!")
    else
        TriggerClientEvent('randol_carheist:client:notify', player, "Failed to remove GPS tracker.")
    end
    return success
end


local function createHeistVehicle(source, model, coords)
    -- Not gonna bother using server setter for a temporary vehicle, cry about it.
    local veh = CreateVehicle(joaat(model), coords.x, coords.y, coords.z, coords.w, true, true)
    local ped = GetPlayerPed(source)

    while not DoesEntityExist(veh) do Wait(0) end 

    while GetVehiclePedIsIn(ped, false) ~= veh do TaskWarpPedIntoVehicle(ped, veh, -1) Wait(0) end

    return veh
end

lib.callback.register('randol_carheist:server:finishHeist', function(source, heistcar)
    local src = source
    local Player = GetPlayer(src)
    local cid = GetPlyIdentifier(Player)

    if not carHeist[src] or not thief or thief ~= cid then return false end 

    local vehicle = NetworkGetEntityFromNetworkId(heistcar)

    if not DoesEntityExist(vehicle) or vehicle ~= carHeist[src].entity then return false end
    
    local pos = GetEntityCoords(GetPlayerPed(src))
    local coords = carHeist[src].delivery
    
    if #(pos - coords) > 10.0 then return false end

    DeleteEntity(vehicle)

    local amt = math.random(Server.Min, Server.Max)
    local metadata = {amount = amt, cid = cid, description = ('$%s'):format(amt)}
    AddHeistPapers(Player, metadata)

    carHeist[src], thief = nil
    TriggerClientEvent('randol_carheist:client:endRobbery', -1)
    return true
end)

lib.callback.register('randol_carheist:attemptjob', function(source)
    local src = source

    if carHeist[src] then return false end 

    local amount = CheckCopCount()

    if amount < Server.RequiredCops then 
        DoNotification(src, ('Not Enough Cops (%s)'):format(Server.RequiredCops), 'error')
        return false 
    end

    if onCooldown then
        DoNotification(src, 'Heist is on cooldown.', 'error')
        return false
    end

    local Player = GetPlayer(src)
    thief = GetPlyIdentifier(Player)

    carHeist[src] = {
        model = Server.VehicleList[math.random(#Server.VehicleList)],
        location = Server.SpawnLocations[math.random(#Server.SpawnLocations)],
        delivery = Server.DeliveryCoords[math.random(#Server.DeliveryCoords)],
        entity = 0,
    }

    initCooldown(src)
    return carHeist[src]
end)

lib.callback.register('randol_carheist:server:createVehicle', function(source)
    if not carHeist[source] then return false end

    local data = carHeist[source]
    local entity = createHeistVehicle(source, data.model, data.location.spawn)

    updateTracker(source, entity)
    carHeist[source].entity = entity

    if AlertPolice then
        AlertPolice(source, entity)
    end

    return NetworkGetNetworkIdFromEntity(entity)
end)

lib.callback.register('randol_carheist:server:returnPapers', function(source)
    local src = source
    local Player = GetPlayer(src) -- Assuming this returns the player's identifier or similar
    local inventory = exports.ox_inventory:GetInventory(src) -- Get the player's inventory

    -- Retrieve the 'heist_papers' item and its metadata
    local item = exports.ox_inventory:Search(src, 'count', 'heist_papers')

    if not item or item == 0 then
        DoNotification(src, 'You do not have the required heist papers.', 'error')
        return false
    end

    -- Assuming metadata is stored in the item's metadata field
    local metadata = exports.ox_inventory:GetItem(src, 'heist_papers')

    --if not metadata or GetPlyIdentifier(Player) ~= metadata.cid then
    --    DoNotification(src, 'These papers do not have your name on them.', 'error')
    --    return false
    --end

    -- Remove the 'heist_papers' item
    exports.ox_inventory:RemoveItem(src, 'heist_papers', 1)

    -- Add the reward money (assuming this is handled separately)
    AddRewardMoney(Player, math.random(120,212))

    -- Add random amount of "rolled_cash" between 13 and 26
    local rolledCashAmount = math.random(13, 26)
    exports.ox_inventory:AddItem(src, 'rolled_cash', rolledCashAmount)

    -- Add one "purple_lootcrate"
    exports.ox_inventory:AddItem(src, 'purple_lootcrate', 1)

    -- Notify the player
    DoNotification(src, ('You received $%s for delivering the vehicle.'):format(metadata.amount), 'success')
    DoNotification(src, ('You also received %s rolled cash and a purple lootcrate.'):format(rolledCashAmount), 'success')
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        SetTimeout(2000, function()
            TriggerClientEvent('randol_carheist:cacheConfig', -1, Server)
        end)
    end
end)

function OnServerPlayerLoaded(source)
    local src = source
    SetTimeout(2000, function()
        TriggerClientEvent('randol_carheist:cacheConfig', src, Server)
    end)
end

function OnServerPlayerUnload(source)
    if carHeist[source] then
        if DoesEntityExist(carHeist[source].entity) then DeleteEntity(carHeist[source].entity) end
        carHeist[source] = nil
    end
end

AddEventHandler('playerDropped', function()
    if carHeist[source] then
        if DoesEntityExist(carHeist[source].entity) then DeleteEntity(carHeist[source].entity) end
        carHeist[source] = nil
    end
end)