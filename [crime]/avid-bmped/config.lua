Config = {}

local locale = SD.Locale.T
SD.Locale.LoadLocale('en')

-- Blip Creation
Config.Blip = {
    Enable = false, -- Change to false to disable blip creation
    Sprite = 480, -- Sprite/Icon
    Display = 4,
    Scale = 0.6,
    Colour = 1,
    Name = "Mysterious Person", -- Name of the blip
}

-- Ped Spawns
Config.DonglePedModel = 'cs_old_man2' -- The model name of the boss ped.

Config.DonglePedLocation = { -- The locations where the boss can spawn.
    [1] = vector4(-64.23, 77.13, 70.62, 66.73)
   -- [3] = vector4(683.48, -789.34, 23.5, 0.13)
}

Config.RobberyList = {
    [1] = {
        bank = true,
        Header = locale('menu.fleeca_banks'),
        icon = "fa-solid fa-building-columns",
        minCops = 4,
        description = locale('menu.fleeca_banks_description'),
    },
    [2] = {
        bank = true,
        Header = locale('menu.paleto_bank'),
        icon = "fa-solid fa-piggy-bank",
        minCops = 4,
        description = locale('menu.paleto_bank_description'),
    },
    [3] = {
        bank = true,
        Header = locale('menu.pacific_bank'),
        icon = "fa-solid fa-landmark",
        minCops = 4,
        description = locale('menu.pacific_bank_description'),
    },
}

Config.Shop = {
    [1] = {
        item = "electronickit",
        label = locale('menu.electronic_kit'),
        price = 5,
        type = "crypto",
        icon = "fa-solid fa-laptop-code",
        description = locale('menu.electronic_kit_description')
    },
    [2] = {
        item = "blueprint_smallexplosive",
        label = locale('menu.blueprint_smallexplosive'),
        price = 60,
        type = "crypto",
        icon = "fa-solid fa-laptop-code",
        description = 'A small explosives bomb',
    },
    [3] = {
        item = "thermite",
        label = locale('menu.thermite'),
        price = 100,
        type = "crypto",
        icon = "fa-solid fa-laptop-code",
        description = locale('menu.thermite_description')
    },
    [4] = {
        item = "trojan_usb",
        label = locale('menu.trojan_usb'),
        price = 100,
        type = "crypto",
        icon = "fa-solid fa-laptop-code",
        description = locale('menu.trojan_usb_description')
    },
    [5] = {
        item = "drill",
        label = locale('menu.drill'),
        price = 30,
        type = "crypto",
        icon = "fa-solid fa-laptop-code",
        description = locale('menu.drill_description')
    }
}