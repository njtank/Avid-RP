fx_version 'cerulean'
game 'gta5'

author 'njtank'
description 'avid-salvage'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Required for oxmysql integration
    'server/main.lua'
}

dependencies {
    'ox_inventory', -- Required for inventory management
    'ox_lib',       -- Required for progress bars and notifications
    'ox_target',    -- Required for targeting
}
