fx_version 'adamant'

game 'gta5'

description 'avid-atmrobbery'

shared_scripts {
	--'@es_extended/imports.lua', -- ESX
}

server_scripts {
	'config.lua',
    'server/server.lua',
}

client_script { 
	'config.lua',
	'client/client.lua',
	'client/drill.lua',
}

lua54 'yes' 

escrow_ignore {
	'config.lua',
	'server/*.lua',
	'client/*.lua',
}
dependency '/assetpacks'