local config = require 'config.client'
local sharedConfig = require 'config.shared'
local isLoggedIn = LocalPlayer.state.isLoggedIn

local function setLocationsBlip()
    if not config.useBlips then return end
    for _, value in pairs(config.locations) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, value.blipIcon)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 83)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(value.blipName)
        EndTextCommandSetBlipName(blip)
    end
end

function RapidLines()
    local success = exports.bl_ui:RapidLines(1, 30, 3)

    return success
end

local function pickProcess()
    local success = RapidLines()
    if not success then return ClearPedTasks(cache.ped) end
    if lib.progressBar({
        duration = math.random(6000, 8000),
        label = locale('progress.pick_grapes'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true
        }
    }) then
        tasking = false
        TriggerServerEvent("qbx_vineyard:server:getGrapes")
    else
        exports.qbx_core:Notify(locale('task.cancel_task'), 'error')
    end
    ClearPedTasks(cache.ped)
end

local function pickAnim()
    lib.playAnim(cache.ped, 'amb@prop_human_bum_bin@idle_a', 'idle_a', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
end

local function toPickGrapes()
    --if not IsPedInAnyVehicle(cache.ped, true) and IsControlJustReleased(0, 38) then
        pickAnim()
        pickProcess()
        random = 0
    --end
end

local lastProcessingTime = 0 -- Variable to store the last processing timestamp

local function wineProcessing()
    local currentTime = GetGameTimer() -- Get the current game time in milliseconds
    if currentTime - lastProcessingTime < 60000 then -- Check if 1 minute (60000 ms) has passed
        exports.qbx_core:Notify(locale('You should wait a minute before doing this'), 'error')
        return
    end

    lib.callback('qbx_vineyard:server:grapeJuicesNeeded', false, function(result)
        if result then
            loadIngredients = true
            if lib.progressBar({
                duration = 5000,
                label = locale('progress.process_wine'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    mouse = true,
                    move = true,
                    combat = true,
                },
                anim = {
                    dict = 'mp_car_bomb',
                    clip = 'car_bomb_mechanic'
                }
            }) then
                lastProcessingTime = GetGameTimer() -- Update the last processing time
                TriggerServerEvent('qbx_vineyard:server:receiveWine')
            else
                exports.qbx_core:Notify(locale('task.cancel_task'), 'error')
            end
        else
            exports.qbx_core:Notify(locale('error.invalid_items'), 'error')
        end
    end)
end

local function juiceProcessing()
    lib.callback('qbx_vineyard:server:grapesNeeded', false, function(result)
        if result then
            loadIngredients = true
            if lib.progressBar({
                duration = 5000,
                label = locale('progress.process_juice'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    mouse = true,
                    move = true,
                    combat = true,
                },
                anim = {
                    dict = 'mp_car_bomb',
                    clip = 'car_bomb_mechanic'
                }
            }) then
                TriggerServerEvent('qbx_vineyard:server:receiveGrapeJuice')
            else
                exports.qbx_core:Notify(locale('task.cancel_task'), 'error')
            end
        else
            exports.qbx_core:Notify(locale('error.invalid_items'), 'error')
        end
    end)
end


local function processingMenu()
    lib.registerContext({
        id = 'processingMenu',
        title = locale('menu.title'),
        options = {
            {
                title = locale('menu.process_wine_title'),
                description = locale('menu.wine_items_needed', sharedConfig.grapeJuicesNeeded ),
                icon = 'wine-bottle',
                onSelect = function()
                    wineProcessing()
                end,
            },
            {
                title = locale('menu.process_juice_title'),
                description = locale('menu.juice_items_needed', sharedConfig.grapesNeeded ),
                icon = 'bottle-droplet',
                onSelect = function()
                    juiceProcessing()
                end,
            }
        }
    })

    lib.showContext('processingMenu')
end

exports.ox_target:addBoxZone({
    coords = config.locations.vineyardProcessing.coords, -- Coordinates for the zone
    size = vec3(1.6, 1.4, 3.2), -- Size of the zone
    rotation = 346.25, -- Rotation angle
    debug = config.debugPoly, -- Debug mode toggle
    options = {
        {
            name = 'vineyard_processing',
            label = 'Vineyard Processing',
            icon = 'fas fa-cog', -- Optional icon
            onSelect = function()
                processingMenu()
            end
        }
    }
})


for _, coords in pairs(config.grapeLocations) do
    exports.ox_target:addBoxZone({
        coords = coords, -- Coordinates for the zone
        size = vec3(1, 1, 1), -- Size of the zone
        rotation = 40, -- Rotation angle
        debug = config.debugPoly, -- Debug mode toggle
        options = {
            {
                name = 'pick_grapes',
                label = 'Pick grapes',
                icon = 'fas fa-hand', -- Optional icon
                item = 'metalsheers', -- Required item to enable interaction
                onSelect = function()
                    toPickGrapes()
                end
            }
        }
    })
end

local function init()
    setLocationsBlip()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    init()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

CreateThread(function()
    if not isLoggedIn then return end
    init()
end)