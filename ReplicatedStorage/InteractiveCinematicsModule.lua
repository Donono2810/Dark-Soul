local InteractiveCinematicsModule = {}

-- Module pour les cinématiques interactives
InteractiveCinematicsModule.Scenes = {
    Intro = {Choices = {"Fight", "Run"}, Outcomes = {"Win", "Lose"}}
}

-- Fonction pour jouer une scène
function InteractiveCinematicsModule.PlayScene(player, sceneName)
    local scene = InteractiveCinematicsModule.Scenes[sceneName]
    if scene then
        -- Afficher choix et gérer réponse
    end
end

return InteractiveCinematicsModule