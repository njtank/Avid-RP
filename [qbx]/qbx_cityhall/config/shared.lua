return {
    cityhalls = {
        {
            coords = vec3(243.97, -1090.49, 29.29),
            showBlip = true,
            blip = {
                label = 'City Services',
                shortRange = true,
                sprite = 487,
                display = 4,
                scale = 0.65,
                colour = 0,
            },
            licenses = {
                ['id'] = {
                    item = 'id_card',
                    label = 'ID',
                    cost = 50,
                },
                ['driver'] = {
                    item = 'driver_license',
                    label = 'Driver License',
                    cost = 50,
                },
                ['weapon'] = {
                    item = 'weaponlicense',
                    label = 'Weapon License',
                    cost = 50,
                },
            },
        },
    },

    employment = {
        enabled = true, -- Set to false to disable the employment menu
        jobs = {
            unemployed = 'Unemployed',
            trucker = 'Trucker',
            taxi = 'Taxi',
            tow = 'Tow Truck',
            electircal = 'Electrical Worker',
            garbage = 'Garbage Collector',
            newspaper = 'Newspaper Delivery',
            it = 'IT Job',
            cargo = 'Cargo Delivery'
        },
    }  
}
