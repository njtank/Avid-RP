local isSalvaging = {}  -- Keeps track of which player is currently salvaging
local scrapCount = {}  -- Tracks the number of scrapped cars per player

RegisterNetEvent('avid-salvage:startSalvaging')
AddEventHandler('avid-salvage:startSalvaging', function()
    local player = source
    if isSalvaging[player] then
        -- If the player is already salvaging, ignore the request
        TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'You are already salvaging!'})
        return
    end

    -- Mark the player as salvaging
    isSalvaging[player] = true
    scrapCount[player] = 0  -- Reset scrap count to 0 when they start

    -- Notify the player that they have started salvaging
    TriggerClientEvent('ox_lib:notify', player, {type = 'inform', description = 'You have started salvaging cars. Complete 14 tasks to get paid.'})
end)

RegisterNetEvent('avid-salvage:getPaid')
AddEventHandler('avid-salvage:getPaid', function()
    local player = source

    -- Ensure the player has scrapped at least 14 cars
    if scrapCount[player] < 14 then
        TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'You need to scrap 14 cars before you can get paid.'})
        return
    end

    -- Give the player $50 for completing the task
    local amount = 50
    TriggerEvent('qb-bank:deposit', player, amount)  -- Assuming you have a bank deposit function or similar
    TriggerClientEvent('ox_lib:notify', player, {type = 'inform', description = 'You have been paid $50 for scrapping cars.'})

    -- Reset the salvaging state
    isSalvaging[player] = false
end)

RegisterNetEvent('avid-salvage:updateScrapCount')
AddEventHandler('avid-salvage:updateScrapCount', function(count)
    local player = source
    scrapCount[player] = count  -- Update the player's scrap count
end)

RegisterNetEvent('avid-salvage:addRewardItem')
AddEventHandler('avid-salvage:addRewardItem', function(itemReward)
    local player = source

    -- Add the item to the player's inventory using ox_inventory
    TriggerEvent('ox_inventory:addItem', player, itemReward, 1)

    -- Notify the player
    TriggerClientEvent('ox_lib:notify', player, {type = 'inform', description = 'You have received ' .. itemReward .. ' as a reward for salvaging.'})
end)
