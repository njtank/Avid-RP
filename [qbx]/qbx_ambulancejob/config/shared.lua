return {
    checkInCost = 35, -- Price for using the hospital check-in system
    minForCheckIn = 222, -- Minimum number of people with the ambulance job to prevent the check-in system from being used

    locations = { -- Various interaction points
        duty = {
            vec3(312.79, -586.41, 43.27),
            --vec3(-254.88, 6324.5, 32.58),
        },
        vehicle = {
            --vec4(294.578, -574.761, 43.179, 35.79),
            --vec4(-234.28, 6329.16, 32.15, 222.5),
        },
        helicopter = {
            --vec4(351.58, -587.45, 74.16, 160.5),
            --vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = {
            
        },
        roof = {
            --(338.54, -583.88, 74.17),
        },
        main = {
            --vec3(298.62, -599.66, 43.29),
        },
        stash = {
            {
                name = 'ambulanceStash',
                label = 'Personal stash',
                weight = 100000,
                slots = 30,
                groups = { ambulance = 0 },
                owner = true, -- Set to false for group stash
                location = vec3(307.09, -601.44, 43.27)
            }
        },

        ---@class Bed
        ---@field coords vector4
        ---@field model number

        ---@type table<string, {coords: vector3, checkIn?: vector3|vector3[], beds: Bed[]}>
        hospitals = {
            pillbox = {
                coords = vec3(310.25, -582.46, 43.27),
                checkIn = vec3(302.81, -584.33, 43.27),
                beds = {
                    {coords = vec4(321.37, -581.73, 44.12, 69.76), model = 1631638868},
                    {coords = vec4(318.53, -580.55, 44.12, 70.09), model = 1631638868},
                    {coords = vec4(316.78, -584.43, 44.12, 250.2), model = 2117668672},
                    {coords = vec4(319.74, -585.26, 44.12, 250.1), model = 2117668672},
                    {coords = vec4(322.54, -586.5, 44.12, 249.94), model = 2117668672},
                    {coords = vec4(325.51, -587.56, 44.12, 250.03), model = -1091386327},
                    {coords = vec4(328.39, -588.52, 44.12, 250.04), model = -1091386327},
                    {coords = vec4(330.46, -585.04, 44.12, 250.12), model = -1091386327},
                    {coords = vec4(327.71, -583.85, 44.12, 69.97), model = -1091386327},
                },
            },
            paleto = {
                coords = vec3(-250, 6315, 32),
                checkIn = vec3(-254.54, 6331.78, 32.43),
                beds = {
                    {coords = vec4(171.6, 259.08, 46.66, 179.76), model = 2117668672},
                    {coords = vec4(172.03, 259.77, 46.66, 359.19), model = 2117668672},
                    {coords = vec4(172.13, 259.82, 46.66, 179.83), model = 2117668672},
                },
            },
            jail = {
                coords = vec3(1761, 2600, 46),
                beds = {
                    {coords = vec4(1771.6, 2592.08, 46.66, 179.76), model = 2117668672},
                    {coords = vec4(1772.03, 2597.77, 46.66, 359.19), model = 2117668672},
                    {coords = vec4(1762.13, 2594.82, 46.66, 179.83), model = 2117668672},
                },
            },
        },

        stations = {
            {label = 'Pillbox Hospital', coords = vec4(310.25, -582.46, 43.27, 243.57)},
        }
    },
}