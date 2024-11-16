local isWorking = false
local currentTaskCount = 0

-- Blip Setup
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Blip.coords)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipScale(blip, Config.Blip.scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Blip.name)
    EndTextCommandSetBlipName(blip)
end)

-- Create Ox_Target Sphere Zones for Each Car
Citizen.CreateThread(function()
    for _, zone in pairs(Config.ScrapZones) do
        exports.ox_target:addSphereZone({
            coords = zone.coords,
            radius = zone.radius,
            options = {
                {
                    name = 'scrap_car_task',
                    label = 'Scrap Car',
                    icon = 'fa fa-wrench',
                    action = function()
                        if not isWorking then
                            StartScrapCarTask()
                        end
                    end
                }
            }
        })
    end
end)

-- Start Scrap Car Task (with Animation)
function StartScrapCarTask()
    isWorking = true
    local randomReward = Config.RewardItems[math.random(1, #Config.RewardItems)]
    local rewardAmount = math.random(Config.MinRewardAmount, Config.MaxRewardAmount)
    
    -- Start the animation
    TaskStartScenarioInPlace(PlayerPedId(), "mini@repair:fixing_a_ped", 0, true)
    
    -- Progress Bar
    TriggerEvent('ox_lib:progress', {
        duration = Config.TaskDuration * 1000, -- Duration in ms
        label = 'Scrapping Car...',
        onComplete = function()
            -- Give Reward Item to Player
            TriggerServerEvent('avid-salvage:giveReward', randomReward, rewardAmount)

            -- Notify Player
            TriggerEvent('ox_lib:notify', {type = 'inform', description = "You received " .. rewardAmount .. " " .. randomReward})
            isWorking = false
            currentTaskCount = currentTaskCount + 1

            -- Check if player should be rewarded with cash
            if currentTaskCount >= Config.TasksBeforeCash then
                TriggerServerEvent('avid-salvage:payPlayer')
            end
        end
    })
end
