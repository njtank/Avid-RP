Config = {}

-- Scrap Yard Location (for the blip and sphere zones)
Config.ScrapYardLocation = vector3(200.0, -2000.0, 20.0) -- Example coordinates

-- Blip Configuration
Config.Blip = {
    coords = vector3(200.0, -2000.0, 20.0), -- Position of the blip
    sprite = 402,  -- Blip sprite ID (e.g., 402 is for a scrap yard)
    color = 5,     -- Blip color (e.g., 5 for green)
    scale = 0.8,   -- Blip size
    name = "Scrap Yard" -- Name that will show on the map
}

-- Task Duration (in seconds)
Config.TaskDuration = 24  -- Example: 24 seconds to scrap a car

-- Reward Items
Config.RewardItems = {
    "plastic",   -- Item 1
    "scrapmetal", -- Item 2
    "rubber"      -- Item 3
}

-- Item Amount Range
Config.MinRewardAmount = 1
Config.MaxRewardAmount = 4

-- Number of Tasks Before Cash Payment
Config.TasksBeforeCash = 5  -- After 5 tasks, $50 is paid to the player

-- Sphere Zone Configuration (for each car in the scrapyard)
Config.ScrapZones = {
    {coords = vector3(210.0, -2000.0, 20.0), radius = 3.0},
    {coords = vector3(220.0, -2000.0, 20.0), radius = 3.0},
    -- Add more zones here as needed
}
