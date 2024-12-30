print("^2BNKS^2-^2YACHT HEIST ^1v^11^1.^10^1.^10 ^1- ^3YACHT HEIST Script by ^4Banksy^7")


Config = {}


Config.PedLocation = vector4(720.22, -1149.42, 22.85, 88.56)
Config.PedLocation2 = vector4(1241.77, -425.81, 67.9, 278.66)

Config.SellPedDel = 600000 ---- Milliseconds = 10 mins 

Config.RequiredCops = 1
Config.coolDown = 10 -- Reset Time In Minutes
Config.Reqitem = "bnk_hacking_device"
Config.Reqitem2 = "bnk_laptop"
Config.MinMoneyBag = 5000
Config.MaxMoneyBag = 10000
Config.Rewards = {
    { item = 'bnk_bagofcash',    min = 1, max = 2, price = 200},
    { item = 'bnk_diamondskull',    min = 1, max = 1, price = 500},
    { item = 'bnk_bagofjewels',    min = 1, max = 1},    
    { item = 'rolex',    min = 1, max = 5},
    { item = 'diamond_ring',    min = 1, max = 6},
    { item = 'diamond',    min = 1, max = 4},
    { item = 'goldchain',    min = 1, max = 5},
    { item = 'goldbar',    min = 1, max = 10},
    { item = 'weapon_heavypistol',    min = 1, max = 1},
}

Config.Searchable = {
    [1] = {
        coords = vector3(-2086.82, -1021.56, 8.97),
        width = 2.6,
        height = 1.0,
        heading = 343,
        minZ = 8.12,
        maxZ = 9.52,
        looted = false
    },
    [2] = {
        coords = vector3(-2076.4, -1020.72, 8.97),
        width = 2.6,
        height = 1.0,
        heading = 341,
        minZ= 8.17,
        maxZ= 9.57,
        looted = false
    },
    [3] = {
        coords = vector3(-2093.71, -1016.81, 5.88),
        width = 1.2,
        height = 1.0,
        heading = 11,
        minZ= 5.08,
        maxZ= 5.68,
        looted = false
    },
    [4] = {
        coords = vector3(-2091.39, -1013.55, 5.88),
        width = 1.4,
        height = 1.0,
        heading = 160,
        minZ= 5.08,
        maxZ= 6.08,
        looted = false
    },
    [5] = {
        coords = vector3(-2090.08, -1009.55, 5.88),
        width = 1.4,
        height = 1.0,
        heading = 342,
        minZ= 5.08,
        maxZ= 6.28,
        looted = false
    },
    [6] = {
        coords = vector3(-2083.54, -1019.24, 5.88),
        width = 2.2,
        height = 0.5,
        heading = 342,
        minZ= 5.08,
        maxZ= 7.08,
        looted = false
    },
    [7] = {
        coords = vector3(-2071.24, -1024.34, 5.88),
        width = 0.6,
        height = 1.0,
        heading = 254,
        minZ= 5.08,
        maxZ= 6.08,
        looted = false
    },
    [8] = {
        coords = vector3(-2070.5, -1021.03, 5.88),
        width = 0.4,
        height = 1.0,
        heading = 71,
        minZ= 5.08,
        maxZ= 6.08,
        looted = false
    },

}


Config['Guards'] = {

    ['Guards1'] = {
    { coords = vector3(-2055.04, -1026.51, 14.9), heading = 246.43, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2085.33, -1018.79, 15.99), heading = 256.9, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2078.27, -1023.4, 15.99), heading = 233.42, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2076.19, -1018.31, 15.99), heading = 292.8, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2064.82, -1019.3, 15.11), heading = 266.42, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2041.43, -1028.76, 11.98), heading = 299.7, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2040.87, -1032.16, 11.98), heading = 246.34, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2043.78, -1034.85, 11.98), heading = 177.35, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2036.51, -1033.94, 8.97), heading = 254.84, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2046.76, -1023.73, 8.97), heading = 252.96, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2052.0, -1035.85, 8.97), heading = 258.66, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2074.99, -1028.71, 5.88), heading = 240.11, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2066.1, -1017.66, 5.88), heading = 291.02, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2017.81, -1033.87, 2.78), heading = 270.35, model = 'mp_m_fibsec_01'},
    { coords = vector3(-2021.85, -1044.58, 2.45), heading = 269.01, model = 'mp_m_fibsec_01'},
    },
   
}
































Config.Timeout = false
Config.Hacked = false