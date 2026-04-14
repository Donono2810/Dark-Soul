local CommunityModule = {}

-- Module pour la communauté intégrée
CommunityModule.Posts = {} -- Stocke les posts

-- Fonction pour poster un message
function CommunityModule.PostMessage(player, message)
    table.insert(CommunityModule.Posts, {Author = player.Name, Content = message})
end

-- Fonction pour afficher le chat communautaire
function CommunityModule.DisplayChat()
    -- Montrer GUI avec posts
end

return CommunityModule