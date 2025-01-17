Config = Config or {}
Locales = Locales or {}

-- ┌───────────────────────────────────┐
-- │  ____                           _ │
-- │ / ___| ___ _ __   ___ _ __ __ _| |│
-- │| |  _ / _ \ '_ \ / _ \ '__/ _` | |│
-- │| |_| |  __/ | | |  __/ | | (_| | |│
-- │ \____|\___|_| |_|\___|_|  \__,_|_|│
-- └───────────────────────────────────┘
-- All general settings like language or webhook can be found here

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!
]]
Config.Language = 'en'
Config.Target = 'ox_target' -- Target system ('qb-target', 'ox_target' or false to disable)

--[[
    Here you set up the discord webhook, you can find more information about
    this in the server/webhook.lua file.
    If you dont know what a webhook is, you can read more about it here:
    https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks
]]
Config.Webhook = {
    ['active'] = false, -- Set to true to enable the webhook
    ['url'] = nil, -- This will do nothing set you webhook url in server/sv_webhook.lua
    ['name'] = 'avid-weed', -- Name for the webhook
    ['avatar'] = 'https://i.imgur.com/KvZZn88.png', -- Avatar for the webhook
}

-- The Drug Dealer system is a system that allows you to buy seed from a dealer
Config.EnableDealers = false -- Enable drug dealer system

Config.DrugDealers = {
    ['seed_dealer'] = { -- Dealer id (Musst be unique)
        label = 'Seed Dealer', -- Dealer name
        locations = { -- Dealer will spawn at one of these locations
            vector4(-462.8489, 1101.5592, 326.6819, 166.9773),
            vector4(-49.4244, 1903.6714, 194.3613, 95.7213),
            vector4(2414.2463, 5003.8462, 45.6655, 40.8932),
        },
        ped = 's_m_y_dealer_01', -- Ped model
        blip = {
            display = false, -- Display blip on map
            sprite = 140, -- Select blip from (https://docs.fivem.net/docs/game-references/blips/)
            displayColor = 2, -- Select blip color from (https://docs.fivem.net/docs/game-references/blips/)
            displayText = 'Seed Dealer',
        },
        items = { -- Items the dealer is selling
            ['weed_lemonhaze_seed'] = {min = 100, max = 200}, -- min/max price
            ['coca_seed'] = {min = 100, max = 300},
        }
    },
}

--- Growing Related Settings
Config.rayCastingDistance = 7.0 -- distance in meters
Config.FireTime = 10000 -- in ms
Config.ClearOnStartup = true -- Clear dead plants on script start-up
Config.PlayerPlantLimit = 30 -- Max amount of plants a player can have simultaneously

-- ┌───────────────────────────┐
-- │ _____                     │
-- │|__  /___  _ __   ___  ___ │
-- │  / // _ \| '_ \ / _ \/ __|│
-- │ / /| (_) | | | |  __/\__ \│
-- │/____\___/|_| |_|\___||___/│
-- └───────────────────────────┘

Config.OnlyZones = false -- Allow drug growth only in defined zones
Config.GlobalGrowTime = 30 -- Time in minutes for a plant to grow

Config.Zones = {
    ['weed_zone_one'] = { -- Zone id (Musst be unique)
        points = {
            vec3(2031.0, 4853.0, 43.0),
            vec3(2007.0, 4877.0, 43.0),
            vec3(1981.0, 4903.0, 43.0),
            vec3(2006.0, 4929.0, 43.0),
            vec3(2032.0, 4903.0, 43.0),
            vec3(2057.0, 4878.0, 43.0),
        },
        thickness = 4.0,
        growMultiplier = 2, -- GlobalGrowTime / growMultiplier = Time in minutes for a plant to grow in this zone
        
        blip = {
            display = false, -- Display blip on map
            sprite = 469, -- Select blip from (https://docs.fivem.net/docs/game-references/blips/)
            displayColor = 2, -- Select blip color from (https://docs.fivem.net/docs/game-references/blips/)
            displayText = 'Weed Zone',
        },
        exclusive = {'weed_lemonhaze_seed'} -- Types of drugs that will be affected in this are.
    },
    ['weed_zone_two'] = { -- Zone id (Musst be unique)
        points = {
            vec3(2067.0, 4890.0, 41.0),
            vec3(2043.0, 4914.0, 41.0),
            vec3(2017.0, 4940.0, 41.0),
            vec3(2045.0, 4969.0, 41.0),
            vec3(2069.0, 4946.0, 41.0),
            vec3(2097.0, 4918.0, 41.0),
        },
        thickness = 4.0,
        growMultiplier = 2, -- GlobalGrowTime / growMultiplier = Time in minutes for a plant to grow in this zone
        blip = {
            display = false, -- Display blip on map
            sprite = 469, -- Select blip from (https://docs.fivem.net/docs/game-references/blips/)
            displayColor = 2, -- Select blip color from (https://docs.fivem.net/docs/game-references/blips/)
            displayText = 'Weed Zone',
        },
        exclusive = {'weed_lemonhaze_seed'} -- Types of drugs that will be affected in this are.
    },
    ['weed_zone_three'] = { -- Zone id (Musst be unique)
        points = {
            vec3(-2685.64, 2345.53, 16.35),
            vec3(-2569.95, 2350.19, 30.37),
            vec3(-1832.09, 2406.98, 30.49),
            vec3(-1656.2, 2449.72, 29.57),
            vec3(-1445.83, 2418.44, 23.78),
            vec3(-992.14, 2760.91, 24.75),
            vec3(-300.97, 2936.17, 28.83),
            vec3(-419.06, 3132.11, 40.23),
            vec3(-2449.22, 3745.03, 17.49),
            vec3(-3161.04, 3264.99, 2.04),
        },
        thickness = 4.0,
        growMultiplier = 2, -- GlobalGrowTime / growMultiplier = Time in minutes for a plant to grow in this zone
        blip = {
            display = false, -- Display blip on map
            sprite = 469, -- Select blip from (https://docs.fivem.net/docs/game-references/blips/)
            displayColor = 2, -- Select blip color from (https://docs.fivem.net/docs/game-references/blips/)
            displayText = 'Weed Zone',
        },
        --exclusive = {'weed_lemonhaze_seed'} -- Types of drugs that will be affected in this are.
    },
}


-- ┌─────────────────────────────┐
-- │ ____  _             _       │
-- │|  _ \| | __ _ _ __ | |_ ___ │
-- │| |_) | |/ _` | '_ \| __/ __|│
-- │|  __/| | (_| | | | | |_\__ \│
-- │|_|   |_|\__,_|_| |_|\__|___/│
-- └─────────────────────────────┘

Config.PlantDistance = 1.5 -- minimum Distance between two plants

Config.OnlyAllowedGrounds = true -- Allow drug growth only on allowed grounds
Config.AllowedGrounds = {   -- Allowed ground types for planting
    1109728704, -- fields
    -1942898710, -- grass/dirt
    510490462, -- dirt path
    -1286696947,
    -1885547121,
    223086562,
    -461750719,
    1333033863,
    -1907520769,
}

Config.WaterDecay = 3 -- Percent of water that decays every minute
Config.FertilizerDecay = 2 -- Percent of fertilizers that decays every minute

Config.FertilizerThreshold = 5
Config.WaterThreshold = 5
Config.HealthBaseDecay = {2, 4} -- Min/Max Amount of health decay when the plant is below the above thresholds for water and nutrition


Config.Items = {
    ['watering_can'] = {
        water = 100,
        fertilizer = 0,
        itemBack = nil, -- Example itemBack = 'watering_can' if you want to get the watering can back after used
    },
    ['liquid_fertilizer'] = {
        water = 50,
        fertilizer = 50,
        itemBack = nil,
    },
    ['fertilizer'] = {
        water = 0,
        fertilizer = 100,
        itemBack = nil,
    },
    ['advanced_fertilizer'] = {
        water = 0,
        fertilizer = 100,
        itemBack = nil,
    },
}

Config.PlantTypes = {
    -- small is growth 0-30%, medium is 30-80%, large is 80-100%
    ["plant1"] = {
        [1] = {"bkr_prop_weed_01_small_01a", -0.5},
        [2] = {"bkr_prop_weed_med_01a", -0.5},
        [3] = {"bkr_prop_weed_lrg_01a", -0.5},
    },
    ["plant2"] = {
        [1] = {"bkr_prop_weed_01_small_01b", -0.5},
        [2] = {"bkr_prop_weed_med_01b",-0.5},
        [3] = {"bkr_prop_weed_lrg_01b", -0.5},
    },
    ["small_plant"] = {
        [1] = {"bkr_prop_weed_bud_pruned_01a", 0},
        [2] = {"bkr_prop_weed_bud_02b", 0},
        [3] = {"bkr_prop_weed_bud_02a", 0},
    },
}

Config.Plants = { -- Create seeds for drugs

    ['weed_lemonhaze_seed'] = {
        growthTime = false, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Lemon Haze', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant)
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_lemonhaze'] = {min = 1, max = 4},  
            --['other_item'] = {min = 1, max = 2}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to plant/harvest in miliseconds
    },
    ['weed_bluedream_seed'] = {
        growthTime = false, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Blue Dream', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_bluedream']= {min = 1, max = 2}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 2 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_sourdiesel_seed'] = {
        growthTime = false, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Sour Diesel', --
        plantType = 'plant2', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_sourdiesel']= {min = 1, max = 2}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 2 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_pinappleexpress_seed'] = {
        growthTime = 20, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Pineapple Express', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_pineappleexpress']= {min = 1, max = 2}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_whitewidow_seed'] = {
        growthTime = 20, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'White Widow', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_whitewidow']= {min = 1, max = 2}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_gglue_seed'] = {
        growthTime = 20, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Gorilla Glue', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_gglue']= {min = 1, max = 3}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_godfatherog_seed'] = {
        growthTime = 23, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Godfather OG', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_godfatherog']= {min = 2, max = 3}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
    ['weed_weddingcake_seed'] = {
        growthTime = 23, -- Cutsom growth time in minutes false if you want to use the global growth time
        label = 'Wedding Cake', --
        plantType = 'plant1', -- Choose plant types from (plant1, plant2, small_plant) also you can change plants yourself in main/client.lua line: 2
        products = { -- Item the plant is going to produce when harvested with the max amount
            ['weed_weddingcake']= {min = 2, max = 3}
        },
        seed = {
            chance = 88, -- Percent of getting back the seed
            min = 1, -- Min amount of seeds
            max = 3 -- Max amount of seeds
        },
        time = 3000 -- Time it takes to harvest in miliseconds
    },
}

