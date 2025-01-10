local debug = CG.debug
local Inventory = exports.ox_inventory
local bank = BK.banks
QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('mifh:give:securitycard', function(source)
    Inventory:AddItem(source, BK.banks.key, 1)
end)

lib.callback.register('mifh:give:moneybag', function(source)
    if bank.money.cash then
        Inventory:AddItem(source, bank.money.item1, math.random(110, 163) )
    else
        Inventory:AddItem(source, BK.banks.money.item2, math.random(110, 163) )
    end
end)

lib.callback.register('mifh:remove:drill', function(source)
    Inventory:RemoveItem(source, BK.banks.drill, 1)
end)

lib.callback.register('mifh:remove:key', function(source)
    Inventory:RemoveItem(source, BK.banks.key, 1)
end)

lib.callback.register('mifh:remove:fleecacoin', function(source)
    Inventory:RemoveItem(source, 'fleeca_bank_coin', 1)
end)

-- bank vault sync

RegisterServerEvent('server:vault:open')
AddEventHandler('server:vault:open', function(choice)
    TriggerClientEvent('openvault', -1, choice)
end)

RegisterServerEvent('server:vault:close')
AddEventHandler('server:vault:close', function(choice)
    TriggerClientEvent('closevault', -1, choice)
end)

RegisterServerEvent('server:vault:reset')
AddEventHandler('server:vault:reset', function(choice)
    TriggerClientEvent('resetvault', -1, choice)
end)

RegisterServerEvent('server:vault:drill')
AddEventHandler('server:vault:drill', function(choice)
    TriggerClientEvent('spawnthermaldrill', -1, choice)
end)

RegisterServerEvent('server:drill:remove')
AddEventHandler('server:drill:remove', function(choice)
    TriggerClientEvent('deletethermaldrill', -1, choice)
end)

QBCore.Functions.CreateCallback('avid:itemTaken:QBCore', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('fleeca_bank_coin', 1) then
        cb(true)
    else
        cb(false)
    end
end)