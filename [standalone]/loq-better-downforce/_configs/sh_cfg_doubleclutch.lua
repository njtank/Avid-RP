--[[
sh_cfg_debug.lua

This is a config file for the double clutch patch.
]]

DoubleClutchConfig = {}

--[[
    DoubleClutchConfig.Enable

    If you wish to utilize the double clutch patch, set the following to true.
    DoubleClutchConfig.Enable = true
]]
DoubleClutchConfig.Enable = true

--[[
    DoubleClutchConfig.EnableVehicleAllowlist

    If you want to utilize the allowlist for vehicle models, set the following to true.
    By enabling the allowlist for vehicle models, only the vehicles listed will utilize
    the double clutch patch.
    DoubleClutchConfig.EnableVehicleAllowlist = true.
]]
DoubleClutchConfig.EnableVehicleAllowlist = false

--[[
    DoubleClutchConfig.EnableVehicleDisallowlist

    If you want to utilize the disallowlist for vehicle models, set the following to true.
    By enabling the disallowlist for vehicle models, the vehicles listed will not utilize
    the double clutch patch.

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IMPORTANT: THIS LIST TAKES PRIORITY OVER THE VEHICLE ALLOWLIST AND VEHICLE CLASSES ALLOWLIST.
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!

    DoubleClutchConfig.EnableVehicleDisallowlist = true.
]]
DoubleClutchConfig.EnableVehicleDisallowlist = false

--[[
    DoubleClutchConfig.EnableClassesAllowlist

    If you want to utilize the allowlist for vehicle classes, set the following to true.
    By enabling the allowlist for vehicle classes, only the vehicle classes listed will
    utilize the double clutch patch.
    DoubleClutchConfig.EnableClassesAllowlist = true.
]]
DoubleClutchConfig.EnableClassesAllowlist = false

--[[
    DoubleClutchConfig.EnableClassesDisallowlist

    If you want to utilize the disallowlist for vehicle classes, set the following to true.
    By enabling the disallowlist for vehicle classes, the vehicle classes listed will not
    utilize the double clutch patch.

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IMPORTANT: THIS LIST TAKES PRIORITY OVER THE VEHICLE ALLOWLIST AND VEHICLE CLASSES ALLOWLIST.
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!

    DoubleClutchConfig.EnableClassesDisallowlist = true.
]]
DoubleClutchConfig.EnableClassesDisallowlist = false

--[[
    DoubleClutchConfig.AllowlistVehicles

    This is the allowlist for vehicle models. Simply add the vehicle model or hash into the list
    and it will be utilized. Example list:

    DoubleClutchConfig.AllowlistVehicles = {
        "adder",
        "comet3",
        "elegy2"
    }
]]
DoubleClutchConfig.AllowlistVehicles = {}

--[[
    DoubleClutchConfig.AllowlistClasses

    This is the allowlist for vehicle classes. Simply add the vehicle class into the list
    and it will be utilized. Example list:

    DoubleClutchConfig.AllowlistClasses = {
        6,
        4,
        7
    }
]]
DoubleClutchConfig.AllowlistClasses = {}

--[[
    DoubleClutchConfig.DisallowlistVehicles

    This is the disallowlist for vehicle models. Simply add the vehicle model or hash into the list
    and it will not be utilized. Example list:

    DoubleClutchConfig.DisallowlistVehicles = {
        "adder",
        "comet3",
        "elegy2"
    }
]]
DoubleClutchConfig.DisallowlistVehicles = {}

--[[
    DoubleClutchConfig.DisallowlistClasses

    This is the disallowlist for vehicle classes. Simply add the vehicle class into the list
    and it will not be utilized. Example list:

    DoubleClutchConfig.DisallowlistClasses = {
        6,
        4,
        7
    }
]]
DoubleClutchConfig.DisallowlistClasses = {}

--[[
    Vehicle Classes:  
    0: Compacts  
    1: Sedans  
    2: SUVs  
    3: Coupes  
    4: Muscle  
    5: Sports Classics  
    6: Sports  
    7: Super  
    8: Motorcycles  
    9: Off-road  
    10: Industrial  
    11: Utility  
    12: Vans  
    13: Cycles  
    14: Boats  
    15: Helicopters  
    16: Planes  
    17: Service  
    18: Emergency  
    19: Military  
    20: Commercial  
    21: Trains  
    22: Open Wheel
]]