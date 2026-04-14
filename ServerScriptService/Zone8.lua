-- Script pour Zone 8 : Forteresse des Ombres avec Phantom Knights
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local teleporter8 = Instance.new("Part")
teleporter8.Size = Vector3.new(4, 1, 4)
teleporter8.Position = Vector3.new(750, 0, 0)
teleporter8.Anchored = true
teleporter8.BrickColor = BrickColor.new("Really black")
teleporter8.Parent = workspace

teleporter8.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(1100, 0, 0)) -- Zone 8
        QuestModule.StartQuest(player, "KillPhantomKnights")
        QuestModule.StartQuest(player, "ExploreZone8")
        -- Ennemis : Phantom Knights
        EnemyModule.CreateEnemy(Vector3.new(1110, 0, 0), "PhantomKnight", "KillPhantomKnights")
        EnemyModule.CreateEnemy(Vector3.new(1090, 0, 10), "PhantomKnight", "KillPhantomKnights")
        EnemyModule.CreateEnemy(Vector3.new(1120, 0, -10), "PhantomKnight", "KillPhantomKnights")
        EnemyModule.CreateEnemy(Vector3.new(1105, 0, 25), "PhantomKnight", "KillPhantomKnights")
        EnemyModule.CreateEnemy(Vector3.new(1095, 0, -25), "PhantomKnight", "KillPhantomKnights")
        -- Placer le boss de la forteresse
        BossModule.CreateBoss(Vector3.new(1100, 0, 30), nil, "ShadowWarden")
    end
end)
