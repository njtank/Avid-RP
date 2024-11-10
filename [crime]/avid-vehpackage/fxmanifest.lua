fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Sparven'
description 'Package Theft'
version '1.0.0'

client_scripts {
    '@ox_lib/init.lua', 
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'ox_inventory',
    'ox_target',
    'ox_lib' 
}
