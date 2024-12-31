local QBCore = exports.qbx_core
local spawnedPeds = {}

local itemProbabilities = {
    { item = 'per_mail', chance = 35 },
    { item = 'gov_mail', chance = 20 },
    { item = 'jnk_mail', chance = 45 }
}

local itemUsageProbabilities = {
    per_mail = {
        { item = 'birthday_card', chance = 25 },
        { item = 'grad_card', chance = 20 },
        { item = 'western_union_check', chance = 5 },
        { item = 'random_letter', chance = 50 }
    },
    gov_mail = {
        { item = 'social_security', chance = 75 },
        { item = 'tax_return', chance = 25 }
    }
}

local function GetRandomItem(itemList)
    local totalChance = 0
    local randomChance = math.random(100)
    
    for _, item in ipairs(itemList) do
        totalChance = totalChance + item.chance
        if randomChance <= totalChance then
            return item.item
        end
    end
end

local function RobMailbox(mailbox)
local playerPed = PlayerPedId()
local mailboxCoords = GetEntityCoords(mailbox)

local animDict = 'amb@prop_human_bum_bin@base'
local animName = 'base'

RequestAnimDict(animDict)
while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end

FreezeEntityPosition(playerPed, true)
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

Citizen.Wait(100)

-- Use ox_lib for progress bar
local result = exports.ox_lib:progress({
    name = "rob_mailbox",
    duration = 5000,
    label = "Robbing Mailbox...",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
})

-- Check if the progress was cancelled or completed
if not result then
    local policeCallChance = 0.2
    if math.random() < policeCallChance then
        exports['ps-dispatch']:SuspiciousActivity('Mail Robbery', mailboxCoords)
        exports.qbx_core:Notify('The police have been alerted!', 'error', 3500)
    end

    local rewardItem = GetRandomItem(itemProbabilities)
    TriggerServerEvent('vivify_mailrobbery:reward', rewardItem, mailboxCoords)
end

ClearPedTasksImmediately(playerPed)
FreezeEntityPosition(playerPed, false)


local function UseItem(item)
    local usageProbabilities = itemUsageProbabilities[item]
    if usageProbabilities then
        local rewardItem = GetRandomItem(usageProbabilities)
        TriggerServerEvent('vivify_mailrobbery:rewardItem', rewardItem)
    end
end

Citizen.CreateThread(function()
    for _, model in ipairs(Config.MailboxModels) do
        -- Use ox_target to add a target interaction
        exports['ox_target']:addSphereZone({
            coords = GetEntityCoords(model),
            radius = 2.5,  -- Distance at which the interaction can be triggered
            debug = false, -- Set to true for debugging
            options = {
                {
                    name = 'mailbox_robbery_' .. model,
                    label = 'Rob Mailbox',
                    icon = 'fas fa-envelope',  -- Optional icon (use one from Font Awesome)
                    onSelect = function(entity, coords)
                        RobMailbox(entity)
                    end
                }
            }
        })
    end
end)


RegisterNetEvent('vivify_mailrobbery:client:useItem')
AddEventHandler('vivify_mailrobbery:client:useItem', function(item)
    UseItem(item)
end)

local function SpawnPeds()
    for i, location in ipairs(Config.PedLocation) do
        local pedModel = GetHashKey(Config.PedModel)

        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Citizen.Wait(0)
        end

        local ped = CreatePed(4, pedModel, location.x, location.y, location.z -1, location.w, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        spawnedPeds[i] = ped

        exports.interact:AddInteraction({
            coords = vector3(location.x, location.y, location.z),
            distance = 4.0,
            interactDst = 1.5,
            id = 'ped_interaction_' .. i,
            options = {
                {
                    label = 'Sell Western Union Check',
                    action = function()
                        TriggerServerEvent('vivify_MailRobbery:sellItem', 'western_union_check')
                    end,
                },
                {
                    label = 'Sell Social Security',
                    action = function()
                        TriggerServerEvent('vivify_MailRobbery:sellItem', 'social_security')
                    end,
                },
                {
                    label = 'Sell Tax Return',
                    action = function()
                        TriggerServerEvent('vivify_MailRobbery:sellItem', 'tax_return')
                    end,
                },
            }
        })
    end
end

Citizen.CreateThread(function()
    SpawnPeds()
end)