-- Script pour gérer un boss (avec exp et compétences)
local BossModule = {}
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BuffModule = require(game.ReplicatedStorage.BuffModule)
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)

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
    local healthScale = MultiplayerModule.GetBossHealthScale()
    humanoid.Health = math.floor(500 * healthScale)
    humanoid.MaxHealth = math.floor(500 * healthScale)
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
    
    -- Phases avec compétences
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
                        local bossScale = MultiplayerModule.GetBossHealthScale()
                        if humanoid.Health > 350 then
                            -- Phase 1: Attaque basique + poison
                            char.Humanoid:TakeDamage(math.floor(50 * bossScale))
                            BuffModule.ApplyPoison(player, char)
                        elseif humanoid.Health > 150 then
                            -- Phase 2: Attaque AoE + stun
                            local pos = char.HumanoidRootPart.Position
                            local allPlayers = game.Players:GetPlayers()
                            for _, p in pairs(allPlayers) do
                                local c = p.Character
                                if c and c:FindFirstChild("HumanoidRootPart") and (c.HumanoidRootPart.Position - pos).Magnitude < 10 then
                                    c.Humanoid:TakeDamage(math.floor(40 * bossScale))
                                    c.Humanoid.WalkSpeed = 0
                                    wait(2)
                                    c.Humanoid.WalkSpeed = 16 -- Reset
                                end
                            end
                        else
                            -- Phase 3: Summon minions + attaque puissante
                            EnemyModule.CreateEnemy(position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)), "Basic")
                            char.Humanoid:TakeDamage(math.floor(80 * bossScale))
                        end
                        wait(2)
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

return BossModule