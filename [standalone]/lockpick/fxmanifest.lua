shared_script "@ReaperV4/bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js'
}

client_script 'client.lua'