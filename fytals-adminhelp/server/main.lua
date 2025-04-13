local QBX = exports['qbx-core']:GetCoreObject()

-- Command for players to request help
lib.addCommand(Config.CommandNames.help, {
    help = 'Request admin assistance',
    params = {
        {
            name = 'message',
            type = 'string',
            help = 'Your help message',
        }
    },
}, function(source, args)
    local player = QBX.Functions.GetPlayer(source)
    if not player then return end

    -- Check if any admins are online
    local adminFound = false
    local players = QBX.Functions.GetPlayers()
    
    for _, v in pairs(players) do
        local targetPlayer = QBX.Functions.GetPlayer(v)
        if targetPlayer and Config.AdminGroups[targetPlayer.PlayerData.group] then
            adminFound = true
            -- Send to each admin
            TriggerClientEvent('fytals-adminhelp:client:ReceiveHelp', v, {
                source = source,
                name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname,
                message = args.message
            })
        end
    end

    if adminFound then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Help',
            description = Config.Messages.helpSent,
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Help',
            description = Config.Messages.noAdmins,
            type = 'error'
        })
    end
end)

-- Command for admins to respond
lib.addCommand(Config.CommandNames.whisper, {
    help = 'Respond to a player help request',
    restricted = true, -- Only for admins
    params = {
        {
            name = 'playerId',
            type = 'number',
            help = 'Player ID to whisper to',
        },
        {
            name = 'message',
            type = 'string',
            help = 'Your response message',
        }
    },
}, function(source, args)
    local admin = QBX.Functions.GetPlayer(source)
    if not admin or not Config.AdminGroups[admin.PlayerData.group] then return end

    local target = QBX.Functions.GetPlayer(args.playerId)
    if not target then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Whisper',
            description = Config.Messages.invalidId,
            type = 'error'
        })
        return
    end

    -- Send whisper to player
    TriggerClientEvent('fytals-adminhelp:client:ReceiveWhisper', args.playerId, {
        admin = admin.PlayerData.charinfo.firstname,
        message = args.message
    })

    -- Confirm to admin
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Whisper',
        description = Config.Messages.whisperSent,
        type = 'success'
    })
end)