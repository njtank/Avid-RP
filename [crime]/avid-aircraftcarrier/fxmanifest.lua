fx_version 'cerulean'
game 'gta5'

version '1.0'

description 'Aircraft Carrier heist'

author 'Banksy'

shared_script{
    'config.lua'

}

client_script{
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    '@PolyZone/CircleZone.lua',
}

server_script{
    'server/*.lua'
}

escrow_ignore {
    'config.lua',
   }
  
lua54 'yes'
dependency '/assetpacks'