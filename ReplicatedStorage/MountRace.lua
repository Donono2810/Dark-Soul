local MountRace = {}

-- Module pour la course de montures
-- Mini-jeu de course avec montures

local racers = {}

-- Fonction pour démarrer une course
function MountRace.StartRace(player)
    if racers[player] then
        return false, "Déjà en course."
    end

    racers[player] = true

    -- Téléporter à la ligne de départ
    player.Character:MoveTo(Vector3.new(200, 0, 200))

    local notification = Instance.new("Hint")
    notification.Text = "Course de montures démarrée ! Montez votre monture et allez au checkpoint (300,0,300)."
    notification.Parent = player.PlayerGui
    wait(5)
    notification:Destroy()

    -- Créer un checkpoint
    local checkpoint = Instance.new("Part")
    checkpoint.Size = Vector3.new(5, 1, 5)
    checkpoint.Position = Vector3.new(300, 0, 300)
    checkpoint.Anchored = true
    checkpoint.BrickColor = BrickColor.new("Bright green")
    checkpoint.Name = "Checkpoint"
    checkpoint.Parent = workspace

    checkpoint.Touched:Connect(function(hit)
        if hit.Parent == player.Character then
            MountRace.FinishRace(player)
            checkpoint:Destroy()
        end
    end)

    return true, "Course démarrée !"
end

-- Fonction pour finir la course
function MountRace.FinishRace(player)
    if not racers[player] then return end

    racers[player] = nil

    -- Récompenses
    local LevelingModule = require(game.ReplicatedStorage.LevelingModule)
    LevelingModule.AddXP(player, 150)

    local playerData = player:FindFirstChild("PlayerData")
    if playerData then
        local gold = playerData:FindFirstChild("Gold") or Instance.new("IntValue")
        gold.Name = "Gold"
        gold.Value = gold.Value + 100
        gold.Parent = playerData
    end

    local notification = Instance.new("Hint")
    notification.Text = "Course terminée ! +150 XP, +100 or."
    notification.Parent = player.PlayerGui
    wait(3)
    notification:Destroy()
end

return MountRace