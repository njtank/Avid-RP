local fw

local function Debug(message)
    if Config.Debug then
        print(message)
    end
end

local function weighted_random(pool)
    local poolsize = 0
    for i = 1, #pool do
        local v = pool[i]
        poolsize = poolsize + v['weight']
    end
    local selection = math.random(poolsize)
    for i = 1, #pool do
        local v = pool[i]
        selection = selection - v['weight']
        if (selection <= 0) then
            return i
        end
    end
end

local function AddItem(src, item, count)
    if Config.inventory == "ox" then 
        return exports.ox_inventory:AddItem(src, item, count)
    elseif Config.inventory == "qb" then 
        return exports["qb-inventory"]:AddItem(src, item, count)
    elseif Config.inventory == "ps" then 
        return exports["ps-inventory"]:AddItem(src, item, count)
    elseif Config.inventory == "qs" then
        return exports['qs-inventory']:AddItem(src, item, count)
    elseif Config.inventory == "codem" then
        return exports['codem-inventory']:AddItem(src, item, count)
    end
end

local function RemoveItem(src, item, count)
    Debug("Removing item: " .. item .. " count: " .. count .. " from source: " .. src)
    local result
    if Config.inventory == "ox" then 
        result = exports.ox_inventory:RemoveItem(src, item, count)
    elseif Config.inventory == "qb" then 
        result = exports["qb-inventory"]:RemoveItem(src, item, count)
    elseif Config.inventory == "ps" then 
        result = exports["ps-inventory"]:RemoveItem(src, item, count)
    elseif Config.inventory == "qs" then
        result = exports['qs-inventory']:RemoveItem(src, item, count)
    elseif Config.inventory == "codem" then
        result = exports['codem-inventory']:RemoveItem(src, item, count)
    end
    Debug("RemoveItem result: " .. tostring(result))
    return result
end


local function FWInit()
    if Config.framework == "esx" then 
        fw = exports["es_extended"]:getSharedObject()
        return fw
    elseif Config.framework == "qb" then 
        fw = exports['qb-core']:GetCoreObject()
        return fw
    end
end

local function CreateUseableItem(k)
    if Config.framework == "esx" then
        fw.RegisterUsableItem(k, function(source)
            Debug("ESX: RegisterUsableItem called for item: " .. k)
            if RemoveItem(source, k, 1) then
                local random = weighted_random(Config.Rewards[k])
                SetTimeout(9500, function()
                    if AddItem(source, Config.Rewards[k][random]['item'], 1) then
                        Debug("Random Item Selected: " .. Config.Rewards[k][random]['item'])
                        local itemLabel = fw.GetItemLabel(Config.Rewards[k][random]['item'])
                        TriggerClientEvent('esx:showNotification', source, 'You Won a ' .. itemLabel .. '!')
                    end
                end)
                TriggerClientEvent('avid-lootcrate:client:open', source, k, random)
            end
        end)
    elseif Config.framework == "qb" then
        Debug("Attempting to register usable item with QBCore for item: " .. k)
        fw.Functions.CreateUseableItem(k, function(source)
            Debug("QBCore: CreateUseableItem callback called for item: " .. k)
            if RemoveItem(source, k, 1) then
                Debug("QBCore: Item removed from inventory")
                local random = weighted_random(Config.Rewards[k])
                SetTimeout(9500, function()
                    if AddItem(source, Config.Rewards[k][random]['item'], 1) then
                        Debug("Random Item Selected: " .. Config.Rewards[k][random]['item'])
                        local itemLabel = fw.Shared.Items[Config.Rewards[k][random]['item']].label
                        TriggerClientEvent('inventory:client:ItemBox', source, fw.Shared.Items[Config.Rewards[k][random]['item']], "add")
                        TriggerClientEvent('QBCore:Notify', source, 'You Won a ' .. itemLabel .. '!', 'success')
                    end
                end)
                TriggerClientEvent('avid-lootcrate:client:open', source, k, random)
                TriggerClientEvent('inventory:client:ItemBox', source, fw.Shared.Items[k], "remove")
            else
                Debug("QBCore: Failed to remove item from inventory")
            end
        end)
    end
end


CreateThread(function()
    fw = FWInit()
    print("Framework Initialized")
    for k, v in pairs(Config.Rewards) do
        CreateUseableItem(k)
    end
end)
