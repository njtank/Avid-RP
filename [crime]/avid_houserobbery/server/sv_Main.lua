--$$$$$$$\  $$\      $$\       $$$$$$$$\ $$\   $$\  $$$$$$\  $$\      $$\   $$\  $$$$$$\  $$$$$$\ $$\    $$\ $$$$$$$$\      $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$\ $$$$$$$\ $$$$$$$$\  $$$$$$\  
--$$  ____| $$$\    $$$ |      $$  _____|$$ |  $$ |$$  __$$\ $$ |     $$ |  $$ |$$  __$$\ \_$$  _|$$ |   $$ |$$  _____|    $$  __$$\ $$  __$$\ $$  __$$\ \_$$  _|$$  __$$\\__$$  __|$$  __$$\ 
--$$ |      $$$$\  $$$$ |      $$ |      \$$\ $$  |$$ /  \__|$$ |     $$ |  $$ |$$ /  \__|  $$ |  $$ |   $$ |$$ |          $$ /  \__|$$ /  \__|$$ |  $$ |  $$ |  $$ |  $$ |  $$ |   $$ /  \__|
--$$$$$$$\  $$\$$\$$ $$ |      $$$$$\     \$$$$  / $$ |      $$ |     $$ |  $$ |\$$$$$$\    $$ |  \$$\  $$  |$$$$$\ $$$$$$\\$$$$$$\  $$ |      $$$$$$$  |  $$ |  $$$$$$$  |  $$ |   \$$$$$$\  
--\_____$$\ $$ \$$$  $$ |      $$  __|    $$  $$<  $$ |      $$ |     $$ |  $$ | \____$$\   $$ |   \$$\$$  / $$  __|\______|\____$$\ $$ |      $$  __$$<   $$ |  $$  ____/   $$ |    \____$$\ 
--$$\   $$ |$$ |\$  /$$ |      $$ |      $$  /\$$\ $$ |  $$\ $$ |     $$ |  $$ |$$\   $$ |  $$ |    \$$$  /  $$ |          $$\   $$ |$$ |  $$\ $$ |  $$ |  $$ |  $$ |        $$ |   $$\   $$ |
--\$$$$$$  |$$ | \_/ $$ |      $$$$$$$$\ $$ /  $$ |\$$$$$$  |$$$$$$$$\\$$$$$$  |\$$$$$$  |$$$$$$\    \$  /   $$$$$$$$\     \$$$$$$  |\$$$$$$  |$$ |  $$ |$$$$$$\ $$ |        $$ |   \$$$$$$  |
-- \______/ \__|     \__|      \________|\__|  \__| \______/ \________|\______/  \______/ \______|    \_/    \________|     \______/  \______/ \__|  \__|\______|\__|        \__|    \______/ 
-- JOIN OUR DISCORD FOR MORE LEAKS: discord.gg/fivemscripts
lib.locale()

local DataForHouse = {}
local HouseRobberiesData = {}
local PedDead = {}
local onTimerRob = {}
local HouseHacked = {}
local PedSpawned = {}
local HousePowdered = {}
local PropRobbedCreated = {}
local Lasers = {}
local LaseredHouse = {}
local SafeRobbed = {}
local PropRobbedStatic = {}

CreateThread( function()
    local currentTime = os.time()
    for i, house in each(HouseRobberiesData) do
        local lockHouse, changeHouse, resetTime, robbed = false, false, house.lastreset, house.robbed
        local difference = (house.lastreset + Config.ResetTime * 60) - currentTime
        if difference < 0 then
            lockHouse, changeHouse, resetTime, robbed = true, true, currentTime, {}
        end
        DataForHouse[house.house] = {
            locked = lockHouse,
            robbed = {},
            players = json.decode(house.players),
            lastreset = resetTime,
            changed = changeHouse
        }
    end
    syncDataForHouse()
end)

