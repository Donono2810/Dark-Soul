local DetailedStatsModule = {}

-- Module pour statistiques détaillées
DetailedStatsModule.Stats = {
    TimePlayed = 0,
    EnemiesKilled = 0
}

-- Fonction pour mettre à jour stat
function DetailedStatsModule.UpdateStat(player, stat, value)
    player:SetAttribute(stat, player:GetAttribute(stat) + value)
end

return DetailedStatsModule