CLIENT = {
    nuiReady = false,
    open = false,
    notes = {},
    lastNotes = {},
    annoucements = {},
    officers = {},
    statusData = {
        pwc = "",
        apwc = "",
        cityStatus = Config.CityStatuses[1]
    },
    s4 = {},
    dispatchData = {},
    lastDispatchNotif = 0,
    napadowa1 = {
        statusData = {
            sv = "",
            svIdentifier = "",
            nego = "",
            negoIdentifier = "",
            notatki = "",
            zadania = "",
            miejsce = "",
        },
        unity = {},
    },
    napadowa2 = {
        statusData = {
            sv = "",
            svIdentifier = "",
            nego = "",
            negoIdentifier = "",
            notatki = "",
            zadania = "",
            miejsce = "",
        },
        unity = {},
    },
    napadowa3 = {
        statusData = {
            sv = "",
            svIdentifier = "",
            nego = "",
            negoIdentifier = "",
            notatki = "",
            zadania = "",
            miejsce = "",
        },
        unity = {},
    },

    konwojowa = {
        statusData = {
            sv = "",
            svIdentifier = "",
            trasa = "",
            zatrzymani = 0,
            swat = {},
        },
        unity = {},
    }
}

CLIENT.TabletEntity = nil
local tabletModel = "prop_cs_tablet_mdt"
local tabletDict = "amb@world_human_seat_wall_tablet@female@base"
local tabletAnim = "base"

local function attachObject()
	if CLIENT.TabletEntity == nil then
		-- Citizen.Wait(380)
		RequestModel(tabletModel)
		while not HasModelLoaded(tabletModel) do
			Citizen.Wait(1)
		end
		CLIENT.TabletEntity = CreateObject(GetHashKey(tabletModel), 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(CLIENT.TabletEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.10, -0.13, 25.0, 170.0, 160.0, true, true, false, true, 1, true)
	end
end

local function startAnim()
    local playerPed = PlayerPedId()

    RequestAnimDict(tabletDict)
    while not HasAnimDictLoaded(tabletDict) do
        Citizen.Wait(0)
    end

    attachObject()

    TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, -3.0, -1, 50, 0, false, false, false)

    while CLIENT.open do
        Citizen.Wait(1)
        if not IsEntityPlayingAnim(playerPed, tabletDict, tabletAnim, 3) then
            TaskPlayAnim(playerPed, tabletDict, tabletAnim, 8.0, -8.0, -1, 50, 0, false, false, false)
        end
    end

    ClearPedTasks(PlayerPedId())

    if CLIENT.TabletEntity then
        DeleteEntity(CLIENT.TabletEntity)
        CLIENT.TabletEntity = nil
    end
end

RegisterNUICallback('uiLoaded', function(data, cb)
    SetTimeout(2000, function ()
        SendNUIMessage({
            action = 'init',
            data = {
                locale = TRANSLATIONS[Config.Language],
                languages = Config.Languages,
                tariff = Config.Tariff,
                vehicles = Config.Vehicles,
                codes = Config.Codes,
                files = Config.OneFile,
            }
        })

        SendNUIMessage({
            action = 'setBlockSettings',
            data = {
                blockSettings = Config.BlockSettings.blockSettings,
                blockSettingsGrade = Config.BlockSettings.blockSettingsGrade,
                qfDispatch = Config.Dispatch.qf_dispatch,
                cdDispatch = Config.Dispatch.cd_dispatch,
                notifDispatch = Config.Dispatch.notif_dispatch,
                functionAccess = Config.Jobs.AccessToManagementFunctions.fromGrade,
            }
        })
        
        CLIENT.nuiReady = true
        cb(true)
    end)
end)

CLIENT.SetPlayerData = function()
    while not CLIENT.nuiReady do
        Citizen.Wait(200)
    end

    local data = FRAMEWORK.GetMdtPlayerData()

    SetTimeout(1500, function ()
        SendNUIMessage({
            action = 'setPlayerData',
            data = data[1]
        })

        CLIENT.notes = data[2]
        SendNUIMessage({
            action = 'setNotes',
            data = CLIENT.notes
        })

        CLIENT.annoucements = data[3]
        SendNUIMessage({
            action = 'setAnnoucements',
            data = CLIENT.annoucements
        })
    end)

    TriggerServerEvent('avid-mdt:houses')
    TriggerServerEvent('avid-mdt:warrants')
    TriggerServerEvent('avid-mdt:evidences')
    TriggerServerEvent('avid-mdt:getSettings')
