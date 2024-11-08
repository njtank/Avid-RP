fx_version "cerulean"

games { "gta5" }

name "loq-better-downforce"
description "A script that fixes the downforce bump issue, as well as double clutching, and implements rev bouncing."

version "1.0.3"

lua54 'yes'

escrow_ignore {
    '_configs/sh_cfg_debug.lua',
    '_configs/sh_cfg_doubleclutch.lua',
    '_configs/sh_cfg_downforce.lua',
    'README.txt',
}

client_scripts {
    "client/cl_main.lua",
    "client/cl_doubleclutch.lua",
    "client/cl_downforce.lua",
}

server_scripts {
    "server/sv_main.lua",
}

shared_scripts {
    "_configs/sh_cfg_doubleclutch.lua",
    "_configs/sh_cfg_downforce.lua",
    "_configs/sh_cfg_debug.lua",
    "shared/sh_debug.lua",
}

dependency "loq-lib"

dependency '/assetpacks'