Config = {}

-- PED settings
Config.PedModel = "s_m_y_construct_01"
Config.PedLocation = vector4(-500.5, -800.2, 30.5, 90.0) -- Changed to vector4

-- Task settings
Config.TaskDuration = 17000 -- Duration in milliseconds (17 seconds)
Config.PayAmount = 50 -- Payment amount for completing all tasks
Config.RewardMin = 1 -- Minimum item amount for task reward
Config.RewardMax = 3 -- Maximum item amount for task reward
Config.RewardItems = { "rubber", "steel", "iron" } -- Items rewarded after each task

-- Salvage zones
Config.SalvageZones = {
    { coords = vector3(-502.2, -802.5, 30.5), radius = 1.0 },
    { coords = vector3(-503.1, -805.3, 30.5), radius = 1.0 },
    { coords = vector3(-505.6, -807.2, 30.5), radius = 1.0 },
    -- Add more zones as needed
}

-- Blip settings
Config.Blip = {
    coords = vector3(-500.0, -800.0, 30.5),
    sprite = 318,
    color = 1,
    scale = 0.8,
    label = "Salvage Yard",
}
