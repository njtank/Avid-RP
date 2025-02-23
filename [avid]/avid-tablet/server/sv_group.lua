Core = exports['qb-core']:GetCoreObject()

local Players = {} -- Don't Touch if you don't know
local Groups = {}
-- Get the player's name
local function GetPlayerCharName(src)
    local player = Core.Functions.GetPlayer(src)
    return player.PlayerData.charinfo.firstname.." "..player.PlayerData.charinfo.lastname
end

Core.Functions.CreateUseableItem("tablet",function(source)
    TriggerClientEvent('OpenTabletRep', source)
end)

-- Random name when there is VPN
local function RandomName()
    local random1 = math.random(1, #Config.FirstName)
    local random2 = math.random(1, #Config.LastName)
    return Config.FirstName[random1].." "..Config.LastName[random2]
end

-- Send notification to all group members // Change notification type depending on the server
local function NotifyGroup(group, msg, type, time)
    if not group or not Groups[group] then return print("Group not found...") end
    for _, v in pairs(Groups[group].members) do
        TriggerClientEvent('QBCore:Notify', v.player, msg or "NO MSG", type or 'primary', time or 7500)
    end
end

exports("NotifyGroup", NotifyGroup)

-- Sends a notification to all group members
local function pNotifyGroup(group, header, msg, icon, colour, length)
    if not group or not Groups[group] then return print("Group not found...") end
    for _, v in pairs(Groups[group].members) do
        TriggerClientEvent('avid-tablet:client:CustomNotification', v.player,
            header or "NO HEADER",
            msg or "NO MSG",
            icon or "fas fa-phone-square",
            colour or "#e84118",
            length or 7500
        )
    end
end

exports("pNotifyGroup", pNotifyGroup)

--Get group by members
local function getGroup(src)
    if not Players[src] then return nil end
    for group, _ in pairs(Groups) do
        for _, v in pairs (Groups[group].members) do
            if v.player == src then
                return Groups[group]
            end
        end
    end
    return nil
end

exports("getGroup", getGroup)

--Get the group's Id by members
local function getGroupByMembers(src)
    if not Players[src] then return nil end
    for group, _ in pairs(Groups) do
        for _, v in pairs (Groups[group].members) do
            if v.player == src then
                return group
            end
        end
    end
    return nil
end

exports("getGroupByMembers", getGroupByMembers)

-- Get the id of the members in the group using the group id
local function getGroupMembers(id)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found")  end
    local temp = {}
    for _,v in pairs(Groups[id].members) do
        temp[#temp+1] = v.player
    end
    return temp
end

exports('getGroupMembers', getGroupMembers)

-- Get the number of members in the group
local function getGroupSize(id)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    return Groups[id].users
end

exports('getGroupSize', getGroupSize)

-- Get the group field's id by the group's id
local function GetGroupLeader(id)
      if not id then return print("Id not found") end
    if Groups[id] == nil then
        return nil
    end
    return Groups[id].leader
end

exports("GetGroupLeader", GetGroupLeader)

-- Trigger event for group members
function GroupEvent(id, event, args)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    if not event then return print("no valid event was passed to GroupEvent") end
    local members = getGroupMembers(id)
    if members and #members > 0 then
        for i = 1, #members do
            if members[i] then
                if args ~= nil then
                    TriggerClientEvent(event, members[i], table.unpack(args))
                else
                    TriggerClientEvent(event, members[i])
                end
            end
        end
    end
end

exports("GroupEvent", GroupEvent)

-- Check to see if it's the group leader or not
local function isGroupLeader(src, id)
    if not id then return end
    local grouplead = GetGroupLeader(id)
    return grouplead == src or false
end

exports('isGroupLeader', isGroupLeader)

---- Set tasks for the group
local function setJobStatus(id, stages)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    Groups[id].status = true
    Groups[id].stage = stages or {}
    local m = getGroupMembers(id)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("avid-tablet:client:AddGroupStage", m[i], Groups[id])
        end
    end
end
exports('setJobStatus', setJobStatus)

-- Change group leader
local function ChangeGroupLeader(id)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    local members = Groups[id].members
    local leader = GetGroupLeader(id)
    if #members > 1 then
        for i=1, #members do
            if members[i].player ~= leader then
                Groups[id].leader = members[i].player
                Groups[id].gName = members[i].name
                TriggerClientEvent('QBCore:Notify', members[i].player, "You have become the group leader", "success")
                return true
            end
        end
    end
    return false
end

-- Reset the party's stage to zero
local function resetJobStatus(id)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    Groups[id].status = false
    Groups[id].stage = {}
    local m = getGroupMembers(id)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent('avid-tablet:client:AddGroupStage', m[i], Groups[id])
        end
    end
    TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
end

exports('resetJobStatus', resetJobStatus)

-- Delete group
local function DestroyGroup(id)
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    local members = getGroupMembers(id)
    if members and #members > 0 then
        for i = 1, #members do
            if members[i] then
                TriggerClientEvent('avid-tablet:client:UpdateGroupId', members[i], 0)
                TriggerClientEvent('avid-tablet:client:checkout', members[i])
                TriggerClientEvent('avid-tablet:client:closeAllNotification', members[i])
                Wait(100)
                TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', members[i], true)
                Players[members[i]] = false
            end
        end
    end
    if Config.JobCenter[Groups[id].job] then
        Config.JobCenter[Groups[id].job].count = Config.JobCenter[Groups[id].job].count - 1
    end
    TriggerClientEvent('avid-tablet:client:updateGroupJob', -1, Config.JobCenter)
    Groups[id] = nil
    TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
end

exports("DestroyGroup", DestroyGroup)

-- Kick players out of the group
local function RemovePlayerFromGroup(src, id, disconnected)
    if not Players[src]  then return false end
    if not id then return print("Id not found") end
    if not Groups[id] then return print("Group :"..id.." not found") end
    local g = Groups[id].members
    for k,v in pairs(g) do
        if v.player == src then
            table.remove(Groups[id].members, k)
            Groups[id].users = Groups[id].users - 1
            Players[src] = false
            TriggerClientEvent('avid-tablet:client:UpdateGroupId', src, 0)
            pNotifyGroup(id, "Job Center", src.." has left the group", "fas fa-users", "#FFBF00", 7500)
            TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', src, true)
            if disconnected then 
                TriggerClientEvent("QBCore:Notify", src, "You have left the group", "error")
                TriggerClientEvent('avid-tablet:client:checkout', src)
            else
                TriggerClientEvent("QBCore:Notify", src, "You have left the group", "error")
            end
            if Groups[id].users <= 0 then
                DestroyGroup(id)
            else
                local m = getGroupMembers(id)
                if not m then return end
                for i=1, #m do
                    if m[i] then
                        TriggerClientEvent('avid-tablet:client:AddGroupStage', m[i], Groups[id])
                    end
                end
            end
            TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
            return
        end
    end
end

----EVENT-----
--Create groups
RegisterNetEvent("avid-tablet:server:createJobGroup", function(bool, job)
    local src = source
    local player = Core.Functions.GetPlayer(src)
    if Players[src] then TriggerClientEvent('QBCore:Notify', src, "You have already created a group", "error") return end
    Players[src] = true
    local ID = #Groups+1
    local name
    if bool then
        name = RandomName()
    else
        name = GetPlayerCharName(src)
    end
    Groups[ID] = {
        id = ID,
        status = false,
        job = job,
        gName = name,
        users = 1,
        leader = src,
        members = {
            {name = name, cid = player.PlayerData.citizenid, player = src, vpn = bool}
        },
        stage = {},
    }
    if Config.JobCenter[job] then
        Config.JobCenter[job].count = Config.JobCenter[job].count + 1
    else
        Config.JobCenter[job].count = 1
    end
    TriggerClientEvent('avid-tablet:client:updateGroupJob', -1, Config.JobCenter)
    TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
    TriggerClientEvent('avid-tablet:client:UpdateGroupId', src, ID)
    TriggerClientEvent('avid-tablet:client:AddGroupStage', src, Groups[ID])
end)

RegisterNetEvent("avid-tablet:server:updateVPN", function (result)
    local src = source
    if Players[src] then
        local id = getGroupByMembers(src)
        local leader = isGroupLeader(src, id)
        if result then
            local name = RandomName()
            if leader then
                Groups[id].gName = name
            end
            for _, v in pairs (Groups[id].members) do
                if v.player == src then
                    Groups[id].members[_].name = name
                    Groups[id].members[_].vpn = true
                end
            end
        else
            local name = GetPlayerCharName(src)
            if leader then
                Groups[id].gName = name
            end
            for _, v in pairs (Groups[id].members) do
                if v.player == src then
                    Groups[id].members[_].name = name
                    Groups[id].members[_].vpn = false
                end
            end
        end
        TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
        local m = getGroupMembers(id)
        if not m then return end
        for i=1, #m do
            if m[i] then
                TriggerClientEvent('avid-tablet:client:AddGroupStage', m[i], Groups[id])
            end
        end
    end
end)

RegisterNetEvent('avid-tablet:server:requestJoinGroup', function(data)
    local src = source
    if Players[src] then return TriggerClientEvent("QBCore:Notify", src, "You are already a part of a group", "error")  end
    if not data.id then
        return
    end
    if not Groups[data.id] then return TriggerClientEvent("QBCore:Notify", src, "That group doesn't exist", "error") end
    local leader = GetGroupLeader(data.id)
    TriggerClientEvent('avid-tablet:client:requestJoinGroup', leader, src)
end)

RegisterNetEvent('avid-tablet:client:requestJoin', function(target, bool)
    local src = source
    if not Groups[getGroupByMembers(src)] then return TriggerClientEvent("QBCore:Notify", target, "That group doesn't exist", "error") end
    if Groups[getGroupByMembers(src)].status == true then
        TriggerClientEvent("QBCore:Notify", target, "This group is already working", "error")
        return
    end
    if bool then
        if getGroupSize(getGroupByMembers(src)) < 6 then
            TriggerClientEvent('avid-tablet:client:Join', target, getGroupByMembers(src))
        else
            TriggerClientEvent("QBCore:Notify", target, getGroupByMembers(src).." is full", "error")
            TriggerClientEvent("QBCore:Notify", src, "Cannot recruit more people into the team", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", target, "The group leader "..getGroupByMembers(src).." has rejected you", "error")
    end
end)

RegisterNetEvent('avid-tablet:server:Join', function (id, vpn)
    local src = source
    local player = Core.Functions.GetPlayer(src)
    if Players[src] then return TriggerClientEvent('QBCore:Notify', src, "You are already a part of a group!", "success") end
    if not id then
        return
    end
    if not Groups[id] then return TriggerClientEvent("QBCore:Notify", src, "That group doesn't exist", "error") end
    if Groups[id].status == true then
        TriggerClientEvent("QBCore:Notify", src, "This group is already working", "error")
        return
    end
    local name
    if vpn then
        name = RandomName()
    else
        name = GetPlayerCharName(src)
    end
    pNotifyGroup(id, "Job Center", src.." has join the group", "fas fa-users", "#FFBF00", 7500)
    Groups[id].members[#Groups[id].members+1] = {name = name, cid = player.PlayerData.citizenid, player = src, vpn = vpn}
    Groups[id].users = Groups[id].users + 1
    Players[src] = true
    local m = getGroupMembers(id)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent('avid-tablet:client:AddGroupStage', m[i], Groups[id])
        end
    end
    TriggerClientEvent('QBCore:Notify', src, "You joined the group "..id, "success")
    TriggerClientEvent('avid-tablet:client:RefreshGroupsApp', -1)
    TriggerClientEvent('avid-tablet:client:JoinSuccess',src)
end)

RegisterNetEvent('avid-tablet:server:LeaveGroup', function(id)
    local src = source
    if not id then
        return
    end
    if not Players[src] then return end
    if isGroupLeader(src, id) then
        local change = ChangeGroupLeader(id)
        if change then
            RemovePlayerFromGroup(src, id)
        else
            DestroyGroup(id)
        end
    else
        RemovePlayerFromGroup(src, id)
    end
end)

RegisterNetEvent('avid-tablet:server:DisbandGroup', function(id)
    local src = source
    if not Players[src] then return end
    DestroyGroup(id)
end)

RegisterNetEvent('avid-tablet:server:checkout', function(id)
    local src = source
    if not Players[src] then return end
    if isGroupLeader(src, id) then
        if Groups[id].status == true then
            DestroyGroup(id)
        else
            local change = ChangeGroupLeader(id)
            if change then
                RemovePlayerFromGroup(src, id, true)
            else
                DestroyGroup(id)
            end
        end
    else
        RemovePlayerFromGroup(src,id, true)
    end
end)

Core.Functions.CreateCallback('avid-tablet:callback:getGroupsApp', function(source, cb)
    local src = source
    if Players[src] then
        local id = getGroupByMembers(src)
        cb(true, Groups[id])
    else
        cb(false, Groups)
    end
end)

Core.Functions.CreateCallback('avid-tablet:callback:getGroupsJob', function(source, cb)
    cb(Config.JobCenter)
end)

Core.Functions.CreateCallback('avid-tablet:callback:CheckPlayerNames', function(source, cb, id)
    local src = source
    if Groups[id] == nil then
        TriggerClientEvent("QBCore:Notify", src, "That group doesn't exist", "error")
        cb(false)
    end
    cb(Groups[id].members)
end)

Core.Functions.CreateCallback('avid-tablet:callback:getDataGroup', function(_, cb)
    cb(Groups)
end)

AddEventHandler('playerDropped', function()
	local src = source
    local id = getGroupByMembers(src)
    if id then
        if isGroupLeader(src, id) then
            if Groups[id].status == true then
                DestroyGroup(id)
            else
                local change = ChangeGroupLeader(id)
                if change then
                    RemovePlayerFromGroup(src, id, true)
                else
                    DestroyGroup(id)
                end
            end
        else
            RemovePlayerFromGroup(src, id, true)
        end
    end
end)
