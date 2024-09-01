fx_version 'cerulean'

lua54 'yes'

game 'gta5'

description 'Ducky Template'

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'shared/*.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}
