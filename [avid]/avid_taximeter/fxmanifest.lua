fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'n1nja'
description 'A simple taximeter made as my first resource.'
version '1.0.0'

ui_page 'html/main.html'

files {
    'html/main.html',
	'html/styles.css',
	'html/script.js',
}

client_scripts {
    'client.lua',
    'config.lua',
}

shared_scripts {
    'config.lua',
}

escrow_ignore {
  'client.lua',
  'config.lua',
  'html/main.html',
  'html/styles.css',
  'html/script.js',
}
