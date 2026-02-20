fx_version 'cerulean'
game 'gta5'

name 'b2b_mdt'
author 'Codex Generated'
description 'Complete police MDT resource inspired by tk_mdt with ESX/QBCore compatibility'
version '1.0.0'

ui_page 'nui/index.html'

shared_scripts {
    'config/config.lua',
    'shared/utils.lua',
    'shared/permissions.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

files {
    'nui/index.html',
    'nui/style.css',
    'nui/js/**/*.js'
}
