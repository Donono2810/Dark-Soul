local ExtendedFriendsModule = {}

-- Module pour le système d'amis étendu
ExtendedFriendsModule.Friends = {} -- Liste d'amis par joueur

-- Fonction pour ajouter un ami
function ExtendedFriendsModule.AddFriend(player, friendPlayer)
    if not ExtendedFriendsModule.Friends[player.UserId] then
        ExtendedFriendsModule.Friends[player.UserId] = {}
    end
    table.insert(ExtendedFriendsModule.Friends[player.UserId], friendPlayer.UserId)
end

-- Fonction pour inviter à un groupe
function ExtendedFriendsModule.InviteToGroup(player, friendId)
    -- Envoyer invitation
end

return ExtendedFriendsModule