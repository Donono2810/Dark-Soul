-- Script pour un donjon avec pièges
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)

-- Entrée du donjon : porte à (200,0,0)
local dungeonDoor = Instance.new("Part")
dungeonDoor.Size = Vector3.new(4, 6, 1)
dungeonDoor.Position = Vector3.new(200, 0, 0)
dungeonDoor.Anchored = true
dungeonDoor.BrickColor = BrickColor.new("Dark stone grey")
dungeonDoor.Parent = workspace

dungeonDoor.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        player.Character:MoveTo(Vector3.new(250, 0, 0)) -- Entrer donjon
        -- Placer pièges : lames qui font mal
        for i = 1, 5 do
            local trap = Instance.new("Part")
            trap.Size = Vector3.new(2, 1, 2)
            trap.Position = Vector3.new(250 + i*10, 0, 0)
            trap.Anchored = true
            trap.BrickColor = BrickColor.new("Really red")
            trap.Parent = workspace
            trap.Touched:Connect(function(hit2)
                local p = game.Players:GetPlayerFromCharacter(hit2.Parent)
                if p then
                    hit2.Parent.Humanoid:TakeDamage(20)
                end
            end)
        end
        -- Ennemis variés dans donjon
        EnemyModule.CreateEnemy(Vector3.new(260, 0, 0), "Basic", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(280, 0, 10), "Orc", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(270, 0, -10), "Skeleton", "KillEnemies")
        EnemyModule.CreateEnemy(Vector3.new(290, 0, 5), "Goblin", "KillEnemies")
        -- Plusieurs boss finaux
        BossModule.CreateBoss(Vector3.new(300, 0, 0), 550) -- Boss donjon 1
        BossModule.CreateBoss(Vector3.new(320, 0, 20), 600) -- Boss donjon 2
        BossModule.CreateBoss(Vector3.new(280, 0, 25), 550) -- Boss donjon 3
    end
end)