local count = exports.ox_inventory:Search(player, 'count', 'item_name') or 0-

- Process Events
RegisterNetEvent("process:removeBillFace", function()
    local player = source
    local count = exports.ox_inventory:Search(player, 'count', 'rolled_cash') or 0

    if count > 0 then
        local amountToProcess = math.min(count, 10) -- Maximum of 10 items per interaction

        TriggerClientEvent('process:startInteraction', player, 10000, 'missmechanic', 'work2_base')

        SetTimeout(10000, function()
            if exports.ox_inventory:RemoveItem(player, 'rolled_cash', amountToProcess) then
                exports.ox_inventory:AddItem(player, 'blank_bill', amountToProcess)
                TriggerClientEvent('ox_lib:notify', player, {type = 'success', description = 'You removed the bill face from ' .. amountToProcess .. ' rolled cash.'})
            else
                TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'Failed to process items.'})
            end
        end)
    else
        TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'You have no rolled cash to process.'})
    end
end)

RegisterNetEvent("process:stampNewMarking", function()
    local player = source
    local count = exports.ox_inventory:Search(player, 'count', 'blank_bill') or 0

    if count > 0 then
        local amountToProcess = math.min(count, 10) -- Maximum of 10 items per interaction

        TriggerClientEvent('process:startInteraction', player, 10000, 'missmechanic', 'work2_base')

        SetTimeout(10000, function()
            if exports.ox_inventory:RemoveItem(player, 'blank_bill', amountToProcess) then
                exports.ox_inventory:AddItem(player, 'stamped_roll', amountToProcess)
                TriggerClientEvent('ox_lib:notify', player, {type = 'success', description = 'You stamped ' .. amountToProcess .. ' blank bills.'})
            else
                TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'Failed to process items.'})
            end
        end)
    else
        TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'You have no blank bills to process.'})
    end
end)

RegisterNetEvent("process:cleanMoney", function()
    local player = source
    local count = exports.ox_inventory:Search(player, 'count', 'stamped_roll') or 0

    if count > 0 then
        local amountToProcess = math.min(count, 10) -- Maximum of 10 items per interaction

        TriggerClientEvent('process:startInteraction', player, 60000, 'missmechanic', 'work2_base')

        SetTimeout(60000, function()
            if exports.ox_inventory:RemoveItem(player, 'stamped_roll', amountToProcess) then
                exports.ox_inventory:AddItem(player, 'money', amountToProcess * 60)
                TriggerClientEvent('ox_lib:notify', player, {type = 'success', description = 'You cleaned ' .. amountToProcess .. ' stamped rolls and received $' .. (amountToProcess * 60) .. '.'})
            else
                TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'Failed to process items.'})
            end
        end)
    else
        TriggerClientEvent('ox_lib:notify', player, {type = 'error', description = 'You have no stamped rolls to process.'})
    end
end)
