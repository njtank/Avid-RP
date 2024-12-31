local exploit = {}
local cooldowntime = Config.Cooldown
local isCooldown = false

function getCops()
    local players = QBCore.Functions.GetPlayers()
    local policeJobs = {}
    for _, job in ipairs(Config.PoliceJobs) do
        policeJobs[job] = true
    end

    local cops = 0
    for _, playerId in ipairs(players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player and policeJobs[player.PlayerData.job.name] then
            cops = cops + 1
        end
    end
    return cops
end

function callCops(coords)
    local players = QBCore.Functions.GetPlayers()
    local policeJobs = {}
    for _, job in ipairs(Config.PoliceJobs) do
        policeJobs[job] = true
    end

    for _, playerId in ipairs(players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player and policeJobs[player.PlayerData.job.name] then
            TriggerClientEvent("avid-atmrobbery:robberyCall", player.PlayerData.source, coords)
        end
    end
end

function cooldown()
    isCooldown = true
    cooldowntime = Config.Cooldown

    Citizen.CreateThread(function()
        repeat
            Citizen.Wait(60000)

            cooldowntime = cooldowntime - 1 

            if cooldowntime <= 0 then
                isCooldown = false
            end

        until cooldowntime == 0
    end)
end

QBCore.Functions.CreateUseableItem(Config.DrillItem, function(source)
    local player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("avid-atmrobbery:checkPosition", source)
    exploit[source] = true
end)

RegisterNetEvent("avid-atmrobbery:RobberyEnd")
AddEventHandler("avid-atmrobbery:RobberyEnd", function(success)
    local player = QBCore.Functions.GetPlayer(source)
    if success then
        if exploit[source] == true then
            local reward = math.random(Config.Reward.min, Config.Reward.max)
            player.Functions.AddMoney(Config.RewardAccount, reward)
            Server_Notify(source, text("robbery_success", reward), "success")
        end
    end
    callCops()
    player.Functions.RemoveItem(Config.DrillItem, 1)
    exploit[source] = false
end)

RegisterNetEvent("avid-atmrobbery:callCops")
AddEventHandler("avid-atmrobbery:callCops", function(coords)
    callCops(coords)
end)

QBCore.Functions.CreateCallback("avid-atmrobbery:getRobberyStatus", function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    local CurrentCops = getCops()

    if isCooldown then 
        Server_Notify(source, text("robbery_cooldown", cooldowntime), "error")
        TriggerClientEvent("QBCore:Notify", source, "Ein ATM-Raub hat kürzlich stattgefunden. Bitte warten Sie " .. cooldowntime .. " Minuten!", "error") 
        exploit[source] = false
        cb(false)
        return 
    end
    if CurrentCops < Config.RequiredCops then 
        Server_Notify(source, text("robbery_missingCops", CurrentCops, Config.RequiredCops), "error")
        exploit[source] = false
        cb(false)
        return 
    end

    cooldown()
    cb(true)
end)

function text(key, ...)
    local placeholders = {...}
    local text = Config.Locales[Config.Language][key]

    if text then
        return string.format(text, table.unpack(placeholders))
    end
end