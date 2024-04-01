fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Team Mikeys EUP'
description 'EUP Menu voor Mikeys EUP versie 1.3 / 1.4'
version '1.0.0'

dependencies 'ox_lib'

shared_scripts {
    '@ox_lib/init.lua',
    'config/init.lua',
    'clothing/*.lua',
    '@es_extended/imports.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
}

files {
    'config/config.lua',
}