end

local function closeMDT()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })

    CLIENT.open = false
end

RegisterNetEvent('avid-mdt:closeMdt', function ()
    Citizen.CreateThread(function()
        closeMDT()
    end)
end)

RegisterNUICallback('closeUI', function(data, cb)
    Citizen.CreateThread(function()
        closeMDT()
    end)
    cb('ok')
end)

RegisterNUICallback('restartUI', function(data, cb)
    CLIENT.SetPlayerData()
    cb('ok')
end)

RegisterCommand(Config.ToggleMDT.commandName, function()
    if not PlayerData.job then
        return
    end

    if not CLIENT.nuiReady then
        return
    end

    if Config.Jobs.OnDuty[PlayerData.job.name] then
        if EDITABLE.CanOpenMDT then
            CLIENT.SetPlayerData()
            CLIENT.open = true
            CreateThread(startAnim)
            SendNUIMessage({
                action = 'setVisible',
                data = true
            })
            SetNuiFocus(true, true)
        end
    end
end, false)

RegisterKeyMapping(Config.ToggleMDT.commandName, Config.ToggleMDT.keymappingLabel, 'keyboard', Config.ToggleMDT.key)

RegisterNetEvent('avid-mdt:openTablet', function ()
    if not PlayerData.job then
        return
    end

    if not CLIENT.nuiReady then
        return
    end

    if Config.Jobs.OnDuty[PlayerData.job.name] then
        if EDITABLE.CanOpenMDT then
            CLIENT.SetPlayerData()
            CLIENT.open = true
            CreateThread(startAnim)
            SendNUIMessage({
                action = 'setVisible',
                data = true
            })
            SetNuiFocus(true, true)
        end
    end
end)

RegisterNetEvent('avid-mdt:updateLastNotes', function(notes)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        CLIENT.lastNotes = notes

        SendNUIMessage({
            action = 'setLastNotes',
            data = CLIENT.lastNotes
        })
    end
end)

RegisterNUICallback('addNote', function(data, cb)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        table.insert(CLIENT.notes, {title = data.title, content = data.content})
        TriggerServerEvent('avid-mdt:addNote', data.title, data.content)
    end

    cb('ok')
end)

RegisterNUICallback('deleteNote', function(data, cb)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        TriggerServerEvent('avid-mdt:deleteNote', data.annid)
    end

    cb('ok')
end)

RegisterNUICallback('addAnnoucement', function(data, cb)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        TriggerServerEvent('avid-mdt:addAnnoucement', data.title, data.content)
    end
    
    cb('ok')
end)

RegisterNUICallback('search', function(data, cb)
    if data.type == 'citizen' then
        if data.value then
            CALLBACK.TriggerServerCallback('avid-mdt:searchCitizen', function(info)
                Citizen.CreateThread(function()
                    SendNUIMessage({
                        action = 'searchResults',
                        data = {
                            info = info,
                            type = 'citizen'
                        }
                    })
                end)
            end, data.value)
        else
            local player, distance = FRAMEWORK.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
            if player and player ~= -1 and distance < 5.0 then
                CALLBACK.TriggerServerCallback('avid-mdt:getCitizenIdentifier', function(info)
                    Citizen.CreateThread(function()
                        SendNUIMessage({
                            action = 'searchResults',
                            data = {
                                info = info,
                                type = 'citizen'
                            }
                        })
                    end)
                end, GetPlayerServerId(player))
            else
                FRAMEWORK.ShowNotification(_L('NO_NEARBY_PERSON'))
            end
        end
    elseif data.type == 'vehicle' then
        if data.value then
            CALLBACK.TriggerServerCallback('avid-mdt:searchVehicle', function(info)
                Citizen.CreateThread(function()
                    SendNUIMessage({
                        action = 'searchResults',
                        data = {
                            info = info,
                            type = 'vehicle'
                        }
                    })
                end)
            end, data.value)
        else
            local veh = FRAMEWORK.GetVehicleInDirection()
            if veh and veh ~= 0 and DoesEntityExist(veh) and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(veh)) < 5.0 then
                local plate = GetVehicleNumberPlateText(veh)
                CALLBACK.TriggerServerCallback('avid-mdt:searchVehicle', function(info)
                    Citizen.CreateThread(function()
                        SendNUIMessage({
                            action = 'searchResults',
                            data = {
                                info = info,
                                type = 'vehicle'
                            }
                        })
                    end)
                end, plate)
            else
                FRAMEWORK.ShowNotification(_L('NO_NEARBY_VEHICLE'))
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('setData', function(data, cb)
    CALLBACK.TriggerServerCallback('avid-mdt:getData', function(callback)
        cb(callback)
    end, data)
end)

