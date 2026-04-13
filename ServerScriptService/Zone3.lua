-- Script pour Zone 3 : Forêt avec Goblins
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

-- Téléporteur vers Zone 3
local teleporter3 = Instance.new("Part")
teleporter3.Size = Vector3.new(4, 1, 4)
teleporter3.Position = Vector3.new(150, 0, 0)
teleporter3.Anchored = true
teleporter3.BrickColor = BrickColor.new("Bright green")
teleporter3.Parent = workspace

teleporter3.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(400, 0, 0)) -- Zone 3
        QuestModule.StartQuest(player, "KillGoblins")
        -- Ennemis : Goblins
        EnemyModule.CreateEnemy(Vector3.new(410, 0, 0), "Goblin", "KillGoblins")
        EnemyModule.CreateEnemy(Vector3.new(390, 0, 10), "Goblin", "KillGoblins")
        EnemyModule.CreateEnemy(Vector3.new(420, 0, -10), "Goblin", "KillGoblins")
        EnemyModule.CreateEnemy(Vector3.new(405, 0, 25), "Goblin", "KillGoblins")
        EnemyModule.CreateEnemy(Vector3.new(395, 0, -25), "Goblin", "KillGoblins")
        -- Placer plusieurs boss
        BossModule.CreateBoss(Vector3.new(400, 0, 20), 350) -- Boss 1 Zone 3
        BossModule.CreateBoss(Vector3.new(420, 0, 40), 380) -- Boss 2 Zone 3
        BossModule.CreateBoss(Vector3.new(380, 0, 35), 350) -- Boss 3 Zone 3
    end
end)