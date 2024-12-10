fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'NTeam - Development'
description 'Bridge Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'