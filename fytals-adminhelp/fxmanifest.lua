fx_version 'cerulean'
game 'gta5'

description 'Fytals Admin Help System for QBOX'
author 'Fytals'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

lua54 'yes'

dependencies {
    'qbx-core',
    'ox_lib'
}