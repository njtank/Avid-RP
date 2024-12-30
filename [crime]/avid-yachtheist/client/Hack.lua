local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("Bnk-YachtHeist:Hacking", function()
    if QBCore.Functions.HasItem(Config.Reqitem) and QBCore.Functions.HasItem(Config.Reqitem2) then 
    exports['ps-ui']:Scrambler(function(success)
        if success then
           TriggerEvent("Bnk-YachtHeist:clientstarted")
           exports['ps-dispatch']:YachtHeist()
        else
            exports['ps-dispatch']:YachtHeist()
            QBCore.Functions.Notify("Get Good Noob. Now The Cops are Coming!", "error")
        end
    end, "numeric", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
else
    QBCore.Functions.Notify("Your Missing somthing", "error")
end
end)