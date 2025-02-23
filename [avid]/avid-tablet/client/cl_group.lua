local inJob = false
local requestCoolDown = false
local isGroupLeader = false
local vpn = false
local groupID = 0
local JobCenter = {}
local request = false

local function loadConfig()
    SendNUIMessage({
        action = "loadConfig",
        config = Config.JobCenter,
    })
end

exports("IsGroupLeader", function()
    return isGroupLeader
end)

exports("GetGroupID", function()
    return groupID
end)

local function ReQuest(title, text, icon, color, timeout, accept, deny)
    request = promise.new()
    SendNUIMessage({
        action = "ReQuest",
        TabletNotify = {
            title = title or "Rep Scripts",
            text = text or "MSG",
            icon = icon or "fas fa-home",
            color = color or "#FFBF00",
            timeout = timeout or 7500, -- If it is "NONE", it will not turn off automatically
            accept = accept or "fas fa-check-circle",
            deny = deny or "fas fa-times-circle",
        },
    })
    local result = Citizen.Await(request)
    return result
end

RegisterNUICallback('openMap', function()
    ExecuteCommand('e tablet2')
    exports['ps-ui']:ShowImage("https://images-ext-2.discordapp.net/external/Fav1ERUT4HznSnjZopp2QH3DHYw2Yh1rLmzyaCgAJUI/https/saeshq2018.weebly.com/uploads/1/1/8/7/118771343/5470709-orig_orig.png?width=690&height=702")
end)

RegisterNUICallback('AcceptNotification', function()
    request:resolve(true)
    request = nil
end)

RegisterNUICallback('DenyNotification', function()
    request:resolve(false)
    request = nil
end)

exports("ReQuest", ReQuest)

-- KWhen turned on, the app will send a message to see if there is a job or not. If there is a job, check
RegisterNUICallback('GetData', function(data, cb)
    local job = LocalPlayer.state.nghe
    if job then
        Core.Functions.TriggerCallback('avid-tablet:callback:getGroupsApp', function (bool, data)
            if bool then
                SendNUIMessage({
                    action = "addGroupStage",  -- When setting state, the status returns to true, and when refreshing App, the job's status returns to false. If Stage == {} then returns the group members interface
                    status =  data,   -- Structure of stage https://cdn.discordapp.com/attachments/1036820124784668692/1052217816528461894/image.png
                })
            else
                SendNUIMessage({
                    action = "refreshApp",  --https://cdn.discordapp.com/attachments/1036820124784668692/1052217278701244527/image.png -- Structure of data sent
                    data = data, -- Remember to redo the for table to check which ones have the same job to add and see which statuses are busy and which are not busy // Group information
                    job = LocalPlayer.state.nghe -- Profession, filter out groups in the data table that have the same occupation
                })
            end
        end)
    else --- Jobcenter will display a list of occupations
        SendNUIMessage({
            action = "jobcenter",
            data = JobCenter,
        })
    end
end)

-- Create blip to workplace
RegisterNUICallback('CreateBlip', function(data)
    TriggerEvent(data.event)
end)

