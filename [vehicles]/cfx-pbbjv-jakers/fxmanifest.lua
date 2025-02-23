fx_version 'cerulean'

game 'gta5'

author 'Jakers'

description 'pbbjv'

version '2.0'

files {
    'vehicles.meta',
    'carvariations.meta',
    'carcols.meta',
    'handling.meta',
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script {
    'vehicle_names.lua'
}

escrow_ignore {
    'stream/**/*.ytd',
    'vehicle_names.lua'
}

lua54 'yes'

dependency '/assetpacks'