Config = {}

-- PED settings
Config.PedModel = "s_m_y_construct_01"
Config.PedLocation = vec4(2370.18, 3156.98, 47.21, 35.65) -- Changed to vector4

-- Task settings
Config.TaskDuration = 17000 -- Duration in milliseconds (17 seconds)
Config.PayAmount = 50 -- Payment amount for completing all tasks
Config.RewardMin = 1 -- Minimum item amount for task reward
Config.RewardMax = 3 -- Maximum item amount for task reward
Config.RewardItems = { "rubber", "steel", "iron" } -- Items rewarded after each task

-- Salvage zones
Config.SalvageZones = {
    { coords = vector3(2405.82, 3118.94, 48.4), radius = 2.0 },
    { coords = vector3(2410.01, 3122.24, 48.66), radius = 1.0 },
    { coords = vector3(2412.07, 3118.71, 48.73), radius = 1.0 },
    -- Add more zones as needed
}

-- Blip settings
Config.Blip = {
    coords = vec3(2370.18, 3156.98, 48.21),
    sprite = 318,
    color = 1,
    scale = 0.5,
    label = "Salvage Yard",
}
