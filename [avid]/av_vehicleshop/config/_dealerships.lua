--[[
    decrypted for reason: scamming
    opiumdev owns all
]]

Config.Dealerships = {
    ['pdm_dealership'] = { -- dealership key index, should be unique for each dealership.
        job = false, -- Job ("string") or false
        garage = "legionsquare", -- Where the vehicle will be stored.
        money_account = "bank", -- Account used for purchase.
        money_sign = "$", -- For price display of the vehicle: $, €, £, ¥, etc... or leave it empty ""
        categories = {"compact", "coupe", "cycle", "motorcycle", "muscle", "offroad", "openwheel", "sedan", "service", "sport"}, -- Categories the dealership can sell.
        test_vehicles = true, -- False if you don't want players be able to test vehicles... prevent trolls from testing helicopters and crashing?.
        test_coords = {x = -12.65, y = -1088.88, z = 27.04, h = 156.6}, -- Where the test vehicle spawns.
        text_zones = { -- Zones where clients can access the catalogue.
            {x = -40.63, y = -1094.69, z = 27.27, distance = 2.0},
            {x = -38.56, y = -1100.12, z = 27.27, distance = 2.0},
            {x = -46.82, y = -1095.8, z = 27.27, distance = 2.0},
            {x = -51.38, y = -1094.86, z = 27.27, distance = 2.0},
            {x = -51.21, y = -1087.35, z = 27.27, distance = 2.0},
        },
        preview_vehicle_coords = {x = -1333.68, y = 144.24, z = -99.51, h = 268.77}, -- Spawn coords for vehicle preview (x, y, z, heading)
        preview_vehicle_camera = {x = -1333.94, y = 149.83, z = -99.19, rotation = 180.0, fov = 50.0}, -- Camera coords, rotation and field of view
        buy_vehicle = true, -- Enable/Disable the buy vehicle option... maybe you just want a dealership to display vehicles and not sell them?
        purchased_vehicle_spawn = {x = -33.82, y = -1080.45, z = 27.04, h = 68.2}, -- Where the vehicle/player will be spawned after purchased a vehicle.
        av_vip = false, -- True = If player has VIP the Buy Vehicle button will be enabled, false = you don't need VIP. Requires: https://av-scripts.tebex.io/package/4422968
        blip = {
            label = "PDM Dealership",
            icon = 227, -- https://docs.fivem.net/docs/game-references/blips/#blips
            color = 5, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            scale = 0.7,
            coords = {x = -46.62, y = -1094.36, z = 27.3}
        }
    },
    --[[['boat_dealership'] = { -- dealership key index, should be unique for each dealership.
        job = false, -- Job ("string") or false
        garage = "millars", -- Where the vehicle will be stored.
        money_account = "bank", -- Account used for purchase.
        money_sign = "$", -- For price display of the vehicle: $, €, £, ¥, etc... or leave it empty ""
        categories = {"boats"}, -- Categories the dealership can sell.
        test_vehicles = false, -- False if you don't want players be able to test vehicles... prevent trolls from testing helicopters and crashing?.
        test_coords = {x = -721.65, y = -1344.16, z = 0.0, h = 134.67}, -- Where the test vehicle spawns.
        text_zones = { -- Zones where clients can access the catalogue.
            {x = -711.77, y = -1299.29, z = 5.4, distance = 3.0},
        },
        preview_vehicle_coords = {x = -720.05, y = -1344.16, z = -0.50, h = 134.67}, -- Spawn coords for vehicle preview (x, y, z, heading)
        preview_vehicle_camera = {x = -712.16, y = -1350.44, z = 1.50, rotation = 50.0, fov = 50.0}, -- Camera coords, rotation and field of view
        buy_vehicle = true, -- Enable/Disable the buy vehicle option... maybe you just want a dealership to display vehicles and not sell them?
        purchased_vehicle_spawn = {x = -734.97, y = -1362.08, z = 0.0, h = 138.3}, -- Where the vehicle/player will be spawned after purchased a vehicle.
        av_vip = false, -- True = If player has VIP the Buy Vehicle button will be enabled, false = you don't need VIP. Requires: https://av-scripts.tebex.io/package/4422968
        blip = {
            label = "Boats Dealership",
            icon = 371, -- https://docs.fivem.net/docs/game-references/blips/#blips
            color = 5, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            scale = 0.7,
            coords = {x = -711.77, y = -1299.29, z = 5.4}
        }
    },
    ['mrpd_dealership'] = { -- dealership key index, should be unique for each dealership.
        job = false, -- Job ("string") or false
        garage = "mrpd", -- Where the vehicle will be stored.
        money_account = "bank", -- Account used for purchase.
        money_sign = "$", -- For price display of the vehicle: $, €, £, ¥, etc... or leave it empty ""
        categories = {"lspd"}, -- Categories the dealership can sell.
        test_vehicles = true, -- False if you don't want players be able to test vehicles... prevent trolls from testing helicopters and crashing?.
        test_coords = {x = 412.65, y = -1068.67, z = 29.3, h = 84.35}, -- Where the test vehicle spawns.
        text_zones = { -- Zones where clients can access the catalogue.
            {x = 458.09, y =  -986.57, z = 25.7, distance = 3.0},			
        },
        preview_vehicle_coords = {x = 458.81, y = -993.17, z = 25.7, h = 0.15}, -- Spawn coords for vehicle preview (x, y, z, heading)
        preview_vehicle_camera = {x = 454.81, y = -993.17, z = 26, rotation = 140.0, fov = 60.0}, -- Camera coords, rotation and field of view
        buy_vehicle = true, -- Enable/Disable the buy vehicle option... maybe you just want a dealership to display vehicles and not sell them?
        purchased_vehicle_spawn = {x = 441.75, y = -1014.06, z = 28.65, h = 92.49}, -- Where the vehicle/player will be spawned after purchased a vehicle.
        av_vip = false, -- True = If player has VIP the Buy Vehicle button will be enabled, false = you don't need VIP. Requires: https://av-scripts.tebex.io/package/4422968
        blip = {
            label = "MRPD Dealership",
            icon = 370, -- https://docs.fivem.net/docs/game-references/blips/#blips
            color = 5, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            scale = 0.7,
            coords = {x = 459.50, y = -986.48, z = 25.7, distance = 3.0}
        }
    }]]
}