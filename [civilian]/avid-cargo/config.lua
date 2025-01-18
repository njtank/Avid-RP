return {
    Debug = false,
    Fuel = {
        enable = true, -- I use ox_fuel so I set this to false and use statebag to set the fuel
        script = 'cdn-fuel',
    },
    Ped = 'mp_m_weapexp_01',
    PedCoords = vec4(849.76, -1995.65, 28.98, 357.21),
    VehicleSpawn = vec4(846.77, -1988.8, 29.39, 357.22),
    DeliveryInfo = { 
        title = 'Cargo Delivery', 
        msg = 'Deliver the cargo to the location.', 
        sec = 7, 
        audioName = 'Boss_Message_Orange', audioRef = 'GTAO_Boss_Goons_FM_Soundset'
    },
    ReturnInfo = { 
        title = 'Delivery Complete', 
        msg = 'Return back to the warehouse to get paid.', 
        sec = 7, 
        audioName = 'Mission_Pass_Notify', audioRef = 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS'
    },
    Target = true, -- true = use target | false = ox lib zones [E] to interact.
}
