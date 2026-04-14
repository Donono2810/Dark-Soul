local VoiceChatModule = {}

-- Module pour chat vocal
VoiceChatModule.Channels = {} -- Canaux vocaux

-- Fonction pour rejoindre un canal
function VoiceChatModule.JoinChannel(player, channelName)
    if not VoiceChatModule.Channels[channelName] then
        VoiceChatModule.Channels[channelName] = {}
    end
    table.insert(VoiceChatModule.Channels[channelName], player)
    -- Activer chat vocal
end

return VoiceChatModule