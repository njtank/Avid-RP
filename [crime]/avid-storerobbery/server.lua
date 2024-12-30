GlobalState.GettingRobbed = false
GlobalState.GettingSafeRobbed = false

RegisterNetEvent('FinishRobbery')
AddEventHandler('FinishRobbery', function(playerId)
    local cashMoney = Config.cashPayout
    local chance = math.random(1, 10)
    exports.ox_inventory:RemoveItem(playerId, 'lockpick', 1)
    exports.ox_inventory:AddItem(playerId, 'money', cashMoney)
    if chance >= 4 then
        exports.ox_inventory:AddItem(playerId, 'electronickit', 1)
    end
    TimerThread()
end)

RegisterNetEvent('FinishSafeRobbery')
AddEventHandler('FinishSafeRobbery', function(playerId)
    local cashMoney = Config.safePayout
    local chance = math.random(1, 100)
    exports.ox_inventory:RemoveItem(playerId, 'electronickit', 1)
    exports.ox_inventory:AddItem(playerId, 'money', cashMoney)
    if chance >= 4 then
        exports.ox_inventory:AddItem(playerId, Config.rewardItem, 1)
    end
    SafeTimerThread()
end)

RegisterNetEvent('FailRobbery')
AddEventHandler('FailRobbery', function(playerId)
    exports.ox_inventory:RemoveItem(playerId, 'lockpick', 1)
end)

function TimerThread()
    Citizen.CreateThread(function()
        print('TimerThread started')
        GlobalState.GettingRobbed = true
        Wait(Config.Cooldown * 60000)
        GlobalState.GettingRobbed = false
    end)
end

function SafeTimerThread()
    Citizen.CreateThread(function()
        print('SafeTimerThread started')
        GlobalState.GettingSafeRobbed = true
        Wait(Config.SafeCooldown * 60000)
        GlobalState.GettingSafeRobbed = false
    end)
end

local function getPoliceOnline()
    local NDCore = exports["ND_Core"]
    local amount = 0
    local policeDepartments = {"sahp", "lspd", "bcso"}
    local players = NDCore.getPlayers()
    for _, player in pairs(players) do
        if lib.table.contains(policeDepartments, player.job) then
            amount += 1
        end
    end
    return amount
end

-- Police count logic
if Config.framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
    local count = #ESX.GetExtendedPlayers('job', 'police')
    GlobalState.police = count
elseif Config.framework == 'nd' then
    GlobalState.police = getPoliceOnline()
elseif Config.framework == 'ox' then
    print('OX Framework support coming soon')
elseif Config.framework == 'qb-core' then
    local QBCore = exports['qb-core']:GetCoreObject()
    GlobalState.police = QBCore.Functions.GetDutyCount('police')
end
