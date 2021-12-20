--[[ FX Information ]]--
fx_version   'cerulean'
game         'gta5'

--[[ Resource Information ]]--
name         'NORP MoneyWash'
author       'Judd#7644'
version      '1.0.0'
description  'Basic moneywash thing.'

--[[ Manifest ]]--
dependencies {
	'es_extended',
}

shared_scripts {
    '@es_extended/imports.lua',
	'shared/*.lua',
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}