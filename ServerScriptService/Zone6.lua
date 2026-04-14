-- Script pour Zone 6 : Caverne de Cristal avec Crystal Golems
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local teleporter6 = Instance.new("Part")
teleporter6.Size = Vector3.new(4, 1, 4)
teleporter6.Position = Vector3.new(550, 0, 0)
teleporter6.Anchored = true
teleporter6.BrickColor = BrickColor.new("Medium blue")
teleporter6.Parent = workspace

teleporter6.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(900, 0, 0)) -- Zone 6
        QuestModule.StartQuest(player, "KillCrystalGolems")
        QuestModule.StartQuest(player, "ExploreZone6")
        -- Ennemis : Crystal Golems
        EnemyModule.CreateEnemy(Vector3.new(910, 0, 0), "CrystalGolem", "KillCrystalGolems")
        EnemyModule.CreateEnemy(Vector3.new(890, 0, 10), "CrystalGolem", "KillCrystalGolems")
        EnemyModule.CreateEnemy(Vector3.new(920, 0, -10), "CrystalGolem", "KillCrystalGolems")
        EnemyModule.CreateEnemy(Vector3.new(905, 0, 25), "CrystalGolem", "KillCrystalGolems")
        EnemyModule.CreateEnemy(Vector3.new(895, 0, -25), "CrystalGolem", "KillCrystalGolems")
        -- Placer plusieurs boss de cristal
        BossModule.CreateBoss(Vector3.new(900, 0, 30), nil, "CrystalColossus")
        BossModule.CreateBoss(Vector3.new(920, 0, 50), nil, "CrystalColossus")
        BossModule.CreateBoss(Vector3.new(880, 0, 45), nil, "CrystalColossus")
    end
end)
