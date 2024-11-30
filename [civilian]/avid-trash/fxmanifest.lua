fx_version 'cerulean'
game 'gta5'

author 'njtank'
description 'Trash Job'
version '1.0.0'

-- Dependencies
dependencies {
    'ox_target',
    'ox_inventory',
    'ox_lib',
}

-- Shared Scripts
shared_scripts {
    '@ox_lib/init.lua'
}

-- Client and Server Scripts
client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

lua54 'yes'
