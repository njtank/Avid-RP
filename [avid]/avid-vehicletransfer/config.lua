Config = Config or {}

Config.Command = 'transferveh'      -- command
Config.Payment = 'bank'             -- cash / bank
Config.EnableTransferSelf = false   -- enable only if you want test transfer vehicle with your self
Config.LimitPrice = {
    MinPrice = 100,                -- Min price sell vehicle
    MaxPrice = 1000000              -- Max price sell vehicle
}
Config.Item = { 
    Enable = false,                 -- this if you want enable use item to open menu transfer vehicle
    ItemName = 'tablet'             -- name item
}
