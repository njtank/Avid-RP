local sharedConfig = require 'config.shared'

local function getClosestHall(pedCoords)
    local distance = #(pedCoords - sharedConfig.cityhalls[1].coords)
    local closest = 1
    for i = 1, #sharedConfig.cityhalls do
        local hall = sharedConfig.cityhalls[i]
        local dist = #(pedCoords - hall.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

local function distanceCheck(source, job)
    local ped = GetPlayerPed(source)
    local pedCoords = GetEntityCoords(ped)
    local closestCityhall = getClosestHall(pedCoords)
    local cityhallCoords = sharedConfig.cityhalls[closestCityhall].coords
    if #(pedCoords - cityhallCoords) >= 20.0 or not sharedConfig.employment.jobs[job] then
        return false
    end
    return true
end

lib.callback.register('qbx_cityhall:server:requestId', function(source, item, hall)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return end
    local itemType = sharedConfig.cityhalls[hall].licenses[item]

    if itemType.item ~= 'id_card' and itemType.item ~= 'driver_license' and itemType.item ~= 'weaponlicense' then
        return exports.qbx_core:Notify(source, locale('error.invalid_type'), 'error')
    end

    if not player.Functions.RemoveMoney('cash', itemType.cost) then
        return exports.qbx_core:Notify(source, locale('error.not_enough_money'), 'error')
    end

    exports.qbx_idcard:CreateMetaLicense(source, itemType.item)
    exports.qbx_core:Notify(source, locale('success.item_recieved') .. itemType.label, 'success')
end)

lib.callback.register('qbx_cityhall:server:applyJob', function(source, job)
    local player = exports.qbx_core:GetPlayer(source)
    if not player or not distanceCheck(source, job) then return end

    player.Functions.SetJob(job, 0)
    exports.qbx_core:Notify(source, locale('success.new_job'), 'success')

    -- Fetch the GPS location from the config
    local location = employment.locations[job]
    if location then
        -- Send the location to the client
        TriggerClientEvent('qbx_cityhall:client:setGPS', source, location)
    end
end)

employment = {
    locations = {
        trucker = vector3(1197.0, -3109.78, 5.03, 0.71), 
        taxi = vector3(909.5, -177.35, 74.22),
        tow = vector3(401.99, -1626.29, 29.29),
        electrical = vector3(-283.01, -2657.75, 5.16),
        garbage = vector3(-313.84, -1522.82, 27.56),
        newspaper = vector3(-606.94, -928.28, 23.86),
        it = vector3(-826.89, -690.01, 27.06),
        cargo = vector3(849.76, -1995.65, 28.98),
    }
}

