-- ModuleScript pour les quêtes (multiples par zone)
local QuestModule = {}

local playerQuests = {} -- Quêtes actives par joueur

local questData = {
    ["KillEnemies"] = {required = 5, reward = {["Potion"] = 2, ["Axe"] = 1}},
    ["KillGoblins"] = {required = 3, reward = {["Dagger"] = 1, ["Potion"] = 1}},
    ["KillOrcs"] = {required = 2, reward = {["Greatsword"] = 1}},
    ["CollectBones"] = {required = 10, reward = {["ShieldSpell"] = 2}} -- Collecte
}

function QuestModule.StartQuest(player, questName)
    if not playerQuests[player.UserId] then
        playerQuests[player.UserId] = {}
    end
    if questData[questName] then
        playerQuests[player.UserId][questName] = {progress = 0, required = questData[questName].required}
    end
end

function QuestModule.UpdateQuest(player, questName, amount)
    if playerQuests[player.UserId] and playerQuests[player.UserId][questName] then
        playerQuests[player.UserId][questName].progress = playerQuests[player.UserId][questName].progress + amount
        if playerQuests[player.UserId][questName].progress >= playerQuests[player.UserId][questName].required then
            -- Récompense
            local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
            for item, qty in pairs(questData[questName].reward) do
                InventoryModule.AddItem(player, item, qty)
            end
            playerQuests[player.UserId][questName] = nil -- Terminer quête
            print("Quête " .. questName .. " terminée ! Récompenses ajoutées.")
        end
    end
end

function QuestModule.GetQuests(player)
    return playerQuests[player.UserId] or {}
end

return QuestModule