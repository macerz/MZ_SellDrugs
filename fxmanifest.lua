fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Macerz'
description 'Custom Drug Selling script made by Macerz'
version '1.0.0'

client_scripts {
    'client/weed.lua',
    'client/coke.lua',
    'client/meth.lua',
}

server_scripts {
    'server/main.lua',
}

shared_script 'config.lua'