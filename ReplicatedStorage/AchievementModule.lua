local AchievementModule = {}

-- Module pour les succès/achievements
-- Récompenses pour milestones

local achievements = {
    ["FirstKill"] = {description = "Tuer votre premier ennemi", reward = {XP = 50}},
    ["Level5"] = {description = "Atteindre le niveau 5", reward = {Gold = 100}},
    ["Collect10Items"] = {description = "Collecter 10 items cachés", reward = {Potion = 5}},
    ["WinPvP"] = {description = "Gagner un combat PvP", reward = {XP = 200}},
    ["Complete10Quests"] = {description = "Terminer 10 quêtes", reward = {Gold = 500}}
}

-- Fonction pour vérifier et débloquer un succès
function AchievementModule.CheckAchievement(player, achievementName)
    local playerData = player:FindFirstChild("PlayerData")
    if not playerData then return end

    local achievementsFolder = playerData:FindFirstChild("Achievements") or Instance.new("Folder")
    achievementsFolder.Name = "Achievements"
    achievementsFolder.Parent = playerData

    if achievementsFolder:FindFirstChild(achievementName) then return end -- Déjà débloqué

    local achievement = achievements[achievementName]
    if not achievement then return end

    -- Créer le succès
    local achievementValue = Instance.new("BoolValue")
    achievementValue.Name = achievementName
    achievementValue.Value = true
    achievementValue.Parent = achievementsFolder

    -- Donner récompenses
    local LevelingModule = require(game.ReplicatedStorage.LevelingModule)
    local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

    for rewardType, amount in pairs(achievement.reward) do
        if rewardType == "XP" then
            LevelingModule.AddXP(player, amount)
        elseif rewardType == "Gold" then
            local gold = playerData:FindFirstChild("Gold") or Instance.new("IntValue")
            gold.Name = "Gold"
            gold.Value = gold.Value + amount
            gold.Parent = playerData
        else
            InventoryModule.AddItem(player, rewardType, amount)
        end
    end

    local notification = Instance.new("Hint")
    notification.Text = "Succès débloqué : " .. achievement.description .. " ! Récompenses gagnées."
    notification.Parent = player.PlayerGui
    wait(5)
    notification:Destroy()

    print(player.Name .. " a débloqué le succès : " .. achievementName)
end

-- Fonction pour obtenir la liste des succès
function AchievementModule.GetAchievements()
    return achievements
end

return AchievementModule