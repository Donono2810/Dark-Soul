local WeeklyChallengesModule = {}

-- Module pour les défis hebdomadaires
WeeklyChallengesModule.Challenges = {
    KillEnemies = {Goal = 100, Reward = "Gold"},
    CompleteQuests = {Goal = 5, Reward = "Experience"}
}

-- Fonction pour vérifier progression
function WeeklyChallengesModule.CheckProgress(player, challengeName)
    -- Mettre à jour progression
end

return WeeklyChallengesModule