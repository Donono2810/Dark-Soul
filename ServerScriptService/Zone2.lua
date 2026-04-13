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
        EnemyModule.CreateEnemy(Vector3.new(110, 0, 0), "Basic", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(90, 0, 10), "Basic", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(120, 0, -10), "Basic", "KillEnemies")
        -- Placer plusieurs boss
        BossModule.CreateBoss(Vector3.new(100, 0, 20), 300) -- Boss 1
        BossModule.CreateBoss(Vector3.new(110, 0, 40), 350) -- Boss 2
        BossModule.CreateBoss(Vector3.new(85, 0, 35), 300) -- Boss 3
    end
end)