RegisterNetEvent("avid_houserobbery:sync")
AddEventHandler("avid_houserobbery:sync", function()
    local src = source
    TriggerClientEvent("avid_houserobbery:sync", src, DataForHouse, true)
end)

RegisterNetEvent("avid_houserobbery:lockpick")
AddEventHandler("avid_houserobbery:lockpick", function(data)
    local src = source
    local neededPoliceCount = Config.HousesToRob[data].Residence.NeedPoliceCount
    if CheckJob() < neededPoliceCount then
        TriggerClientEvent('avid_houserobbery:notify', src, 'error', locale('houserobbery'), locale('RequiredCops'))
        return
    end
    if GetItem(Config.Lockpick.item, 1, src) then
        if Config.Lockpick.remove then
            RemoveItem(Config.Lockpick.item, 1, src)
        end
        TriggerClientEvent("avid_houserobbery:lockpick", src, data)
    else
        TriggerClientEvent('avid_houserobbery:notify', src, 'error', locale('houserobbery'), locale('RequiredItems'))
    end
end)

RegisterNetEvent("avid_houserobbery:unlockHouse")
AddEventHandler( "avid_houserobbery:unlockHouse", function(house)
    local src = source

    Logs(src, locale('unlockedhouse', house))
    if DataForHouse[house] then
        DataForHouse[house].locked = false
    else
        DataForHouse[house] = {
            locked = false,
            robbed = {},
            players = {},
            lastreset = os.time(),
            changed = true
        }
    end
    TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
end)

RegisterNetEvent("avid_houserobbery:joinHouse")
AddEventHandler("avid_houserobbery:joinHouse", function(house)
    local src = source

    local alreadyIn = false

    if DataForHouse[house] then
        local char = GetIdent(src)
        for i, player in each(DataForHouse[house].players) do
            if player == char then
                alreadyIn = true
                break
            end
        end
    else
        DataForHouse[house] = {
            locked = false,
            robbed = {},
            players = {},
            lastreset = os.time(),
            changed = true
        }
    end

    if not alreadyIn then
        table.insert(DataForHouse[house].players, GetIdent(src))
    end
end)

RegisterNetEvent("avid_houserobbery:robbedHousePlace")
AddEventHandler("avid_houserobbery:robbedHousePlace", function(house, place)
    local src = source
    local Residence = Config.HousesToRob[house].Residence
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local dist = #(srcCoords - vec3(Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.x, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.y, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.z))
    if dist > 45 then
        if Config.DropPlayer then
            Logs(src, locale('ban/kick_reason_startrobbery_far'))
            DropPlayer(source, locale('ban/kick_reason_startrobbery_far'))
            return
        end
        BanPlayer(source, locale('ban/kick_reason_startrobbery_far'))
        return
    else
        if onTimerRob[src] and onTimerRob[src] > GetGameTimer() then
            if Config.DropPlayer then
                Logs(src, locale('ban/kick_reason_startrobbery_time'))
                DropPlayer(source, locale('ban/kick_reason_startrobbery_time'))
                return
            end
            BanPlayer(source, locale('ban/kick_reason_startrobbery_time'))
            return
        end
        onTimerRob[src] = GetGameTimer() + (1.5 * 1000)

        for _, AllPlaces in each(DataForHouse[house].robbed) do
            if place == AllPlaces then
                TriggerClientEvent('avid_houserobbery:notify', src, 'error', locale('houserobbery'), locale('emptyplace'))
                return
            end
        end

        if math.random(1, 100) <= Residence.InsidePositions[place].ChanceToFindNothing then
            TriggerClientEvent('avid_houserobbery:notify', src, 'error', locale('houserobbery'), locale('DidntFindItem'))
        else
            for i, v in each(Residence.InsidePositions[place].Items) do
                local luck = nil
                luck = math.random(100)
                if luck <= v.Chance then
                    foundItem = v.Item
                    count = math.random(v.MinCount, v.MaxCount)
                    Logs(src, 'Found **'..foundItem..'** **'..count..'x**')
                    AddItem(foundItem, count, src)
                    TriggerClientEvent('avid_houserobbery:notify', src, 'success', locale('houserobbery'), locale('FindItem', foundItem, count))
                end  
            end
        end

        table.insert(DataForHouse[house].robbed, place)
        DataForHouse[house].changed = true
        TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
    end
end)

