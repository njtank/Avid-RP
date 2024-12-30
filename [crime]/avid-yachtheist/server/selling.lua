local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["bnk_diamondskull"] = math.random(400, 500),
    ["bnk_bagofjewels"] = math.random(800, 1000),
    ["rolex"] = math.random(800, 1700),
    ["diamond_ring"] = math.random(800, 1200),
    ["diamond"] = math.random(300, 700),
    ["goldchain"] = math.random(200, 800),
    ["goldbar"] = math.random(1000, 1500),
    --- add rest of items and prices here.... it doesnt have to have a math random 
    ---- ["item"] = math.random(lowest, highest price)
    ---- ["item"] = 500
}

RegisterNetEvent("Bnk-YachtHeist:StartSelling", function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold items")
        TriggerClientEvent('QBCore:Notify', src, "You have Sold Your Items")
    end
end)