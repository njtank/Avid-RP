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

exports.ox_target:addLocalEntity(ped, {
    options = {
        {
            name = "start_salvaging",
            label = "Start Salvaging",
            icon = "fa-solid fa-hammer",
            onSelect = function()
                isSalvaging = true
                scrapCount = 0
                TriggerEvent("ox_lib:notify", { type = "inform", description = "Scrap 14 cars to earn $50!" })
            end,
        },
        {
            name = "get_paid",
            label = "Get Paid",
            icon = "fa-solid fa-money-bill",
            onSelect = function()
                if scrapCount >= 14 then
                    TriggerServerEvent("avid-salvage:payPlayer")
                    scrapCount = 0
                    isSalvaging = false
                else
                    TriggerEvent("ox_lib:notify", { type = "error", description = "You haven't completed 14 cars yet!" })
                end
            end,
            distance = 1.5,
            condition = function()
                return scrapCount >= 14
            end,
        },
    },
})
