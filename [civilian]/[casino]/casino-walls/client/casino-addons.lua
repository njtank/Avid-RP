local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-casino:client:openCasinoShop', function()
    local ShopItems = {}
    ShopItems.label = "The Diamond Casino & Resort Shop"
    ShopItems.items = Config.CasinoShop
    ShopItems.slots = #Config.CasinoShop 
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_", ShopItems)
end)

RegisterNetEvent('nchub::casinoChipMenu', function()
    TriggerEvent('drawtextui:HideUI')
    exports['qb-menu']:openMenu({
        {
            header = "The Diamond Casino & Resort Chip Exchange",
            isMenuHeader = true,
        },
        {
            header = "Sell All Casino Chips", 
            txt = "Current Value: $"..Config.casinoChipPrice.." per chip",
            params = {
                
                event = "qb-casino:server:GoldSell",
                isServer = true,
            }
        },
        {
            header = "< Return",
			txt = "",
			params = {
                event = "nchub::casinoMainMenu"
            }
        },
    })
end)

CreateThread(function()
    local CasinoShop = CircleZone:Create(vector3(948.591, 34.207, 71.839), 2.0, {
        name="CasinoShop",
        heading=160,
        debugPoly=false,
        useZ=true,
    })
    CasinoShop:onPlayerInOut(function(isPointInside)
        if isPointInside then
            text = '<b>The Diamond Casino & Resort</b></p>Cashier'
            exports['qb-core']:DrawText(text)
            exports['qb-target']:AddTargetModel(`U_F_M_CasinoCash_01`, {
                options = {
                    { 
                        event = "nchub::casinoMainMenu",
                        icon = "fab fa-speakap",
                        label = "Speak with Casino Employee", 
                    },
                },
                distance = 3.0 
            })
        else
            exports['qb-menu']:closeMenu()
            exports["qb-core"]:HideText()
        end
    end)
end)


CreateThread(function()
    local CasinoMembership = CircleZone:Create(vector3(920.726, 45.883, 71.073), 5.0, {
        name="CasinoMembership",
        heading=160,
        debugPoly=false,
        useZ=true,
    })
    CasinoMembership:onPlayerInOut(function(isPointInside)
        if isPointInside then
            text = '<b>The Diamond Casino & Resort</b></p>Front Counter'
            exports['qb-core']:DrawText(text)
            exports['qb-target']:AddTargetModel(`u_f_m_casinoshop_01`, {
                options = {
                    { 
                        event = "nchub::casinoMembershipMenu",
                        icon = "fab fa-speakap",
                        label = "Speak with Casino Employee", 
                    },
                },
                distance = 3.0 
            })
        else
            exports['qb-menu']:closeMenu()
            exports["qb-core"]:HideText()
        end
    end)
end)



RegisterNetEvent('nchub::casinoMainMenu', function()
    -- QBCore.Functions.TriggerCallback('nchub::server:HasCasinoMembership', function(HasItem)
    --     if HasItem then  
            -- exports["qb-core"]:HideText()
            exports['qb-menu']:openMenu({
                {
                    header = "The Diamond Casino & Resort", 
                    isMenuHeader = true,
                },
                {
                    header = "Chip Exchange", 
                    txt = "See current prices",
                    params = {
                        event = "nchub::casinoChipMenu",
                    }
                },
                {
                    header = "Browse Shop", 
                    txt = "See what we have to offer",
                    params = {
                        event = "qb-casino:client:openCasinoShop",
                    }
                },
                {
                    header = "Cancel",
                    txt = "",
                    params = {
                        event = ""
                    }
                },
            })
        -- else
            text = '<b>The Diamond Casino & Resort</p>Please visit the front desk!</b>'
            exports['qb-core']:DrawText(text)
    --     end
    -- end)
end)

Citizen.CreateThread(function()
    casino = AddBlipForCoord(924.75469, 46.705448, 81.106391)
    SetBlipSprite (casino, 680)
    SetBlipDisplay(casino, 4)
    SetBlipScale  (casino, 0.8)
    SetBlipAsShortRange(casino, true)
    SetBlipColour(casino, 28)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Casino")
    EndTextCommandSetBlipName(casino)
end) 


RegisterNetEvent('nchub::casinoMembershipMenu', function()
    -- exports["qb-core"]:HideText() 
    exports['qb-menu']:openMenu({
        {
            header = "The Diamond Casino & Resort", 
            isMenuHeader = true,
        },
        {
            header = "Purchase Casino Membership", 
            txt = "Price: $"..Config.casinoMemberPrice,
            params = {
                isServer = true,
                event = "nchub::server:purchaseMembership",
            }
        },
        {
            header = "Purchase V.I.P Membership", 
            txt = "Price: $"..Config.casinoVIPPrice,
            params = {
                isServer = true,
                event = "nchub::server:purchaseVIPMembership",
            }
        },
        {
            header = "Cancel",
            txt = "",
            params = {
                event = ""
            }
        },
    })
end) 
