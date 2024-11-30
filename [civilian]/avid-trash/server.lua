local Config = {}

RegisterNetEvent('trash:giveReward', function()
    local src = source
    local reward = Config.RewardItems[math.random(#Config.RewardItems)]
    local amount = math.random(1, 5) -- Random amount between 1 and 5
    local success = exports.ox_inventory:AddItem(src, reward, amount)
    if success then
        TriggerClientEvent('ox_inventory:notify', src, reward, amount, 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You received ' .. amount .. 'x ' .. reward, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Your inventory is full.', 'error')
    end
end)
