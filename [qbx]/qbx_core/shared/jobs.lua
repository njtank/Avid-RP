---Job names must be lower case (top level table key)
---@type table<string, Job>
return {
    ['unemployed'] = {
        label = 'Civilian',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Freelancer',
                payment = 0
            },
        },
    },
    ['electrical'] = {
        label = 'Electrical',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Electrician',
                payment = 0
            },
        },
    },
    ['newspaper'] = {
        label = 'Newspaper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Newpaper Delivery',
                payment = 0
            },
        },
    },
    ['it'] = {
        label = 'IT',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'IT Technician',
                payment = 0
            },
        },
    },
    ['cargo'] = {
        label = 'Cargo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Cargo Delivery',
                payment = 0
            },
        },
    },
    ['police'] = {
        label = 'LSPD',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Officer',
                payment = 75
            },
            [2] = {
                name = 'Senior Officer',
                payment = 100
            },
            [3] = {
                name = 'Corporal',
                payment = 125
            },
            [4] = {
                name = 'Sergeant',
                payment = 175
            },
            [5] = {
                name = 'Lieutenant',
                isboss = true,
                payment = 225
            },
            [6] = {
                name = 'Capitan',
                isboss = true,
                payment = 275
            },
            [7] = {
                name = 'Assistant Chief',
                isboss = true,
                bankAuth = true,
                payment = 275
            },
            [8] = {
                name = 'Chief',
                isboss = true,
                bankAuth = true,
                payment = 325
            },
            [9] = {
                name = 'Commissioner',
                isboss = true,
                bankAuth = true,
                payment = 375
            },
        },
    },
    ['bcso'] = {
        label = 'BCSO',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Officer',
                payment = 75
            },
            [2] = {
                name = 'Sergeant',
                payment = 100
            },
            [3] = {
                name = 'Lieutenant',
                payment = 125
            },
            [4] = {
                name = 'Chief',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['sasp'] = {
        label = 'SASP',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Officer',
                payment = 75
            },
            [2] = {
                name = 'Sergeant',
                payment = 100
            },
            [3] = {
                name = 'Lieutenant',
                payment = 125
            },
            [4] = {
                name = 'Chief',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['ambulance'] = {
        label = 'EMS',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Paramedic',
                payment = 200
            },
            [2] = {
                name = 'Doctor',
                isboss = true,
                payment = 275
            },
            [3] = {
                name = 'Chief',
                isboss = true,
                bankAuth = true,
                payment = 325
            },
        },
    },
    ['firefighter'] = {
        label = 'SAFD',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Probationary Firefighter',
                payment = 100
            },
            [1] = {
                name = 'Firefighter',
                payment = 200
            },
            [2] = {
                name = 'Engineer',
                isboss = true,
                payment = 275
            },
            [3] = {
                name = 'Lieutenant',
                isboss = true,
                bankAuth = true,
                payment = 325
            },
            [4] = {
                name = 'Battalion Chief',
                isboss = true,
                bankAuth = true,
                payment = 350
            },
            [5] = {
                name = 'Fire Chief',
                isboss = true,
                bankAuth = true,
                payment = 400
            },
        },
    },
    ['realestate'] = {
        label = 'Real Estate',
        type = 'realestate',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'House Sales',
                payment = 75
            },
            [2] = {
                name = 'Business Sales',
                payment = 100
            },
            [3] = {
                name = 'Broker',
                payment = 125
            },
            [4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['taxi'] = {
        label = 'Taxi',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Driver',
                payment = 75
            },
            [2] = {
                name = 'Event Driver',
                payment = 100
            },
            [3] = {
                name = 'Sales',
                payment = 125
            },
            [4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['bus'] = {
        label = 'Bus',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['cardealer'] = {
        label = 'Vehicle Dealer',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Showroom Sales',
                payment = 75
            },
            [2] = {
                name = 'Business Sales',
                payment = 100
            },
            [3] = {
                name = 'Finance',
                payment = 125
            },
            [4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['mechanic'] = {
        label = 'Mechanic',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
            [1] = {
                name = 'Novice',
                payment = 75
            },
            [2] = {
                name = 'Experienced',
                payment = 100
            },
            [3] = {
                name = 'Advanced',
                payment = 125
            },
            [4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['judge'] = {
        label = 'Honorary',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Judge',
                payment = 100
            },
        },
    },
    ['lawyer'] = {
        label = 'Law Firm',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Associate',
                payment = 50
            },
        },
    },
    ['reporter'] = {
        label = 'Reporter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Journalist',
                payment = 50
            },
        },
    },
    ['trucker'] = {
        label = 'Trucker',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['tow'] = {
        label = 'Towing',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['garbage'] = {
        label = 'Garbage',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Collector',
                payment = 50
            },
        },
    },
    ['vineyard'] = {
        label = 'Vineyard',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Picker',
                payment = 50
            },
        },
    },
    ['hotdog'] = {
        label = 'Hotdog',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Sales',
                payment = 50
            },
        },
    },
    ['atomic'] = {
        label = 'Atomic Auto',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Mechanic',
                payment = 50
            },
            [1] = {
                name = 'Sr. Mechanic',
                payment = 75
            },
            [2] = {
                name = 'Supervisor',
                payment = 100
            },
            [3] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 125
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
    ['mosley'] = {
        label = 'Mosley Auto',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Mechanic',
                payment = 50
            },
            [1] = {
                name = 'Sr. Mechanic',
                payment = 75
            },
            [2] = {
                name = 'Supervisor',
                payment = 100
            },
            [3] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 125
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
    },
}
