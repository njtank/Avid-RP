local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateUseableItem('spikespack', function(src)
    TriggerClientEvent("bprp-spikes:client:usespikes", src)
end)

RegisterNetEvent('bprp-spikes:server:removespikes', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('spikespack', 1)
end)

RegisterNetEvent("bprp-spikes:server:pickupspikes", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == 'police' then 
        Player.Functions.AddItem('spikespack', 1)
    end
end)