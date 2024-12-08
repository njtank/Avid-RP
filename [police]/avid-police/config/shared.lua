return {
    timeout = 10000,
    maxSpikes = 5,
    policePlatePrefix = 'LSPD',
    objects = {
        cone = {model = `prop_roadcone02a`, freeze = false},
        barrier = {model = `prop_barrier_work06a`, freeze = true},
        roadsign = {model = `prop_snow_sign_road_06g`, freeze = true},
        tent = {model = `prop_gazebo_03`, freeze = true},
        light = {model = `prop_worklight_03b`, freeze = true},
        chair = {model = `prop_chair_08`, freeze = true},
        chairs = {model = `prop_chair_pile_01`, freeze = true},
        tabe = {model = `prop_table_03`, freeze = true},
        monitor = {model = `des_tvsmash_root`, freeze = true},
    },

    locations = {
        duty = {
            vec3(626.28, 6.46, 84.39), -- VWPD Front Desk
            vec3(619.6, 10.51, 87.82), -- VWPD Side Desk
        },
        vehicle = {
            vec4(592.41, -2.27, 70.23, 250.34), -- VWPD
            vec4(591.15, -4.89, 70.24, 251.37), -- VWPD
            vec4(589.43, -9.89, 70.24, 251.39), -- VWPD
            vec4(588.53, -12.28, 70.24, 248.42), -- VWPD
        },
        stash = { -- Not currently used, use ox_inventory stashes
            -- vec3(453.075, -980.124, 30.889),
        },
        impound = {
            vec3(402.46, -1626.66, 29.29),
        },
        helicopter = {
            vec4(631.7, 2.99, 99.81, 68.04), -- VWPD
        },
        armory = { -- Not currently used, use ox_inventory shops
            -- vec3(462.23, -981.12, 30.68),
        },
        trash = {
            vec3(629.43, 0.15, 77.5), -- VWPD
        },
        fingerprint = {
            vec3(626.28, -5.62, 77.5), -- VWPD
        },
        evidence = { -- Not currently used, use ox_inventory evidence system
        },
        stations = {
            -- {label = 'Mission Row Police Station', coords = vec3(434.0, -983.0, 30.7)},
            -- {label = 'Sandy Shores Police Station', coords = vec3(1853.4, 3684.5, 34.3)},
             {label = 'Vinewood Police Station', coords = vec3(637.1, 1.6, 81.8)},
            -- {label = 'Vespucci Police Station', coords = vec3(-1092.6, -808.1, 19.3)},
            -- {label = 'Davis Police Station', coords = vec3(368.0, -1618.8, 29.3)},
            -- {label = 'Paleto Bay Police Station', coords = vec3(-448.4, 6011.8, 31.7)},
        },
    },

    radars = {
        -- /!\ The maxspeed(s) need to be in an increasing order /!\
        -- If you don't want to fine people just do that: 'config.speedFines = false'
        -- fine if you're maxspeed or less over the speedlimit
        -- (i.e if you're at 41 mph and the radar's limit is 35 you're 6mph over so a 25$ fine)
        speedFines = {
            {fine = 25, maxSpeed = 10 },
            {fine = 50, maxSpeed = 30},
            {fine = 250, maxSpeed = 80},
            {fine = 500, maxSpeed = 180},
        }
    }
}
