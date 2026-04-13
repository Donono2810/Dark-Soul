-- Script pour Zone 5 : Château final avec mélange
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

-- Téléporteur vers Zone 5
local teleporter5 = Instance.new("Part")
teleporter5.Size = Vector3.new(4, 1, 4)
teleporter5.Position = Vector3.new(450, 0, 0)
teleporter5.Anchored = true
teleporter5.BrickColor = BrickColor.new("Bright green")
teleporter5.Parent = workspace

teleporter5.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(800, 0, 0)) -- Zone 5
        QuestModule.StartQuest(player, "KillEnemies") -- Quête finale
        -- Mélange d'ennemis
        EnemyModule.CreateEnemy(Vector3.new(810, 0, 0), "Basic", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(790, 0, 10), "Goblin", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(820, 0, -10), "Orc", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(780, 0, -20), "Skeleton", "KillEnemies")
        BossModule.CreateBoss(Vector3.new(800, 0, 40), 600) -- Boss final ultime
    end
end)