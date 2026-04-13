-- Script pour Zone 4 : Montagne avec Orcs et collecte
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

-- Téléporteur vers Zone 4
local teleporter4 = Instance.new("Part")
teleporter4.Size = Vector3.new(4, 1, 4)
teleporter4.Position = Vector3.new(300, 0, 0)
teleporter4.Anchored = true
teleporter4.BrickColor = BrickColor.new("Bright green")
teleporter4.Parent = workspace

teleporter4.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(600, 0, 0)) -- Zone 4
        QuestModule.StartQuest(player, "KillOrcs")
        QuestModule.StartQuest(player, "CollectBones")
        -- Ennemis : Orcs
        EnemyModule.CreateEnemy(Vector3.new(610, 0, 0), "Orc", "KillOrcs")
        EnemyModule.CreateEnemy(Vector3.new(590, 0, 10), "Orc", "KillOrcs")
        -- Skeletons pour collecte
        EnemyModule.CreateEnemy(Vector3.new(620, 0, -10), "Skeleton", "CollectBones")
        EnemyModule.CreateEnemy(Vector3.new(580, 0, -20), "Skeleton", "CollectBones")
        BossModule.CreateBoss(Vector3.new(600, 0, 30), 400) -- Boss Zone 4
    end
end)