RegisterNUICallback('addVehicleNote', function(data, cb)
    TriggerServerEvent('avid-mdt:addVehicleNote', data)
    cb('ok')
end)

RegisterNUICallback('deleteVehicleNote', function(data, cb)
    TriggerServerEvent('avid-mdt:deleteVehicleNote', data)
    cb('ok')
end)

RegisterNUICallback('addCitizenNote', function(data, cb)
    TriggerServerEvent('avid-mdt:addCitizenNote', data)
    cb('ok')
end)

RegisterNUICallback('deleteCitizenNote', function(data, cb)
    TriggerServerEvent('avid-mdt:deleteCitizenNote', data)
    cb('ok')
end)

CLIENT.Load = function()
    CALLBACK.TriggerServerCallback('avid-mdt:getDispatchData', function(cb)
        CLIENT.statusData = cb.statusData
        CLIENT.s4 = cb.s4
        CLIENT.dispatchData = cb.dispatchData

        SendNUIMessage({
            action = 'setStatusData',
            data = CLIENT.statusData
        })
        SendNUIMessage({
            action = 'setS4',
            data = CLIENT.s4
        })
        SendNUIMessage({
            action = 'setDispatch',
            data = CLIENT.dispatchData
        })
    end)
end

RegisterNUICallback('setPWC', function(data, cb)
    TriggerServerEvent('avid-mdt:setPWC', data.pwc)
    cb('ok')
end)

RegisterNUICallback('setAPWC', function(data, cb)
    TriggerServerEvent('avid-mdt:setAPWC', data.apwc)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updatePWC', function(pwc)
    CLIENT.statusData.pwc = pwc

    SendNUIMessage({
        action = 'setStatusData',
        data = CLIENT.statusData
    })
end)

RegisterNetEvent('avid-mdt:updateAPWC', function(apwc)
    CLIENT.statusData.apwc = apwc

    SendNUIMessage({
        action = 'setStatusData',
        data = CLIENT.statusData
    })
end)

RegisterNetEvent('avid-mdt:cityStatus', function(cityStatus)
    CLIENT.statusData.cityStatus = cityStatus

    SendNUIMessage({
        action = 'setStatusData',
        data = CLIENT.statusData
    })
end)

RegisterNUICallback('setStatus', function(data, cb)
    TriggerServerEvent('avid-mdt:setStatus', data.status)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updateS4', function(data)
    CLIENT.s4 = data

    SendNUIMessage({
        action = 'setS4',
        data = CLIENT.s4
    })
end)

RegisterNUICallback('submitFine', function(data, cb)
    TriggerServerEvent('avid-mdt:submitFine', data)
    cb('ok')
end)

RegisterNUICallback('clearDispatch', function(data, cb)
    TriggerServerEvent('avid-mdt:clearDispatch')
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updateDispatch', function(data)
    CLIENT.dispatchData = data

    SendNUIMessage({
        action = 'setDispatch',
        data = CLIENT.dispatchData
    })

    local id = GetPlayerServerId(PlayerId())
    local currentPatrol = nil

    for i=1, #CLIENT.dispatchData, 1 do
        for p=1, #CLIENT.dispatchData[i].officers, 1 do
            if CLIENT.dispatchData[i].officers[p].id == id then
                currentPatrol = i - 1
                break
            end
        end
    end

    SendNUIMessage({
        action = 'setCurrentPatrol',
        data = currentPatrol
    })
end)

