local TSE = TriggerServerEvent

if Config.SellShop.enabled then

RegisterNetEvent("avid_houserobbery:SellShop:menus", function()
    PlayPedAmbientSpeechNative(SellShopNPC, 'Generic_Hows_It_Going', 'Speech_Params_Force')
    options = {}
    if Config.Context == "ox_lib" then
        for _, v in pairs(Config.SellShop.Items) do
            options[v.label] = {}
            options[v.label].arrow = false
            options[v.label].description = v.description .. v.price
            options[v.label].event = 'avid_houserobbery:SellShop:progress'
            options[v.label].args = { item = v.item, price = v.price, min = v.MinAmount,
                max = v.MaxAmount }
        end
        lib.registerContext({
            id = 'SellShop',
            title = Config.SellShop.Header,
            options = options
        })
        lib.showContext('SellShop')
    elseif Config.Context == "qbcore" then
        options[#options + 1] = {
            isMenuHeader = true,
            header = Config.SellShop.Header
        }

        for _, v in pairs(Config.SellShop.Items) do
            options[#options + 1] = {
                header = v.label,
                arrow = false,
                txt = v.description .. v.price,
                params = {
                    event = 'avid_houserobbery:SellShop:progress',
                    args = { item = v.item, price = v.price, min = v.MinAmount, 
                        max = v.MaxAmount }
                }
            }
        end
        exports['qb-menu']:openMenu(options)
    end
end)

RegisterNetEvent("avid_houserobbery:SellShop:all", function()
    if Config.SellShop.EnabledSellAll then
        dict = "misscarsteal4@actor"
        clip = "actor_berating_loop"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        ProgressBar(6000, locale("selling"))
        ClearPedTasks(cache.ped)
        PlayPedAmbientSpeechNative(SellShopNPC, 'GENERIC_THANKS', 'SPEECH_PARAMS_FORCE')
        TSE("avid_houserobbery:SellShop:sellall")
    end
end)

RegisterNetEvent("avid_houserobbery:SellShop:progress")
AddEventHandler("avid_houserobbery:SellShop:progress", function(data)
    if Config.Input == "qb-input" then
        local dialog = exports['qb-input']:ShowInput({
            header = locale("Pricefor") .. data.price,
            submitText = "Submit",
            inputs = {
                {
                    text = locale("Amount") .. locale("Range") .. data.min .. ' - ' .. data.max,
                    name = "amount",
                    type = "number",
                    isRequired = true,
                }
            }
        })
        if dialog then
            
            amount = tonumber(dialog["amount"])
        end
    elseif Config.Input == "ox_lib" then
        amount = lib.inputDialog(locale("Pricefor") .. data.price,
            { locale("Amount") .. locale("Range") .. data.min .. ' - ' .. data.max })
        amount = tonumber(amount[1])
    end

    if amount then
        if tonumber(amount) >= data.min and tonumber(amount) <= data.max then
            lib.callback('avid_houserobbery:SellShop:getitem', false, function(value)
                if value then
                    dict = "misscarsteal4@actor"
                    clip = "actor_berating_loop"
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Wait(0) end
                    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
                    ProgressBar(6000, locale("selling"))
                    ClearPedTasks(cache.ped)
                    PlayPedAmbientSpeechNative(SellShopNPC, 'GENERIC_THANKS', 'SPEECH_PARAMS_FORCE')
                    TSE("avid_houserobbery:SellShop:giveitems", data.item, data.price, amount)
                else
                    Notify("error", locale("error"), locale("RequiredItems"))
                end
            end, data.item, amount)
        else
            Notify("error", locale("error"), locale("IvalidAmount"))
        end
    else
        Notify("error", locale("error"), locale("IvalidAmount"))
    end
end)

local SellShopPed = nil
local Spawned = false
CreateThread(function()
    while true do
        Wait(1000)
        local Coords = GetEntityCoords(PlayerPedId())
        local distance = #(Coords - vec3(Config.SellShop.Ped.coords.xyz))
        if distance < 20 and not Spawned then
            Spawned = true
            RequestModel(Config.SellShop.Ped.model)

            while not HasModelLoaded(Config.SellShop.Ped.model) do
                Wait(100)
            end

            SellShopNPC = CreatePed(4, Config.SellShop.Ped.model, Config.SellShop.Ped.coords.x, Config.SellShop.Ped.coords.y, Config.SellShop.Ped.coords.z, Config.SellShop.Ped.coords.w, false, true)
            SellShopPed = SellShopNPC
                if Config.InteractionType == 'textui' or Config.InteractionType == "3dtext" then
                    npctxtui = lib.zones.sphere({
                        coords = GetEntityCoords(SellShopNPC),
                        radius = 1,
                        debug = Config.Debug,
                        inside = function(self)
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent('avid_houserobbery:SellShop:menus')
                            end
                            if IsControlJustReleased(0, 74) then
                                if Config.SellShop.EnabledSellAll then
                                    TriggerEvent('avid_houserobbery:SellShop:all')
                                end
                            end

                            if Config.InteractionType == "3dtext" then
                                if Config.SellShop.EnabledSellAll then
                                    Draw3DText(self.coords, string.format("[~g~E~w~] - %s   [~g~H~w~] - %s", locale('sell'), locale("SellAll")))
                                else
                                    Draw3DText(self.coords, string.format("[~g~E~w~] - %s", locale('sell')))
                                end
                            end
                        end,
                        onEnter = function()
                            if Config.InteractionType == "textui" then
                                if Config.SellShop.EnabledSellAll then
                                    TextUIShow('[E] - ' .. locale('sell')  .."  \n [H] - " ..locale("SellAll"))
                                else
                                    TextUIShow('[E] - ' .. locale('sell'))
                                end
                            end
                        end,
                        onExit = function()
                            if Config.InteractionType == "textui" then
                                TextUIHide()
                            end
                        end
                    })
                elseif Config.InteractionType == 'target' then
                    SetTimeout(1000, function()
                    target = Target()
                    target:AddTargetEntity(SellShopNPC, {
                        options = {
                            {
                                type = "client",
                                event = "avid_houserobbery:SellShop:menus",
                                icon = "fas fa-coins",
                                label = locale("SellShop")
                            },
                            {
                                type = "client",
                                event = "avid_houserobbery:SellShop:all",
                                icon = "fas fa-coins",
                                label = locale("SellAll"),
                                canInteract = function()
                                    return Config.SellShop.EnabledSellAll
                                end
                            },
                        },
                        distance = 2
                    })
                end)
            end
            for i = 0, 255, 51 do
                Wait(50)
                SetEntityAlpha(SellShopNPC, i, false)
            end
            FreezeEntityPosition(SellShopNPC, true)
            SetEntityInvincible(SellShopNPC, true)
            SetBlockingOfNonTemporaryEvents(SellShopNPC, true)
            TaskStartScenarioInPlace(SellShopNPC, Config.SellShop.Ped.scenario, 0, true)
        elseif distance >= 20 and Spawned then
            for i = 255, 0, -51 do
                Wait(50)
                SetEntityAlpha(SellShopPed, i, false)
            end
            DeletePed(SellShopPed)
            Spawned = false
        end
    end
end)

end