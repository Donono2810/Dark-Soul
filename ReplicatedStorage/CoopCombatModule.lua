local CoopCombatModule = {}

-- Module pour le combat coopératif
CoopCombatModule.Groups = {} -- Stocke les groupes de joueurs

-- Fonction pour rejoindre un groupe
function CoopCombatModule.JoinGroup(player, groupId)
    if not CoopCombatModule.Groups[groupId] then
        CoopCombatModule.Groups[groupId] = {}
    end
    table.insert(CoopCombatModule.Groups[groupId], player)
end

-- Fonction pour partager les récompenses
function CoopCombatModule.ShareRewards(groupId, reward)
    local group = CoopCombatModule.Groups[groupId]
    if group then
        local share = reward / #group
        for _, p in ipairs(group) do
            -- Ajouter récompense à l'inventaire du joueur
        end
    end
end

return CoopCombatModule