-- Script pour une deuxième zone (avec téléporteur)
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)

-- Téléporteur vers zone 2
local teleporter = Instance.new("Part")
teleporter.Size = Vector3.new(4, 1, 4)
teleporter.Position = Vector3.new(50, 0, 0)
teleporter.Anchored = true
teleporter.BrickColor = BrickColor.new("Bright green")
teleporter.Parent = workspace

teleporter.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(100, 0, 0)) -- Téléporter à zone 2
        -- Placer ennemis en zone 2
        EnemyModule.CreateEnemy(Vector3.new(110, 0, 0), 30, "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(90, 0, 10), 30, "KillEnemies")
        BossModule.CreateBoss(Vector3.new(100, 0, 20), 300) -- Boss plus dur
    end
end)