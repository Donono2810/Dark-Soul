-- ModuleScript pour les ennemis (avec quêtes)
local EnemyModule = {}
local QuestModule = require(game.ReplicatedStorage.QuestModule)

function EnemyModule.CreateEnemy(position, expReward, questUpdate)
    expReward = expReward or 20
    questUpdate = questUpdate or "KillEnemies"
    local enemy = Instance.new("Model")
    enemy.Name = "Enemy"
    enemy.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(2, 2, 1)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.Parent = enemy
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Health = 150
    humanoid.MaxHealth = 150
    humanoid.WalkSpeed = 10
    humanoid.Parent = enemy
    
    humanoid.Died:Connect(function()
        -- Donner exp au joueur proche
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - position).Magnitude < 20 then
                _G.GainExp(player, expReward)
                QuestModule.UpdateQuest(player, questUpdate, 1) -- Mettre à jour quête
            end
        end
        enemy:Destroy()
    end)
    
    -- Comportement
    local function AttackPlayer()
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance < 10 then
                    humanoid:MoveTo(char.HumanoidRootPart.Position)
                    wait(2)
                    if distance < 3 then
                        char.Humanoid:TakeDamage(30)
                    end
                end
            end
        end
    end
    
    while humanoid.Health > 0 do
        AttackPlayer()
        wait(3)
    end
end

return EnemyModule