fx_version 'cerulean'
game 'gta5'

description "NTeam Development Showroom Script"

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua',
}

escrow_ignore {
	'config.lua',
}

dependency 'ox_lib'
dependency '/assetpacks'