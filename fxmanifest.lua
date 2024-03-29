fx_version 'cerulean'
game 'gta5'

name "mtc-mikeyseup"
description "EUP script for Mikeys EUP"
author "More Than Code"
version "1.0.0"

lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'shared/*.lua',
	'shared/jobs/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

dependencies 'ox_lib'
