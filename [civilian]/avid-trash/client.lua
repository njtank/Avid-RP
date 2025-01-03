local Config = {}

local trashCollected = false
local bag = nil
local ped = nil
local truck = nil

CreateThread(function()
    -- Load the ped model
    local pedModel = GetHashKey("s_m_y_dockwork_01")
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    -- Create the ped
    local ped = CreatePed(4, pedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, Config.PedHeading, false, true) -- Adjusted Z coordinate for targeting
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- Ensure the ped is flagged properly for targeting
    Wait(500) -- Allow entity creation to settle
    exports.ox_target:addLocalEntity(ped, { -- Use addLocalEntity for non-networked ped
        {
            name = 'startTrashJob',
            label = 'Start Trash Job',
            icon = 'fa-solid fa-recycle',
            onSelect = function()
                TriggerEvent('trash:giveTruck')
            end
        },
        {
            name = 'getTruck',
            label = 'Obtain Truck',
            icon = 'fa-solid fa-truck',
            onSelect = function()
                TriggerEvent('trash:spawnTruck')
            end
        }
    })
end)


RegisterNetEvent('trash:spawnTruck', function()
    local vehicleHash = GetHashKey("trash")
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Wait(100)
    end

    -- Spawn the truck
    local truck = CreateVehicle(vehicleHash, Config.TruckSpawnLocation.x, Config.TruckSpawnLocation.y, Config.TruckSpawnLocation.z, Config.TruckHeading, true, false)
    SetVehicleFuelLevel(truck, 100.0)
    exports['cdn-fuel']:SetFuel(truck, 100.0)

    -- Set the player as the vehicle owner and give keys
    local plate = GetVehicleNumberPlateText(truck) -- Get the truck's plate
    exports['Renewed-Vehiclekeys']:addKey(plate)
    --TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', plate) -- Register ownership
    --TriggerEvent('vehiclekeys:client:SetOwner', plate) -- Give client keys

    -- Notify the player
    TriggerEvent('QBCore:Notify', 'Trash truck spawned. Use it to collect trash.', 'success')
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Loop through the trash objects and add targeting
        for _, object in pairs(Config.TrashObjects) do
            -- Create object if not already in world (this can be modified if objects are preloaded)
            local objectHash = GetHashKey(object)
            RequestModel(objectHash)
            while not HasModelLoaded(objectHash) do
                Wait(100)
            end
            
            -- Ensure the object is spawned in the world
            local objectEntity = CreateObject(objectHash, coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z, true, true, false)

            -- Add target interaction to collect trash
            exports.ox_target:addEntity(objectEntity, {
                options = {
                    {
                        name = 'collectTrash',
                        label = 'Grab Trash',
                        icon = 'fa-solid fa-hand',
                        onSelect = function()
                            if not trashCollected then
                                trashCollected = true
                                bag = CreateObject(GetHashKey("prop_rub_binbag_sd_02"), coords.x, coords.y, coords.z, true, true, true)
                                AttachEntityToEntity(bag, playerPed, GetPedBoneIndex(playerPed, 57005), 0.4, 0.0, 0.0, 0, 0, 90, true, true, false, true, 1, true)
                                TaskPlayAnim(playerPed, "missfbi4prepp1", "_idle_garbage_man", 8.0, -8.0, -1, 49, 0, false, false, false)
                                Wait(3000)
                                ClearPedTasks(playerPed)
                            end
                        end
                    }
                },
                distance = 2.5
            })
        end

        -- Dispose Trash
        if trashCollected and bag then
            local truckRear = GetOffsetFromEntityInWorldCoords(truck, 0.0, -2.5, 0.0)
            exports.ox_target:addSphereZone("DisposeTrash", truckRear, 1.5, {
                options = {
                    {
                        name = 'disposeTrash',
                        label = 'Dispose Waste',
                        icon = 'fa-solid fa-trash',
                        onSelect = function()
                            DeleteEntity(bag)
                            trashCollected = false
                            TriggerServerEvent('trash:giveReward')
                        end
                    }
                },
                debugPoly = false
            })
        end

        Wait(1000)
    end
end)



Config = {
    PedLocation = vec3(-349.23, -1571.03, 25.23), -- Ped location
    PedHeading = 318.47, -- Ped heading
    TruckSpawnLocation = vec3(-336.07, -1563.07, 24.94), -- Truck spawn location
    TruckHeading = 59.85, -- Truck heading
    DropRadius = 100.0, -- Radius for trash locations
    TrashObjects = { -- List of targetable trash objects
        "hw1_13_props_dump01alod1", "hw1_13_props_dump01alod", "prop_cs_bin_01_skinned",
        "prop_bin_07b", "prop_cs_bin_01", "prop_cs_bin_03", "prop_bin_08a",
        "prop_fragtest_cnst_01", "prop_cs_street_binbag_01", "prop_rub_binbag_06",
        "ch_chint10_binbags_smallroom_01", "prop_rub_binbag_05", "prop_dumpster_4b"
    },
    RewardItems = { -- Items the player can receive
        "plastic", "dirty_cloth", "rubber"
    }
}
