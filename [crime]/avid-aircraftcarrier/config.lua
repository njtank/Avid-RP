Config = {}

Config.coolDown = 3 --- In Mins
Config.ReqCops = 1 -- Required Police 
Config.Reqitem = "weapon_crowbar" ---------Item Required to open create
Config.RemoveReq = 0.5 -- chance to remove required item 

Config.Alert = "ps"   --ps = project sloth dispatch / qb = qb-policejob dispatch 
Config.Phone = "lb"  ----qb = qb-phone / lb = lb phone / gks = gks-phone

---------- Only Needed if using LB-Phone 
Config.lbsender = "Lez@PornHubPremium.cum"
Config.lbsubject = "PornHub Premium"
Config.lbmsg = "Head to the location marked on your GPS and grab a boat. Head to the aircraft carrier and the rest is on you..... Dont Fuck This Up"
Config.lbatm = "https://cdn.discordapp.com/attachments/590889429241954325/1193916655357657199/59f04af32abc04fd3b5a22a18e7dbd4d79f5066a.png?ex=65ae7488&is=659bff88&hm=edbd95eb48f4ac3943cb12814ad53a072120b2d81945c38d4aac4093fe3cf819&"

Config.StartPrice = 10000
Config.PedLocation = vector4(-1046.15, -2867.48, 33.48, 263.59)
-----------------------------------------------------------------

Config.Boat = "dinghy"
Config.Boat1 = vector4(-860.21, -1486.83, 0.12, 290.25)
Config.Boat2 = vector4(-862.6, -1478.46, 0.12, 292.69)
Config.Boat3 = vector4(-856.94, -1494.7, 0.11, 289.89)


Config.Rewards = {
    { item = 'weapon_carbinerifle', min = 1, max = 1},
    { item = 'weapon_heavypistol', min = 1, max = 2},
    { item = 'weapon_minismg', min = 1, max = 2},
    { item = 'weapon_pistol50', min = 1, max = 2},
    { item = 'weapon_pistol', min = 1, max = 2},
}


Config.Searchable = {
    [1] = {
        coords = vector3(3094.75, -4796.1, 6.08),
        width = 1.6,
        height = 1.0,
        heading = 280,
        minZ = 5.68,
        maxZ = 6.28,
        looted = false
    },
    [2] = {
        coords = vector3(3083.68, -4749.45, 6.08),
        width = 1.6,
        height = 1.0,
        heading = 280,
        minZ = 5.68,
        maxZ = 6.28,
        looted = false
    },
    [3] = {
        coords = vector3(3067.13, -4749.12, 6.08),
        width = 1.6,
        height = 1.0,
        heading = 10,
        minZ = 5.68,
        maxZ = 6.48,
        looted = false
    },
    [4] = {
        coords = vector3(3073.7, -4726.32, 6.08),
        width = 1.6,
        height = 1.0,
        heading = 320,
        minZ = 5.68,
        maxZ = 6.48,
        looted = false
    },
    [5] = {
        coords = vector3(3065.48, -4748.6, 8.55),
        width = 1.6,
        height = 1.0,
        heading = 5,
        minZ = 8.15,
        maxZ = 8.95,
        looted = false
    },
    [6] = {
        coords = vector3(3041.29, -4693.0, 6.08),
        width = 1.6,
        height = 1.0,
        heading = 285,
        minZ = 5.68,
        maxZ = 6.48,
        looted = false
    },
   
}


------------Guards -----------------
Config.GuardsGun = "weapon_carbinerifle"
Config['Guards'] = {
    ['AcGuards'] = {
    { coords = vector3(3104.45, -4821.37, 7.03), heading = 194.81, model = 'mp_m_fibsec_01'},
    { coords = vector3(3100.79, -4821.08, 7.03), heading = 198.43, model = 'mp_m_fibsec_01'},
    { coords = vector3(3091.64, -4823.55, 7.03), heading = 198.52, model = 'mp_m_fibsec_01'},
    { coords = vector3(3086.25, -4825.06, 7.03), heading = 193.1, model = 'mp_m_fibsec_01'},
    { coords = vector3(3084.3, -4828.68, 7.03), heading = 207.29, model = 'mp_m_fibsec_01'},
    { coords = vector3(3076.95, -4828.88, 7.03), heading = 105.9, model = 'mp_m_fibsec_01'},
    { coords = vector3(3080.86, -4812.01, 7.03), heading = 239.76, model = 'mp_m_fibsec_01'},
    { coords = vector3(3102.06, -4806.65, 7.03), heading = 139.73, model = 'mp_m_fibsec_01'},
    { coords = vector3(3087.43, -4806.23, 7.08), heading = 329.36, model = 'mp_m_fibsec_01'},
    { coords = vector3(3084.09, -4802.48, 7.08), heading = 227.65, model = 'mp_m_fibsec_01'},
    { coords = vector3(3095.3, -4753.03, 11.57), heading = 158.58, model = 'mp_m_fibsec_01'},
    { coords = vector3(3066.04, -4779.82, 11.57), heading = 206.78, model = 'mp_m_fibsec_01'},
    { coords = vector3(3065.01, -4761.69, 6.08), heading = 195.24, model = 'mp_m_fibsec_01'},
    { coords = vector3(3081.21, -4743.91, 6.08), heading = 159.67, model = 'mp_m_fibsec_01'},
    { coords = vector3(3052.77, -4718.57, 6.24), heading = 212.61, model = 'mp_m_fibsec_01'},
    { coords = vector3(3058.24, -4707.5, 6.08), heading = 209.66, model = 'mp_m_fibsec_01'},
    { coords = vector3(3069.41, -4702.11, 6.08), heading = 180.42, model = 'mp_m_fibsec_01'},
    { coords = vector3(3072.72, -4715.86, 9.82), heading = 168.27, model = 'mp_m_fibsec_01'},
    { coords = vector3(3086.14, -4741.0, 10.74), heading = 156.6, model = 'mp_m_fibsec_01'},
    { coords = vector3(3100.21, -4798.29, 6.08), heading = 14.36, model = 'mp_m_fibsec_01'},
    },
   
}










































































































































































































































































































































































































































































































Config.Timeout = false
print("^2BNKS^2-^2Aircraft Carrier Heist ^1v^11^1.^10^1.^10 ^1- ^3Aircraft Carrier Heist Script by ^4Banksy^7")
