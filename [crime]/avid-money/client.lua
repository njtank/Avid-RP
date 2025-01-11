local count = exports.ox_inventory:Search(player, 'count', 'item_name') or 0

local targetZones = {
    {
        name = "remove_bill_face",
        label = "Remove Bill Face",
        coords = vec3(513.43, -1964.0, 13.54), -- Update these coordinates
        event = "process:removeBillFace"
    },
    {
        name = "stamp_new_marking",
        label = "Stamp New Markings",
        coords = vec3(505.14, -1969.77, 12.81), -- Update these coordinates
        event = "process:stampNewMarking"
    },
    {
        name = "clean_money",
        label = "Clean Money",
        coords = vec3(504.35, -1966.27, 12.81), -- Update these coordinates
        event = "process:cleanMoney"
    }
}

-- Register target zones
for _, zone in ipairs(targetZones) do
    exports.ox_target:addSphereZone({
        name = zone.name,
        coords = zone.coords,
        radius = 1.5,
        options = {
            {
                name = zone.name,
                label = zone.label,
                icon = "fas fa-money-bill",
                event = zone.event,
                canInteract = function(entity, distance, coords)
                    return true -- You can add custom interaction logic here
                end
            }
        }
    })
end

-- Client-side animation and progress bar
RegisterNetEvent('process:startInteraction', function(duration, animationDict, animationName)
    local playerPed = PlayerPedId()

    -- Start Progress Bar
    lib.progress({
        duration = duration,
        label = 'Processing...',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    })

    -- Play Animation
    RequestAnimDict(animationDict)
    while not HasAnimDictLoaded(animationDict) do
        Wait(0)
    end

    TaskPlayAnim(playerPed, animationDict, animationName, 1.0, 1.0, duration, 1, 0, false, false, false)
    Wait(duration)
    ClearPedTasks(playerPed)
end)