RegisterNetEvent("avid_houserobbery:robbedHouseProp")
AddEventHandler("avid_houserobbery:robbedHouseProp", function(house, place)
    table.insert(DataForHouse[house].robbed, place)
    DataForHouse[house].changed = true
    TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
end)

RegisterNetEvent("avid_houserobbery:CheckHackedHouse")
AddEventHandler("avid_houserobbery:CheckHackedHouse", function(house)
    --table.insert(HouseHacked, {house = house})
    for k, v in pairs(HouseHacked) do
        if v.house == house then 
            TriggerClientEvent('avid_houserobbery:HackedSync', -1, v.house)
        end
    end
end)

RegisterNetEvent("avid_houserobbery:AddHackedHouse")
AddEventHandler("avid_houserobbery:AddHackedHouse", function(house)
    table.insert(HouseHacked, {house = house})
    TriggerClientEvent('avid_houserobbery:HackedSync', -1, house)
end)

RegisterNetEvent("avid_houserobbery:SpawnPed")
AddEventHandler("avid_houserobbery:SpawnPed", function(house, NPC)
    local exist =  (not DoesEntityExist(NPC))
    if not PedSpawned[house] or not exist then
        TriggerClientEvent('avid_houserobbery:SpawnPed', source, house, false)
        PedSpawned[house] = true
    end
end)

RegisterNetEvent("avid_houserobbery:CheckPowderHouse")
AddEventHandler("avid_houserobbery:CheckPowderHouse", function(house)
    for k, v in pairs(HousePowdered) do
        if v.house == house then 
            TriggerClientEvent('avid_houserobbery:PowderSync', -1, v.house) 
        end
    end
end)

RegisterNetEvent("avid_houserobbery:AddPowderHouse")
AddEventHandler("avid_houserobbery:AddPowderHouse", function(house)
    table.insert(HousePowdered, {house = house})
    for k, v in pairs(HousePowdered) do
        TriggerClientEvent('avid_houserobbery:PowderSync', -1, v.house)
    end
end)

RegisterNetEvent("avid_houserobbery:PowderedHouse")
AddEventHandler("avid_houserobbery:PowderedHouse", function(house, place)
    table.insert(DataForHouse[house].powdered, place)
    DataForHouse[house].changed = true
    TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
end)

RegisterNetEvent("avid_houserobbery:leaveHouse")
AddEventHandler( "avid_houserobbery:leaveHouse", function(house)
    local src = source
    for i, player in each(DataForHouse[house].players) do
        if player == GetIdent(src) then
            table.remove(DataForHouse[house].players, i)
            DataForHouse[house].changed = true
            break
        end
    end
end)

function syncDataForHouse()
    local currentTime = os.time()
    for house, data in pairs(DataForHouse) do
        if data.changed then
            data.changed = false
            local lockHouse = data.locked
            local difference = currentTime - (data.lastreset + Config.ResetTime * 60)
            if difference > 0 then
                lockHouse = true
            end

            if not Config.ResetHousesAfterTime then
                lockHouse = false
            end
            if lockHouse then
                data.locked = true
                data.robbed = {}
                data.lastreset = os.time()

                HouseHacked[house] = nil
                PedSpawned[house] = nil
                HousePowdered[house] = nil
                PropRobbedCreated[house] = nil
                Lasers[house] = nil
                LaseredHouse[house] = nil
                SafeRobbed[house] = nil
                PropRobbedStatic[house] = nil
                TriggerClientEvent("avid_houserobbery:missionoccupiedreset", -1)
                TriggerClientEvent("avid_houserobbery:reset", -1, house)
            end
            table.insert(HouseRobberiesData, {house = house, robbed = json.encode(data.robbed), players = json.encode(data.players), locked = lockHouse, lastreset = data.lastreset})
        end
    end
    TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse)
    SetTimeout(Config.ResetTime * 60, syncDataForHouse)
