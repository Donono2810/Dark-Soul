local LevelingModule = {}

-- Module pour gérer le système de niveaux des joueurs
-- Les joueurs gagnent de l'expérience, montent de niveau et améliorent leurs stats

local levelStats = {
    [1] = {health = 100, damage = 10, mana = 50},
    [2] = {health = 110, damage = 12, mana = 55},
    [3] = {health = 120, damage = 14, mana = 60},
    [4] = {health = 130, damage = 16, mana = 65},
    [5] = {health = 140, damage = 18, mana = 70},
    [6] = {health = 150, damage = 20, mana = 75},
    [7] = {health = 160, damage = 22, mana = 80},
    [8] = {health = 170, damage = 24, mana = 85},
    [9] = {health = 180, damage = 26, mana = 90},
    [10] = {health = 200, damage = 30, mana = 100},
    -- Ajouter plus de niveaux si nécessaire
}

local xpPerLevel = {
    [1] = 100,
    [2] = 200,
    [3] = 300,
    [4] = 400,
    [5] = 500,
    [6] = 600,
    [7] = 700,
    [8] = 800,
    [9] = 900,
    [10] = 1000,
}

-- Fonction pour obtenir les stats d'un niveau
function LevelingModule.GetLevelStats(level)
    return levelStats[level] or levelStats[10]
end

-- Fonction pour obtenir l'XP requis pour un niveau
function LevelingModule.GetXPForLevel(level)
    return xpPerLevel[level] or 1000
end

-- Fonction pour ajouter de l'XP à un joueur
function LevelingModule.AddXP(player, amount)
    local playerData = player:FindFirstChild("PlayerData")
    if not playerData then return end

    local level = playerData:FindFirstChild("Level") or Instance.new("IntValue")
    level.Name = "Level"
    level.Value = level.Value or 1
    level.Parent = playerData

    local xp = playerData:FindFirstChild("XP") or Instance.new("IntValue")
    xp.Name = "XP"
    xp.Value = xp.Value or 0
    xp.Parent = playerData

    xp.Value = xp.Value + amount

    -- Vérifier si niveau up
    local requiredXP = LevelingModule.GetXPForLevel(level.Value)
    if xp.Value >= requiredXP then
        level.Value = level.Value + 1
        xp.Value = xp.Value - requiredXP

        -- Appliquer les nouvelles stats
        local newStats = LevelingModule.GetLevelStats(level.Value)
        player.Character.Humanoid.MaxHealth = newStats.health
        player.Character.Humanoid.Health = newStats.health

        -- Notification
        local notification = Instance.new("Hint")
        notification.Text = "Niveau " .. level.Value .. " atteint ! Stats améliorées."
        notification.Parent = player.PlayerGui
        wait(3)
        notification:Destroy()

        print(player.Name .. " a atteint le niveau " .. level.Value)
    end
end

-- Fonction pour obtenir le niveau actuel
function LevelingModule.GetLevel(player)
    local playerData = player:FindFirstChild("PlayerData")
    if playerData then
        local level = playerData:FindFirstChild("Level")
        return level and level.Value or 1
    end
    return 1
end

return LevelingModule