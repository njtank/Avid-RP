local currentInstance = ""

RegisterNetEvent("avid_houserobbery_instance:onEnter")
AddEventHandler("avid_houserobbery_instance:onEnter", function(instance)
    currentInstance = instance
end)

RegisterNetEvent("avid_houserobbery_instance:onLeave")
AddEventHandler("avid_houserobbery_instance:onLeave", function()
    currentInstance = ""
end)

function getPlayerInstance()
    return currentInstance
end