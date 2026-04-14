local AchievementsModule = {}

-- Module pour système d'achievements
AchievementsModule.Achievements = {
    FirstKill = {Condition = "KillEnemy", Reward = "Badge"}
}

-- Fonction pour vérifier achievement
function AchievementsModule.CheckAchievement(player, action)
    for name, ach in pairs(AchievementsModule.Achievements) do
        if ach.Condition == action then
            -- Débloquer
        end
    end
end

return AchievementsModule