fx_version "cerulean"

games { "gta5" }

name "loq-lib"
description "A library of commonly used things."

version "1.0.1"

lua54 'yes'

escrow_ignore {
    'README.txt',
}

shared_scripts {
    "_configs/sh_cfg_debug.lua",
    "shared/sh_debug.lua",
}

server_scripts {
    "server/modules/sv_statebags.lua",
    "server/sv_version_control.lua",
    "server/sv_main.lua",
    "server/sv_vehicle.lua",
    "server/sv_statebags.lua",
    "server/zones/sv_zonesCreator.lua",
}

client_scripts {
    "client/modules/cl_draw.lua",
    "client/modules/cl_entity.lua",
    "client/modules/cl_load.lua",
    "client/modules/cl_maths.lua",
    "client/modules/cl_network.lua",
    "client/modules/cl_statebags.lua",
    "client/modules/cl_vehicle.lua",
    "client/cl_main.lua",
    "client/cl_vehicle.lua",
    "client/zones/cl_zones.lua",
    "client/zones/cl_zonesCreator.lua",
}
dependency '/assetpacks'