end

RegisterNetEvent("avid_houserobbery:localize")
AddEventHandler("avid_houserobbery:localize", function(type, house)
    local src = source
    local distance = #(GetEntityCoords(GetPlayerPed(src)) - vec3(Config.StartMission.Ped.coords.xyz))
    if distance < 20 then
        if type == 'newmission' then
            Logs(src, 'Started mission ')
        elseif type == 'cancelmission' then
            Logs(src, 'Stoped mission ')
        else
            if Config.DropPlayer then
                Logs(src, locale('ban/kick_reason_startmission_type'))
                DropPlayer(source, locale('ban/kick_reason_startmission_type'))
                return
            end
            BanPlayer(source, locale('ban/kick_reason_startmission_type'))
            return
        end
    else
        if Config.DropPlayer then
            Logs(src, locale('ban/kick_reason_startmission_far'))
            DropPlayer(source, locale('ban/kick_reason_startmission_far'))
            return
        end
        BanPlayer(source, locale('ban/kick_reason_startmission_far'))
        return
    end
end)

RegisterNetEvent("avid_houserobbery:removeobject")
AddEventHandler("avid_houserobbery:removeobject", function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then
        local owner = NetworkGetEntityOwner(entity)
		if owner <= 0 then
			DeleteEntity(entity)
		else
			TriggerClientEvent("avid_houserobbery:deleteObject", owner, netId)
		end
	end
end)

RegisterNetEvent("avid_houserobbery:PickUp")
AddEventHandler("avid_houserobbery:PickUp", function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then
        local owner = NetworkGetEntityOwner(entity)
		if owner <= 0 then
			DeleteEntity(entity)
            SetEntityAlpha(entity, 0, false)
            SetEntityCollision(entity, false, true)
		else
			TriggerClientEvent("avid_houserobbery:PickUpProp", owner, netId)
		end
	end
end)

RegisterNetEvent("avid_houserobbery:propcheck")
AddEventHandler("avid_houserobbery:propcheck", function(object, value, house, model)
    if object and house then
        TriggerClientEvent('avid_houserobbery:propcheck', -1, object, value, house, model) 
    end
end)

RegisterNetEvent("avid_houserobbery:propcheck2")
AddEventHandler("avid_houserobbery:propcheck2", function(object, value, house, netId, model)
    if object and house then
        if netId then
            DeleteEntity(NetworkGetEntityFromNetworkId(netId))
        end
        TriggerClientEvent('avid_houserobbery:propcheck2', -1, object, value, house) 
    end
end)

RegisterNetEvent("avid_houserobbery:lasercheck")
AddEventHandler("avid_houserobbery:lasercheck", function(laser, house)
    local AlreadyFound = false
    for k, v in pairs(Lasers) do
        if v.house == house then
            AlreadyFound = true
        end
    end
    if not AlreadyFound then
        SetTimeout(1000, function()
            table.insert(Lasers, {house = house, lasers = laser})
        end)
    end
    Wait(2000)
    for k, v in pairs(Lasers) do
        TriggerClientEvent('avid_houserobbery:lasercheck', -1, v.lasers, house) 
    end
end)

RegisterNetEvent("avid_houserobbery:CheckLaser")
AddEventHandler("avid_houserobbery:CheckLaser", function(house)
    for k, v in pairs(LaseredHouse) do
        if v.house == house then 
            TriggerClientEvent('avid_houserobbery:LaserSync', -1, v.house)
        end
    end
end)

RegisterNetEvent("avid_houserobbery:AddLaser")
AddEventHandler("avid_houserobbery:AddLaser", function(house)
    table.insert(LaseredHouse, {house = house})
    TriggerClientEvent('avid_houserobbery:LaserSync', -1, house)
end)

