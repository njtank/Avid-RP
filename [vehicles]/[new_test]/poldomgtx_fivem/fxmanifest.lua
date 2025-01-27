fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Exclusive Wheels'

files {
    -- 'vehiclelayouts.meta',
    'handling.meta',
    'vehicles.meta',
    'carcols.meta',
    'carvariations.meta',
  }
  
-- data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script {
	'modkit_names.lua'
}