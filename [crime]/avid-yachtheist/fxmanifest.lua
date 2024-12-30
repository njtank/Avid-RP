fx_version 'cerulean'
game 'gta5'

version '1.1'

description 'Yacht heist'

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
    'server/selling.lua',
    'config.lua',
    'client/Hack.lua',
   }
  
lua54 'yes'
dependency '/assetpacks'