RegisterNetEvent("avid_houserobbery:RobbedSafe")
AddEventHandler("avid_houserobbery:RobbedSafe", function(house, place)
    local src = source
    local Residence = Config.HousesToRob[house].Residence
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local dist = #(srcCoords - vec3(Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.x, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.y, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.z))
    if dist > 45 then
        if Config.DropPlayer then
            Logs(src, locale('ban/kick_reason_startrobbery_far'))
            DropPlayer(source, locale('ban/kick_reason_startrobbery_far'))
            return
        end
        BanPlayer(source, locale('ban/kick_reason_startrobbery_far'))
        return
    else
        if onTimerRob[src] and onTimerRob[src] > GetGameTimer() then
            if Config.DropPlayer then
                Logs(src, locale('ban/kick_reason_startrobbery_time'))
                DropPlayer(source, locale('ban/kick_reason_startrobbery_time'))
                return
            end
            BanPlayer(source, locale('ban/kick_reason_startrobbery_time'))
            return
        end
        onTimerRob[src] = GetGameTimer() + (1.5 * 1000)
        local AlreadyRobbed = false
        for k, v in pairs(SafeRobbed) do
            if SafeRobbed[house] == nil then
                if v.house == house then 
                    if place == v.safe then
                        AlreadyRobbed = true
                    end
                end
            end
        end
        if not AlreadyRobbed then
            table.insert(SafeRobbed, {house = house, safe = place})
            if math.random(1, 100) <= Residence.Safes[place].ChanceToFindNothing then
                TriggerClientEvent('avid_houserobbery:notify', src, 'error', locale('houserobbery'), locale('DidntFindItem'))
            else
                for i, v in each(Residence.Safes[place].Items) do
                    local luck = nil
                    luck = math.random(100)
                    if luck <= v.Chance then
                        foundItem = v.Item
                        count = math.random(v.MinCount, v.MaxCount)
                        Logs(src, 'Found **'..foundItem..'** **'..count..'x**')
                        AddItem(foundItem, count, src)
                        TriggerClientEvent('avid_houserobbery:notify', src, 'success', locale('houserobbery'), locale('FindItem', foundItem, count))
                    end  
                end
            end
        end
        table.insert(DataForHouse[house].robbed, place)
        DataForHouse[house].changed = true
        TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
    end
end)

RegisterNetEvent("avid_houserobbery:robbedpropstatic")
AddEventHandler("avid_houserobbery:robbedpropstatic", function(model, house, place, netId, TrunkNeeded)
    local src = source
    local Residence = Config.HousesToRob[house].Residence
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local dist = #(srcCoords - vec3(Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.x, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.y, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.z))
    if not TrunkNeeded and dist > 45 then
        if Config.DropPlayer then
            Logs(src, locale('ban/kick_reason_startrobbery_far'))
            DropPlayer(source, locale('ban/kick_reason_startrobbery_far'))
            return
        end
        BanPlayer(source, locale('ban/kick_reason_startrobbery_far'))
        return
    else
        if onTimerRob[src] and onTimerRob[src] > GetGameTimer() then
            if Config.DropPlayer then
                Logs(src, locale('ban/kick_reason_startrobbery_time'))
                DropPlayer(source, locale('ban/kick_reason_startrobbery_time'))
                return
            end
            BanPlayer(source, locale('ban/kick_reason_startrobbery_time'))
            return
        end
        onTimerRob[src] = GetGameTimer() + (1.5 * 1000)
        local AlreadyRobbed = false
        for k, v in pairs(PropRobbedStatic) do
            if PropRobbedStatic[house] == nil then
                if v.house == house then 
                    if place == v.prop then
                        AlreadyRobbed = true
                    end
                end
            end
        end

        if not AlreadyRobbed then
            if model == Residence.StaticProps[place].model then
                table.insert(PropRobbedStatic, {house = house, prop = place})
                local count = Residence.StaticProps[place].Count or 1
                Logs(src, 'Found **'..Residence.StaticProps[place].Item..'** **'..count..'x**')
                AddItem(Residence.StaticProps[place].Item, count, src)
                TriggerClientEvent('avid_houserobbery:notify', src, 'success', locale('houserobbery'), locale('FindItem', Residence.StaticProps[place].Item, count))
                table.insert(DataForHouse[house].robbed, place)
                DataForHouse[house].changed = true
                TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
            end
        end
    end
end)

