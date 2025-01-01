local rewards = {
    'folded_cash',
    'lockpick'
}

local mailRewards = {
    'folded_cash',
    'lockpick'
}

local mailCache = {}

local ox = exports.ox_inventory

local function validObj(obj)
    local valid = false

    for _, v in pairs(Config.Mailboxes) do
        if tonumber(v) == tonumber(obj) then valid = true break end
    end

    return valid
end

local function alreadyRobbed(co, o, coords)

    local robbed = false

    for k,v in pairs(mailCache) do
        if coords then
            print('distance ' .. #(v.coords - coords))
        end
        if v.coords == co and v.obj == o and not coords or coords and #(v.coords - coords) < 2 and v.coords == co and v.obj == o then
            robbed = true
            break
        end
    end

    return robbed
end


local function valid(coords, objs)

    local validCache = {}

    local valid = false


    for _, v in pairs(objs) do
        validCache.vector3 = vector3(v.coords.x, v.coords.y, v.coords.z)
        validCache.obj = v.object

        if alreadyRobbed(validCache.vector3, validCache.obj) then 
            break 
        end


        if #(coords - validCache.vector3) <= Config.Maxdistance and validObj(validCache.obj) and not alreadyRobbed(validCache.vector3, validCache.obj) then
            valid = true
            break
        end
    end

    if valid then
        table.insert(mailCache, {coords = validCache.vector3, obj = validCache.obj})
    end

    return valid
end



RegisterNetEvent('mailbox', function(objs)
    local src = source
    local weapon = exports.ox_inventory:GetCurrentWeapon(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    if not valid(coords, objs) then return end

    
    if Config.Reward.multiReward then
        for _, reward in pairs(rewards) do
            local rewardAmount = math.random(Config.Reward.am[1], Config.Reward.am[2])
            local doubleReward = rewardAmount < Config.Reward.am[2] / 2 and math.random(1, 25) > 1 --1/25 chance

            local ct = doubleReward and rewardAmount * 2 or rewardAmount
            ox:AddItem(src, reward, ct)
        end
    else
        local rewardAmount = math.random(Config.Reward.am[1], Config.Reward.am[2])
        local doubleReward = rewardAmount < Config.Reward.am[2] / 2 and math.random(1, 4) > 1 --1/4 chance

        reward = rewards[math.random(1, #rewards)]
        local ct = doubleReward and rewardAmount * 2 or rewardAmount
        ox:AddItem(src, reward, ct)
    end
    

    exports.ox_inventory:SetDurability(src, weapon.slot, weapon.metadata.durability - math.random(Config.Hammer.decay[1], Config.Hammer.decay[2]))
    print('^2ADDED ITEM^7')
end)

RegisterNetEvent('hammer', function()
    local src = source
    local weapon = exports.ox_inventory:GetCurrentWeapon(src)

    if weapon and weapon.label == Config.Hammer.label then
        exports.ox_inventory:SetDurability(src, weapon.slot, weapon.metadata.durability - math.random(Config.Hammer.decay[1] * 2, Config.Hammer.decay[2] * 2))
    end
end)


lib.callback.register('mailboxRobbed', function(source, objs)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    local robbed = false

    for _, v in pairs(objs) do
        local vector3 = vector3(v.coords.x, v.coords.y, v.coords.z)
        local obj = v.object

        if alreadyRobbed(vector3, obj, coords) then 
            robbed = true
            break
        end
    end

    return robbed
end) 



exports('mail', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local src = inventory.id
        TriggerClientEvent('openMail', src)

        -- and math.random(1, 2) > 1

        local giveReward = math.random(1, 100) <= Config.Reward.mailRewardChance and math.random(1,2) > 1 or false

        if giveReward then
            ox:AddItem(src, mailRewards[math.random(1, #mailRewards)], 1)
        end
    end
end)