--[[
    Next you have to prepeare the Processing settings. You can create as many processing tables as you want.
    You can create use as many ingrediants as you want. You can also change the processing table models to your liking.
    Each table is for proccessing a specific drug type. You can also create to tables for the same drug type.

]]

-- ┌─────────────────────────────────────────────────┐
-- │ ____                              _             │
-- │|  _ \ _ __ ___   ___ ___  ___ ___(_)_ __   __ _ │
-- │| |_) | '__/ _ \ / __/ _ \/ __/ __| | '_ \ / _` |│
-- │|  __/| | | (_) | (_|  __/\__ \__ \ | | | | (_| |│
-- │|_|   |_|  \___/ \___\___||___/___/_|_| |_|\__, |│
-- │                                           |___/ │
-- └─────────────────────────────────────────────────┘

Config.EnableProcessing = false -- Enable crafting system
Config.ShowIngrediants = false -- Show ingrediants in the processing table

Config.ProcessingSkillCheck = false -- Enable skill check for processingTables (Replaces the progressbar)
Config.SkillCheck = {
    difficulty = {'easy', 'easy', 'medium', 'easy'},
    keys = {'w', 'a', 's', 'd'}
}

Config.ProcessingTables = { -- Create processing table
    ['weed_processing_table'] = {
        type = 'weed',
        model = 'bkr_prop_weed_table_01a', -- Exanples: bkr_prop_weed_table_01a, bkr_prop_meth_table01a, bkr_prop_coke_table01a
        recipes = {
            ['joint'] = {
                label = 'Joint',
                ingrediants = {
                    ['weed_lemonhaze'] = 3,
                    ['paper'] = 1
                },
                outputs = {
                    ['joint'] = 2
                },
                processTime = 5,
                failChance = 15,
                animation = {
                    dict = 'anim@gangops@facility@servers@bodysearch@',
                    anim = 'player_search',
                }
            },
            -- Add more recipes here like this
            --[[ ['weedbag'] = {
                label = 'Weed Bag',
                ingrediants = {
                    ['weed_lemonhaze'] = 3,
                    ['plastic'] = 1
                },
                outputs = {
                    ['weedbag'] = 1
                },
                processTime = 10,
                failChance = 15
            } ]]
        }
    },
    
    ['cocaine_processing_table'] = {
        type = 'cocaine',
        model = 'bkr_prop_coke_table01a', -- Exanples: bkr_prop_weed_table_01a, bkr_prop_meth_table01a, bkr_prop_coke_table01a
        recipes = {
            ['cocaine'] = {
                label = 'Cocaine',
                ingrediants = {
                    ['coca'] = 3,
                    ['nitrous'] = 1
                },
                outputs = {
                    ['cocaine'] = 2
                },
                processTime = 10,
                failChance = 15
            },
        }
    },
}

-- ┌────────────────────────────┐
-- │ ____                       │
-- │|  _ \ _ __ _   _  __ _ ___ │
-- │| | | | '__| | | |/ _` / __|│
-- │| |_| | |  | |_| | (_| \__ \│
-- │|____/|_|   \__,_|\__, |___/│
-- │                  |___/     │
-- └────────────────────────────┘

--[[ Possible Drug Effects:
    runningSpeedIncrease, 
    infinateStamina,
    moreStrength,
    healthRegen,
    foodRegen,
    halfArmor,
    fullArmor,
    drunkWalk,
    psycoWalk,
    outOfBody,
    cameraShake,
    fogEffect,
    confusionEffect,
    whiteoutEffect,
    intenseEffect,
    focusEffect,
    superJump,
    swimming
--]]

Config.EnableDrugs = true -- Enable drug effects
Config.Drugs = { -- Create you own drugs

    --[[['joint'] = {
        label = 'Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'intenseEffect',
            'healthRegen',
            'moreStrength',
            'drunkWalk'
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
    ['cocaine'] = {
        label = 'Cocaine',
        animation = 'sniff', -- Animations: blunt, sniff, pill
        time = 60, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'runningSpeedIncrease',
            'infinateStamina',
            'fogEffect',
            'psycoWalk'
        },
        cooldown = 480, -- Cooldown in seconds until you can use this drug again
    }, ]] 
    ['lemonhaze_joint'] = {
        label = 'Lemon Haze Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'intenseEffect',
            'healthRegen',
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
    ['bluedream_joint'] = {
        label = 'Blue Dream Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'whiteoutEffect',
            'foodRegen',
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
    ['sourdiesel_joint'] = {
        label = 'Sour Diesel Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'intenseEffect',
            'runningSpeedIncrease',
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
    ['pineappleexpress_joint'] = {
        label = 'Pineapple Express Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'fogEffect',
            'infinateStamina',
            'moreStrength',
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
    ['whitewidow_joint'] = {
        label = 'White Widow Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 80, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'outOfBody',
            'healthRegen',
            'foodRegen',
            'psycoWalk'
        },
        cooldown = 360, -- Cooldown in seconds until you can use this drug again
    },
}

--[[
    You also can sell the drugs you created. You can create as many sell zones as you want.
    You can also change the sell zone models to your liking. You can change the price of each drug in each zone.
]]

-- ┌──────────────────────────────┐
-- │ ____       _ _ _             │
-- │/ ___|  ___| | (_)_ __   __ _ │
-- │\___ \ / _ \ | | | '_ \ / _` |│
-- │ ___) |  __/ | | | | | | (_| |│
-- │|____/ \___|_|_|_|_| |_|\__, |│
-- │                        |___/ │
-- └──────────────────────────────┘

Config.EnableSelling = true -- Enable selling system

Config.MinimumCops = 0 -- Minimum cops required to sell drugs
Config.OnlyCopsOnDuty = true -- Check if cops are on-duty (Only QBCore).
Config.PoliceJobs = {
    'police',
    'offpolice',
    'sheriff',
    'offsheriff',
}

Config.SellSettings = {
    ['onlyAvailableItems'] = true, -- Only offers with drugs the player has in his inventory
    ['sellChance'] = 88, -- Chance to sell drug (in %)
    ['stealChance'] = 1, -- Chance that the ped dont give you money (in %)
    ['sellAmount'] = { -- Amount of drugs you can sell
        min = 1,
        max = 3,
    },
    ['sellTimeout'] = 20, -- Max time you get to choose your option (secs)
    ['giveBonusOnPolice'] = true, -- Give bonus money if there is police online | 1-2 Cops : x1.2 | 3-6 Cops : x1.5 | 7-10 Cops : x1.7 | +10 Cops : x2.0
}

Config.SellZones = {
    ['groove'] = {
        points = {
            vec3(-154.0, -1778.0, 30.0),
            vec3(48.0, -1690.0, 30.0),
            vec3(250.0, -1860.0, 30.0),
            vec3(142.0, -1993.0, 30.0),
            vec3(130.0, -2029.0, 30.0),
        },
        thickness = 27,
        drugs = {
            { item = 'whitewidow_joint', price = math.random(4, 8)},
            { item = 'pineappleexpress_joint', price = math.random(4, 8)},
            { item = 'sourdiesel_joint', price = math.random(6, 9)},
            { item = 'bluedream_joint', price = math.random(4, 9)},
            { item = 'lemonhaze_joint', price = math.random(3, 10)},
            { item = 'meth', price = math.random(10, 18)},
        }
    },
    ['vinewood'] = {
        points = {
            vec3(685.0, 36.0, 84.0),
            vec3(647.0, 53.0, 84.0),
            vec3(575.0, 81.0, 84.0),
            vec3(529.0, 100.0, 84.0),
            vec3(52.0, 274.0, 84.0),
            vec3(-34.0, 42.0, 84.0),
            vec3(426.0, -125.0, 84.0),
            vec3(494.0, -140.0, 84.0),
            vec3(518.0, -101.0, 84.0),
            vec3(595.0, -60.0, 84.0),
            vec3(667.0, -9.0, 84.0),
        },
        thickness = 59.0,
        drugs = {
            { item = 'whitewidow_joint', price = math.random(4, 8)},
            { item = 'pineappleexpress_joint', price = math.random(4, 8)},
            { item = 'sourdiesel_joint', price = math.random(6, 9)},
            { item = 'bluedream_joint', price = math.random(4, 9)},
            { item = 'lemonhaze_joint', price = math.random(3, 10)},
            { item = 'meth', price = math.random(10, 18)},
        }
    },
    ['beach'] = {
        points = {
            vec3(-1328.0, -1340.0, 5.0),
            vec3(-1307.0, -1399.0, 5.0),
            vec3(-1297.0, -1421.0, 5.0),
            vec3(-1266.0, -1466.0, 5.0),
            vec3(-1139.0, -1646.0, 5.0),
            vec3(-1129.0, -1640.0, 5.0),
            vec3(-1307.0, -1358.0, 5.0),
            vec3(-1335.0, -1279.0, 5.0),
            vec3(-1349.0, -1285.0, 5.0),
        },
        thickness = 4.0,
        drugs = {
            { item = 'whitewidow_joint', price = math.random(4, 8)},
            { item = 'pineappleexpress_joint', price = math.random(4, 8)},
            { item = 'sourdiesel_joint', price = math.random(6, 9)},
            { item = 'bluedream_joint', price = math.random(4, 9)},
            { item = 'lemonhaze_joint', price = math.random(3, 10)},
            { item = 'meth', price = math.random(10, 18)},
        }
    },
}

Config.BlacklistPeds = { 
    -- Peds you cant sell drugs to
    "mp_m_shopkeep_01",
    "s_m_y_ammucity_01",
    "s_m_m_lathandy_01",
    "s_f_y_clubbar_01",
    "ig_talcc",
    "g_f_y_vagos_01",
    "hc_hacker",
    "s_m_m_migrant_01",
    "S_M_Y_Cop_01",
    "S_M_Y_AmmuCity_01",
    "S_M_M_AmmuCountry",
    "S_F_Y_Cop_01",
    "s_m_y_construct_01",
    "mp_m_exarmy_01",
    "s_m_y_fireman_01",
    
}

function SendPoliceAlert(coords)
    -- Add You own police alert system here
    --[[local message = 'Drug Dealer spotted at '..coords
    TriggerEvent('chat:addMessage', {
        args = {message}
    })]]
    exports['ps-dispatch']:DrugSale()
end

function ShowNotification(source, message, type)
    -- Bridge.Functions.Notify(message, type) are the default Framework notifications
    -- You can change this to your own notification systems
    if source ~= nil then -- Server Messages
        if type == 'error' then
            it.notify(source, message, "error")
        elseif type == 'success' then
            it.notify(source, message, "success")
        else
            it.notify(source, message)
        end
    else -- Client Messages
        if type == 'error' then
            it.notify(message, "error")
        elseif type == 'success' then
            it.notify(message, "success")
        else
            it.notify(message)
        end
    end
end

--[[
    Debug mode, you can see all kinds of prints/logs using debug,
    but it's only for development.
]]
Config.EnableVersionCheck = false -- Enable version check
Config.Branch = 'main' -- Set to 'master' to use the master branch, set to 'development' to use the dev branch
Config.Debug = false -- Set to true to enable debug mode
Config.DebugPoly = false -- Set to true to enable debug mode for PolyZone
