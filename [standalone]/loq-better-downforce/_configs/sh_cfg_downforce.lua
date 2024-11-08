--[[
sh_cfg_downforce.lua

This is a config file for the downforce patch.
]]

DownForceConfig = {}

--[[
    DownForceConfig.Enable

    If you wish to utilize the downforce patch, set the following to true.
    DownForceConfig.Enable = true
]]
DownForceConfig.Enable = true

--[[
    DownForceConfig.GlobalSuspensionTolerance

    This is the global suspension tolerance for a vehicle.
    This is applied to every vehicle that utilizes the downforce patch, unless
    specified in the DownForceConfig.SpecificSuspensionTolerance list.

    This value effects how sensitive the patch will be applied.
    For example, setting the value to a higher number will result in
    the patch not being applied as often, if not at all.

    Setting the value to a lower number will result in the patch
    being applied often.

    Lower value = more sensitive.
    Higher value = less sensitive.

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IMPORTANT: YOU MAY NEED TO ADJUST IF YOU DO NOT RUN STOCK GTAV HANDLING.
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!

    A good starting point with default GTAV vehicles is 1.2

    DownForceConfig.GlobalSuspensionTolerance = 1.2
]]
DownForceConfig.GlobalSuspensionTolerance = 1.1

--[[
    DownForceConfig.SpeedHarshness

    This is the harshness that the speed will be adjusted for a vehicle
    when it goes over a bump on the road.

    Increasing the value will reduce the harshness, meaning that you will
    not notice much of a speed change when going over a bump.

    Decreasing the value will increase the harshness, meaning that you will
    notice more of a speed change when going over a bump.

    The speed change means how much the speed will reduce when going over a bump.

    For example, if the speed harshness is set to 10, and the vehicle is going at
    86mph and it goes over a bump, it will reduce down to 75-80mph.

    But, if the spee harshness is set to 80, and the vehicle is going at
    86mph and it goes over a bump, it will reduce down to 84-86mph.

    A good starting point with default GTAV vehicles is 50.
]]
DownForceConfig.SpeedHarshness = 50

--[[
    DownForceConfig.SpecificSuspensionTolerance

    These are specific suspension tolerances for specific vehicles.
    If you find that one or two of your vehicles does not work well
    with the global suspension tolerance, you can specify a specific
    value for the vehicle.

    View the above configuration option to know more about the values.

    Example list:
    DownForceConfig.SpecificSuspensionTolerance = {
        ["adder"] = 1.5
    }
]]
DownForceConfig.SpecificSuspensionTolerance = {}

--[[
    DownForceConfig.EnableVehicleAllowlist

    If you want to utilize the allowlist for vehicle models, set the following to true.
    By enabling the allowlist for vehicle models, only the vehicles listed will utilize
    the downforce patch.
    DownForceConfig.EnableVehicleAllowlist = true.
]]
DownForceConfig.EnableVehicleAllowlist = false

--[[
    DownForceConfig.EnableVehicleDisallowlist

    If you want to utilize the disallowlist for vehicle models, set the following to true.
    By enabling the disallowlist for vehicle models, the vehicles listed will not utilize
    the downforce patch.

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IMPORTANT: THIS LIST TAKES PRIORITY OVER THE VEHICLE ALLOWLIST AND VEHICLE CLASSES ALLOWLIST.
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!

    DownForceConfig.EnableVehicleDisallowlist = true.
]]
DownForceConfig.EnableVehicleDisallowlist = false

--[[
    DownForceConfig.EnableClassesAllowlist

    If you want to utilize the allowlist for vehicle classes, set the following to true.
    By enabling the allowlist for vehicle classes, only the vehicle classes listed will
    utilize the downforce patch.
    DownForceConfig.EnableClassesAllowlist = true.
]]
DownForceConfig.EnableClassesAllowlist = false

--[[
    DownForceConfig.EnableClassesDisallowlist

    If you want to utilize the disallowlist for vehicle classes, set the following to true.
    By enabling the disallowlist for vehicle classes, the vehicle classes listed will not
    utilize the downforce patch.

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IMPORTANT: THIS LIST TAKES PRIORITY OVER THE VEHICLE ALLOWLIST AND VEHICLE CLASSES ALLOWLIST.
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!

    DownForceConfig.EnableClassesDisallowlist = true.
]]
DownForceConfig.EnableClassesDisallowlist = false

--[[
    DownForceConfig.AllowlistVehicles

    This is the allowlist for vehicle models. Simply add the vehicle model or hash into the list
    and it will be utilized. Example list:

    DownForceConfig.AllowlistVehicles = {
        "adder",
        "comet3",
        "elegy2"
    }
]]
DownForceConfig.AllowlistVehicles = {}

--[[
    DownForceConfig.AllowlistClasses

    This is the allowlist for vehicle classes. Simply add the vehicle class into the list
    and it will be utilized. Example list:

    DownForceConfig.AllowlistClasses = {
        6,
        4,
        7
    }
]]
DownForceConfig.AllowlistClasses = {}

--[[
    DownForceConfig.DisallowlistVehicles

    This is the disallowlist for vehicle models. Simply add the vehicle model or hash into the list
    and it will not be utilized. Example list:

    DownForceConfig.DisallowlistVehicles = {
        "adder",
        "comet3",
        "elegy2"
    }
]]
DownForceConfig.DisallowlistVehicles = {}

--[[
    DownForceConfig.DisallowlistClasses

    This is the disallowlist for vehicle classes. Simply add the vehicle class into the list
    and it will not be utilized. Example list:

    DownForceConfig.DisallowlistClasses = {
        6,
        4,
        7
    }
]]
DownForceConfig.DisallowlistClasses = {}

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