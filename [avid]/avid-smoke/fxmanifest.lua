fx_version 'cerulean'

game 'gta5'

author 'Lusty94'

name "bprp-smoke"

description 'Smoking Activity Script For QB-Core'

version '1.2.0'

lua54 'yes'

client_script {
    'client/smoking_client.lua',
}


server_scripts { 
    'server/smoking_server.lua',
}


shared_scripts { 
	'shared/config.lua',
}

escrow_ignore {
    'shared/config.lua',
    'client/smoking_client.lua',
    'server/smoking_server.lua',
}