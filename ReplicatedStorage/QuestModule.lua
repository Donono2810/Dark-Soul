-- ModuleScript pour les quêtes
local QuestModule = {}

local playerQuests = {} -- Quêtes actives par joueur

function QuestModule.StartQuest(player, questName)
    if not playerQuests[player.UserId] then
        playerQuests[player.UserId] = {}
    end
    playerQuests[player.UserId][questName] = {progress = 0, required = 5} -- Exemple : tuer 5 ennemis
end

function QuestModule.UpdateQuest(player, questName, amount)
    if playerQuests[player.UserId] and playerQuests[player.UserId][questName] then
        playerQuests[player.UserId][questName].progress = playerQuests[player.UserId][questName].progress + amount
        if playerQuests[player.UserId][questName].progress >= playerQuests[player.UserId][questName].required then
            -- Récompense
            local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
            InventoryModule.AddItem(player, "Potion", 2)
            InventoryModule.AddItem(player, "Axe", 1)
            playerQuests[player.UserId][questName] = nil -- Terminer quête
            print("Quête terminée ! Récompenses ajoutées.")
        end
    end
end

function QuestModule.GetQuests(player)
    return playerQuests[player.UserId] or {}
end

return QuestModule