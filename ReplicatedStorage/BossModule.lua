-- Script pour gérer un boss (avec exp)
local BossModule = {}

function BossModule.CreateBoss(position, expReward)
    expReward = expReward or 200
    local boss = Instance.new("Model")
    boss.Name = "Boss"
    boss.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(4, 4, 2)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.Parent = boss
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Health = 500
    humanoid.MaxHealth = 500
    humanoid.WalkSpeed = 15
    humanoid.Parent = boss
    
    humanoid.Died:Connect(function()
        -- Donner exp
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - position).Magnitude < 50 then
                _G.GainExp(player, expReward)
            end
        end
        boss:Destroy()
    end)
    
    -- Phases
    local function AttackPlayer()
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance < 20 then
                    humanoid:MoveTo(char.HumanoidRootPart.Position)
                    wait(1.5)
                    if distance < 5 then
                        local damage = humanoid.Health > 250 and 50 or 80
                        char.Humanoid:TakeDamage(damage)
                        wait(2)
                    end
                end
            end
        end
    end
    
    while humanoid.Health > 0 do
        AttackPlayer()
        wait(2)
    end
end

return BossModule