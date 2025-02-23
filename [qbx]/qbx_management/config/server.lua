return {
    discordWebhook = nil, -- Replace nil with your webhook if you chose to use discord logging over ox_lib logging
    minOnDutyLogTimeMinutes = 30,
    formatDateTime = '%m-%d-%Y %H:%M',

    -- While the config boss menu creation still works, it is recommended to use the runtime export instead.
    ---@alias GroupName string
    ---@type table<GroupName, ZoneInfo>
    menus = {
        lostmc = {
            coords = vec3(983.69, -90.92, 74.85),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'gang',
        },
        vagos = {
            coords = vec3(351.18, -2054.92, 22.09),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'gang',
        },
        police = {
            coords = vec3(461.63, -986.05, 30.69),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'job',
        },
        ambulance = {
            coords = vec3(314.17, -582.42, 43.27),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'job',
        },
        mosley = {
            coords = vec3(-15.53, -1659.19, 33.04),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'job',
        },
        atomic = {
            coords = vec3(463.42, -1883.55, 26.11),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'job',
        },
        firefighter = {
            coords = vec3(357.45, -1096.76, 29.45),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 39.68,
            type = 'job',
        }
    },
}