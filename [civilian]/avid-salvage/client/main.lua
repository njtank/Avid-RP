local isSalvaging = false
local scrapCount = 0

-- Register a function to show progress and play animation
local function startScrapTask(zoneName)
    if isSalvaging then
        lib.progressBar({
            duration = Config.TaskDuration * 1000, -- Configurable task duration
            label = "Scrapping...",
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = "mini@repair", clip = "fixing_a_ped" },
        })
        Wait(Config.TaskDuration * 1000)

        -- Reward player with random items from the config
        local rewardItem = Config.RewardItems[math.random(#Config.RewardItems)]
        local amount = math.random(Config.RewardMin, Config.RewardMax)
        TriggerServerEvent("avid-salvage:rewardPlayer", rewardItem, amount)

        scrapCount = scrapCount + 1
        TriggerEvent("ox_lib:notify", {
            type = "inform",
            description = ("Car scrapped! Total: %d/14"):format(scrapCount),
        })

        if scrapCount >= 14 then
            TriggerEvent("ox_lib:notify", { type = "success", description = "Return to the ped to get paid!" })
        end
    else
        TriggerEvent("ox_lib:notify", { type = "error", description = "You haven't started salvaging!" })
    end
end

-- Add zones for scrapping
for i, zone in ipairs(Config.SalvageZones) do
    exports.ox_target:addSphereZone({
        coords = zone.coords,
        radius = zone.radius,
        options = {
            {
                name = "scrap_car",
                label = "Scrap Car",
                icon = "fa-solid fa-car",
                onSelect = function()
                    if scrapCount < 14 then
                        startScrapTask(zone.name)
                    else
                        TriggerEvent("ox_lib:notify", { type = "error", description = "You've already scrapped enough cars!" })
                    end
                end,
            },
        },
    })
end

-- Add the ped with ox_target
local pedModel = Config.PedModel
RequestModel(pedModel)
while not HasModelLoaded(pedModel) do
    Wait(0)
end
local ped = CreatePed(4, pedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z, Config.PedHeading, false, true)
FreezeEntityPosition(ped, true)
SetEntityInvincible(ped, true)
SetBlockingOfNonTemporaryEvents(ped, true)

if DoesEntityExist(ped) then
    -- Add ped to ox_target for interactions
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'start_salvaging',
            icon = 'fas fa-wrench',
            label = 'Start Salvaging',
            onSelect = function()
                TriggerServerEvent('avid-salvage:startSalvaging')
            end,
            canInteract = function()
                return not isSalvaging -- Prevent starting if already salvaging
            end
        },
        {
            name = 'get_paid',
            icon = 'fas fa-dollar-sign',
            label = 'Get Paid',
            onSelect = function()
                TriggerServerEvent('avid-salvage:getPaid')
            end,
            canInteract = function()
                return scrapCount >= 14 -- Only show if 14 tasks are completed
            end
        }
    })
else
    print("Error: Failed to create ped for salvage script.")
end

