local PvPArena = {}

-- Module pour les arènes PvP
-- Combats joueur contre joueur dans une zone dédiée

local arenaPlayers = {}

-- Fonction pour entrer dans l'arène
function PvPArena.EnterArena(player)
    if arenaPlayers[player] then
        return false, "Déjà dans l'arène."
    end

    arenaPlayers[player] = true

    -- Téléporter dans l'arène
    player.Character:MoveTo(Vector3.new(1000, 0, 1000)) -- Zone arène

    -- Donner des buffs temporaires ou reset santé
    player.Character.Humanoid.Health = 100

    local notification = Instance.new("Hint")
    notification.Text = "Entré dans l'Arène PvP ! Combattez d'autres joueurs."
    notification.Parent = player.PlayerGui
    wait(3)
    notification:Destroy()

    return true, "Entré dans l'arène !"
end

-- Fonction pour quitter l'arène
function PvPArena.ExitArena(player)
    if not arenaPlayers[player] then
        return false, "Pas dans l'arène."
    end

    arenaPlayers[player] = nil

    -- Téléporter au spawn
    player.Character:MoveTo(Vector3.new(0, 0, 0))

    return true, "Sorti de l'arène."
end

-- Fonction pour récompenser le vainqueur
function PvPArena.RewardWinner(winner)
    local LevelingModule = require(game.ReplicatedStorage.LevelingModule)
    LevelingModule.AddXP(winner, 100)

    local playerData = winner:FindFirstChild("PlayerData")
    if playerData then
        local gold = playerData:FindFirstChild("Gold") or Instance.new("IntValue")
        gold.Name = "Gold"
        gold.Value = gold.Value + 50
        gold.Parent = playerData
    end

    local notification = Instance.new("Hint")
    notification.Text = "Victoire en PvP ! +100 XP, +50 or."
    notification.Parent = winner.PlayerGui
    wait(3)
    notification:Destroy()
end

return PvPArena