RegisterNetEvent("avid_houserobbery:robbedpropcreated")
AddEventHandler("avid_houserobbery:robbedpropcreated", function(model, house, place, netId, TrunkNeeded)
    local src = source
    local Residence = Config.HousesToRob[house].Residence
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    local dist = #(srcCoords - vec3(Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.x, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.y, Config.HousesToRob[house].Residence.InsidePositions.Exit.coords.z))
    if not TrunkNeeded and dist > 45 then
        if Config.DropPlayer then
            Logs(src, locale('ban/kick_reason_startrobbery_far'))
            DropPlayer(source, locale('ban/kick_reason_startrobbery_far'))
            return
        end
        BanPlayer(source, locale('ban/kick_reason_startrobbery_far'))
        return
    else
        if onTimerRob[src] and onTimerRob[src] > GetGameTimer() then
            if Config.DropPlayer then
                Logs(src, locale('ban/kick_reason_startrobbery_time'))
                DropPlayer(source, locale('ban/kick_reason_startrobbery_time'))
                return
            end
            BanPlayer(source, locale('ban/kick_reason_startrobbery_time'))
            return
        end
        onTimerRob[src] = GetGameTimer() + (1.5 * 1000)
        local AlreadyRobbed = false
        for k, v in pairs(PropRobbedCreated) do
            if PropRobbedCreated[house] == nil then
                if v.house == house then 
                    if place == v.prop then
                        AlreadyRobbed = true
                    end
                end
            end
        end
        if not AlreadyRobbed then
            if model == Residence.CreateProps[place].model then
                table.insert(PropRobbedCreated, {house = house, prop = place})
                local count = Residence.CreateProps[place].Count or 1
                Logs(src, 'Found **'..Residence.CreateProps[place].Item..'** **'..count..'x**')
                AddItem(Residence.CreateProps[place].Item, Residence.CreateProps[place].Count or 1, src)
                TriggerClientEvent('avid_houserobbery:notify', src, 'success', locale('houserobbery'), locale('FindItem', Residence.CreateProps[place].Item, count))
                table.insert(DataForHouse[house].robbed, place)
                DataForHouse[house].changed = true
                TriggerClientEvent("avid_houserobbery:sync", -1, DataForHouse, false)
            end
        end
    end
end)

lib.callback.register('avid_houserobbery:getitem', function(source, item)
    local src = source
    if GetItem(item, 1, src) then
        return true
    else
        return false
    end
end)

local missionzones = {}
local MissionOccupied = {}

RegisterNetEvent("avid_houserobbery:missionoccupied")
AddEventHandler("avid_houserobbery:missionoccupied", function(houseid)
    MissionOccupied[houseid] = true
    TriggerClientEvent("avid_houserobbery:missionoccupied", -1, houseid)
end)


RegisterNetEvent("avid_houserobbery:missionsync")
AddEventHandler("avid_houserobbery:missionsync", function(houseid)
    missionzones[houseid] = true
    TriggerClientEvent("avid_houserobbery:missionsync", -1, houseid)
end)

RegisterNetEvent("avid_houserobbery:missionsync2")
AddEventHandler("avid_houserobbery:missionsync2", function(spawn)
    for k, v in pairs(missionzones) do
        if missionzones[k] then
            TriggerClientEvent("avid_houserobbery:missionsync", source, k)
        end
    end
end)