local QBCore = exports['qb-core']:GetCoreObject()

ArtHeist = {
    ['start'] = false,
    ['cuting'] = false,
    ['startPeds'] = {},
    ['sellPeds'] = {},
    ['cut'] = 0,
    ['objects'] = {},
    ['scenes'] = {},
    ['painting'] = {}
}



Citizen.CreateThread(function()
    for k, v in pairs(Config['ArtHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        ArtHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['startPeds'][k], true)
        SetEntityInvincible(ArtHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['startPeds'][k], true)
    end
    for k, v in pairs(Config['ArtHeist']['sellPainting']['peds']) do
        loadModel(v['ped'])
        ArtHeist['sellPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['sellPeds'][k], true)
        SetEntityInvincible(ArtHeist['sellPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['sellPeds'][k], true)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local heistDist = #(pedCo - Config['ArtHeist']['startHeist']['pos'])
        local sellDist = #(pedCo - Config['ArtHeist']['sellPainting']['pos'])
        --[[if heistDist <= 3.0 then
            sleep = 1
            ShowHelpNotification(Strings['start_heist'])
            if IsControlJustPressed(0, 38) then
                StartHeist()
            end
        elseif sellDist <= 3.0 then
            sleep = 1
            ShowHelpNotification(Strings['sell_painting'])
            if IsControlJustPressed(0, 38) then
                FinishHeist()
            end
        end ]]
        if ArtHeist['start'] then
            for k, v in pairs(Config['ArtHeist']['painting']) do
                local dist = #(pedCo - v['scenePos'])
                if dist <= 1.0 then
                    sleep = 1
                    if not v['taken'] then
                        ShowHelpNotification(Strings['start_stealing'])
                        if IsControlJustPressed(0, 38) then
                            local weapon = GetSelectedPedWeapon(ped)
                            if weapon == GetHashKey('WEAPON_SWITCHBLADE') then
                                if not ArtHeist['cuting'] then
                                    HeistAnimation(k)
                                else
                                    QBCore.Functions.Notify(Strings['already_cuting'], 'primary')
                                end
                            else
                                QBCore.Functions.Notify('You dont armed a switchblade', 'error')
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('artheist:client:policeAlert')
AddEventHandler('artheist:client:policeAlert', function(targetCoords)
    QBCore.Functions.Notify(Strings['police_alert'], 'primary')
    local alpha = 250
    local artheistBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(artheistBlip, true)
    SetBlipColour(artheistBlip, 1)
    SetBlipAlpha(artheistBlip, alpha)
    SetBlipAsShortRange(artheistBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(125)
        alpha = alpha - 1
        SetBlipAlpha(artheistBlip, alpha)

        if alpha == 0 then
            RemoveBlip(artheistBlip)
            return
        end
    end
end)
--exports('artheist', artheist)
RegisterNetEvent('artheist:client:syncHeistStart')
AddEventHandler('artheist:client:syncHeistStart', function()
    ArtHeist['start'] = not ArtHeist['start']
end)

RegisterNetEvent('artheist:client:syncPainting')
AddEventHandler('artheist:client:syncPainting', function(x)
    Config['ArtHeist']['painting'][x]['taken'] = true
end)

RegisterNetEvent('artheist:client:syncAllPainting')
AddEventHandler('artheist:client:syncAllPainting', function(x)
    for k, v in pairs(Config['ArtHeist']['painting']) do
        v['taken'] = false
    end
end)

function FinishHeist()
    for k, v in pairs(ArtHeist['sellPeds']) do
        TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
    end
    TriggerServerEvent('artheist:server:finishHeist')
    RemoveBlip(sellBlip)
    if DoesBlipExist(stealBlip) then
        RemoveBlip(stealBlip)
    end
end


-- ADDING TARGET TO SCRIPT --
local coords = vector3(244.346, 374.012, 105.738)
local radius = 2.0 -- Adjust radius as needed

exports.ox_target:addSphereZone({
    coords = coords,
    radius = radius,
    options = {
        {
            name = 'start_heist',
            event = 'heist:start', -- Custom event name
            icon = 'fas fa-mask', -- Icon to display in the target menu
            label = 'Start Heist', -- Label to display in the target menu
        }
    }
})

-- Event handler for starting the heist
RegisterNetEvent('heist:start')
AddEventHandler('heist:start', function()
    StartHeist()
    -- Define the spawn locations for the NPCs
    local npcSpawns = {
        {x = 1399.67, y = 1163.8, z = 114.33, heading = 179.69},
        {x = 1392.48, y = 1147.18, z = 114.33, heading = 267.34},
        {x = 1405.31, y = 1149.3, z = 114.33, heading = 158.15},
        {x = 1400.22, y = 1131.17, z = 114.33, heading = 30.25},
        {x = 1391.97, y = 1137.96, z = 114.44, heading = 89.82},
        {x = 1389.86, y = 1157.54, z = 114.33, heading = 124.35},
    }

    -- The NPC model and weapon
    local npcModel = `CSB_MWeather`
    local weaponHash = `WEAPON_ASSAULTSMG`

    -- Ensure the model is loaded
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(0)
    end

    -- Spawn the NPCs
    for _, spawn in ipairs(npcSpawns) do
        local ped = CreatePed(4, npcModel, spawn.x, spawn.y, spawn.z, spawn.heading, true, true)
        
        -- Give the NPC a weapon
        GiveWeaponToPed(ped, weaponHash, 999, false, true)

        -- Set the NPC health
        SetEntityHealth(ped, 250)

        -- Make the NPC hostile
        SetPedAsEnemy(ped, true)
        TaskCombatPed(ped, GetPlayerPed(-1), 0, 16) -- Target the player
    end

    -- Clean up the model to free memory
    SetModelAsNoLongerNeeded(npcModel)
end)

function StartHeist()
    QBCore.Functions.TriggerCallback('artheist:server:checkRobTime', function(time)
        if time then
            if ArtHeist['start'] then QBCore.Functions.Notify(Strings['already_heist'], 'primary') return end
            for k, v in pairs(ArtHeist['startPeds']) do
                TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
            end
            local paintingList = {}
            for k, v in pairs(Config['ArtHeist']['painting']) do
                table.insert(paintingList, {v['object']})
            end
            SendNUIMessage({
                action = 'open',
                list = paintingList
            })
            Wait(3000)
            TriggerServerEvent('artheist:server:syncHeistStart')
            QBCore.Functions.Notify(Strings['go_steal'], 'primary')
            stealBlip = addBlip(vector3(1397.66, 1140.42, 114.268), 439, 0, Strings['steal_blip'])
            repeat
                local ped = PlayerPedId()
                local pedCo = GetEntityCoords(ped)
                local dist = #(pedCo - Config['ArtHeist']['painting'][1]['scenePos'])
                Wait(1)
            until dist <= 100.0
            for k, v in pairs(Config['ArtHeist']['painting']) do
                loadModel(v['object'])
                ArtHeist['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 1, 0)
                SetEntityRotation(ArtHeist['painting'][k], 0, 0, v['objHeading'], 2, true)
            end
        end
    end)
end

function HeistAnimation(sceneId)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local scene = Config['ArtHeist']['painting'][sceneId]
    TriggerServerEvent('artheist:server:syncPainting', sceneId)
    loadAnimDict(animDict)
    
    for k, v in pairs(Config['ArtHeist']['objects']) do
        loadModel(v)
        ArtHeist['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end
    
    ArtHeist['objects'][3] = ArtHeist['painting'][sceneId]
    
    for i = 1, 10 do
        ArtHeist['scenes'][i] = NetworkCreateSynchronisedScene(scene['scenePos']['x'], scene['scenePos']['y'], scene['scenePos']['z'], scene['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][3], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][1], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][2], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][5], 1.0, -1.0, 1148846080)
    end

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    ArtHeist['cuting'] = true
    FreezeEntityPosition(ped, true)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][1])
    PlayCamAnim(cam, 'ver_01_top_left_enter_cam_ble', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][2])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(Strings['cute_right'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][3])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_to_right_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][4])
    PlayCamAnim(cam, 'ver_01_cutting_top_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(Strings['cute_down'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][5])
    PlayCamAnim(cam, 'ver_01_cutting_right_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][6])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(Strings['cute_left'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][7])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_to_left_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    repeat
        ShowHelpNotification(Strings['cute_down'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][9])
    PlayCamAnim(cam, 'ver_01_cutting_left_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(1500)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][10])
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    Wait(7500)
    TriggerServerEvent('artheist:server:rewardItem', scene)
    ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
    RemoveAnimDict(animDict)
    for k, v in pairs(ArtHeist['objects']) do
        DeleteObject(v)
    end
    DeleteObject(ArtHeist['painting'][sceneId])
    ArtHeist['objects'] = {}
    ArtHeist['scenes'] = {}
    ArtHeist['cuting'] = false
    ArtHeist['cut'] = ArtHeist['cut'] + 1
    scenes = {false, false, false, false}
    if ArtHeist['cut'] == 1 then
        exports['ps-dispatch']:ArtGalleryRobbery()
        --TriggerServerEvent('artheist:server:policeAlert', GetEntityCoords(PlayerPedId()))
    end
    if ArtHeist['cut'] == #Config['ArtHeist']['painting'] then
        TriggerServerEvent('artheist:server:syncHeistStart')
        TriggerServerEvent('artheist:server:syncAllPainting')
        QBCore.Functions.Notify(Strings['go_sell'], 'primary')
        RemoveBlip(stealBlip)
        sellBlip = addBlip(Config['ArtHeist']['sellPainting']['pos'], 500, 0, Strings['sell_blip'])
        ArtHeist['cut'] = 0
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Citizen.Wait(50)
    end
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(ArtHeist['painting']) do
            DeleteObject(v)
        end
        for k, v in pairs(ArtHeist['objects']) do
            DeleteObject(v)
        end
    end
end)


