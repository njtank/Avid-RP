Config = {} -- Do not alter

-- 🔎 Looking for more high quality scripts?
-- 🛒 Shop Now: https://lationscripts.com/github
-- 💬 Join Discord: https://discord.gg/9EbY4nM5uu
-- 😢 How dare you leave this option false?!
Config.YouFoundTheBestScripts = false

-- Use only if needed, directed by support or know what you're doing
-- Notice: enabling debug features will significantly increase resmon
-- And should always be disabled in production
Config.Debug = false

-- Do you want to be notified via server console if an update is available?
-- True if yes, false if no
Config.VersionCheck = false

-- Target system, available options are: 'ox_target', 'qb-target', 'qtarget', 'custom' & 'none'
-- 'custom' needs to be added to client/functions.lua
-- If 'none' then TextUI is used instead of targeting
Config.Target = 'ox_target'

-- Notification system, available options are: 'ox_lib', 'esx', 'qb', 'okok' & 'custom'
-- 'custom' needs to be added to client/functions.lua
Config.Notify = 'ox_lib'

-- If using TextUI (Config.Target = 'none') then what key do you want to open the shop?
-- Default is 38 (E), find more control ID's here: https://docs.fivem.net/docs/game-references/controls/
Config.Interact = 38

-- Manage & create your pawn shops here
Config.Shops = {
    ['vinewood'] = { -- Unique identifier for this shop
        name = 'Vinewood Pawn & Jewelry', -- Shop name
        slots = 100, -- How many slots are available
        weight = 100000000, -- How much weight is available
        coords = vec4(-265.81, 236.67, 90.57, 79.89), -- Where this shop exists
        radius = 1.0, -- How large of a circle zone radius (for targeting only)
        spawnPed = true, -- Spawn a ped to interact with here?
        pedModel = 'CSB_RoccoPelosi', -- If spawnPed = true, what ped model?
        -- You can limit the hours at which the shop is available here
        -- Min is the earliest the shop is available (default 06:00AM)
        -- Max is the latest the shop is available (detault 21:00 aka 9PM)
        -- If you want it available 24/7, set min to 1 and max to 24
        hour = { min = 1, max = 24 },
        account = 'cash', -- Give 'cash', 'bank' or 'dirty' money when selling here?
        allowlist = {
            -- What items can be sold here
            -- Any item not in this list, cannot be sold here
            -- ['itemSpawnName'] = { label = 'Item Name', price = sellPrice }
            --['water'] = { label = 'Water', price = 50 },
            ['panties'] = { label = 'Knickers', price = 10 },
            --['lockpick'] = { label = 'Lockpick', price = 25 },
            ['phone'] = { label = 'Phone', price = 150 },
            ['wine'] = { label = 'Wine', price = 100},
            ['armour'] = { label = 'Bulletproof Vest', price = 225 },
            ['gold_ring'] = { label = 'Gold Ring', price = 170},
            ['diamond_ring'] = { label = 'Diamond Ring', price = 450 },
            ['ruby_necklace'] = { label = 'Ruby Necklace', price = 250},
            ['diamond_necklace'] = { label = 'Diamond Necklace', price = 490 },
            ['fleeca_bank_coin'] = { label = 'Gold Coin', price = 1000},
            ['sapphire_necklace'] = { label = 'Saphire Necklace', price = 180 },
            ['rolex'] = { label = 'Golden Watch', price = 140},
            ['goldchain'] = { label = 'Gold Necklace', price = 130 },
            ['goldearring'] = { label = 'Gold Earring', price = 180 },
            ['diamond_earring'] = { label = 'Diamond Earring', price = 470},
            ['silverearring'] = { label = 'Silver Earring', price = 140 },
            ['romantic_book'] = { label = 'Romantic Book', price = 20},
            ['notepad'] = { label = 'Notepad', price = 10 },
            ['pencil'] = { label = 'Pencil', price = 8},
            ['bong'] = { label = 'Bong', price = 50 },
            ['pogo'] = { label = 'Art Piece', price = 180 },
            ['gold_bracelet'] = { label = 'Gold Braclet', price = 190},
            ['television'] = { label = 'Flat Screen TV', price = 350 },
            ['shoebox'] = { label = 'Shoe Box', price = 110},
            ['dj_deck'] = { label = 'DJ Deck', price = 120 },
            ['console'] = { label = 'Console', price = 80 },
            ['boombox'] = { label = 'Boombox', price = 30},
            ['coffemachine'] = { label = 'Coffee Machine', price = 75 },
            ['tapeplayer'] = { label = 'Tape Player', price = 30},
            ['hairdryer'] = { label = 'Hair Dryer', price = 20 },
            ['j_phone'] = { label = 'Phone', price = 45 },
            ['sculpture'] = { label = 'Sculpture', price = 230},
            ['toiletry'] = { label = 'Toiletry', price = 15 },
            ['paintinge'] = { label = 'Art Piece', price = math.random(900,1100) },
            ['paintingi'] = { label = 'Art Piece', price = math.random(900,1100) },
            ['paintingh'] = { label = 'Art Piece', price = math.random(900,1100) },
            ['paintingj'] = { label = 'Art Piece', price = math.random(900,1100) },
            ['paintingf'] = { label = 'Art Piece', price = math.random(900,1100) },
            ['paintingg'] = { label = 'Art Piece', price = math.random(900,1100) },
            -- Add & remove items here as desired
            -- Be sure to follow the same format as above
        },
        -- If placeholders = true then the "slots" amount above will be overridden
        -- This option will fill the shop with "display" items, and only
        -- Display items that are possible to sell here. If false, it will be
        -- An empty inventory, and the "slots" amount above will not be overridden
        placeholders = true,
        blip = {
            enabled = true, -- Enable or disable the blip for this shop
            sprite = 605, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.5, -- Size/scale
            label = 'Pawn Shop' -- Label
        }
    },
   --[[ ['strawberry'] = {
        name = 'Strawberry Ave Pawn Shop',
        slots = 25,
        weight = 100000,
        coords = vec4(-780.19, -608.97, 30.28, 0.51),
        radius = 1.0,
        spawnPed = true,
        pedModel = 'CSB_Anton',
        hour = { min = 1, max = 24 },
        account = 'cash',
        allowlist = {
            ['water'] = { label = 'Water', price = 2500 },
        },
        placeholders = false,
        blip = {
            enabled = true,
            sprite = 59,
            color = 0,
            scale = 0.5,
            label = 'Pawn Shop'
        }
    },]]
    -- Add more pawn shops here as desired
    -- Be sure to follow the same format as above
}