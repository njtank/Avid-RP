local QBCore = exports['qb-core']:GetCoreObject()
local Config = {}
local brokenInto = {}

RegisterNetEvent('package_theft:smashWindow', function(vehicleNetId)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    local plate = GetVehicleNumberPlateText(vehicle)
    
    if not brokenInto[plate] then

        brokenInto[plate] = true

        TriggerClientEvent('package_theft:playSmashAnimation', src, vehicleNetId)

        Citizen.Wait(1000)
        TriggerClientEvent('package_theft:givePackage', src)
    else
        TriggerClientEvent('QBCore:Notify', src, "This vehicle has already been broken into!", 'error')
    end
end)

--[[RegisterNetEvent('package_theft:givePackage', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local randomCash = math.random(10, 20)
        
        
        Player.Functions.AddMoney('cash', randomCash)
        
        TriggerClientEvent('QBCore:Notify', source, "You grabbed " .. randomCash .. " in cash!", 'success')
        
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cash'], "add")
    end
end) ]]

RegisterNetEvent('package_theft:givePackage', function()
    -- Randomly select a reward from the config
    local reward = Config.Rewards[math.random(#Config.Rewards)]
    print('Selected reward:', reward.item)

    if reward.item == 'cash' then
        -- Add cash directly to player's inventory
        local randomCash = math.random(reward.amount.min, reward.amount.max)
        local success = exports.ox_inventory:AddItem(source, 'money', randomCash)
        print('Cash add success:', success)

        if success then
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'success',
                description = "You grabbed $" .. randomCash .. " in cash!"
            })
        else
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'error',
                description = "Failed to add cash to inventory."
            })
        end
    else
        -- Add item reward to player's inventory
        local randomAmount = math.random(reward.amount.min, reward.amount.max)
        print('Attempting to add item:', reward.item, 'Amount:', randomAmount)
        local success = exports.ox_inventory:AddItem(source, reward.item, randomAmount)
        print('Item add success:', success)

        if success then
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'success',
                description = "You grabbed " .. randomAmount .. "x " .. reward.item.label .. "!"
            })
        else
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'error',
                description = "Failed to add item. Inventory might be full."
            })
        end
    end
end)




Config.Rewards = {
    { item = 'cash', amount = { min = 10, max = 20 } },
    { item = 'folded_cash', label = 'Folded Cash', amount = { min = 2, max = 6 } },
    { item = 'weed_lemonhaze_seed', label = 'Lemon Haze Seed', amount = { min = 1, max = 3 } },
    { item = 'weed_bluedream_seed', label = 'Blue Dream Seed', amount = { min = 1, max = 3 } },
    { item = 'diamond_ring', label = 'Diamond Ring', amount = { min = 1, max = 1 } },
    { item = 'goldchain', label = 'Gold Chain', amount = { min = 1, max = 1 } },
    { item = 'dirty_cloth', label = 'Dirty Cloth', amount = { min = 2, max = 4 } }
}