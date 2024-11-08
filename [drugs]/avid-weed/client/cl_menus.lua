RegisterNetEvent("avid-weed:client:showDealerMenu", function(dealerId)
    local options = {}

    local dealerData = Config.DrugDealers[dealerId]
    local dealerName = dealerData.label

    for k, v in pairs(dealerData.items) do

        local itemData = lib.callback.await('avid-weed:server:getDealerItemData', false, dealerId, k)

        table.insert(options, {
            title = it.getItemLabel(k),
            description = _U('MENU__DEALER__DESC'):format(itemData.price),
            icon = "coins",
            arrow = true,
            event = "avid-weed:client:handelBuyInteraction",
            args = {item = k, price = itemData.price, dealerId = dealerId}
        })
    end

    lib.registerContext({
        id = "avid-weed-dealer-menu",
        title = _U('MENU__DEALER'):format(dealerName),
        options = options
    })

    lib.showContext("avid-weed-dealer-menu")
end)

-- ┌───────────────────────────────────────────────────┐
-- │ ____  _             _     __  __                  │
-- │|  _ \| | __ _ _ __ | |_  |  \/  | ___ _ __  _   _ │
-- │| |_) | |/ _` | '_ \| __| | |\/| |/ _ \ '_ \| | | |│
-- │|  __/| | (_| | | | | |_  | |  | |  __/ | | | |_| |│
-- │|_|   |_|\__,_|_| |_|\__| |_|  |_|\___|_| |_|\__,_|│
-- └───────────────────────────────────────────────────┘
-- Plant Menu

RegisterNetEvent("avid-weed:client:showPlantMenu", function(plantData)
    local plantName = Config.Plants[plantData.type].label

    if plantData.health == 0 then
        lib.registerContext({
            id = "avid-weed-dead-plant-menu",
            title = _U('MENU__DEAD__PLANT'),
            options = {
                {
                    title = _U('MENU__PLANT__LIFE'),
                    icon = "notes-medical",
                    description = math.floor(plantData.health).. '%',
                    metadata = {
                        _U('MENU__PLANT__LIFE__META')
                    },
                    progress = math.floor(plantData.health),
                    colorScheme = "red",
                },
                {
                    title = _U('MENU__PLANT__STAGE'),
                    description = math.floor(plantData.growth).. '%',
                    icon = "seedling",
                    metadata = {
                        _U('MENU__PLANT__STAGE__META')
                    },
                    progress = math.floor(plantData.growth),
                    colorScheme = "green"
                },
                {
                    title = _U('MENU__PLANT__FERTILIZER'),
                    description = math.floor(plantData.fertilizer).. '%',
                    icon = "bucket",
                    metadata = {
                        _U('MENU__PLANT__STAGE__META')
                    },
                    progress = math.floor(plantData.fertilizer),
                    colorScheme = "orange"
                },
                {
                    title = _U('MENU__PLANT__WATER'),
                    description = math.floor(plantData.water).. '%',
                    icon = "droplet",
                    metadata = {
                        _U('MENU__PLANT__STAGE__META')
                    },
                    progress = math.floor(plantData.water),
                    colorScheme = "blue"
                },
                {
                    title = _U('MENU__PLANT__DESTROY'),
                    description = _U('MENU__PLANT__DESTROY__DESC'),
                    icon = "fire",
                    arrow = true,
                    event = "avid-weed:client:destroyPlant",
                    args = {entity = plantData.entity, type = plantData.type}
                }
            }
        })
        lib.showContext("avid-weed-dead-plant-menu")
        return
    elseif plantData.growth == 100 then
        lib.registerContext({
            id = "avid-weed-harvest-plant-menu",
            title = _U('MENU__PLANT'):format(plantName),
            options = {
                {
                    title = _U('MENU__PLANT__LIFE'),
                    icon = "notes-medical",
                    description = math.floor(plantData.health).. '%',
                    metadata = {
                        _U('MENU__PLANT__LIFE__META')
                    },
                    progress = math.floor(plantData.health),
                    colorScheme = "red",
                },
                {
                    title = _U('MENU__PLANT__STAGE'),
                    description = math.floor(plantData.growth).. '%',
                    icon = "seedling",
                    metadata = {
                       _U('MENU__PLANT__STAGE__META')
                    },
                    progress = math.floor(plantData.growth),
                    colorScheme = "green"
                },
                {
                    title = _U('MENU__PLANT__FERTILIZER'),
                    description = math.floor(plantData.fertilizer).. '%',
                    icon = "bucket",
                    metadata = {
                        _U('MENU__PLANT__FERTILIZER__META')
                    },
                    progress = math.floor(plantData.fertilizer),
                    colorScheme = "orange"
                },
                {
                    title = _U('MENU__PLANT__WATER'),
                    description = math.floor(plantData.water).. '%',
                    icon = "droplet",
                    metadata = {
                        _U('MENU__PLANT__WATER__META')
                    },
                    progress = math.floor(plantData.water),
                    colorScheme = "blue"
                },
                {
                    title = _U('MENU__PLANT__HARVEST'),
                    icon = "scissors",
                    description = _U('MENU__PLANT__HARVEST__DESC'),
                    arrow = true,
                    event = "avid-weed:client:harvestPlant",
                    args = {entity = plantData.entity, type = plantData.type}

                },
                {
                    title = _U('MENU__PLANT__DESTROY'),
                    icon = "fire",
                    description = _U('MENU__PLANT__DESTROY__DESC'),
                    arrow = true,
                    event = "avid-weed:client:destroyPlant",
                    args = {entity = plantData.entity, type = plantData.type}
                }
            }
        })
        lib.showContext("avid-weed-harvest-plant-menu")
    
    else
        lib.registerContext({
            id = "avid-weed-plant-menu",
            title = _U('MENU__PLANT'):format(plantName),
            options = {
                {
                    title = _U('MENU__PLANT__LIFE'),
                    icon = "notes-medical",
                    description = math.floor(plantData.health).. '%',
                    metadata = {
                        _U('MENU__PLANT__LIFE__META')
                    },
                    progress = math.floor(plantData.health),
                    colorScheme = "red",
                },
                {
                    title = _U('MENU__PLANT__STAGE'),
                    description = math.floor(plantData.growth).. '%',
                    icon = "seedling",
                    metadata = {
                        _U('MENU__PLANT__STAGE__META')
                    },
                    progress = math.floor(plantData.growth),
                    colorScheme = "green"
                },
                {
                    title = _U('MENU__PLANT__FERTILIZER'),
                    description = math.floor(plantData.fertilizer).. '%',
                    icon = "bucket",
                    metadata = {
                        _U('MENU__PLANT__FERTILIZER__META')
                    },
                    arrow = true,
                    progress = math.floor(plantData.fertilizer),
                    colorScheme = "orange",
                    event = "avid-weed:client:showItemMenu",
                    args = {entity = plantData.entity, type = plantData.type, eventType = "fertilizer"}
                },
                {
                    title = _U('MENU__PLANT__WATER'),
                    description = math.floor(plantData.water).. '%',
                    icon = "droplet",
                    metadata = {
                        _U('MENU__PLANT__WATER__META')
                    },
                    arrow = true,
                    progress = math.floor(plantData.water),
                    colorScheme = "blue",
                    event = "avid-weed:client:showItemMenu",
                    args = {entity = plantData.entity, type = plantData.type, eventType = "water"}
                },
                {
                    title = _U('MENU__PLANT__DESTROY'),
                    icon = "fire",
                    description = _U('MENU__PLANT__DESTROY__DESC'),
                    arrow = true,
                    event = "avid-weed:client:destroyPlant",
                    args = {entity = plantData.entity, type = plantData.type}
                }
            }
        })
        lib.showContext("avid-weed-plant-menu")
    end
end)

RegisterNetEvent('avid-weed:client:showItemMenu', function(data)
    local entity = data.entity
    local type = data.type
    local eventType = data.eventType

    local options = {}
    if eventType == 'water' then
        for item, itemData in pairs(Config.Items) do
            if it.hasItem(item, 1) and itemData.water ~= 0 then
                table.insert(options, {
                    title = it.getItemLabel(item),
                    description = _U('MENU__ITEM__DESC'),
                    metadata = {
                        {label = _U('MENU__PLANT__WATER'), value = itemData.water},
                        {label = _U('MENU__PLANT__FERTILIZER'), value = itemData.fertilizer}
                    },
                    arrow = true,
                    event = 'avid-weed:client:useItem',
                    args = {entity = entity, type = type, item = item}
                })
            end
        end
    elseif eventType == 'fertilizer' then
        for item, itemData in pairs(Config.Items) do
            if it.hasItem(item, 1) and itemData.fertilizer ~= 0 then
                table.insert(options, {
                    title = it.getItemLabel(item),
                    description = _U('MENU__ITEM__DESC'),
                    metadata = {
                        {label = _U('MENU__PLANT__WATER'), value = itemData.water},
                        {label = _U('MENU__PLANT__FERTILIZER'), value = itemData.fertilizer}
                    },
                    arrow = true,
                    event = 'avid-weed:client:useItem',
                    args = {entity = entity, type = type, item = item}
                })
            end
        end
    end
    if #options == 0 then
        ShowNotification(nil, _U('NOTIFICATION__NO__ITEMS'), 'error')
        return
    end

    lib.registerContext({
        id = "avid-weed-item-menu",
        title = _U('MENU__ITEM'),
        options = options
    })

    lib.showContext("avid-weed-item-menu")
end)

-- ┌───────────────────────────────────────────────────────────────────────────┐
-- │ ____                              _               __  __                  │
-- │|  _ \ _ __ ___   ___ ___  ___ ___(_)_ __   __ _  |  \/  | ___ _ __  _   _ │
-- │| |_) | '__/ _ \ / __/ _ \/ __/ __| | '_ \ / _` | | |\/| |/ _ \ '_ \| | | |│
-- │|  __/| | | (_) | (_|  __/\__ \__ \ | | | | (_| | | |  | |  __/ | | | |_| |│
-- │|_|   |_|  \___/ \___\___||___/___/_|_| |_|\__, | |_|  |_|\___|_| |_|\__,_|│
-- │                                           |___/                           │
-- └───────────────────────────────────────────────────────────────────────────┘
-- Processing Menu
RegisterNetEvent('avid-weed:client:showRecipesMenu', function(data)

    local tableType = Config.ProcessingTables[data.type]
    local options = {}

    for k, v in pairs(tableType.recipes) do
        table.insert(options, {
            title = v.label,
            description = _U('MENU__RECIPE__DESC'),
            icon = "flask",
            arrow = true,
            event = "avid-weed:client:showProcessingMenu",
            args = {entity = data.entity, recipe = k, type = data.type}
        })
    end

    table.insert(options, {
        title = _U('MENU__TABLE__REMOVE'),
        icon = "ban",
        description = _U('MENU__TABLE__REMOVE__DESC'),
        arrow = true,
        event = "avid-weed:client:removeTable",
        args = {entity = data.entity, type = data.type}
    })

    lib.registerContext({
        id = "avid-weed-recipes-menu",
        title = _U('MENU__PROCESSING'),
        options = options
    })

    lib.showContext("avid-weed-recipes-menu")
end)

RegisterNetEvent("avid-weed:client:showProcessingMenu", function(data)

    local tableType = data.type
    local recipe = Config.ProcessingTables[tableType].recipes[data.recipe]

    local options = {}
    if not Config.ShowIngrediants then
        for k, v in pairs(recipe.ingrediants) do
            -- Menu only shows the amount not the name of the item
            table.insert(options, {
                title = _U('MENU__UNKNOWN__INGREDIANT'),
                description = _U('MENU__INGREDIANT__DESC'):format(v),
                icon = "flask",
            })
        end
    else
        for k, v in pairs(recipe.ingrediants) do
            table.insert(options, {
                title = it.getItemLabel(k),
                description = _U('MENU__INGREDIANT__DESC'):format(v), --:replace("{amount}", v),
                icon = "flask",
            })
        end
    end

    table.insert(options, {
        title = _U('MENU__TABLE__PROCESS'),
        icon = "play",
        description = _U('MENU__TABLE__PROCESS__DESC'),
        arrow = true,
        event = "avid-weed:client:processDrugs",
        args = {entity = data.entity, type = data.type, recipe = data.recipe}
    })

    lib.registerContext({
        id = "avid-weed-processing-menu",
        title = recipe.label,
        options = options,
        menu = 'avid-weed-recipes-menu',
        onBack = function()
            TriggerEvent('avid-weed:client:showRecipesMenu', {type = data.type, entity = data.entity})
        end,
    })
    lib.showContext("avid-weed-processing-menu")
end)

-- ┌──────────────────────────────────────────┐
-- │ ____       _ _   __  __                  │
-- │/ ___|  ___| | | |  \/  | ___ _ __  _   _ │
-- │\___ \ / _ \ | | | |\/| |/ _ \ '_ \| | | |│
-- │ ___) |  __/ | | | |  | |  __/ | | | |_| |│
-- │|____/ \___|_|_| |_|  |_|\___|_| |_|\__,_|│
-- └──────────────────────────────────────────┘
-- Sell Menu

RegisterNetEvent("avid-weed:client:showSellMenu", function(data)
    local item = data.item
    local amount = data.amount
    local price = data.price
    local ped = data.entity

    local itemLabel = it.getItemLabel(item)

    lib.registerContext({
        id = "avid-weed-sell-menu",
        title = _U('MENU__SELL'),
        options = {
            {
                title = _U('MENU__SELL__DEAL'),
                description = _U('MENU__SELL__DESC'):format(itemLabel, amount, amount * price),
                icon = "coins",
            },
            {
                title = _U('MENU__SELL__ACCEPT'),
                icon = "circle-check",
                description = _U('MENU__SELL__ACCEPT__DESC'),
                arrow = true,
                event = "avid-weed:client:salesInitiate",
                args = {type = 'buy', item = item, price = price, amount = amount, tped = ped}
            },
            {
                title = _U('MENU__SELL__REJECT'),
                icon = "circle-xmark",
                description = _U('MENU__SELL__REJECT__DESC'),
                arrow = true,
                event = "avid-weed:client:salesInitiate",
                args = {type = 'close', tped = ped}
            }
        }
    })
    lib.showContext("avid-weed-sell-menu")
end)

-- ┌──────────────────────────────────────────────────────────┐
-- │    _       _           _         __  __                  │
-- │   / \   __| |_ __ ___ (_)_ __   |  \/  | ___ _ __  _   _ │
-- │  / _ \ / _` | '_ ` _ \| | '_ \  | |\/| |/ _ \ '_ \| | | |│
-- │ / ___ \ (_| | | | | | | | | | | | |  | |  __/ | | | |_| |│
-- │/_/   \_\__,_|_| |_| |_|_|_| |_| |_|  |_|\___|_| |_|\__,_|│
-- └──────────────────────────────────────────────────────────┘

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

RegisterNetEvent('avid-weed:client:showMainAdminMenu', function(data)

    local menuType = data.menuType
    if menuType == 'plants' then
        local allPlants = lib.callback.await('avid-weed:server:getPlants', false)
        local plantCount = tablelength(allPlants)

        lib.registerContext({
            id = "avid-weed-admin-main-menu-plants",
            title = _U('MENU__ADMIN__PLANT__MAIN'),
            options = {
                {
                    title = _U('MENU__PLANT__COUNT'),
                    description = _U('MENU__PLANT__COUNT__DESC'):format(plantCount),
                    icon = "seedling",
                },
                {
                    title = _U('MENU__LIST__PLANTS'),
                    description = _U('MENU__LIST__PLANTS__DESC'),
                    icon = "list",
                    arrow = true,
                    event = "avid-weed:client:generatePlantListMenu",
                },
                {
                    title = _U('MENU__ADD__BLIPS'),
                    description = _U('MENU__ADD__PLANT__BLIPS__DESC'),
                    icon = "map-location-dot",
                    arrow = true,
                    event = "avid-weed:client:addAllAdminBlips",
                    args = {type = 'plants'}
                },
                {
                    title = _U('MENU__REMOVE__BLIPS'),
                    description = _U('MENU__REMOVE__PLANT__BLIPS__DESC'),
                    icon = "eraser",
                    arrow = true,
                    event = "avid-weed:client:removeAllAdminBlips",
                    args = {type = 'plants'}
                },
            }
        })
        lib.showContext("avid-weed-admin-main-menu-plants")
    elseif menuType == 'tables' then
        local allTables = lib.callback.await('avid-weed:server:getTables', false)
        local tableCount = tablelength(allTables)

        lib.registerContext({
            id = "avid-weed-admin-main-menu-tables",
            title = _U('MENU__ADMIN__TABLE__MAIN'),
            options = {
                {
                    title = _U('MENU__TABLE__COUNT'),
                    description = _U('MENU__TABLE__COUNT__DESC'):format(tableCount),
                    icon = "flask-vial",
                },
                {
                    title = _U('MENU__LIST__TABLES'),
                    description = _U('MENU__LIST__TABLES__DESC'),
                    icon = "list",
                    arrow = true,
                    event = "avid-weed:client:generateTableListMenu",
                },
                {
                    title = _U('MENU__ADD__BLIPS'),
                    description = _U('MENU__ADD_TABLE__BLIPS__DESC'),
                    icon = "map-location-dot",
                    arrow = true,
                    event = "avid-weed:client:addAllAdminBlips",
                    args = {type = 'tables'}
                },
                {
                    title = _U('MENU__REMOVE__BLIPS'),
                    description = _U('MENU__REMOVE__TABLE__BLIPS__DESC'),
                    icon = "eraser",
                    arrow = true,
                    event = "avid-weed:client:removeAllAdminBlips",
                    args = {type = 'tables'}
                },
            }
        })
        lib.showContext("avid-weed-admin-main-menu-tables")
    end
end)

RegisterNetEvent('avid-weed:client:showPlantListMenu', function(data)

    local plantList = data.plantList

    local options = {}
    for _, v in ipairs(plantList) do
        table.insert(options, {
            title = v.label,
            description = _U('MENU__DIST'):format(it.round(v.distance, 2)),
            icon = "seedling",
            arrow = true,
            event = "avid-weed:client:showPlantAdminMenu",
            args = {plantData = v}
        })
    end

    lib.registerContext({
        id = "avid-weed-plant-list-menu",
        title = _U('MENU__PLANT__LIST'),
        menu = 'avid-weed-placeholder',
        onBack = function()
            Wait(5)
            TriggerEvent('avid-weed:client:showMainAdminMenu', {menuType = 'plants'})
        end,
        options = options
    })
    lib.showContext("avid-weed-plant-list-menu")
end)

RegisterNetEvent('avid-weed:client:showTableListMenu', function(data)
    
    local tableList = data.tableList

    local options = {}
    for _, v in ipairs(tableList) do
        table.insert(options, {
            title = v.label,
            description = _U('MENU__DIST'):format(it.round(v.distance, 2)),
            icon = "flask-vial",
            arrow = true,
            event = "avid-weed:client:showTableAdminMenu",
            args = {tableData = v}
        })
    end

    lib.registerContext({
        id = "avid-weed-table-list-menu",
        title = _U('MENU__TABLE__LIST'),
        menu = 'avid-weed-placeholder',
        onBack = function()
            TriggerEvent('avid-weed:client:showMainAdminMenu', {menuType = 'tables'})
        end,
        options = options
    })
    lib.showContext("avid-weed-table-list-menu")
end)

RegisterNetEvent('avid-weed:client:showPlantAdminMenu', function(data)
    local plantData = data.plantData
    local streetNameHash, _ = GetStreetNameAtCoord(plantData.coords.x, plantData.coords.y, plantData.coords.z)
    local streetName = GetStreetNameFromHashKey(streetNameHash)

    lib.registerContext({
        id = "avid-weed-plant-admin-menu",
        title = _U('MENU__PLANT__ID'):format(plantData.id),
        menu = 'avid-weed-placeholder',
        onBack = function()
            TriggerEvent('avid-weed:client:generatePlantListMenu')
        end,
        options = {
            {
                title = _U('MENU__OWNER'),
                description = plantData.owner,
                icon = "user",
                metadata = {
                    _U('MENU__OWNER__META')
                },
                onSelect = function()
                    lib.setClipboard(plantData.owner)
                    ShowNotification(nil, _U('NOTIFICATION__COPY__CLIPBOARD'):format(plantData.owner), 'success')
                end
            },
            {
                title = _U('MENU__PLANT__LOCATION'),
                description = _U('MENU__LOCATION__DESC'):format(streetName, plantData.coords.x, plantData.coords.y, plantData.coords.z),
                metadata = {
                    _U('MENU__LOCATION__META')
                },
                icon = "map-marker",
                onSelect = function()
                    lib.setClipboard('('..plantData.coords.x..", "..plantData.coords.y..", "..plantData.coords.z..')')
                    ShowNotification(nil, _U('NOTIFICATION__COPY__CLIPBOARD'):format('('..plantData.coords.x..", "..plantData.coords.y..", "..plantData.coords.z..')'), 'success')
                end
            },
            {
                title = _U('MENU__PLANT__TELEPORT'),
                description = _U('MENU__PLANT__TELEPORT__DESC'),
                icon = "route",
                arrow = true,
                onSelect = function()
                    SetEntityCoords(PlayerPedId(), plantData.coords.x, plantData.coords.y, plantData.coords.z)
                    ShowNotification(nil, _U('NOTIFICATION__TELEPORTED'), 'success')
                end
            },
            {
                title = _U('MENU__ADD__BLIP'),
                description = _U('MENU__ADD__PLANT__BLIP__DESC'),
                icon = "map-location-dot",
                arrow = true,
                event = "avid-weed:client:addAdminBlip",
                args = {id = plantData.id, coords = plantData.coords, entityType = plantData.type, type = 'plant'}
            },
            {
                title = _U('MENU__PLANT__DESTROY'),
                description = _U('MENU__PLANT__DESTROY__DESC'),
                icon = "fire",
                arrow = true,
                onSelect = function()
                    TriggerServerEvent('avid-weed:server:destroyPlant', {entity = plantData.entity, extra='admin'})
                    ShowNotification(nil, _U('NOTIFICATION__PLANT__DESTROYED'), 'success')
                end
            }
        }
    })
    lib.showContext("avid-weed-plant-admin-menu")
end)

RegisterNetEvent('avid-weed:client:showTableAdminMenu', function(data)
    local tableData = data.tableData
    local streetNameHash, _ = GetStreetNameAtCoord(tableData.coords.x, tableData.coords.y, tableData.coords.z)
    local streetName = GetStreetNameFromHashKey(streetNameHash)

    lib.registerContext({
        id = "avid-weed-table-admin-menu",
        title = _U('MENU__TABLE__ID'):format(tableData.id),
        menu = 'avid-weed-placeholder',
        onBack = function()
            TriggerEvent('avid-weed:client:generateTableListMenu')
        end,
        options = {
            {
                title = _U('MENU__PLANT__LOCATION'),
                description = _U('MENU__LOCATION__DESC'):format(streetName, tableData.coords.x, tableData.coords.y, tableData.coords.z),
                metadata = {
                    _U('MENU__LOCATION__META')
                },
                icon = "map-marker",
                onSelect = function()
                    lib.setClipboard('('..tableData.coords.x..", "..tableData.coords.y..", "..tableData.coords.z..')')
                    ShowNotification(nil, _U('NOTIFICATION__COPY__CLIPBOARD'):format('('..tableData.coords.x..", "..tableData.coords.y..", "..tableData.coords.z..')'), 'success')
                end
            },
            {
                title = _U('MENU__TABLE__TELEPORT'),
                description = _U('MENU__TABLE__TELEPORT__DESC'),
                icon = "route",
                arrow = true,
                onSelect = function()
                    SetEntityCoords(PlayerPedId(), tableData.coords.x, tableData.coords.y, tableData.coords.z)
                    ShowNotification(nil, _U('NOTIFICATION__TELEPORTED'), 'success')
                end
            },
            {
                title = _U('MENU__ADD__BLIP'),
                description = _U('MENU__ADD__TABLE__BLIP__DESC'),
                icon = "map-location-dot",
                arrow = true,
                event = "avid-weed:client:addAdminBlip",
                args = {id = tableData.id, coords = tableData.coords, entityType = tableData.type, type = 'table'}
            },
            {
                title = _U('MENU__TABLE__DESTROY'),
                description = _U('MENU__TABLE__DESTROY__DESC'),
                icon = "trash",
                arrow = true,
                onSelect = function()
                    TriggerServerEvent('avid-weed:server:removeTable', {entity = tableData.entity, extra='admin'})
                    ShowNotification(nil, _U('NOTIFICATION__TABLE__DESTROYED'), 'success')
                end,
                
            }
        }
    })
    lib.showContext("avid-weed-table-admin-menu")
end)