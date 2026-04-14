local DynamicQuestsModule = {}

-- Module pour quêtes dynamiques
DynamicQuestsModule.Quests = {} -- Générées procéduralement

-- Fonction pour générer quête
function DynamicQuestsModule.GenerateQuest(player)
    -- Basé sur actions du joueur
    local quest = {Objective = "Kill " .. math.random(5,10) .. " enemies"}
    table.insert(DynamicQuestsModule.Quests, quest)
    return quest
end

return DynamicQuestsModule