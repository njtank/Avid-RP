Config = {}

Config.FrameWork = "QB-CORE" -- "ESX","QB-CORE"

-- List of jobs that have command access
Config.AllowedJobs = {
    ["police"] = true
}

-- Vehicle and PED model configuration
Config.VehicleModel = 'sheriff'
Config.DriverPedModel = 's_m_y_sheriff_01'
Config.PassengerPedModel = 's_m_y_sheriff_01'

-- Enable this if you want PEDS to be invincible and not afraid
Config.Invincible = true

-- Coords of vehicles and PEDs
Config.Locations = {
    FirstVehicle = {
        Start = { x = 341.5603, y = 3417.1433, z = 36.4954, heading = 340.8571 },
        End = { x = 414.3867, y = 3623.8164, z = 32.9673, heading = 297.0319 },
        DriverEnd = { x = 416.6595, y = 3621.3555, z = 33.3659, heading = 359.0754 },
        PassengerEnd = { x = 415.7424, y = 3604.5151, z = 33.3172, heading = 170.7431 }
    },
    SecondVehicle = {
        Start = { x = 363.4009, y = 4446.3071, z = 63.0648, heading = 12.9713 },
        End = { x = -19.4151, y = 4437.0234, z = 57.7198, heading = 156.5797 },
        DriverEnd = { x = -20.3900, y = 4431.5840, z = 58.1148, heading = 219.8900 },
        PassengerEnd = { x = -32.2048, y = 4432.1387, z = 58.1148, heading = 139.5086 }
    },
    ThirdVehicle = {
        Start = { x = -2042.7404, y = 4452.2847, z = 56.2988, heading = 6.3736 },
        End = { x = -1858.6245, y = 4633.0884, z = 56.6908, heading = 226.7670 },
        DriverEnd = { x = -1854.2318, y = 4631.1509, z = 57.0898, heading = 208.8666 },
        PassengerEnd = { x = -1873.9630, y = 4631.1958, z = 57.1835, heading = 94.5651 }
    }
}

-- Animation configuration 
Config.Animations = {
    FirstVehicle = {
        Driver = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
        Passenger = 'WORLD_HUMAN_CAR_PARK_ATTENDANT'
    },
    SecondVehicle = {
        Driver = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
        Passenger = 'WORLD_HUMAN_CAR_PARK_ATTENDANT'
    },
    ThirdVehicle = {
        Driver = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
        Passenger = 'WORLD_HUMAN_CAR_PARK_ATTENDANT'
    }
}
