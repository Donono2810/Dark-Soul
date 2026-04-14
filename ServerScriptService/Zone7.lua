-- Script pour Zone 7 : Inferno Magmatique avec Lava Spirits
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local teleporter7 = Instance.new("Part")
teleporter7.Size = Vector3.new(4, 1, 4)
teleporter7.Position = Vector3.new(650, 0, 0)
teleporter7.Anchored = true
teleporter7.BrickColor = BrickColor.new("Bright orange")
teleporter7.Parent = workspace

teleporter7.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(1000, 0, 0)) -- Zone 7
        QuestModule.StartQuest(player, "KillLavaSpirits")
        QuestModule.StartQuest(player, "ExploreZone7")
        -- Ennemis : Lava Spirits
        EnemyModule.CreateEnemy(Vector3.new(1010, 0, 0), "LavaSpirit", "KillLavaSpirits")
        EnemyModule.CreateEnemy(Vector3.new(990, 0, 10), "LavaSpirit", "KillLavaSpirits")
        EnemyModule.CreateEnemy(Vector3.new(1020, 0, -10), "LavaSpirit", "KillLavaSpirits")
        EnemyModule.CreateEnemy(Vector3.new(1005, 0, 25), "LavaSpirit", "KillLavaSpirits")
        EnemyModule.CreateEnemy(Vector3.new(995, 0, -25), "LavaSpirit", "KillLavaSpirits")
        -- Placer plusieurs boss de magma
        BossModule.CreateBoss(Vector3.new(1000, 0, 30), nil, "MagmaTitan")
        BossModule.CreateBoss(Vector3.new(1020, 0, 50), nil, "MagmaTitan")
        BossModule.CreateBoss(Vector3.new(980, 0, 45), nil, "MagmaTitan")
    end
end)
