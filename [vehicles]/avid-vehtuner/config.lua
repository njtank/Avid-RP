Config = {}

Config.TuningClasses = {
    ["D"] = {
        powerMultiplier = 0.3,
        torqueMultiplier = 0.3,
        maxSpeed = 120.0,
        suspensionForce = 3.0,
        suspensionDamping = 0.5,
        brakeForce = 2.0,
        handBrakeForce = 1.0,
        tractionCurveMax = 2.0,
        tractionCurveMin = 1.8,
        tractionLossMult = 0.9
    },
    
    ["C"] = {
        powerMultiplier = 0.5,
        torqueMultiplier = 0.5,
        maxSpeed = 140.0,
        suspensionForce = 2.5,
        suspensionDamping = 0.4,
        brakeForce = 2.5,
        handBrakeForce = 1.5,
        tractionCurveMax = 2.5,
        tractionCurveMin = 2.2,
        tractionLossMult = 0.8
    },
    
    ["B"] = {
        powerMultiplier = 0.7,
        torqueMultiplier = 0.7,
        maxSpeed = 160.0,
        suspensionForce = 2.0,
        suspensionDamping = 0.3,
        brakeForce = 3.0,
        handBrakeForce = 1.8,
        tractionCurveMax = 2.8,
        tractionCurveMin = 2.5,
        tractionLossMult = 0.7
    },

    ["A"] = {
        powerMultiplier = 1.5,
        torqueMultiplier = 2.8,
        maxSpeed = 180.0,
        suspensionForce = 1.5,
        suspensionDamping = 0.2,
        brakeForce = 4.0,
        handBrakeForce = 2.0,
        tractionCurveMax = 3.0,
        tractionCurveMin = 2.5,
        tractionLossMult = 0.6
    },

    ["S"] = {
        powerMultiplier = 2.0,
        torqueMultiplier = 3.5,
        maxSpeed = 220.0,
        suspensionForce = 1.2,
        suspensionDamping = 0.15,
        brakeForce = 5.0,
        handBrakeForce = 2.5,
        tractionCurveMax = 3.5,
        tractionCurveMin = 3.0,
        tractionLossMult = 0.5
    }
}

Config.EnableJobRestrictions = true 
Config.EnableCategoryRestrictions = true 

Config.AllowedJobs = {
    ["police"] = {"A", "B", "C", "D", "S"},
    ["ems"] = {"A", "B", "C", "D", "S"},
}

Config.VehicleCategories = {
    ["emergency"] = {
        enabled = true,
        classes = {"A", "B", "C", "D", "S"}
    },
    ["sedans"] = {
        enabled = false,
        classes = {}
    },
    ["suvs"] = {
        enabled = false,
        classes = {}
    },
    ["coupes"] = {
        enabled = false,
        classes = {}
    },
    ["muscle"] = {
        enabled = false,
        classes = {}
    },
    ["sports"] = {
        enabled = false,
        classes = {}
    },
    ["sports classics"] = {
        enabled = false,
        classes = {}
    },
    ["vans"] = {
        enabled = false,
        classes = {}
    },
    ["utility"] = {
        enabled = false,
        classes = {}
    },
    ["industrial"] = {
        enabled = false,
        classes = {}
    },
    ["off-road"] = {
        enabled = false,
        classes = {"A", "B", "C", "D", "S"}
    },
}
