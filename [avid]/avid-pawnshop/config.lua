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
        slots = 25, -- How many slots are available
        weight = 100000, -- How much weight is available
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
            ['water'] = { label = 'Water', price = 50 },
            ['panties'] = { label = 'Knickers', price = 10 },
            ['lockpick'] = { label = 'Lockpick', price = 25 },
            ['phone'] = { label = 'Phone', price = 150 },
            ['armour'] = { label = 'Bulletproof Vest', price = 225 },
            -- Add & remove items here as desired
            -- Be sure to follow the same format as above
        },
        -- If placeholders = true then the "slots" amount above will be overridden
        -- This option will fill the shop with "display" items, and only
        -- Display items that are possible to sell here. If false, it will be
        -- An empty inventory, and the "slots" amount above will not be overridden
        placeholders = false,
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