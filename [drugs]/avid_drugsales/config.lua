Config = {}

Config.ItemName = "black_phone"  -- Make sure this matches the item you put in your qb-core/shared/items.lua
Config.SpawnDistance = 15.0
Config.PedStopDistance = 1.5
Config.AnimationTime = 8000     -- in MS
Config.MinWaitTime = 5000       -- in MS
Config.MaxWaitTime = 8000       -- in MS
Config.AlertChance = 10         -- Percentage chance to alert the police. 1 = 1%, 10 = 10%, 100 = 100%

Config.PedModels = {
    "a_m_m_business_01",
    "a_m_m_farmer_01",
    "a_m_m_hillbilly_01",
    "a_m_m_bevhills_01"
}

Config.Drugs = {
    { name = "cokebaggy", minPrice = 10, maxPrice = 20 },
    { name = "lsd", minPrice = 25, maxPrice = 40 },
    { name = "meth", minPrice = 15, maxPrice = 22 },
}