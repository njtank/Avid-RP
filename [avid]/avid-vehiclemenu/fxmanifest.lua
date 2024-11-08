fx_version 'cerulean'

game "gta5"

author "Byte Labs"
version '1.0.0'
description 'Byte Labs Vehicle Menu'
repository 'https://github.com/Byte-Labs-Project/bl_vehiclemenu'

lua54 'yes'

ui_page 'build/index.html'
-- ui_page 'http://localhost:3000/' --for dev

shared_script {
    '@ox_lib/init.lua',
    'shared/*.lua',
}

client_script {
    'client/*.lua',
}

files {
    'build/**',
    'client/modules/*lua',
    'shared/modules/*lua',
}
