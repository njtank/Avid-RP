function it.hasItem(itemName, amount)
    local hasItem = lib.callback.await('avid-weed:hasItem', false, itemName, amount)
    return hasItem
end

function it.getItemLabel(itemName)
    local itemLabel
    if it.inventory == 'ox' then
        local items = exports.ox_inventory:Items()
        return items[itemName].label
    elseif it.core == 'qb-core' then
        itemLabel = CoreObject.Shared.Items[itemName].label
    elseif it.core == 'esx' then
        itemLabel = lib.callback.await('avid-weed:server:getItemLabel', false, itemName)
    end
    return itemLabel
end

lib.callback.register('avid-weed:client:getItemLabel', function(itemName)
    local items = exports.ox_inventory:Items()
    return items[itemName].label
end)

function it.getItemCount(itemName)
    local itemCount = lib.callback.await('avid-weed:getItemCount', false, itemName)
    return itemCount
end

function it.toggleItem(toggle, name, amount, metadata)
    TriggerServerEvent('avid-weed:toggleItem', toggle, name, amount, metadata)
end