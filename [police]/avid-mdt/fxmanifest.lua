fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    'config/translations/shared.lua',
    'config/translations/pl.lua',
    'config/translations/en.lua',
    'config/translations/de.lua',
    'config/translations/es.lua',
    'config/translations/fr.lua',
    'config/config.lua',
    'config/config_tariff.lua',
    'config/config_citystatuses.lua',
    'config/config_vehicles.lua',
}

client_scripts {
    "callbacks/client.lua",
    'config/client/config_editable.lua',
    'config/client/config_framework.lua',
    'config/client/config_death.lua',
    'config/client/config_codes.lua',
    'config/client/config_prop.lua',
    'config/client/config_languages.lua',
    "client/main.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', --// Use this SQL system for better optimization and functions
    "callbacks/server.lua",
    'config/server/config_framework.lua',
    'config/server/config_sql.lua',
    'config/server/config_editable.lua',
    'config/server/config_webhooks.lua',
    'server/main.lua',
    'server/version.lua'
}

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
}

escrow_ignore {
    'config/translations/shared.lua',
    'config/translations/pl.lua',
    'config/translations/en.lua',
    'config/translations/de.lua',
    'config/translations/es.lua',
    'config/translations/fr.lua',
    'config/config.lua',
    'config/config_tariff.lua',
    'config/config_citystatuses.lua',
    'config/config_vehicles.lua',
    "callbacks/client.lua",
    'config/client/config_editable.lua',
    'config/client/config_framework.lua',
    'config/client/config_death.lua',
    'config/client/config_codes.lua',
    'config/client/config_prop.lua',
    'config/client/config_languages.lua',
    "client/main.lua",
    "callbacks/server.lua",
    'config/server/config_framework.lua',
    'config/server/config_sql.lua',
    'config/server/config_editable.lua',
    'config/server/config_webhooks.lua',
    'server/main.lua'
}

dependencies {
    'mysql-async', -- Required for proper operation of tablet queries. Also supported "oxmysql".
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}

server_script "antitrigger.lua"