RegisterNUICallback('readyToJob', function()
    if groupID == 0 then return end
    local success = ReQuest("Job Offer", 'Would you like to begin this job?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success == nil then return end
    if success then
        TriggerEvent('avid-tablet:client:readyforjob')
    else
        SendNUIMessage({
            action = "reLoop", -- When setting state, the status returns to true, and when refreshing App, the job's status returns to fail
        })
    end
end)

-- Create groups
RegisterNUICallback('CreateJobGroup', function(data, cb) --employment
    local result = vpn
    TriggerServerEvent('avid-tablet:server:createJobGroup', result, LocalPlayer.state.nghe)
    isGroupLeader = true
    cb("ok")
end)

--Request tp join the group
RegisterNUICallback('RequestToJoin', function (data, cb)
    if not requestCoolDown then
        requestCoolDown = true
        Core.Functions.Notify("Sent Request", "success")
        TriggerServerEvent('avid-tablet:server:requestJoinGroup', data)
        Wait(5000)
        requestCoolDown = false
    else
        Core.Functions.Notify("You need to wait before requesting again", "error")
    end
end)

RegisterNUICallback('checkOut', function (data, cb)
    if groupID ~= 0 or inJob then
        if inJob then
            SendNUIMessage({
                action = "closeAllNotification",
            })
            TriggerServerEvent('avid-tablet:server:checkout', groupID)
            LocalPlayer.state:set('nghe', nil, false)
        end
    end
    if groupID == 0 then
        TriggerEvent('avid-tablet:client:checkout')
    end
    SendNUIMessage({
        action = "jobcenter",
        data = JobCenter,
    })
end)

RegisterNetEvent('avid-tablet:client:closeAllNotification', function ()
    SendNUIMessage({
        action = "closeAllNotification",
    })
end)
-- Leave Group
RegisterNUICallback('LeaveGroup', function(data, cb) 
    if not data then return end
    local success = ReQuest("Job Center", 'Are you sure you want to leave the group?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        isGroupLeader = false
        TriggerServerEvent('avid-tablet:server:LeaveGroup', groupID)
        cb("ok")
    end
end)
-- Disband Group
RegisterNUICallback('DisbandGroup', function(data, cb) 
    if not data then return end
    local success = ReQuest("Job Center", 'Are you sure you want to disband the group?', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        isGroupLeader = false
        TriggerServerEvent('avid-tablet:server:DisbandGroup', groupID)
        cb("ok")
    end
end)

-- Events --
-- Refresh the group, anyone in the stage will not edit
RegisterNetEvent('avid-tablet:client:RefreshGroupsApp', function(bool)
    local job = LocalPlayer.state.nghe
    if not job then
        SendNUIMessage({
            action = "jobcenter",
            data = JobCenter,
        })
    else
        if bool then inJob = false end
        if inJob then return end
        Core.Functions.TriggerCallback('avid-tablet:callback:getGroupsApp', function (bool1, data)
            if bool1 then
                SendNUIMessage({
                    action = "addGroupStage",  -- When setting state, the status returns to true, and when refreshing app, the job's status returns to false. If stage == {} then returns the group members interface
                    status =  data,   -- Structure of stage https://cdn.discordapp.com/attachments/1036820124784668692/1052217816528461894/image.png
                })
            else
                SendNUIMessage({
                    action = "refreshApp",  --https://cdn.discordapp.com/attachments/1036820124784668692/1052217278701244527/image.png 
                    data = data, 
                    job = LocalPlayer.state.nghe 
                })
            end
        end)
    end
end)

-- When you sign in, groups for that profession will appear
RegisterNetEvent('avid-tablet:client:signIn', function(bool)
    LocalPlayer.state:set('nghe', bool, false)
    Core.Functions.TriggerCallback('avid-tablet:callback:getGroupsApp', function (bool, data)
        if bool then
        else
            SendNUIMessage({
                action = "refreshApp",  --https://cdn.discordapp.com/attachments/1036820124784668692/1052217278701244527/image.png 
                data = data, 
                job = LocalPlayer.state.nghe
            })
        end
    end)
end)

-- When you sign off, you will switch back to the jobcenter interface
RegisterNetEvent('avid-tablet:client:signOff', function()
    if groupID ~= 0 or inJob then
        if inJob then
            SendNUIMessage({
            action = "closeAllNotification",
        })
        end
        TriggerServerEvent('avid-tablet:server:checkout', groupID)
        LocalPlayer.state:set('nghe', nil, false)
    end
    if groupID == 0 then
        TriggerEvent('avid-tablet:client:checkout')
    end
    SendNUIMessage({
        action = "jobcenter",
        data = JobCenter,
    })
end)

-- Add tasks
RegisterNetEvent('avid-tablet:client:AddGroupStage', function(data)
    inJob = true
    SendNUIMessage({
        action = "addGroupStage",
        status =  data
    })
end)

--Set Id to group
RegisterNetEvent('avid-tablet:client:UpdateGroupId', function(id)
    groupID = id
    if id == 0 then
        isGroupLeader = false
    end
end)

--Request to join a group
RegisterNetEvent('avid-tablet:client:requestJoinGroup', function(target)
    local success = ReQuest("Job Center", target..' want to join your group', 'fas fa-users', '#FFBF00', "NONE", 'bx bxs-check-square', 'bx bxs-x-square')
    if success then
        TriggerServerEvent('avid-tablet:client:requestJoin', target, true)
    else
        TriggerServerEvent('avid-tablet:client:requestJoin', target, false)
    end
end)

RegisterNetEvent('avid-tablet:client:notReady', function ()
    SendNUIMessage({
        action = "cancelReady",
    })
end)

--Update Group Job
RegisterNetEvent('avid-tablet:client:updateGroupJob', function (data)
    Config.JobCenter = data
    loadConfig()
    JobCenter = {}
    for k, v in pairs(Config.JobCenter) do
        if vpn then
            JobCenter[#JobCenter+1] = v
        else
            if v.vpn == false then
                JobCenter[#JobCenter+1] = v
            end
        end
    end
end)

--Join the group
RegisterNetEvent('avid-tablet:client:Join', function(id)
    groupID = id
    TriggerServerEvent('avid-tablet:server:Join', id, vpn)
end)

-- Request
RegisterNetEvent("avid-tablet:client:request", function(title, text, icon, color, timeout, accept, deny)
    ReQuest(title, text, icon, color, timeout, accept, deny)
end)

RegisterNetEvent('avid-tablet:jobcenter:tow', function()
    SetNewWaypoint(-238.94, -1183.74)
end)

RegisterNetEvent('avid-tablet:jobcenter:taxi', function()
    SetNewWaypoint(909.51, -177.36)
end)

RegisterNetEvent('avid-tablet:jobcenter:postop', function()
    SetNewWaypoint(-432.51, -2787.98)
end)

RegisterNetEvent('avid-tablet:jobcenter:sanitation', function()
    SetNewWaypoint(-351.44, -1566.37)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = nil
end)

local function CheckVPN()
    for _, itemData in pairs(PlayerData.items) do
        if itemData.name == 'vpn' then
            return true
        end
    end
    return false
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    Wait(100)
    local result = CheckVPN()
    if vpn ~= result then
        vpn = result
        JobCenter = {}
        for k, v in pairs(Config.JobCenter) do
            if vpn then
                JobCenter[#JobCenter+1] = v
            else
                if v.vpn == false then
                    JobCenter[#JobCenter+1] = v
                end
            end
        end
        TriggerServerEvent('avid-tablet:server:updateVPN', result)
    end
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerData = Core.Functions.GetPlayerData()
        vpn = CheckVPN()
        JobCenter = {}
        for k, v in pairs(Config.JobCenter) do
            if vpn then
                JobCenter[#JobCenter+1] = v
            else
                if v.vpn == false then
                    JobCenter[#JobCenter+1] = v
                end
            end
        end
        LocalPlayer.state.nghe = nil
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(10000)
    Core.Functions.TriggerCallback('avid-tablet:callback:getGroupsJob', function (data)
        Config.JobCenter = data
    end)
    vpn = CheckVPN()
    loadConfig()
    JobCenter = {}
    for k, v in pairs(Config.JobCenter) do
        if vpn then
            JobCenter[#JobCenter+1] = v
        else
            if v.vpn == false then
                JobCenter[#JobCenter+1] = v
            end
        end
    end
    PlayerData = Core.Functions.GetPlayerData()
end)
