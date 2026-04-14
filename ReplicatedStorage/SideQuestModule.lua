-- ModuleScript pour les quêtes secondaires
local SideQuestModule = {}

local quests = {
    ["KillGoblins"] = {
        description = "Tuer 5 Gobelins",
        reward = {"Potion", 3},
        progress = 0,
        required = 5
    },
    ["CollectLoot"] = {
        description = "Collecter 10 loots",
        reward = {"Gold", 50},
        progress = 0,
        required = 10
    }
}

function SideQuestModule.GetQuests()
    return quests
end

function SideQuestModule.UpdateProgress(questName, amount)
    if quests[questName] then
        quests[questName].progress = quests[questName].progress + amount
        if quests[questName].progress >= quests[questName].required then
            -- Récompense
            print("Quête " .. questName .. " terminée ! Récompense : " .. quests[questName].reward[1])
        end
    end
end

return SideQuestModule