fx_version 'adamant'

game 'gta5'

description 'ESX Nuo Give Car'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/main.lua',
	'locales/zh.lua',
	'config.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua',
	'locales/zh.lua',
	'config.lua',
}

dependency 'es_extended'