RegisterNUICallback('leavePatrol', function(data, cb)
    TriggerServerEvent('avid-mdt:quitPatrol', data.index)
    cb('ok')
end)

RegisterNUICallback('changePatrolStatus', function(data, cb)
    TriggerServerEvent('avid-mdt:changePatrolStatus', data.index, data.status)
    cb('ok')
end)

RegisterNUICallback('joinPatrol', function(data, cb)
    TriggerServerEvent('avid-mdt:joinPatrol', data.index)
    cb('ok')
end)

RegisterNUICallback('createPatrol', function(data, cb)
    TriggerServerEvent('avid-mdt:createPatrol', data.unit, data.vehicle)
    cb('ok')
end)

RegisterNUICallback('editPatrol', function(data, cb)
    TriggerServerEvent('avid-mdt:editPatrol', data.index, data.unit, data.vehicle)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:getVehicleModel', function(mid)
    TriggerServerEvent('avid-mdt:backVehicleModel', GetDisplayNameFromVehicleModel(mid))
end)

RegisterNUICallback('removeAnn', function(data, cb)
    TriggerServerEvent('avid-mdt:removeAnn', data.ret)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updatePersonalNotes', function(notes)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        CLIENT.notes = notes

        SendNUIMessage({
            action = 'setNotes',
            data = CLIENT.notes
        })
    end
end)

RegisterNetEvent('avid-mdt:updateAnnoucements', function(annons)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        CLIENT.annoucements = annons
    
        SendNUIMessage({
            action = 'setAnnoucements',
            data = CLIENT.annoucements
        })
    end
end)

RegisterNetEvent('avid-mdt:updatePoliceList', function(funcs)
    CLIENT.officers = {}

    for k, v in pairs(funcs) do
        table.insert(CLIENT.officers, v)
    end

    SendNUIMessage({
        action = 'setPoliceList',
        data = CLIENT.officers
    })
end)

RegisterNUICallback('setNapadowaSV', function(data, cb)
    TriggerServerEvent('avid-mdt:setSv', data.zakladkaType, data.sv)
    cb('ok')
end)

RegisterNUICallback('setNapadowaNEGO', function(data, cb)
    TriggerServerEvent('avid-mdt:setNEGO', data.zakladkaType, data.nego)
    cb('ok')
end)

RegisterNUICallback('clearNapadowa', function(data, cb)
    TriggerServerEvent('avid-mdt:clearNapadowa', data.zakladkaType)
    cb('ok')
end)

RegisterNUICallback('removeUnit', function(data, cb)
    TriggerServerEvent('avid-mdt:removeUnit', data.zakladkaType, data.index)
    cb('ok')
end)

RegisterNUICallback('createUnit', function(data, cb)
    TriggerServerEvent('avid-mdt:createUnit', data.zakladkaType, data.unit, data.vehicle, data.officers, data.patrolUnit)
    cb('ok')
end)

RegisterNUICallback('editUnit', function(data, cb)
    TriggerServerEvent('avid-mdt:editUnit', data.zakladkaType, data.index, data.unit, data.vehicle, data.officers, data.patrolUnit)
    cb('ok')
end)

RegisterNUICallback('updateZadaniaAkcyjna', function(data, cb)
    TriggerServerEvent('avid-mdt:updateZadania', data.zakladkaType, data.text)
    cb('ok')
end)

RegisterNUICallback('updateNotatkiAkcyjna', function(data, cb)
    TriggerServerEvent('avid-mdt:updateNotatki', data.zakladkaType, data.text)
    cb('ok')
end)

RegisterNUICallback('updateRabunekAkcyjna', function(data, cb)
    TriggerServerEvent('avid-mdt:updatePlace', data.zakladkaType, data.text)
    cb('ok')
end)

RegisterNUICallback('updateZatrzymani', function(data, cb)
    TriggerServerEvent('avid-mdt:updateZatrzymani', data.text)
    cb('ok')
end)

RegisterNUICallback('addSWAT', function(data, cb)
    TriggerServerEvent('avid-mdt:setPrzydzial')
    cb('ok')
end)

