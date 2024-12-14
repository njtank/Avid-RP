Config = {}
-- Config the job, if vpn = true, vpn will be needed to see this job. 
Config.JobCenter = {
    ['towing'] = {
        vpn = false,
        label = "Towing",
        event = "avid-tablet:jobcenter:tow",
        mem = 1, -- Maximum number of people in 1 group
        count = 0, -- Don't touch
        salary = 'high',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-car-crash"

    },
    ['taxi'] = {
        vpn = false,
        label = "Taxi",
        event = "avid-tablet:jobcenter:taxi",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-taxi"
    },
    ['chopshop'] = {
        vpn = true,
        label = "House Robbery",
        event = "sn-houserobbery:client:chiduong",
        mem = 6,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-mask"
    },
    ['oxyrun'] = {
        vpn = true,
        label = "Oxy Run",
        event = "rep-oxyrun:client:chiduong",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-pills"
    },
    ['theftcar'] = {
        vpn = true,
        label = "Chop Shop",
        event = "rep-chopshop:client:chiduong",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-lock-open"
    },
    ['postop'] = {
        vpn = false,
        label = "PostOp Worker",
        event = "avid-tablet:jobcenter:postop",
        mem = 2,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fa-solid fa-truck-fast"
    },
    ['sani'] = {
        vpn = false,
        label = "Sanitation Worker",
        event = "avid-tablet:jobcenter:sanitation",
        mem = 4,
        count = 0,
        salary = 'low',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-trash"
    },
    ['taco'] = {
        vpn = true,
        label = "Taco Shop",
        event = "rep-weed:client:chiduong",
        mem = 1,
        count = 0,
        salary = 'mid',
        time = {
            first = 2500,
            second = 10000,
        },
        icon = "fas fa-cannabis"
    },
}

-- They will be randomized when they have a VPN
Config.FirstName = {
    'Trump',
    'Musk',
    'Adams',
    'Harrison',
    'Taft',
    'Long',
    'Lodge',
    'Kennedy',
    'Bayh',
    'Indiana',
    'Brown',
    'Miller',
    'Davis',
    'Garcia',
}
-- The name will be random when you have a VPN
Config.LastName = {
    'James',
    'Robert',
    'John',
    'Michael',
    'Cheng',
    'BahnMy',
    'Cris',
    'Hwan',
    'William'
}