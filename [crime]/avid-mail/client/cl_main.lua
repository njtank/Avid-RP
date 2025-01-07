local cache = {}

function RapidLines()
    local success = exports.bl_ui:RapidLines(2, 50, 5)

    return success
end

Citizen.CreateThread(function()

    local locales = Config.Locales

    local function notify(text)
        lib.notify({title='', description = locales[text], position = 'topcenter'})
    end

    local function reOrderObjs()
        for k,v in pairs(cache.objs) do
            v.object = GetEntityModel(v.object)
        end
    end

    local eventA = AddEventHandler('ox_inventory:currentWeapon', function(currentWeapon)
        if currentWeapon == Config.Hammer.label and not cache.noti then
            notify('new_equip')
            RemoveEventHandler(eventA)
        end
    end)

    local lastMailTime = 0 -- Variable to store the last smash timestamp

    function robmailbox()

        local weapon = exports.ox_inventory:getCurrentWeapon()
        local hasWeapon = exports.ox_inventory:GetSlotIdWithItem(Config.Hammer.item)
        local currentTime = GetGameTimer() -- Get the current game time in milliseconds
        if currentTime - lastMailTime < 120000 then -- Check if 2 minutes (120,000 ms) have passed
            exports.qbx_core:Notify("You need to wait before smashing another window.", 'error')
            return
        end
    
        lastMailTime = currentTime

        if not weapon and not hasWeapon or weapon and weapon.label ~= Config.Hammer.label then
            notify('noweapon')
            return 
        end

    

        cache.ped = PlayerPedId()
        cache.coords = GetEntityCoords(cache.ped)
        cache.objs = lib.getNearbyObjects(cache.coords, Config.Maxdistance)

        if not next(cache.objs) then
            return
        end


        reOrderObjs()

        local alreadyRobbed = lib.callback.await('mailboxRobbed', false, cache.objs)

        if alreadyRobbed then
            notify('robbed')
            return
        end

        if not weapon then
            exports.ox_inventory:useSlot(hasWeapon)
            weapon = exports.ox_inventory:getCurrentWeapon()
        end

        if weapon and weapon.metadata.durability <= 0 then
            notify('durability')
            return 
        end

        Wait(500)

        lib.requestAnimDict(Config.Animations.Breakin.dict)
        length = GetAnimDuration(Config.Animations.Breakin.dict, Config.Animations.Breakin.clip)

        cache.object = GetClosestObjectOfType(cache.coords, 1.5, cache.objs[1].object)
        if cache.object ~= 0 then
            TaskTurnPedToFaceEntity(cache.ped, cache.object, -1) -- for some reason whenever i try to use the entity from the cache.objs ox gives it just spins my ass in circles
        end



        Wait(500)

        lib.progressCircle({
            label = locales['breaking'],
            duration = math.random(5000, 7500),
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {car = true, move = true, combat = true},
            anim = {dict = Config.Animations.Breakin.dict, clip = Config.Animations.Breakin.clip},
            -- prop = {bone = 28422, model = 'prop_tool_hammer', pos = vec3(0.04, 0.1, -0.025), rot = vec3(90.0, 0.0, 180.0)}
        })


        Wait(length)
        ClearPedTasks(PlayerPedId())

        local success = RapidLines()
            if not success then return end

        --local success = lib.skillCheck('medium', {'w', 'a', 's', 'd'})
        
        if success then
            TriggerServerEvent('mailbox', cache.objs)
        else
            TriggerServerEvent('hammer')
        end
    end


    exports.ox_target:addModel(Config.Mailboxes, {
        label = locales['initrob'],
        icon = 'fa-solid fa-hammer',
        distance = Config.Maxdistance,
        onSelect = robmailbox
    })


    RegisterNetEvent('openMail', function()
    
        lib.requestAnimDict(Config.Animations.MailOpen.dict)
    
        lib.progressCircle({
            label = locales['mail'],
            duration = math.random(1000, 1500),
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            disable = {car = true, move = true, combat = true},
            anim = {dict = Config.Animations.MailOpen.dict, clip = Config.Animations.MailOpen.clip},
            prop = {bone = 28422, model = Config.Animations.MailOpen.prop, pos = vec3(0.04, 0.1, -0.025), rot = vec3(90.0, 0.0, 180.0)}
        })
    end)
end)