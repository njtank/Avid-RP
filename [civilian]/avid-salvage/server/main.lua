RegisterNetEvent('avid-salvage:giveReward')
AddEventHandler('avid-salvage:giveReward', function(item, amount)
    local playerId = source
    -- Add the item to the player's inventory using ox_inventory
    TriggerEvent('ox_inventory:addItem', playerId, item, amount)
end)

-- Player Task Completion Counter
local playerTasks = {}

RegisterNetEvent('avid-salvage:payPlayer')
AddEventHandler('avid-salvage:payPlayer', function()
    local playerId = source
    if playerTasks[playerId] then
        local completedTasks = playerTasks[playerId] or 0

        -- Pay $50 after certain number of tasks
        if completedTasks >= Config.TasksBeforeCash then
            TriggerEvent('qb-banking:deposit', playerId, 50)  -- Deposit to player's bank account
            playerTasks[playerId] = 0  -- Reset tasks after payment
            TriggerClientEvent('ox_lib:notify', playerId, {type = 'inform', description = 'You have been paid $50 for completing the scrap task!'})
        end
    end
end)
