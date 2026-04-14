local RotatingDailyChallengesModule = {}

-- Module pour défis journaliers rotatifs
RotatingDailyChallengesModule.Challenges = {
    "Kill10Enemies",
    "Collect5Items"
}

-- Fonction pour générer défi
function RotatingDailyChallengesModule.GenerateChallenge()
    return RotatingDailyChallengesModule.Challenges[math.random(#RotatingDailyChallengesModule.Challenges)]
end

return RotatingDailyChallengesModule