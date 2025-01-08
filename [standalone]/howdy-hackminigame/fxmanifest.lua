shared_script "@ReaperV4/bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'

game 'gta5'

ui_page 'build/index.html'

client_script('client.lua')

files {
	'build/index.html',
	'build/main.js',
	'build/style.css',
    'build/sounds/*',
}