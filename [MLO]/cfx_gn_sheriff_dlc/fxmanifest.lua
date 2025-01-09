fx_version 'cerulean'
game 'gta5'

author 'G&N_s Studio'
description 'Sheriff_Department_DLC'
version '4.0.0'

this_is_a_map 'yes'

dependencies {
    '/gameBuild:2189',
    'cfx_gn_collection'
}

data_file 'AUDIO_GAMEDATA' 'audio/gn_sheriff_door_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/sheriff_game.dat'
data_file 'TIMECYCLEMOD_FILE' 'gn_sheriff_timecycle.xml'

files {
    'audio/gn_sheriff_door_game.dat151.rel',
    'audio/sheriff_game.dat151.rel',
    'gn_sheriff_timecycle.xml'
}

escrow_ignore {
    'stream/**/*.ytd',
    'stream/unlock_file/**/*.ydr'
}

dependency '/assetpacks'