-- Script pour Donjon Secret : Abysse Éternel avec VoidBeasts et boss EternalOverlord
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local secretEntrance = Instance.new("Part")
secretEntrance.Size = Vector3.new(4, 1, 4)
secretEntrance.Position = Vector3.new(1120, 0, 0) -- Dans Zone 8
secretEntrance.Anchored = true
secretEntrance.BrickColor = BrickColor.new("Really black")
secretEntrance.Parent = workspace

secretEntrance.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(1300, 0, 0)) -- Donjon Secret
        QuestModule.StartQuest(player, "DefeatEternalOverlord")
        -- Ennemis : VoidBeasts
        EnemyModule.CreateEnemy(Vector3.new(1310, 0, 0), "VoidBeast", "DefeatEternalOverlord")
        EnemyModule.CreateEnemy(Vector3.new(1290, 0, 10), "VoidBeast", "DefeatEternalOverlord")
        EnemyModule.CreateEnemy(Vector3.new(1320, 0, -10), "VoidBeast", "DefeatEternalOverlord")
        -- Boss final
        BossModule.CreateBoss(Vector3.new(1300, 0, 30), nil, "EternalOverlord")
    end
end)
