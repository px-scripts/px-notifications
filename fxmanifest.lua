fx_version "cerulean"
lua54 'yes'
use_experimental_fxv2_oal 'yes'
games { 'gta5' }

description 'PX Notifications - Modern notification system for FiveM'
author 'PX scripts'
version '1.0.0'

ui_page 'web/build/index.html'

shared_script 'config.lua'

client_script {
	'client/utils.lua',
	'client/client.lua',
}
server_script {
	'server/server.lua',
}

files {
	'web/build/index.html',
	'web/build/**/*',
}