fx_version 'cerulean'
game 'gta5'

name "Avid Tablet"
author "njtank"
version "1.0"

client_scripts {'client/*.lua'}
server_scripts {'server/*.lua'}

ui_page 'Ui/ui.html'
files {
	'Ui/ui.html',
	'Ui/*.css',
	'Ui/*.js',
	'Ui/imgs/*.png',
    'Ui/imgs/app/*.png',
	'Ui/sounds/*.ogg'
}

dependencies {
    'ps-ui',
}

shared_script 'config.lua'
lua54 'yes'
