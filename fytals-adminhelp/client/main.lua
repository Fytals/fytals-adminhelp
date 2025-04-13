local QBX = exports['qbx-core']:GetCoreObject()

-- Helper function for screen effects
local function PlayHelpEffect()
    StartScreenEffect('MenuMGSelectionTint', 0, false)
    Wait(300)
    StopScreenEffect('MenuMGSelectionTint')
end

-- Receive help request (admin side)
RegisterNetEvent('fytals-adminhelp:client:ReceiveHelp', function(data)
    PlayHelpEffect()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    
    lib.notify({
        title = 'Help Request',
        description = string.format('From: %s (%s)\nMessage: %s', data.name, data.source, data.message),
        type = 'inform',
        duration = 10000
    })
end)

-- Receive whisper (player side)
RegisterNetEvent('fytals-adminhelp:client:ReceiveWhisper', function(data)
    PlayHelpEffect()
    PlaySoundFrontend(-1, "TEXT_ARRIVE_TOM", "FRANKLIN_NORMAN_FRANKLIN_SOUNDS", 1)
    
    lib.notify({
        title = Config.Messages.receivedWhisper,
        description = string.format('From Admin %s:\n%s', data.admin, data.message),
        type = 'inform',
        duration = 10000
    })
end)