RegisterNUICallback('removePrydzial', function(data, cb)
    TriggerServerEvent('avid-mdt:removePrzydzial')
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updateNapadowa', function(zt, data)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.unity = data
        SendNUIMessage({
            action = 'setNapadowa1',
            data = data
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.unity = data
        SendNUIMessage({
            action = 'setNapadowa2',
            data = data
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.unity = data
        SendNUIMessage({
            action = 'setNapadowa3',
            data = data
        })
    elseif zt == 'konwojowa' then
        CLIENT.konwojowa.unity = data
        SendNUIMessage({
            action = 'setKonwojowa',
            data = data
        })
    end
end)

RegisterNetEvent('avid-mdt:updateZakladkaSV', function(zt, sv, ident)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.statusData.sv = sv
        CLIENT.napadowa1.statusData.svIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa1SV',
            data = {
                sv = CLIENT.napadowa1.statusData.sv
            }
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.statusData.sv = sv
        CLIENT.napadowa2.statusData.svIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa2SV',
            data = {
                sv = CLIENT.napadowa2.statusData.sv
            }
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.statusData.sv = sv
        CLIENT.napadowa3.statusData.svIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa3SV',
            data = {
                sv = CLIENT.napadowa3.statusData.sv
            }
        })
    elseif zt == 'konwojowa' then
        CLIENT.konwojowa.statusData.sv = sv
        CLIENT.konwojowa.statusData.svIdentifier = ident
        SendNUIMessage({
            action = 'setKonwojowaSV',
            data = {
                sv = CLIENT.konwojowa.statusData.sv
            }
        })
    end
end)

RegisterNetEvent('avid-mdt:updateZakladkaNEGO', function(zt, nego, ident)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.statusData.nego = nego
        CLIENT.napadowa1.statusData.negoIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa1NEGO',
            data = {
                nego = CLIENT.napadowa1.statusData.nego
            }
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.statusData.nego = nego
        CLIENT.napadowa2.statusData.negoIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa2NEGO',
            data = {
                nego = CLIENT.napadowa2.statusData.nego
            }
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.statusData.nego = nego
        CLIENT.napadowa3.statusData.negoIdentifier = ident
        SendNUIMessage({
            action = 'setNapadowa3NEGO',
            data = {
                nego = CLIENT.napadowa3.statusData.nego
            }
        })
    end
end)

RegisterNetEvent('avid-mdt:updateZadania', function(zt, text)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.statusData.zadania = text
        SendNUIMessage({
            action = 'setNapadowa1Zadania',
            data = {
                zadania = CLIENT.napadowa1.statusData.zadania
            }
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.statusData.zadania = text
        SendNUIMessage({
            action = 'setNapadowa2Zadania',
            data = {
                zadania = CLIENT.napadowa2.statusData.zadania
            }
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.statusData.zadania = text
        SendNUIMessage({
            action = 'setNapadowa3Zadania',
            data = {
                zadania = CLIENT.napadowa3.statusData.zadania
            }
        })
    end
end)

RegisterNetEvent('avid-mdt:updateNotatki', function(zt, text)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.statusData.notatki = text
        SendNUIMessage({
            action = 'setNapadowa1Notatki',
            data = {
                notatki = CLIENT.napadowa1.statusData.notatki
            }
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.statusData.notatki = text
        SendNUIMessage({
            action = 'setNapadowa2Notatki',
            data = {
                notatki = CLIENT.napadowa2.statusData.notatki
            }
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.statusData.notatki = text
        SendNUIMessage({
            action = 'setNapadowa3Notatki',
            data = {
                notatki = CLIENT.napadowa3.statusData.notatki
            }
        })
    end
end)

RegisterNetEvent('avid-mdt:updatePlace', function(zt, text)
    if zt == 'napadowa1' then
        CLIENT.napadowa1.statusData.miejsce = text
        SendNUIMessage({
            action = 'setNapadowa1Miejsce',
            data = {
                miejsce = CLIENT.napadowa1.statusData.miejsce
            }
        })
    elseif zt == 'napadowa2' then
        CLIENT.napadowa2.statusData.miejsce = text
        SendNUIMessage({
            action = 'setNapadowa2Miejsce',
            data = {
                miejsce = CLIENT.napadowa2.statusData.miejsce
            }
        })
    elseif zt == 'napadowa3' then
        CLIENT.napadowa3.statusData.miejsce = text
        SendNUIMessage({
            action = 'setNapadowa3Miejsce',
            data = {
                miejsce = CLIENT.napadowa3.statusData.miejsce
            }
        })
    elseif zt == 'konwojowa' then
        CLIENT.konwojowa.statusData.miejsce = text
        SendNUIMessage({
            action = 'setKonwojowaTrasa',
            data = {
                trasa = CLIENT.konwojowa.statusData.miejsce
            }
        })
    end
end)

RegisterNetEvent('avid-mdt:updateZatrzymani', function(text)
    CLIENT.konwojowa.statusData.swat = text
    SendNUIMessage({
        action = 'setKonwojowaZatrzymani',
        data = {
            zatrzymani = tonumber(text)
        }
    })
end)

RegisterNetEvent('avid-mdt:updatePrzydzial', function(data)
    CLIENT.konwojowa.statusData.swat = data
    SendNUIMessage({
        action = 'setPrzydzial',
        data = data
    })
end)

RegisterNetEvent('avid-mdt:updateStatus', function(of, d)
    CLIENT.officers[d].status = of
    Wait(2000)
    SendNUIMessage({
        action = 'setPoliceList',
        data = CLIENT.officers
    })
end)

RegisterNUICallback('kickFromDuty', function(data, cb)
    TriggerServerEvent('avid-mdt:kickFromDuty', data.id)
    cb('ok')
end)

RegisterNUICallback('housesearch', function(data, cb)
    local value = data.value
    TriggerServerEvent('avid-mdt:searchHouses', value)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:housesResults', function(data)
    SendNUIMessage({
        action = 'searchHouseResults',
        data = data
    })
end)

RegisterNUICallback('setHouseData', function(data, cb)
    if data.houseName then
        CALLBACK.TriggerServerCallback('avid-mdt:getCurrentHouse', function(callback)
            cb(callback)
        end, data.houseName)
    end
end)

RegisterNUICallback('addHouseNote', function(data, cb)
    TriggerServerEvent('avid-mdt:addHouseNote', data)
    cb('ok')
end)

RegisterNUICallback('deleteHouseNote', function(data, cb)
    TriggerServerEvent('avid-mdt:removeHouseNote', data)
    cb('ok')
end)

RegisterNUICallback('searchWarrants', function(data, cb)
    TriggerServerEvent('avid-mdt:warrantSearching', data.value)
    cb('ok')
end)

RegisterNUICallback('setWarrantData', function(data, cb)
    if data then
        CALLBACK.TriggerServerCallback('avid-mdt:currentWarrant', function(callback)
            cb(callback)
        end, data)
    end
end)

RegisterNetEvent('avid-mdt:updateWarrants', function(data)
    SendNUIMessage({
        action = 'warrantSearchResults',
        data = data
    })
end)

RegisterNUICallback('newWarrant', function(data, cb)
    TriggerServerEvent('avid-mdt:saveWarrant', data)
    cb('ok')
end)

RegisterNUICallback('updateWarrants', function(data, cb)
    Wait(1000)
    TriggerServerEvent('avid-mdt:warrants')
    cb('ok')
end)

RegisterNUICallback('searchEvidences', function(data, cb)
    TriggerServerEvent('avid-mdt:searchEvidences', value)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:searchEvidencesResult', function(data)
    SendNUIMessage({
        action = 'evidenceSearchResults',
        data = data
    })
end)

RegisterNUICallback('setEvidenceData', function(data, cb)
    if data then
        CALLBACK.TriggerServerCallback('avid-mdt:currentEvidence', function(callback)
            cb(callback)
        end, data)
    end
end)

RegisterNUICallback('updateEvidences', function(data, cb)
    Wait(1000)
    TriggerServerEvent('avid-mdt:evidences')
    cb('ok')
end)

RegisterNUICallback('newEvidence', function(data, cb)
    TriggerServerEvent('avid-mdt:saveEvidence', data)
    cb('ok')
end)

RegisterNUICallback('saveSettings', function(data, cb)
    if data.type == 'save' then
        if data.choosedLanguage then
            SendNUIMessage({
                action = 'changeLanguage1',
                data = {
                    locale = TRANSLATIONS[data.choosedLanguage]
                }
            })

            SendNUIMessage({
                action = 'setMDTScale',
                data = data.MDTScale
            })
        end
    else
        SendNUIMessage({
            action = 'changeLanguage1',
            data = {
                locale = TRANSLATIONS[Config.Language]
            }
        })

        SendNUIMessage({
            action = 'setMDTScale',
            data = data.MDTScale
        })
    end

    TriggerServerEvent('avid-mdt:saveSettings', data)
    cb('ok')
end)

RegisterNetEvent('avid-mdt:updateSettings', function(data)
    if not data then
        SendNUIMessage({
            action = 'changeLanguage',
            data = {
                locale = TRANSLATIONS['en']
            }
        })
    else
        SendNUIMessage({
            action = 'changeLanguage',
            data = {
                locale = TRANSLATIONS[data.language]
            }
        })
    end

    SendNUIMessage({
        action = 'updateSettings',
        data = data
    })
end)

AddEventHandler('cd_dispatch:AddNotification', function (data)
    if Config.Dispatch.cd_dispatch then
        CLIENT.lastDispatchNotif = CLIENT.lastDispatchNotif + 1

        local data = {
            id = CLIENT.lastDispatchNotif,
            localization = {
                x = data.coords.x,
                y = data.coords.y,
                z = data.coords.z,
            },
            title = data.title,
            subtitle = data.message,
            code = '',
            color = 'rgb(33, 113, 252)',
            response = 10, -- max
        }

        SendNUIMessage({
            action = 'addNotif',
            data = data,
        }) 

        TriggerServerEvent('avid-mdt:addDNS', data, CLIENT.lastDispatchNotif)
    end
end)

RegisterNetEvent('avid-mdt:addDispatchAlert', function(gps, title, subtitle, code, color, response)
    if Config.Jobs.OnDuty[PlayerData.job.name] then
        CLIENT.lastDispatchNotif = CLIENT.lastDispatchNotif + 1

        local data = {
            id = CLIENT.lastDispatchNotif,
            localization = {
                x = gps.x,
                y = gps.y,
                z = gps.z,
            },
            title = title,
            subtitle = subtitle,
            code = code,
            color = color,
            response = response, -- max
        }
    
        SendNUIMessage({
            action = 'addNotif',
            data = data,
        })
    
        if Config.NotifDispatchAlerts then
            SendNUIMessage({
                action = 'addScreenNotif',
                data = data,
            })
        end
    
        TriggerServerEvent('avid-mdt:addDNS', data, CLIENT.lastDispatchNotif)
    end
end)

RegisterNUICallback('addReactionn', function(data, cb)
    TriggerServerEvent('avid-mdt:DNaddReaction', data)
end)

RegisterNetEvent('avid-mdt:DNaddreactionC', function(badge, notif, id)
    SendNUIMessage({
        action = 'addDNReaction',
        data = {
            badge = tostring(badge),
            alert = notif,
            response = id
        }
    })
end)

RegisterNUICallback('setLocalization', function(data, cb)
    local x, y = data.x, data.y
    SetNewWaypoint(x, y)
    FRAMEWORK.ShowNotification('Zaznaczono pozycję zgłoszenia!')

    cb('ok')
end)

RegisterNUICallback('setSearchedPlayer', function(data, cb)
    TriggerServerEvent('avid-mdt:changeSearchedPlayer', data.searched, data.identifier)
    cb('ok')
end)

RegisterNUICallback('setAvatarPicture', function(data, cb)
    TriggerServerEvent('avid-mdt:setAvatarPicture', data.picutre, data.identifier)
    cb('ok')
end)

RegisterNUICallback('deleteWarrant', function(data, cb)
    SendNUIMessage({
        action = 'closeWarrant',
    })
    TriggerServerEvent('avid-mdt:removeWarrant', data)
    Wait(500)
    TriggerServerEvent('avid-mdt:warrants')
    cb('ok')
end)

RegisterNUICallback('deleteEvidence', function(data, cb)
    SendNUIMessage({
        action = 'closeEvidence',
    })
    TriggerServerEvent('avid-mdt:removeEvidence', data)
    Wait(500)
    TriggerServerEvent('avid-mdt:evidences')
    cb('ok')
end)
