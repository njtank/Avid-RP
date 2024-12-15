Config = {}

--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


-- Thank you for downloading this script!

-- Below you can change multiple options to suit your server needs.


Config.DebugPoly = false



Config.Blips = {
    {title = 'Smoking Shop', colour = 5, id = 648, coords = vector3(172.19, -1336.0, 29.3), scale = 0.7, useblip = false}, -- BLIP FOR SMOKING SHOP
}


Config.CoreSettings = {
    Notify = {
        Type = 'qb', -- support for qb-core notify, okokNotify, mythic_notify and boii_ui notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for mythic_notify
        --use 'boii' for boii_ui notify
        UseSound = true, -- uses sound for okokNotify
        PrimaryLength = 2500, -- primary notification length
        SuccessLength = 2500, -- success notification length
        ErrorLength = 2500, -- error notification length
    },
    Target = {
        Type = 'ox', -- support for qb-target and ox_target
        -- use 'qb' for qb-target
        --use 'ox' for ox_target
    },
    ProgressBar = {
        OpenPack = 5000, -- time it takes in MS to open pack of cigs
        SmokeCig = 20000, -- time it takes in MS to smoke cigs
        SmokeVape = 20000, -- time it takes in MS to smoke a vape
    },
    Shop = {
        Type = 'ox', -- support for qb-inventory shops, jim-shops and ox_inventory shops - IF USING OX INVENTORY YOU MUST CREATE YOUR OWN SHOP INSIDE OX_INVENTORY TO ACCESS THE SUPPLIES STORE USING THE SNIPPET PROVIDED IN THE README FILE
        --use 'qb' for qb-shops
        --use 'jim' for jim-shops
        --use 'ox' for ox_inventory shops
    },
    Inventory = { --support for qb-inventory and ox_inventory
        Type = 'ox',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
    },
    EventNames = {
        HudStatus = 'hud:server:RelieveStress', -- NAME OF HUD EVENT TO RELIEVE STRESS - DEFAULT EVENT NAME IS 'hud:server:RelieveStress'
    },
    Effects = {

        --CIGARETTES ONLY
        RemoveHealth = true, -- removes a small amount of health when the player smokes a cigarette
        HealthAmount = math.random(1,2), -- if set to true then how much health does the player lose?

        --VAPES ONLY
        AddHealth = true, -- adds a small amount of health when the player smokes a vape
        VapeHealthAmount = math.random(5,10), -- if set to true then how much health does the player gain?

        --VAPES AND CIGARETTES
        AddArmour = true, -- add armour from smoking
        ArmourAmount = math.random(1,3), -- if set to true then how much armour does the player gain?

        RemoveStress = true, -- removes stress from smoking
        RemoveStressAmount = math.random(5,10), -- if set to true then how much stress relief does the player get?
        
    },
}


Config.InteractionLocations = {-- if using ox_inventory you can ignore this section but make sure you have included the ox_inventory shops snippet found in the readme file to be able to obtain the items
    Store = {
       --[[ Location = {
            Location = vector3(170.03, -1337.09, 29.3), -- location of boxzone
            Width = 1.5, --width of boxzone
            Height = 1.5, -- height of boxzone
            Heading = 100, -- heading of boxzone
            MinZ = 28.5, -- minz of boxzone
            MaxZ = 31, -- maxz of boxzone
            Icon = 'fa-solid fa-smoking', -- icon for target
            Label = 'Open Smoking Shop', -- label for target
            Size = vec3(1.5,1.5,3), -- ONLY USED FOR OX_TARGET
        },
        Items = {
            label = "Smoking Shop",
            slots = 7,
            items = {
                [1] = { name = "redwoodpack", price = 250, amount = 100, info = {}, type = "item", slot = 1,},
                [2] = { name = "yukonpack", price = 250, amount = 100, info = {}, type = "item", slot = 2,},
                [3] = { name = "debonairepack", price = 250, amount = 100, info = {}, type = "item", slot = 4,},
                [4] = { name = "lighter", price = 5, amount = 100000, info = {}, type = "item", slot = 5,},
                [5] = { name = "vape", price = 25, amount = 100, info = {}, type = "item", slot = 6,},
                [6] = { name = "vapejuice", price = 25, amount = 100, info = {}, type = "item", slot = 7,},
            },
        },]]
    },
}

